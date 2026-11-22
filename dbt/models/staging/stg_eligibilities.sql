select
    nct_id,
    upper(gender)       as gender,
    healthy_volunteers,
    length(criteria)    as criteria_length
from {{ source('aact', 'eligibilities') }}
