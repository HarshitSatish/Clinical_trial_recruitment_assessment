
  
  create view "aact"."main"."stg_countries__dbt_tmp" as (
    select
    nct_id,
    name                     as country,
    coalesce(removed, false) as removed   -- true = country was dropped from the record later
from "aact"."raw"."countries"
  );
