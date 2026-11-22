
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select at_risk
from "aact"."main"."mart_trial_analysis"
where at_risk is null



  
  
      
    ) dbt_internal_test