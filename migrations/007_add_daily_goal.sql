-- Adds each user's daily goal: how many applications to send per day (0 hides it).
alter table public.user_settings add column if not exists daily_goal integer not null default 10;
