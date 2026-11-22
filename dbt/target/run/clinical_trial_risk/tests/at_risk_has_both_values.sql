
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  -- A singular test FAILS if it returns any rows.
-- Returns a row when at_risk has fewer than 2 distinct values.
select count(distinct at_risk) as n_values
from "aact"."main"."mart_trial_analysis"
having count(distinct at_risk) < 2
  
  
      
    ) dbt_internal_test