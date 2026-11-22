-- One row per trial in the cohort. Everything downstream reads this table.
select
    -- id, label, and cohort columns (NOT model inputs)
    c.nct_id,
    c.at_risk,
    c.overall_status,
    c.study_type,
    c.enrollment,
    cv.registration_year,                -- split key

    -- design
    st.phase,
    d.allocation,
    d.intervention_model,
    d.primary_purpose,
    d.masking,
    st.number_of_arms,
    st.has_dmc,

    -- eligibility
    e.gender,
    e.healthy_volunteers,
    cv.min_age_years,
    cv.max_age_years,
    e.criteria_length,

    -- sites and geography
    cv.number_of_facilities,
    cv.has_us_facility,
    cv.has_single_facility,
    a.n_countries,

    -- sponsor
    a.lead_sponsor_name,
    a.lead_agency_class,
    a.n_collaborators,
    sh.sponsor_prior_n,
    sh.sponsor_prior_stop_rate,

    -- condition and intervention
    a.mesh_area,
    a.intervention_types,
    a.n_interventions

from {{ ref('int_cohort') }} c
join      {{ ref('stg_studies') }}           st using (nct_id)
left join {{ ref('stg_calculated_values') }} cv using (nct_id)
left join {{ ref('stg_designs') }}           d  using (nct_id)
left join {{ ref('stg_eligibilities') }}     e  using (nct_id)
left join {{ ref('int_trial_aggregates') }}  a  using (nct_id)
left join {{ ref('int_sponsor_history') }}   sh using (nct_id)
