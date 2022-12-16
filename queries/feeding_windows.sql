with feeding_log as (
  select 
    "start date" as start_datetime, 
    date("start date") as start_date,
    "duration(mins)" as duration_min
  from raw.babyfeedtimer
  where "log type" in ('Breast', 'Bottle')
  order by 1
),
feeding_windows as (
  select 
    start_datetime,
    date(start_datetime) as start_date,
    lead(start_datetime) over (order by start_datetime) - start_datetime as window_length
  from feeding_log
),
ranked_feeding_windows as (
  select 
    *,
    row_number() over (partition by start_date order by window_length desc) as window_rank
  from feeding_windows
),
windows as (
    select 
        start_date,
        EXTRACT(epoch FROM window_length)/3600 as window_hrs
    from ranked_feeding_windows
    where window_rank = 1
)
select start_date, window_hrs
FROM windows
WHERE window_hrs < 8