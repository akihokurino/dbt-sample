{{ config(materialized='view') }}

WITH
date_range AS ({{ generate_date_range() }}),
events AS (
    SELECT
    COUNT(*) AS count,
    DATE(CreatedAt) AS date,
    FROM `liberaworks-prod.DatastoreBackup.Customer_*`
    WHERE _TABLE_SUFFIX = FORMAT_DATE('%Y%m%d', DATE_SUB(CURRENT_DATE('Asia/Tokyo'), INTERVAL 1 DAY))
    GROUP BY date
)

SELECT
date_range.date AS date,
IFNULL(events.count, 0) AS count,
FROM date_range
LEFT OUTER JOIN events ON date_range.date = events.date
ORDER BY date_range.date DESC