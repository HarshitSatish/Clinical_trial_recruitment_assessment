
    
    

with all_values as (

    select
        overall_status as value_field,
        count(*) as n_records

    from "aact"."main"."mart_trial_analysis"
    group by overall_status

)

select *
from all_values
where value_field not in (
    'COMPLETED','TERMINATED','WITHDRAWN'
)


