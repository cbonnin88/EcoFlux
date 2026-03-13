-- When is the grid being optmized the most in Denmark vs Spain ? 

SELECT
  EXTRACT(HOUR FROM event_at) AS hour_of_day,
  country,
  COUNT(*) AS total_charges
FROM `ecoflux-490009.dbt_ecoflux.stg_ecoflux_events`
WHERE event_type = 'Schedule Smart Charge'
GROUP BY 
  1,2
ORDER BY 
  3 DESC;