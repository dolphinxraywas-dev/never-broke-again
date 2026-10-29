# NBA — Take the Throne (Telegram Mini App)

This folder is an **initial frontend prototype**. It is separate from the existing root pages, which are intentionally left unchanged.

## Included in this prototype
- Telegram Web App SDK initialization and mobile layout
- Six dice revealed sequentially, with number results under each die
- Choose two numbers, including choosing the same number twice
- Spinning wheel demo with selectable numbers
- Demo token store, badge exchange, profile, ranks and share button
- Host dashboard preview placeholder

## Important prototype limitations
- Coins are local demo values only; no payment, cash-out, ticket sale or real reward is processed.
- Local browser storage does not provide globally unique usernames or persistent accounts.
- Member counts and bot leaderboard entries are explicitly demo/sample data.
- The host panel is only a visual placeholder, not a secure admin system.
- Game outcomes are generated in the browser. Never use this client-side RNG to settle real-money or valuable rewards.

## Open in Telegram
1. Deploy this folder as an HTTPS site. GitHub Pages can serve it at:
   `https://dolphinxraywas-dev.github.io/never-broke-again/nba-telegram-mini-app/`
   (Enable Pages in the repository settings if not already enabled.)
2. In Telegram, open **@BotFather**, select/create your bot and use `/setmenubutton` or the Mini App settings to set the web app URL to the deployed HTTPS address.
3. Test inside Telegram on mobile and desktop.

## Secure production architecture
For real accounts, balances, payment approvals, withdrawals or private chat, connect a backend such as Supabase:
- Validate Telegram `initData` on a trusted server using Telegram's documented HMAC procedure; never trust user IDs sent by the browser alone.
- Keep service-role keys and payment-provider secrets on the server only.
- Use database transactions for balance changes and a unique idempotency key per request.
- Enforce row-level security and role checks. Only the server may approve payments, adjust balances, or create ledger entries.
- Store an append-only credit/debit ledger; don't let the client write balances directly.
- Use real payment-provider callbacks or manually reviewed payment evidence. A journal/reference number alone is not proof of payment.
- Don't embed admin passwords in HTML/JavaScript. Use server-side authentication, Telegram account allowlisting and audit logs.
- Before offering paid wagering, redeemable tokens or lottery tickets, get legal and payment-provider review for every target jurisdiction.

See `schema.sql` for a starting database model; it must be reviewed and configured before production use.
