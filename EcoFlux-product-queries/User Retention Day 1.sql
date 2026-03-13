-- What percent of users who opened the app yesterday came back today ?

WITH user_activity AS (
  SELECT DISTINCT user_id, DATE(event_at) AS activity_date
  FROM `ecoflux-490009.dbt_ecoflux.stg_ecoflux_events`
)
SELECT
  t1.activity_date AS original_date,
  COUNT(DISTINCT t1.user_id) AS total_users,
  COUNT(DISTINCT t2.user_id) AS returned_users,
  ROUND(SAFE_DIVIDE(COUNT(DISTINCT t2.user_id), COUNT(DISTINCT t1.user_id)),2) AS d1_retention
FROM user_activity AS t1
LEFT JOIN user_activity AS t2
  ON t1.user_id = t2.user_id
  AND t2.activity_date = DATE_ADD(t1.activity_date, INTERVAL 1 DAY)
GROUP BY 1
ORDER BY 1 DESC;