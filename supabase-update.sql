-- One-time update for the To Apply removal, the Assessment status,
-- rejection details, the Overview dashboard and the daily goal setting.
-- Combines migrations/005_remove_to_apply.sql, 006_add_rejection.sql and 007_add_daily_goal.sql.
-- Safe to run more than once.
--
-- Supabase dashboard -> SQL Editor -> New query -> paste this file -> Run.

begin;

-- 1. "To Apply" was removed: those jobs become Applied, dated today if they have no date.
update public.applications
set status = 'Applied',
    date_applied = coalesce(date_applied, current_date)
where status = 'To Apply';

-- 2. When and at which stage (Resume, Screening, Assessment, Interview) a job was rejected.
alter table public.applications add column if not exists rejected_date date;
alter table public.applications add column if not exists rejected_stage text;

-- 3. Rejections recorded before this change count as rejected at Resume.
update public.applications
set rejected_stage = 'Resume'
where status = 'Rejected' and rejected_stage is null;

-- 4. Each user's daily goal: applications to send per day (0 hides it).
alter table public.user_settings add column if not exists daily_goal integer not null default 10;

commit;
