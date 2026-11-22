
  
  create view "aact"."main"."stg_eligibilities__dbt_tmp" as (
    select
    nct_id,
    upper(gender)       as gender,
    healthy_volunteers,
    length(criteria)    as criteria_length
from "aact"."raw"."eligibilities"
  );
