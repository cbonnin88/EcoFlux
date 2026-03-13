-- Is our total Environmental impact growing week-over-week ?

WITH weekly_totals AS (
  -- Step 1: Aggregate the data by week first
  SELECT
    DATE_TRUNC(event_date,WEEK) AS reporting_week,
    SUM(total_c02_saved) AS weekly_co2_saved
  FROM `ecoflux-490009.dbt_ecoflux.fct_daily_product_usage`
  GROUP BY 1
)

-- Step 2: Perform the Window Function on the aggregated results
SELECT
  reporting_week,
  ROUND(weekly_totals.weekly_co2_saved,1) AS weekly_co2_saved,
  ROUND(LAG(weekly_totals.weekly_co2_saved) OVER(ORDER BY reporting_week),1) AS prev_week_o2,

  -- WoW Growth Calculation
  SAFE_DIVIDE(
    (weekly_totals.weekly_co2_saved - LAG(weekly_totals.weekly_co2_saved) OVER(ORDER BY reporting_week)),
    LAG(weekly_totals.weekly_co2_saved) OVER(ORDER BY weekly_totals.reporting_week)
  ) AS wow_growth
FROM weekly_totals
ORDER BY weekly_totals.reporting_week DESC;

