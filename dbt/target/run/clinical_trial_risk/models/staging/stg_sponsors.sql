
  
  create view "aact"."main"."stg_sponsors__dbt_tmp" as (
    select
    nct_id,
    name                         as sponsor_name,
    upper(agency_class)          as agency_class,
    lower(lead_or_collaborator)  as sponsor_role   -- 'lead' or 'collaborator'
from "aact"."raw"."sponsors"
  );
