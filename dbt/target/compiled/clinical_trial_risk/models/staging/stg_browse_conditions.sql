select
    nct_id,
    downcase_mesh_term as mesh_term,
    mesh_type                       -- 'mesh-list' (direct) or 'mesh-ancestor' (broader parent)
from "aact"."raw"."browse_conditions"