select
    nct_id,
    name                     as country,
    coalesce(removed, false) as removed   -- true = country was dropped from the record later
from {{ source('aact', 'countries') }}
