# Job Application Tracker

A lightweight, self-hosted job application tracker with real cloud storage,
magic-link email sign-in, and CSV import/export — no framework, no build
step, one HTML file.

**Live site:**[ _add your GitHub Pages URL here once deployed_
(`https://<your-username>.github.io/<repo-name>/`)
](https://zixi-chen122.github.io/job-tracker/)
## Features

- **Add, edit, and delete applications** with company, role, region, status,
  dates, next-action reminders, a job posting link, referral/contact notes,
  and free-text notes.
- **Status pipeline** — Applied, Screening, Interview, Offer, Rejected,
  Withdrawn — shown as clickable stat cards that double as filters.
- **Filter and sort** by region and by date (or by upcoming next-action
  date, to answer "what do I need to follow up on this week").
- **CSV export and import** for backup and portability, independent of the
  database.
- **Real per-user cloud storage** via Supabase (Postgres), so your data
  follows you to any device — you just sign in with your email.
- **No password to manage** — sign-in is a magic link sent to your email
  (Supabase Auth's passwordless OTP flow).

## Tech stack

- Plain HTML/CSS/JavaScript — no framework, no bundler, no `npm install`.
  Open `index.html` and it works.
- [Supabase](https://supabase.com) for the database and authentication,
  loaded client-side via the `@supabase/supabase-js` CDN build.
- [GitHub Pages](https://pages.github.com) for free static hosting.

## How data privacy works

Every row in the `applications` table is tied to the signed-in user via a
`user_id` column, and a Postgres **Row Level Security (RLS)** policy
enforces that a user can only ever read or write their *own* rows —
enforced at the database level, not just hidden in the UI. See
[`schema.sql`](./schema.sql) for the exact policy.

The Supabase project URL and *publishable* API key are visible in this
repo's `index.html` — that's expected and safe. The publishable key has no
elevated privileges on its own; RLS is what actually protects the data, not
the secrecy of that key.

## Setting up your own copy

1. **Create a free [Supabase](https://supabase.com) project.**
2. **Run the schema** in the Supabase SQL Editor — see
   [`schema.sql`](./schema.sql) in this repo.
3. **Enable email auth** (on by default) and add your future GitHub Pages
   URL under Authentication → URL Configuration → Redirect URLs.
4. **Get your Project URL and Publishable key** from the "Connect" button
   on your Supabase dashboard, and paste them into the `SUPABASE_URL` and
   `SUPABASE_KEY` constants near the top of the `<script>` block in
   `index.html`.
5. **Push this repo to GitHub**, then enable GitHub Pages under
   Settings → Pages → Deploy from branch → `main` → `/ (root)`.
6. **Add the resulting Pages URL** to Supabase's Redirect URLs (step 3)
   if you haven't already.

## Local development

No build step — just open `index.html` directly in a browser, or serve it
with any static file server:

```bash
python3 -m http.server 8000
# then open http://localhost:8000
```

## License

MIT — do whatever you like with it.
