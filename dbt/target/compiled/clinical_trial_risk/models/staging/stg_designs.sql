select
    nct_id,
    upper(allocation)         as allocation,
    upper(intervention_model) as intervention_model,
    upper(primary_purpose)    as primary_purpose,
    upper(masking)            as masking
from "aact"."raw"."designs"