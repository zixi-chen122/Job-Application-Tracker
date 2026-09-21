-- Run this once in the Supabase SQL Editor (SQL Editor -> New query -> Run)
-- to create the applications table with row-level security so each signed-in
-- user can only ever read or write their own rows.

create table public.applications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  company text not null,
  role text not null,
  region text,
  status text not null default 'Applied',
  date_applied date,
  next_action_date date,
  next_action text,
  link text,
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
