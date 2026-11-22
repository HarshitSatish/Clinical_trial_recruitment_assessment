select
    nct_id,
    registered_in_calendar_year as registration_year,
    number_of_facilities,
    has_us_facility,
    has_single_facility,
    {{ to_years('minimum_age_num', 'minimum_age_unit') }} as min_age_years,
    {{ to_years('maximum_age_num', 'maximum_age_unit') }} as max_age_years
from {{ source('aact', 'calculated_values') }}
