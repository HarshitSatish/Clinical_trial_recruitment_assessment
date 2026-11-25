import os 
import duckdb

tables = ["studies","calculated_values ","designs","eligibilities","sponsors","browse_conditions","interventions","countries"]

user = os.environ.get("POSTGRES_USER")
password = os.environ.get("POSTGRES_PASSWORD")
dsn = f"dbname=aact host=localhost user={user}"
if password:
    dsn += f" password={password}"

con = duckdb.connect()
con.execute("INSTALL postgres; LOAD postgres;")
con.execute(f"ATTACH DATABASE '{dsn}' AS pg (TYPE postgres, READ_ONLY);")

os.makedirs("parquet", exist_ok=True)

for t in tables:
    con.execute(f"COPY (SELECT * FROM pg.ctgov.{t}) TO 'parquet/{t}.parquet' (FORMAT PARQUET)")
    n_pg = con.execute(f"SELECT count(*) FROM pg.ctgov.{t}").fetchone()[0]
    n_pq = con.execute(f"SELECT count(*) FROM read_parquet('parquet/{t}.parquet')").fetchone()[0]
    status = "OK" if n_pg == n_pq else "MISMATCH"
    print(f"{t:20} postgres={n_pg:>12,}  parquet={n_pq:>12,}  {status}")