import pandas as pd
from sqlalchemy import create_engine


df = pd.read_csv('data/babyfeedtimer/BabyFeedTimer_logs.csv')
df.columns = [c.lower() for c in df.columns] # PostgreSQL doesn't like capitals or spaces

df.replace('(null)', pd.NA, inplace=True)

# Convert to Pandas Datetime to make plotting easier.
df["start date"] = pd.to_datetime(df["start date"])
df["end date"] = pd.to_datetime(df["end date"])

engine = create_engine('postgresql://postgres:password@localhost:5432/babydata')
df.to_sql("babyfeedtimer", engine, schema='raw', if_exists='replace')