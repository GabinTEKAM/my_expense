# Pocketbook

Personal expense tracker: static web app (GitHub Pages) + Supabase (database and sign-in).

## Files
- `index.html`: the whole app (HTML, CSS, JS). Loads supabase-js from a CDN (pinned version).
- `config.js`: your Supabase project URL and public (anon/publishable) key. Public by design; data is protected by Row Level Security in `supabase.sql`. Never commit a service_role or secret key.
- `supabase.sql`: tables `transactions` and `settings` with per-user security rules.

## Setup
1. Create a Supabase project, run `supabase.sql` in the SQL Editor.
2. Put the project URL and public key in `config.js`.
3. In Supabase Authentication > URL configuration, set Site URL to your GitHub Pages address.
4. Push the three files to a GitHub repository, enable Pages (branch `main`, root).

## Test after deployment
Open the site, create an account, add a transaction with MealV_amount on Food, reload, open on a second device and sign in: the entry must appear. Edit and delete it, then check Reconcile and Settings > Export JSON.

## Notes
Free Supabase projects pause after a week of inactivity. Export a JSON backup regularly. Without `config.js`, the app falls back to browser storage.
