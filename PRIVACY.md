# Privacy Policy: Larenest

**Effective date:** November 25, 2026

Larenest is a budgeting and net-worth app that you run yourself: on your own computer, on your own home server, or entirely on your phone. This policy explains what happens to your information when you use the desktop app, the Android and iOS apps, or the self-hosted server.

## The short version

- **We don't collect your data.** The developer never receives, stores or sees your transactions, balances, budgets, accounts or anything else you enter.
- **Your data stays where you put it:** on your phone (phone-only mode), on your computer, or on a server you run.
- **No ads, no analytics, no tracking,** and no developer account to sign up for.
- **Receipts stay with your data,** and reading a receipt happens on your phone. On Android, Google's on-device text recognition (ML Kit) also sends Google basic, non-financial diagnostics about how that feature runs; see [Receipt scanning](#receipts).
- The only things that leave your device are **optional** requests you turn on to public data services: stock prices and market data, interest rates and inflation, and vehicle look-ups. Those requests contain stock symbols or a VIN, never your financial information.

## What the app stores, and where

| Mode | Where your data is kept |
| --- | --- |
| **Phone-only mode** (Android/iOS) | In the app's private storage on your phone. Other apps can't read it. Uninstalling the app or clearing its data deletes it, so make a backup first. |
| **Desktop app** (this computer) | In a data folder on your computer, by default `%APPDATA%\HouseholdFinances` on Windows. |
| **Self-hosted server** | In the data folder on the computer that runs the server. |
| **Connecting to a server** (desktop or phone app) | On that server. The app on your device only displays it. |

What's stored: the statements you import (dates, descriptions and amounts of transactions), account names and balances, budgets, rules, goals, investment holdings, the assets you enter, notes and tags on transactions, receipt photos and PDF receipts you attach, side-business details you enter (such as a mileage log), your settings and, if you add them, API keys for the optional data services. Statement files you import (CSV, PDF, OFX/QFX) are read **on your device**. They're never uploaded to the developer or to anyone else.

Logins for a server you run are stored on that server, with passwords protected by a one-way hash (scrypt). The developer has no access to them. The server owner can reset or remove other people's logins, and anyone with a login can delete their own login from the app; the dashboards and their data stay on the server.

## Information sent to third parties (only if you turn it on)

These features are optional, and most need you to add your own free API key. When they're used, your device or your server contacts the service directly. The developer is not involved and receives nothing.

| Service | What is sent | Used for |
| --- | --- | --- |
| Finnhub (finnhub.io) | Stock and fund symbols, your API key | Prices, company sector, news, analyst ratings, earnings dates |
| Financial Modeling Prep | Stock and fund symbols, your API key | Prices, market overview, dividends, price targets, fund holdings |
| Stooq | Stock symbols | Delayed prices when no key is set |
| Yahoo Finance (query1.finance.yahoo.com) | Stock symbols | Daily price history for the investment chart, when the other sources have none |
| FRED (Federal Reserve Bank of St. Louis) | Your API key | Interest rates, inflation and home-price data |
| U.S. Bureau of Labor Statistics | Your API key | Inflation by category |
| U.S. Energy Information Administration | Your API key | Gasoline and electricity prices |
| NHTSA (U.S. Department of Transportation) | A vehicle VIN you enter, or its make, model and year | Vehicle details and recall notices |
| Nager.Date | The current year | Bank-holiday dates |
| U.S. Treasury (fiscaldata.treasury.gov) | Nothing personal | Treasury bill, note and I-bond rates |
| Frankfurter (frankfurter.dev) | Nothing personal | Currency exchange rates |
| SimpleFIN Bridge (simplefin.org) | Your SimpleFIN access link | Automatic bank sync, only if you connect it. You sign up with SimpleFIN yourself and link your banks on their site; this app only receives your balances and transactions (charges that are still pending are shown but not saved), read-only, and never sees your bank passwords |
| Plaid (plaid.com) | Your own developer keys, and the connection for each bank you link | Automatic bank sync with your own developer account, only if the person running the server adds those keys and you connect a bank. You sign in to your bank in Plaid’s own window; this app only receives balances and transactions, read-only, and never your bank password. |

