SELECT CAST("raw"."babyfeedtimer"."start date" AS date) AS "start date", sum("raw"."babyfeedtimer"."duration(mins)") AS "sum", sum("raw"."babyfeedtimer"."amount(ounces)") AS "sum_2"
FROM "raw"."babyfeedtimer"
WHERE ("raw"."babyfeedtimer"."log type" = 'Bottle'
    OR "raw"."babyfeedtimer"."log type" = 'Breast')
GROUP BY CAST("raw"."babyfeedtimer"."start date" AS date)
ORDER BY CAST("raw"."babyfeedtimer"."start date" AS date) ASC