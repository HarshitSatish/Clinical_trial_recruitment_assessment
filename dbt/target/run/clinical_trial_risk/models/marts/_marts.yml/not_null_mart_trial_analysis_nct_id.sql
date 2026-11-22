
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select nct_id
from "aact"."main"."mart_trial_analysis"
where nct_id is null



  
  
      
    ) dbt_internal_test