-- How often do our users return ?

WITH dau AS (
  SELECT
    event_at,
    COUNT(DISTINCT user_id) AS daily_users
  FROM `ecoflux-490009.dbt_ecoflux.stg_ecoflux_events`
  GROUP BY 1
),

mau AS (
  SELECT
    DATE_TRUNC(event_at, MONTH) AS month,
    COUNT(DISTINCT user_id) AS monthly_users
  FROM `ecoflux-490009.dbt_ecoflux.stg_ecoflux_events`
  GROUP BY 1
)
SELECT
  d.event_at,
  ROUND(SAFE_DIVIDE(d.daily_users, m.monthly_users),2) AS stickiness_ratio
FROM dau AS d
JOIN mau AS m
  ON DATE_TRUNC(d.event_at, MONTH) = m.month
ORDER BY
  1 DESC;