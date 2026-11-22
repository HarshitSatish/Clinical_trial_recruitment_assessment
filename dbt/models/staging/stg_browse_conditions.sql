select
    nct_id,
    downcase_mesh_term as mesh_term,
    mesh_type                       -- 'mesh-list' (direct) or 'mesh-ancestor' (broader parent)
from {{ source('aact', 'browse_conditions') }}
