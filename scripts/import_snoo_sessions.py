import datetime
from io import StringIO
from snoo import Client
import pandas as pd
from sqlalchemy import create_engine

client = Client()

# Enter the start and end dates of your Snoo usage in the format (year,month,day) and omit leading zeroes
start_date = datetime.datetime(2022,8,16)
end_date = datetime.datetime.now()

# This will export data for each individual session
data_sessions = client.export_sessions(start_date,end_date)

df = pd.read_csv(StringIO(data_sessions))

df.columns = [c.lower() for c in df.columns]

df["asleep"] = pd.to_numeric(df["asleep"])
df["soothing"] = pd.to_numeric(df["soothing"])

# Break out dates and times.
df["start_datetime"] = pd.to_datetime(df["start_time"])
df["end_datetime"] = pd.to_datetime(df["end_time"])
df["start_time"] = df["start_datetime"].dt.time
df["end_time"] = df["end_datetime"].dt.time
df["start_date"] = df["start_datetime"].dt.date


# Deal with sessions that cross day boundaries.
df_no_cross = df[df["start_datetime"].dt.day == df["end_datetime"].dt.day].copy()
df_cross = df[df["start_datetime"].dt.day != df["end_datetime"].dt.day]
df_cross_1 = df_cross.copy()
df_cross_2 = df_cross.copy()
df_cross_1["end_time"] = datetime.time(hour=23, minute=59, second=59)
df_cross_2["start_date"] = df_cross_2["start_date"] + datetime.timedelta(days=1)
df_cross_2["start_time"] = datetime.time(hour=0, minute=0, second=0)


# Combine dataframes
rows_no_cross = df_no_cross[["start_date", "start_time", "end_time"]]
rows_cross_1 = df_cross_1[["start_date", "start_time", "end_time"]]
rows_cross_2 = df_cross_2[["start_date", "start_time", "end_time"]]
rows = pd.concat([rows_no_cross, rows_cross_1, rows_cross_2])

# Convert to Pandas Datetime to make plotting easier.
rows["start_time"] = pd.to_datetime(rows["start_time"], format='%H:%M:%S')
rows["end_time"] = pd.to_datetime(rows["end_time"], format='%H:%M:%S')

# Import into postgres
engine = create_engine('postgresql://postgres:password@localhost:5432/babydata')
df.to_sql("snoo_sessions", engine, schema='raw', if_exists='replace')
