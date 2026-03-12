-- Cleaning the 'raw' data

WITH source AS (
    SELECT * FROM {{source('raw_ecoflux','users')}}
)

SELECT
    CAST(user_id AS string) AS user_id,
    CAST(signup_date AS date) AS signup_date,
    UPPER(country) as country_name,
    subscription_plan as plan_level,
    device_type
FROM source