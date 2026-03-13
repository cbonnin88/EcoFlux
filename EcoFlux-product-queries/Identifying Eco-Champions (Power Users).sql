-- Who are the top 1% of users by CO2 savings for our marketing referral program

SELECT
  u.user_id,
  fct.country_name,
  SUM(fct.total_c02_saved) AS lifetime_savings
FROM `ecoflux-490009.dbt_ecoflux.fct_daily_product_usage` AS fct
JOIN `ecoflux-490009.dbt_ecoflux.stg_ecoflux_users`AS u
  ON fct.country_name = u.country_name
GROUP BY 
  1,2
ORDER BY 
  3 DESC
LIMIT 30;