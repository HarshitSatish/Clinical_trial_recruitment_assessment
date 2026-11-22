-- The modeling population plus the label. Defined once, reused everywhere.
select
    nct_id,
    overall_status,
    study_type,
    enrollment,
    start_date,
    completion_date,
    overall_status in ('TERMINATED', 'WITHDRAWN') as at_risk
from "aact"."main"."stg_studies"
where study_type = 'INTERVENTIONAL'
  and overall_status in ('COMPLETED', 'TERMINATED', 'WITHDRAWN')