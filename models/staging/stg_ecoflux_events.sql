-- Using the 'activity_score' to define what the user did

WITH source AS (
    SELECT * FROM {{source('raw_ecoflux','events')}}
)

SELECT
    CAST(user_id AS STRING) AS user_id,
    -- Converting the 'time' column (ms) to BigQuery TimeStamp
    DATE(CAST(event_date AS DATETIME)) AS event_date,
    TIMESTAMP_MILLIS(CAST(time as INT64)) AS event_at,
    country,
    subscription_plan AS plan_level,
    device_type,
    CAST(activity_score AS FLOAT64) AS activity_score,

    -- LOGIC: Define the Event Type based on the Score
    CASE
        WHEN CAST(activity_score AS FLOAT64) > 0.85 THEN 'Schedule Smart Charge'
        WHEN CAST(activity_score AS FLOAT64) > 0.30 THEN 'App Open'
        ELSE 'Background Heartbeat'
    END AS event_type,

    -- LOGIC: Synthesize a metric (e.g., high score = more carbon saved)
    CASE 
        WHEN CAST(activity_score AS FLOAT64) > 0.85 THEN ROUND(CAST(activity_score  AS FLOAT64) * 12.5,2)
        ELSE 0
    END AS estimated_co2_saved_kg
FROM source