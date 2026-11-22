select
    nct_id,
    registered_in_calendar_year as registration_year,
    number_of_facilities,
    has_us_facility,
    has_single_facility,
    
    case lower(minimum_age_unit)
        when 'year'   then minimum_age_num * 1.0
        when 'month'  then minimum_age_num / 12.0
        when 'week'   then minimum_age_num / 52.0
        when 'day'    then minimum_age_num / 365.0
        when 'hour'   then minimum_age_num / 8760.0
        when 'minute' then minimum_age_num / 525600.0
    end
 as min_age_years,
    
    case lower(maximum_age_unit)
        when 'year'   then maximum_age_num * 1.0
        when 'month'  then maximum_age_num / 12.0
        when 'week'   then maximum_age_num / 52.0
        when 'day'    then maximum_age_num / 365.0
        when 'hour'   then maximum_age_num / 8760.0
        when 'minute' then maximum_age_num / 525600.0
    end
 as max_age_years
from "aact"."raw"."calculated_values"