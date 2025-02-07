{{ config(materialized='view') }}

WITH
date_range AS ({{ generate_month_range() }}),
events AS (
    SELECT
    COUNT(*) AS count,
    DATE_TRUNC(DATE(CreatedAt), MONTH) AS month,
    FROM `liberaworks-prod.DatastoreBackup.MessageRoom_*`
    WHERE _TABLE_SUFFIX = FORMAT_DATE('%Y%m%d', DATE_SUB(CURRENT_DATE('Asia/Tokyo'), INTERVAL 1 DAY))
    AND IsScout = true
    GROUP BY month
),
monthly_data AS (
    SELECT
    date_range.month AS month,
    IFNULL(events.count, 0) AS count,
    FROM date_range
    LEFT OUTER JOIN events ON date_range.month = events.month
)

SELECT
FORMAT_DATE('%Y-%m', month) AS month,
count,
SUM(count) OVER (ORDER BY month) AS cumulative_count,
FROM monthly_data
ORDER BY month DESC

