-- Complete current schema for a fresh setup.
-- Run this once in the Supabase SQL Editor (SQL Editor -> New query -> Run)
-- if you're setting this project up from scratch.
--
-- If you already have an existing database that was set up before the
-- Priority/Job Type features were added, don't re-run this file -- use the
-- individual files in migrations/ instead, in order, which apply only the
-- incremental changes without trying to recreate the base table.

create table public.applications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  company text not null,
  role text not null,
  region text,
  job_type text,
  status text not null default 'Applied',
  priority text,
  date_applied date,
  next_action_date date,
  next_action text,
  link text,
  source text,
  category text,
  contact text,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.applications enable row level security;

create policy "Users manage their own applications"
  on public.applications
  for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- Stores each user's own Tier 1/2 company lists and title keywords, used to
-- auto-suggest a Priority (1 Important / 2 Medium / 3 Low) on new applications.
create table public.user_settings (
  user_id uuid primary key references auth.users(id) on delete cascade,
  tier1_companies text not null default '',
  tier2_companies text not null default '',
  tier1_keywords text not null default '',
  updated_at timestamptz not null default now()
);

alter table public.user_settings enable row level security;

create policy "Users manage their own settings"
  on public.user_settings
  for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
