SELECT CAST("raw"."babyfeedtimer"."start date" AS date) AS "start date", "raw"."babyfeedtimer"."diaper" AS "diaper", count(*) AS "count"
FROM "raw"."babyfeedtimer"
WHERE "raw"."babyfeedtimer"."log type" = 'Diaper'
GROUP BY CAST("raw"."babyfeedtimer"."start date" AS date), "raw"."babyfeedtimer"."diaper"
ORDER BY CAST("raw"."babyfeedtimer"."start date" AS date) ASC, "raw"."babyfeedtimer"."diaper" ASC