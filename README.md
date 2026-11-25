# Larenest

**Your whole financial picture — budgets, bills, net worth, investments and planning — on your own devices.**
No account with us, no ads, no selling your data. Your numbers stay on your phone, your computer or your own home server.

[**⬇ Download**](https://github.com/nmllr93-git/household_finances-releases/releases) · [Privacy Policy](PRIVACY.md) · Windows · Mac · Android · [iPhone beta (TestFlight)](https://testflight.apple.com/join/T2K2rVsw)

---

## Why Larenest?

Most budgeting apps want your bank password and keep a copy of every transaction on their servers, then charge around $100 a year for it. Larenest flips that around:

- **Private by design.** Your data lives in a single file on a device you own. Nothing is uploaded to us — there is no "us" server to upload to.
- **Built for households.** Separate personal dashboards for each person, plus a shared household dashboard with "who paid what" splits. Share an account's balance into the shared view without sharing its transactions.
- **More than a budget.** Investments, dividends, live market data, an economy panel, debt payoff, cash forecasts, retirement estimates and a tax summary — in one place.
- **Works your way.** Import statements you download from your bank, or turn on optional automatic sync. Run it on one phone, or host it on a home PC and open it from every device in the house.
- **Free.** No subscription.

## Features

### Everyday money
- **Import statements:** CSV, OFX/QFX and **PDF statements** from banks, credit cards, mortgages and brokerages. Duplicate checks, transfer matching between your own accounts, and an editable transaction list.
- **Automatic bank sync (optional):** connect banks through [SimpleFIN Bridge](https://beta-bridge.simplefin.org), a separate read-only service you subscribe to yourself (about $15/year). Your bank logins go to SimpleFIN, never to this app.
- **Rules & categories:** auto-categorize vendors, rename messy descriptions, split one-time purchases from everyday spending.
- **Budgets with pace:** monthly budgets per category with rollover, a budget ring showing *today* and *pace* markers, and mortgage payments counted correctly.
- **Bills & subscriptions:** recurring charges detected automatically, price-increase alerts, "not recurring" marker for things like Venmo, and bill reminders on your phone.
- **Receipts:** attach a photo of a receipt to any transaction.

### Net worth & investments
- **Accounts & net worth:** checking, savings, cards, loans, mortgage, home and vehicle values, with history.
- **Holdings:** lots, buys and sells, gains, allocation rings, dividends and a dividend calendar; import positions from a broker CSV.
- **Markets:** indexes, sectors, commodities, top movers in the sectors you follow, a watchlist, per-holding news, earnings dates, 52-week range and analyst views, plus a stock screener (free API keys from Finnhub / Financial Modeling Prep).
- **Economy panel:** mortgage and savings rates, inflation (including Midwest category inflation), gas and electricity prices, Treasury and I-bond rates, exchange rates and an economic calendar — with refinance and savings-yield alerts.

### Planning
- **90-day cash forecast**, **debt payoff planner** (avalanche or snowball), mortgage payoff schedule.
- **Net worth projection** and a **retirement estimate**.
- **Tax summary** with CSV export for your preparer.
- **Year in review** with inflation-adjusted spending and clickable month snapshots.

### Household & sharing
- Personal and **shared dashboards**; people and percentage splits; "who paid what".
- **View-only logins**, an activity log of who changed what, and per-dashboard show/hide for sections.
- **Weekly email digest** (optional, when hosting).

### Your data, your control
- **Backups:** automatic daily backups plus one-click backup and restore files.
- **Export everything** at any time. No lock-in.
- **Customizable:** chart colors, which sections show, default tab and date range, phone menu layout.

## Ways to run it

| Setup | Best for | What you need |
|---|---|---|
| **Phone only** | One person, no computer involved | The Android app, or the iPhone app ([TestFlight beta](https://testflight.apple.com/join/T2K2rVsw)). Data stays on the phone. |
| **This computer only** | One person on one Windows PC or Mac | The desktop app. |
| **Home host** | A household: everyone uses it from their own phone and computer | The desktop app on an always-on PC or Mac, set to *Allow other devices*. Phones connect with the Android app or any browser. |

Want to reach it away from home? Use a VPN to your home network (for example WireGuard or Tailscale) — the app never needs to be exposed to the internet.

## Download & install

Open **[Releases](https://github.com/nmllr93-git/household_finances-releases/releases)** and pick the newest release for your device.

- **Windows** (10/11): newest `Desktop …` release → `Household-Finances-Setup-x.y.z.exe`. If SmartScreen warns, choose **More info → Run anyway**. Later updates install from inside the app (**Check for updates**).
- **Mac** (macOS 12 Monterey or newer): newest `Desktop …` release → `…-mac-arm64.dmg` for Apple Silicon (M1 and newer) or `…-mac-x64.dmg` for Intel Macs. Drag the app into Applications. The Mac app is not signed yet, so the first time go to **System Settings → Privacy & Security → Open Anyway**.
- **Android** (7.0 or newer): newest `Android …` release → `HouseholdFinances-x.y.z.apk`. Open it on your phone and allow your browser to install apps when asked.
- **Any browser:** when a home host is running, open its address on any phone, tablet or computer — iPhone included.

The other files on each release (`latest.yml`, `latest-mac.yml`, `.blockmap`) are used by the app's update check. You can ignore them.

### First run
1. Choose how to run it (phone only, this computer only, or host for your household).
2. Create your login and your dashboards (for example *Personal* and *Shared*).
3. Import a statement or connect automatic sync, then set a few budgets. The app walks you through it.

## Privacy
Your financial data never leaves your device or your own server. The app only contacts outside services you turn on — market and economy data providers (with your own free API keys) and, if you choose, SimpleFIN for bank sync. See the **[Privacy Policy](PRIVACY.md)**.

## Questions & feedback
Found a bug or have an idea? Open an [issue](https://github.com/nmllr93-git/household_finances-releases/issues).
