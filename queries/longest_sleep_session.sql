with ranked as (
select 
  TO_CHAR((duration || ' second')::interval, 'HH24:MI:SS') as dur,
  duration/60/60::float as hours,
  row_number() over (partition by start_date order by duration desc) as day_dur_rank, 
  *
from raw.snoo_sessions
)
select start_date, hours, start_time, end_time, soothing as soothing_seconds
from ranked
where day_dur_rank = 1
order by 1;