Each service has its own privacy policy. Like any internet request, these services can see the network address the request comes from. No account, transaction, balance or personal financial information is ever included.

The desktop and phone apps check the public releases page on GitHub for new versions. That check tells GitHub which file is being downloaded, as any download does, and nothing else.

## Receipt scanning

When you scan a receipt, the text is read **on your phone** by the phone's own text recognition: Apple's Vision framework on iPhone, and Google's ML Kit on Android. A PDF receipt's text is read inside the app on any device. The photo, the PDF and the text read from them are never sent to the developer, to Apple or to Google; they're saved with your data like any other receipt.

On Android, Google's ML Kit may contact Google from time to time to receive updates, and sends Google metrics about how the feature performs: details such as the device model and Android version, the app's name and version, how long a scan took, and error codes. It never includes the receipt, its text or any of your financial information. Google describes this in its [ML Kit terms](https://developers.google.com/ml-kit/terms).

## Email digest and invites

If the person who runs a Larenest server sets up the optional weekly email digest, the server sends a summary of that dashboard to the addresses they enter, through the email account they configure. Invite links are created on that server and only work on it. Neither involves the developer.

## Notifications

Bill reminders and alerts (a bill due tomorrow, a budget passing 90%, a reminder you set to cancel or review a subscription) are worked out **on your phone** from your own data. They're local notifications: nothing is sent to a notification server, and you can turn them off in the app or in your phone's settings.

## Feedback

“Send feedback” opens your own email app with a message to contact@larenest.app, with the app type and device details filled in. Nothing is sent unless you press Send, and the developer receives only that email.

## Backups and sharing

- **Backup files** are created on your device. When you save or send one (for example to Google Drive, iCloud, Files or email), it goes where you choose, under that service's own privacy terms. Backups contain your financial data, so keep them somewhere private.
- **Sharing between dashboards** (on a server you run, or between dashboards on the same phone) shares only the account names, types, owners and balances you choose, with the other dashboards on that same server or phone. Transactions are never shared.

## Children

The app isn't directed at children under 13 and doesn't knowingly collect information from anyone, since it doesn't collect information at all.

## Your choices and control

You control all of your data. You can export it (Settings → Backup & restore), delete individual items in the app, delete a dashboard's data by restoring an empty backup, or remove everything by deleting the data folder or uninstalling the app (phone-only mode). Because the developer holds none of your data, there's nothing for us to delete or hand over on request.

## Security

Data on your phone uses the app's private storage, protected by your phone's own security and encryption. The optional app lock asks for a PIN (and fingerprint or Face ID, through your phone's own check) when the app opens; the PIN is kept only as a one-way hash on the phone, and fingerprint and face data never reach the app. On a computer or server, protect the data folder as you would any sensitive file. We recommend reaching a home server only through your home network or a private VPN such as Tailscale or WireGuard, never by opening it to the internet.

**Connections between your devices are encrypted.** The computer running Larenest makes its own HTTPS certificate. The Larenest phone and desktop apps trust that one certificate, which they learn from the QR code you scan (or the first time they connect), so traffic between them and your computer is encrypted even on ordinary home Wi-Fi. If that certificate ever changes, the app warns you before connecting. A web browser can use the same https:// address, with a one-time warning because the certificate is your computer's own; if you use Tailscale with its free HTTPS certificates turned on, the Tailscale address has no warning. Plain http:// addresses still work for compatibility but are not encrypted between devices. All connections to the outside services listed above use HTTPS.

## Changes to this policy

If this policy changes, the updated version is posted here with a new effective date. Material changes will also be noted in the release notes.

## Contact

Questions about this policy: email contact@larenest.app, or open an issue at https://github.com/nmllr93-git/household\_finances-releases/issues
