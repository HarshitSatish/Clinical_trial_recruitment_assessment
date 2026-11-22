
  
  create view "aact"."main"."stg_interventions__dbt_tmp" as (
    select
    nct_id,
    upper(intervention_type) as intervention_type
from "aact"."raw"."interventions"
  );
