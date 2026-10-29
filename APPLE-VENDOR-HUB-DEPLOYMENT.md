# Apple Vendor Hub — deployment

This folder is the Apple Vendor Hub starter for the existing `never-broke-again` repository. The root `index.html` is intentionally added as a new file; the existing `Index.html` and other files are preserved.

## Publish with GitHub Pages
1. Open **Settings → Pages** in this repository.
2. Under **Build and deployment**, choose **Deploy from a branch**.
3. Select branch `main` and folder `/(root)`, then Save.
4. Wait for GitHub Pages to finish publishing. Open the Pages URL shown in Settings → Pages.

## Important functionality limits
- This starter is browser-only and uses localStorage. Listings, wishlist, order requests and sell requests are stored only in the visitor's browser.
- It does **not** send notifications, support cross-device customer/admin chat, upload payment screenshots to a server, or process payments.
- The PIN `2004` is a convenience gate, not secure authentication. Do not use it as the sole protection for real admin operations.
- Before accepting real orders, connect a backend such as Supabase: enable authentication, run a reviewed schema, enforce row-level security (RLS), restrict admin actions by authenticated role, and use private storage for uploaded customer documents/payment proof.
- Never place a Supabase service-role key, bot token, password, or other secret in public HTML. Only publish a public anon/publishable key with strict RLS policies.
- Verify device ownership, Apple ID status, part history, and payments independently.

## Files
- `index.html` — mini app UI
- `manifest.webmanifest` — installable web-app manifest
- `supabase/schema.sql` — database schema placeholder/starting point (review and adapt before use)

The original repository files remain untouched.
