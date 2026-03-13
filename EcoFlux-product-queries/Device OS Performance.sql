-- Does the 'Smart Charge' feature fail more often (lower usage) on Android than iOS ?

SELECT
  device_type,
  ROUND(AVG(smart_charge_adoption_rate),2) AS adoption_rate
FROM `ecoflux-490009.dbt_ecoflux.fct_daily_product_usage`
GROUP BY
  1;