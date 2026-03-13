-- Are Premium users actually saving more CO2, or is the 'Free' tier more efficient per user ?

SELECT
  u.plan_level,
  COUNT(DISTINCT u.user_id) AS total_users,
  round(SUM(fct.total_c02_saved),0) AS total_kg_saved,
  ROUND(SAFE_DIVIDE(SUM(fct.total_c02_saved), COUNT(DISTINCT user_id)),0) AS avg_co2_per_user
FROM `ecoflux-490009.dbt_ecoflux.fct_daily_product_usage` AS fct
JOIN `ecoflux-490009.dbt_ecoflux.stg_ecoflux_users` AS u
  ON fct.plan_level = u.plan_level
GROUP BY 1;