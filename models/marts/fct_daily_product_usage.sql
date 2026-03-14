-- Daily Product Usage

WITH users AS (
    SELECT * FROM {{ref('stg_ecoflux_users')}}
),

events AS (
    SELECT * FROM {{ref('stg_ecoflux_events')}}
)

SELECT
    u.user_id,
    DATE(e.event_at) AS event_date,
    u.country_name,
    u.plan_level,
    u.device_type,
    AVG(e.activity_score) as avg_activity_score,
    COUNT(DISTINCT e.user_id) AS daily_active_users,
    COUNTIF(e.event_type = 'Schedule Smart Charge') AS total_smart_charges,
    SUM(e.estimated_co2_saved_kg) AS total_c02_saved,

    -- Product Hook: Smart Charge Adoption Rate
    SAFE_DIVIDE(
        COUNT(DISTINCT CASE WHEN e.event_type = 'Schedule Smart Charge' THEN e.user_id END),
        COUNT(DISTINCT e.user_id)
    ) AS smart_charge_adoption_rate
FROM events AS e
JOIN users AS u
    ON e.user_id = u.user_id
GROUP BY 1,2,3,4,5