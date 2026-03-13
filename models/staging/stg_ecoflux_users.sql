-- Cleaning the 'raw' data

WITH source AS (
    SELECT * FROM {{source('raw_ecoflux','users')}}
)

SELECT
    CAST(user_id AS string) AS user_id,
    SAFE.PARSE_TIMESTAMP('%Y-%m-%dT%H:%M:%E*S', signup_date) AS signup_at,
    UPPER(country) as country_name,
    subscription_plan as plan_level,
    device_type
FROM source