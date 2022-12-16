import datetime
from io import StringIO
from snoo import Client
import pandas as pd
from sqlalchemy import create_engine

client = Client()

# Enter the start and end dates of your Snoo usage in the format (year,month,day) and omit leading zeroes
start_date = datetime.datetime(2022,8,16)
end_date = datetime.datetime.now()

# This will export some daily aggregated stats
data_history = client.export_stats(start_date,end_date)

df2 = pd.read_csv(StringIO(data_history))

# Import into postgres
engine = create_engine('postgresql://postgres:password@localhost:5432/babydata')
df2.to_sql("snoo_daily", engine, schema='raw', if_exists='replace')