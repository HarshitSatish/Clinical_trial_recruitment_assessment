{# Converts an age number plus its unit into years, e.g. (6, 'month') -> 0.5 #}
{% macro to_years(num_col, unit_col) %}
    case lower({{ unit_col }})
        when 'year'   then {{ num_col }} * 1.0
        when 'month'  then {{ num_col }} / 12.0
        when 'week'   then {{ num_col }} / 52.0
        when 'day'    then {{ num_col }} / 365.0
        when 'hour'   then {{ num_col }} / 8760.0
        when 'minute' then {{ num_col }} / 525600.0
    end
{% endmacro %}
