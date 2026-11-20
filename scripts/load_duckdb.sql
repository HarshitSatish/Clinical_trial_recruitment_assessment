CREATE SCHEMA IF NOT EXISTS raw;

CREATE OR REPLACE TABLE raw.studies           AS SELECT * FROM read_parquet('parquet/studies.parquet');
CREATE OR REPLACE TABLE raw.calculated_values AS SELECT * FROM read_parquet('parquet/calculated_values.parquet');
CREATE OR REPLACE TABLE raw.designs           AS SELECT * FROM read_parquet('parquet/designs.parquet');
CREATE OR REPLACE TABLE raw.eligibilities     AS SELECT * FROM read_parquet('parquet/eligibilities.parquet');
CREATE OR REPLACE TABLE raw.sponsors          AS SELECT * FROM read_parquet('parquet/sponsors.parquet');
CREATE OR REPLACE TABLE raw.browse_conditions AS SELECT * FROM read_parquet('parquet/browse_conditions.parquet');
CREATE OR REPLACE TABLE raw.interventions     AS SELECT * FROM read_parquet('parquet/interventions.parquet');
CREATE OR REPLACE TABLE raw.countries         AS SELECT * FROM read_parquet('parquet/countries.parquet');