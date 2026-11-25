import os
import sys
from google.cloud import bigquery

TABLES = [
    "studies", "calculated_values", "designs", "eligibilities",
    "sponsors", "browse_conditions", "interventions", "countries",
]

project = os.environ.get("BQ_PROJECT")
location = os.environ.get("BQ_LOCATION", "US")
if not project:
    sys.exit("BQ_PROJECT is not set. Run: BQ_PROJECT=your_project_id python scripts/load_bigquery.py")

client = bigquery.Client(project=project)

dataset = bigquery.Dataset(f"{project}.aact_raw")
dataset.location = location
client.create_dataset(dataset, exists_ok=True)

cfg = bigquery.LoadJobConfig(
    source_format=bigquery.SourceFormat.PARQUET,
    write_disposition="WRITE_TRUNCATE",
)

for t in TABLES:
    with open(f"parquet/{t}.parquet", "rb") as f:
        client.load_table_from_file(f, f"{project}.aact_raw.{t}", job_config=cfg).result()
    n = client.get_table(f"{project}.aact_raw.{t}").num_rows
    print(f"{t:20} bigquery={n:>12,}")