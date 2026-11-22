-- Collapses the four one-to-many tables to exactly one row per trial.

with sponsor_agg as (
    select
        nct_id,
        max(sponsor_name) filter (where sponsor_role = 'lead')  as lead_sponsor_name,
        max(agency_class) filter (where sponsor_role = 'lead')  as lead_agency_class,
        count(*) filter (where sponsor_role = 'collaborator')   as n_collaborators
    from {{ ref('stg_sponsors') }}
    group by nct_id
),

intervention_agg as (
    select
        nct_id,
        -- e.g. ['DRUG','PLACEBO','DRUG'] -> 'DRUG|PLACEBO'
        array_to_string(list_sort(list_distinct(list(intervention_type))), '|') as intervention_types,
        count(*) as n_interventions
    from {{ ref('stg_interventions') }}
    group by nct_id
),

country_agg as (
    select
        nct_id,
        count(distinct country) filter (where not removed) as n_countries
    from {{ ref('stg_countries') }}
    group by nct_id
),

-- Top-level MeSH disease headings -> one therapeutic area per trial.
-- priority breaks ties when a trial touches several areas (lower wins).
area_map as (
    select * from (values
        ('neoplasms',                                              'oncology',         1),
        ('cardiovascular diseases',                                'cardiovascular',   2),
        ('infections',                                             'infectious',       3),
        ('bacterial infections and mycoses',                       'infectious',       3),
        ('virus diseases',                                         'infectious',       3),
        ('parasitic diseases',                                     'infectious',       3),
        ('mental disorders',                                       'mental_health',    4),
        ('nervous system diseases',                                'neurology',        5),
        ('respiratory tract diseases',                             'respiratory',      6),
        ('digestive system diseases',                              'digestive',        7),
        ('nutritional and metabolic diseases',                     'metabolic',        8),
        ('endocrine system diseases',                              'endocrine',        9),
        ('immune system diseases',                                 'immune',          10),
        ('musculoskeletal diseases',                               'musculoskeletal', 11),
        ('skin and connective tissue diseases',                    'skin',            12),
        ('eye diseases',                                           'eye',             13),
        ('urogenital diseases',                                    'urogenital',      14),
        ('female urogenital diseases and pregnancy complications', 'urogenital',      14),
        ('male urogenital diseases',                               'urogenital',      14),
        ('hemic and lymphatic diseases',                           'blood',           15),
        ('wounds and injuries',                                    'injury',          16)
    ) as t(mesh_term, mesh_area, priority)
),

mesh_agg as (
    select
        b.nct_id,
        arg_min(a.mesh_area, a.priority) as mesh_area   -- area with the lowest priority number
    from {{ ref('stg_browse_conditions') }} b
    join area_map a on b.mesh_term = a.mesh_term
    group by b.nct_id
)

select
    s.nct_id,
    sp.lead_sponsor_name,
    sp.lead_agency_class,
    coalesce(sp.n_collaborators, 0) as n_collaborators,
    iv.intervention_types,
    coalesce(iv.n_interventions, 0) as n_interventions,
    coalesce(co.n_countries, 0)     as n_countries,
    m.mesh_area
from {{ ref('stg_studies') }} s
left join sponsor_agg      sp using (nct_id)
left join intervention_agg iv using (nct_id)
left join country_agg      co using (nct_id)
left join mesh_agg         m  using (nct_id)
