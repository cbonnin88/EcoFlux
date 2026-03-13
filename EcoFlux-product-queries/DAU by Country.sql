-- Which Western European markets are most active right now ?

SELECT
  event_date,
  country_name,
  daily_active_users  
FROM `ecoflux-490009.dbt_ecoflux.fct_daily_product_usage`
ORDER BY
  1 DESC,
  3 DESC;