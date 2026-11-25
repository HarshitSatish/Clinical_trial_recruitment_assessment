-- total number of studies
select count(*) from ctgov.studies;


-- 1. studies
select * from ctgov.studies limit 10;


select column_name from information_schema.columns
where table_schema = 'ctgov' and table_name = 'studies'
order by ordinal_position;

select nct_id, enrollment, enrollment_type, overall_status, phase, study_type, start_date_type,start_date, completion_date_type,completion_date,study_type, number_of_arms, source, has_dmc
from ctgov.studies limit 10;


-- 2. calculated_values
select * from ctgov.calculated_values limit 10;

select column_name from information_schema.columns
where table_schema = 'ctgov' and table_name = 'calculated_values'
order by ordinal_position;

select nct_id, number_of_facilities, registered_in_calendar_year,
minimum_age_num, maximum_age_num, has_us_facility, has_single_facility
from ctgov.calculated_values limit 10;

-- 3. designs
select * from ctgov.designs limit 10;

select column_name from information_schema.columns
where table_schema = 'ctgov' and table_name = 'designs'
order by ordinal_position;

select nct_id, allocation, intervention_model, primary_purpose, masking,
observational_model from ctgov.designs limit 10;

-- 4. eligibilities
select * from ctgov.eligibilities limit 10;

select column_name from information_schema.columns
where table_schema = 'ctgov' and table_name = 'eligibilities'
order by ordinal_position;

select gender, healthy_volunteers, sampling_method, criteria
from ctgov.eligibilities limit 10;

-- 5. Sponsors
SELECT * FROM ctgov.sponsors limit 10;

select column_name from information_schema.columns
where table_schema = 'ctgov' and table_name = 'sponsors'
order by ordinal_position;

select nct_id, agency_class, lead_or_collaborator, name
from ctgov.sponsors limit 10;

-- 6. browse_conditions
select * from ctgov.browse_conditions limit 10;

select column_name from information_schema.columns
where table_schema = 'ctgov' and table_name = 'browse_conditions'
order by ordinal_position;

select nct_id, downcase_mesh_term, mesh_type
from ctgov.browse_conditions limit 10;

-- 7. interventions
select * from ctgov.interventions limit 10;

select column_name from information_schema.columns
where table_schema = 'ctgov' and table_name = 'interventions'
order by ordinal_position;

select nct_id, intervention_type
from ctgov.interventions limit 10;


-- 8. countries
select * from ctgov.countries limit 10;

select column_name from information_schema.columns
where table_schema = 'ctgov' and table_name = 'countries'
order by ordinal_position;

select nct_id, name, removed
from ctgov.countries limit 10;