SELECT "raw"."snoo_sessions"."start_date" AS "start_date", sum("raw"."snoo_sessions"."asleep") AS "sum", sum("raw"."snoo_sessions"."soothing") AS "sum_2"
FROM "raw"."snoo_sessions"
GROUP BY "raw"."snoo_sessions"."start_date"
ORDER BY "raw"."snoo_sessions"."start_date" ASC