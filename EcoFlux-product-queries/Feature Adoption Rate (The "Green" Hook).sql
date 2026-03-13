-- What percentage of our active users actually used the 'Smart Charge' feature today ?

SELECT
  event_date,
  SUM(total_smart_charges) AS total_charges,
  AVG(smart_charge_adoption_rate) AS avg_adoption_rate  
FROM `ecoflux-490009.dbt_ecoflux.fct_daily_product_usage`
GROUP BY 
  1
ORDER BY
  1 DESC;