
    

    create  table
      "aact"."main"."int_sponsor_history__dbt_tmp"
  
    
    as (
      -- For each trial: the lead sponsor's stop rate among its trials that ENDED
-- BEFORE this trial STARTED. Only the past is used, so no leakage.

with cohort as (
    select
        c.nct_id,
        a.lead_sponsor_name,
        c.start_date,
        c.completion_date,
        c.at_risk
    from "aact"."main"."int_cohort" c
    join "aact"."main"."int_trial_aggregates" a using (nct_id)
    where a.lead_sponsor_name is not null
),

-- Running totals per sponsor, ordered by end date. Trials sharing an end date
-- get the same totals (the default window frame includes ties), and DISTINCT
-- keeps one row per (sponsor, end date).
ended as (
    select distinct
        lead_sponsor_name,
        completion_date            as end_date,
        count(*)          over w   as n_ended_so_far,
        sum(at_risk::int) over w   as n_stopped_so_far
    from cohort
    where completion_date is not null
    window w as (partition by lead_sponsor_name order by completion_date)
)

-- ASOF join: for each trial, take the latest row in `ended` for the same
-- sponsor whose end_date is strictly before this trial's start_date.
select
    c.nct_id,
    coalesce(e.n_ended_so_far, 0)                  as sponsor_prior_n,
    e.n_stopped_so_far::double / e.n_ended_so_far  as sponsor_prior_stop_rate  -- null if no history
from cohort c
asof left join ended e
    on  c.lead_sponsor_name = e.lead_sponsor_name
    and c.start_date > e.end_date
    );
    
  