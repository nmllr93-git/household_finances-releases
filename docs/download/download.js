// Picks the right download for this device from the newest releases on GitHub.
(function () {
  const REPO = 'nmllr93-git/household_finances-releases';
  const PAGE = `https://github.com/${REPO}/releases`;
  const $ = (id) => document.getElementById(id);
  const ua = navigator.userAgent || '', plat = (navigator.userAgentData && navigator.userAgentData.platform) || navigator.platform || '';
  const isIOS = /iPhone|iPad|iPod/.test(ua) || (/Mac/.test(plat) && navigator.maxTouchPoints > 1);
  const os = isIOS ? 'ios' : /Android/i.test(ua) ? 'android' : /Win/i.test(plat) || /Windows/i.test(ua) ? 'windows' : /Mac/i.test(plat) || /Mac OS X/.test(ua) ? 'mac' : /Linux|CrOS/i.test(plat + ua) ? 'linux' : 'other';
  const btn = (href, text, alt) => { const a = document.createElement('a'); a.className = 'btn' + (alt ? ' alt' : ''); a.href = href; a.textContent = text; return a; };
  const card = (href, name, sub) => { const a = document.createElement('a'); a.href = href; const b = document.createElement('b'); b.textContent = name; const s = document.createElement('span'); s.textContent = sub; a.append(b, s); return a; };

  const show = (files) => {
    const W = files.win, MA = files.macArm, MI = files.macIntel, A = files.apk;
    const set = (title, desc, buttons, steps) => { $('title').textContent = title; $('desc').textContent = desc; $('btns').replaceChildren(...buttons); $('steps').textContent = steps || ''; };
    if (os === 'windows') set('Larenest for Windows', `Version ${files.desktopVer || ''} · Windows 10 or 11`, [btn(W || PAGE, 'Download for Windows')],
      'Open the downloaded file to install. If Windows SmartScreen warns about an unknown app, choose “More info”, then “Run anyway”. Later updates install from inside the app.');
    else if (os === 'mac') {
      // Browsers don't reliably say which kind of Mac this is, so offer both, newest kind first
      set('Larenest for Mac', `Version ${files.desktopVer || ''} · macOS 12 or newer`, [btn(MA || PAGE, 'Apple Silicon (M1 or newer)'), btn(MI || PAGE, 'Intel Mac', true)],
        'Not sure which Mac you have? Apple menu → About This Mac: “Chip” means Apple Silicon, “Processor” means Intel. Drag Larenest into Applications. The first time, open it from System Settings → Privacy & Security → Open Anyway.');
    } else if (os === 'android') set('Larenest for Android', `Version ${files.androidVer || ''} · Android 7 or newer`, [btn(A || PAGE, 'Download for Android')],
      'Open the downloaded file and allow your browser to install apps when asked. A Google Play version is coming soon.');
    else if (os === 'ios') set('Larenest on iPhone and iPad', 'The App Store version is on its way.', [btn('/#run', 'How to use it today', true)],
      'Until then, open your home computer’s Larenest address in Safari (the desktop app shows a QR code you can scan), sign in, then Share → Add to Home Screen.');
    else set('Download Larenest', 'Pick your device below.', [btn(PAGE, 'All downloads', true)], os === 'linux' ? 'On Linux you can run the Larenest server with Node.js 22; see the instructions on the releases page.' : '');
    const o = [];
    if (os !== 'windows') o.push(card(W || PAGE, 'Windows', 'Windows 10 or 11'));
    if (os !== 'mac') o.push(card(MA || PAGE, 'Mac (Apple Silicon)', 'M1 or newer, macOS 12+'), card(MI || PAGE, 'Mac (Intel)', 'macOS 12+'));
    if (os !== 'android') o.push(card(A || PAGE, 'Android', 'Android 7 or newer'));
    o.push(card(PAGE, 'All versions', 'Release notes and older versions'));
    $('others').replaceChildren(...o);
  };

  show({});
  fetch(`https://api.github.com/repos/${REPO}/releases?per_page=30`, { headers: { Accept: 'application/vnd.github+json' } })
    .then((r) => (r.ok ? r.json() : []))
    .then((list) => {
      const live = (list || []).filter((r) => !r.draft && !r.prerelease).sort((a, b) => new Date(b.published_at) - new Date(a.published_at));
      const desk = live.find((r) => /^v\d/.test(r.tag_name) && r.assets.some((a) => /\.exe$/i.test(a.name)));
      const andr = live.find((r) => /^android-v/.test(r.tag_name) && r.assets.some((a) => /\.apk$/i.test(a.name)));
      const pick = (rel, re) => { const a = rel && rel.assets.find((x) => re.test(x.name)); return a ? a.browser_download_url : ''; };
      show({ win: pick(desk, /Setup.*\.exe$/i), macArm: pick(desk, /mac-arm64\.dmg$/i), macIntel: pick(desk, /mac-x64\.dmg$/i), apk: pick(andr, /\.apk$/i),
        desktopVer: desk ? desk.tag_name.replace(/^v/, '') : '', androidVer: andr ? andr.tag_name.replace(/^android-v/, '') : '' });
    })
    .catch(() => {}); // the buttons already point at the releases page
})();
