-- A singular test FAILS if it returns any rows.
-- Returns a row when at_risk has fewer than 2 distinct values.
select count(distinct at_risk) as n_values
from {{ ref('mart_trial_analysis') }}
having count(distinct at_risk) < 2
