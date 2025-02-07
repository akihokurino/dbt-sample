{{ config(materialized='view') }}

WITH
date_range AS ({{ generate_month_range() }}),
events AS (
    SELECT
    SUM(Amount) as amount,
    DATE_TRUNC(DATE(CreatedAt), MONTH) AS month,
    FROM `liberaworks-prod.DatastoreBackup.SubscriptionSalesSheet_*`
    WHERE _TABLE_SUFFIX = FORMAT_DATE('%Y%m%d', DATE_SUB(CURRENT_DATE('Asia/Tokyo'), INTERVAL 1 DAY))
    GROUP BY month
),
monthly_data AS (
    SELECT
    date_range.month AS month,
    IFNULL(events.amount, 0) AS amount,
    FROM date_range
    LEFT OUTER JOIN events ON date_range.month = events.month
)

SELECT
FORMAT_DATE('%Y-%m', month) AS month,
amount,
SUM(amount) OVER (ORDER BY month) AS cumulative_amount,
FROM monthly_data
ORDER BY month DESC

