-- Creating my dimension Table which will be the single source of truth

WITH users AS (
    SELECT * FROM {{ref('stg_ecoflux_users')}}
),

event_stats AS (
    SELECT
        user_id,
        MIN(event_at) AS first_event_at,
        MAX(event_at) as last_event_at,
        SUM(estimated_co2_saved_kg) AS lifetime_c02_saved,
        COUNTIF(event_type = 'Schedule Smart Charge') AS total_smart_charges
    FROM {{ref('stg_ecoflux_events')}}
    GROUP BY 1
)

SELECT
    u.*,
    s.first_event_at,
    s.last_event_at,
    s.lifetime_c02_saved,
    s.total_smart_charges,
    
    -- Metric: Is this a 'Power User" ? (More than 10. charges)
    CASE 
        WHEN s.total_smart_charges > 10 THEN TRUE
        ELSE FALSE
    END AS is_power_user
FROM users AS u
LEFT JOIN event_stats AS s
    ON u.user_id = s.user_id