#!/usr/bin/env bash
# Larenest: install (or update) the server on a Linux machine as a background service that starts on boot.
#
#   curl -fsSL https://larenest.app/install.sh | sudo bash                  install or update
#   curl -fsSL https://larenest.app/install.sh | sudo bash -s -- --port 8443 a different port (default 8080)
#   sudo bash install-linux.sh --uninstall                                  remove the service (your data stays)
#
# What it does (nothing else):
#   - uses Node 22.13+ if it's already installed, otherwise downloads the official Node 22 build from nodejs.org
#     into /opt/larenest/node (checked against nodejs.org's published checksums)
#   - downloads the latest Larenest server from GitHub into /opt/larenest/app
#   - keeps your data in /var/lib/larenest (database, backups, settings), owned by a "larenest" system user
#   - adds a systemd service "larenest", and a "larenest" command for logins and backups
# Works on Debian, Ubuntu, Raspberry Pi OS, Fedora, Arch and others with systemd, on x86-64 and ARM64.
set -euo pipefail

REPO="nmllr93-git/household_finances-releases"
PREFIX=/opt/larenest
DATA=/var/lib/larenest
PORT=8080
ACTION=install
while [ $# -gt 0 ]; do
  case "$1" in
    --port) PORT="$2"; shift 2 ;;
    --uninstall) ACTION=uninstall; shift ;;
    -h|--help) sed -n '2,15p' "$0"; exit 0 ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

say() { printf '\033[1;33m==>\033[0m %s\n' "$*"; }
die() { printf '\033[1;31mError:\033[0m %s\n' "$*" >&2; exit 1; }
[ "$(id -u)" -eq 0 ] || die "Run this with sudo (it installs a system service)."
NO_SYSTEMD="${LARENEST_NO_SYSTEMD:-}"   # for testing in containers without systemd
if [ -z "$NO_SYSTEMD" ]; then command -v systemctl >/dev/null || die "This installer needs systemd. Use Docker instead: https://larenest.app/linux"; fi

if [ "$ACTION" = uninstall ]; then
  if [ -z "$NO_SYSTEMD" ]; then systemctl disable --now larenest 2>/dev/null || true; rm -f /etc/systemd/system/larenest.service; systemctl daemon-reload; fi
  rm -rf "$PREFIX" /usr/local/bin/larenest
  say "Larenest is removed. Your data is still in $DATA (delete it yourself if you're sure)."
  exit 0
fi

need() { command -v "$1" >/dev/null || die "Please install $1 first (e.g. sudo apt install $1)."; }
need curl; need tar

# ---- Node 22.13+ ----
node_ok() { "$1" -e 'const [a,b]=process.versions.node.split(".").map(Number);process.exit(a>22||(a===22&&b>=13)?0:1)' 2>/dev/null; }
NODE=""
if command -v node >/dev/null && node_ok "$(command -v node)"; then NODE="$(command -v node)"; say "Using Node $(node -v) from $NODE"
elif [ -x "$PREFIX/node/bin/node" ] && node_ok "$PREFIX/node/bin/node"; then NODE="$PREFIX/node/bin/node"; say "Using Node $($NODE -v) from $PREFIX/node"
else
  case "$(uname -m)" in x86_64|amd64) ARCH=x64 ;; aarch64|arm64) ARCH=arm64 ;; armv7l) ARCH=armv7l ;; *) die "Unsupported processor: $(uname -m)" ;; esac
  say "Downloading Node 22 for $ARCH from nodejs.org"
  BASE=https://nodejs.org/dist/latest-v22.x
  SUMS="$(curl -fsSL "$BASE/SHASUMS256.txt")"
  FILE="$(printf '%s\n' "$SUMS" | awk '{print $2}' | grep -E "^node-v22\.[0-9]+\.[0-9]+-linux-$ARCH\.tar\.xz$" | head -1)"
  [ -n "$FILE" ] || die "Couldn't find a Node 22 download for $ARCH."
  TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
  curl -fsSL "$BASE/$FILE" -o "$TMP/$FILE"
  (cd "$TMP" && printf '%s\n' "$SUMS" | grep " $FILE\$" | sha256sum -c - >/dev/null) || die "The Node download didn't match its checksum."
  rm -rf "$PREFIX/node"; mkdir -p "$PREFIX/node"; tar -xJf "$TMP/$FILE" -C "$PREFIX/node" --strip-components=1
  NODE="$PREFIX/node/bin/node"
