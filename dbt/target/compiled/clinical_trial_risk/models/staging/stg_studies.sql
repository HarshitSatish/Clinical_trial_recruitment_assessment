select
    nct_id,
    upper(overall_status)   as overall_status,
    upper(study_type)       as study_type,
    upper(phase)            as phase,
    enrollment,
    enrollment_type,
    cast(start_date as date)      as start_date,
    cast(completion_date as date) as completion_date,
    number_of_arms,
    has_dmc
from "aact"."raw"."studies"