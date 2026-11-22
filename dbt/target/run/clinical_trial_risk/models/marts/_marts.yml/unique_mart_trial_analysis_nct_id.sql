
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    nct_id as unique_field,
    count(*) as n_records

from "aact"."main"."mart_trial_analysis"
where nct_id is not null
group by nct_id
having count(*) > 1



  
  
      
    ) dbt_internal_test