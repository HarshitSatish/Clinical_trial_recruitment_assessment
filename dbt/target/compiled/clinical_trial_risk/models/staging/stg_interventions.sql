select
    nct_id,
    upper(intervention_type) as intervention_type
from "aact"."raw"."interventions"