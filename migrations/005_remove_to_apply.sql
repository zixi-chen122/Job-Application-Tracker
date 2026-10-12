-- The "To Apply" status was removed; existing To Apply rows become Applied.
-- Rows without a date get today's date as their applied date.
update public.applications
set status = 'Applied',
    date_applied = coalesce(date_applied, current_date)
where status = 'To Apply';