fi

# ---- Larenest server ----
TMP2="$(mktemp -d)"
if [ -n "${LARENEST_TARBALL:-}" ]; then cp "$LARENEST_TARBALL" "$TMP2/server.tar.gz"; VER="(local file)"
else
  say "Finding the latest Larenest release"
  URL="$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" | grep -oE '"browser_download_url": *"[^"]*larenest-server-[^"]*\.tar\.gz"' | head -1 | sed -E 's/.*"(https[^"]+)"/\1/')"
  [ -n "$URL" ] || die "Couldn't find the Larenest server download. Check https://github.com/$REPO/releases"
  VER="$(basename "$URL" .tar.gz | sed 's/larenest-server-//')"
  curl -fsSL "$URL" -o "$TMP2/server.tar.gz"
fi
say "Installing Larenest $VER"
rm -rf "$PREFIX/app.new"; mkdir -p "$PREFIX/app.new"; tar -xzf "$TMP2/server.tar.gz" -C "$PREFIX/app.new"
[ -f "$PREFIX/app.new/server.js" ] || die "The download didn't contain the server."
rm -rf "$PREFIX/app.old"; [ -d "$PREFIX/app" ] && mv "$PREFIX/app" "$PREFIX/app.old"; mv "$PREFIX/app.new" "$PREFIX/app"; rm -rf "$TMP2"

# ---- user, data folder, command ----
id larenest >/dev/null 2>&1 || useradd --system --home-dir "$DATA" --shell /usr/sbin/nologin larenest
mkdir -p "$DATA"; chown -R larenest:larenest "$DATA"; chmod 750 "$DATA"
cat > /usr/local/bin/larenest <<EOS
#!/bin/sh
# Larenest commands, run as the service user on the same data: larenest add-user alex personal,shared · larenest passwd alex · larenest backup · larenest users
exec sudo -u larenest env DATA_DIR=$DATA NODE_NO_WARNINGS=1 "$NODE" $PREFIX/app/server.js "\$@"
EOS
chmod 755 /usr/local/bin/larenest

# ---- service ----
if [ -z "$NO_SYSTEMD" ]; then
cat > /etc/systemd/system/larenest.service <<EOS
[Unit]
Description=Larenest (self-hosted budgeting and net worth)
After=network-online.target
Wants=network-online.target

[Service]
User=larenest
Group=larenest
Environment=DATA_DIR=$DATA
Environment=PORT=$PORT
Environment=HOST=0.0.0.0
Environment=NODE_ENV=production
Environment=NODE_NO_WARNINGS=1
ExecStart=$NODE $PREFIX/app/server.js
Restart=on-failure
RestartSec=5
NoNewPrivileges=true
ProtectSystem=strict
ProtectHome=true
PrivateTmp=true
ReadWritePaths=$DATA

[Install]
WantedBy=multi-user.target
EOS
systemctl daemon-reload
systemctl enable larenest >/dev/null 2>&1
systemctl restart larenest
fi

# ---- first login ----
if [ -z "$(DATA_DIR=$DATA NODE_NO_WARNINGS=1 sudo -u larenest "$NODE" "$PREFIX/app/server.js" users 2>/dev/null | grep -v -i 'no logins' | head -1)" ] && [ -t 0 ]; then
  say "Create your first login (it can see every budget)."
  read -r -p "Login name (letters/numbers, e.g. alex): " U
  /usr/local/bin/larenest add-user "$U" personal,shared
  [ -z "$NO_SYSTEMD" ] && systemctl restart larenest
fi

IP="$(hostname -I 2>/dev/null | awk '{print $1}')"
say "Larenest $VER is running."
echo "   Open:        https://${IP:-<this-server>}:$PORT   (your browser warns once: the certificate is this server's own)"
echo "   Phones:      in Larenest, ⚙ Settings → Connect a phone shows a QR code to scan with the Larenest app"
echo "   Data:        $DATA   (backed up daily into $DATA/backups)"
echo "   Commands:    larenest add-user <name> personal,shared · larenest passwd <name> · larenest backup"
echo "   Logs:        journalctl -u larenest -f      Update: run this installer again"
