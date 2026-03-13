-- How long does it take for a new user to perform their first Smart Charge ?

WITH first_charge AS (
  SELECT
    user_id,
    MIN(event_at) AS first_charge_at
  FROM `ecoflux-490009.dbt_ecoflux.stg_ecoflux_events`
  WHERE event_type = 'Schedule Smart Charge'
  GROUP BY 1
)

SELECT
  u.user_id,
  u.signup_at,
  fc.first_charge_at,
  TIMESTAMP_DIFF(fc.first_charge_at,u.signup_at, HOUR) AS hours_to_first_action
FROM `ecoflux-490009.dbt_ecoflux.stg_ecoflux_users` AS u
INNER JOIN first_charge AS fc
  ON u.user_id = fc.user_id
WHERE fc.first_charge_at IS NOT NULL;