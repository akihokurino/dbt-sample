WITH
actual AS ({{ generate_month_range() }}),
expected AS (
    SELECT DATE_TRUNC(DATE_SUB(CURRENT_DATE('Asia/Tokyo'), INTERVAL 10 YEAR), MONTH) AS month
    UNION ALL
    SELECT DATE_TRUNC(DATE_SUB(DATE_SUB(CURRENT_DATE('Asia/Tokyo'), INTERVAL 10 YEAR), INTERVAL -30 DAY), MONTH)
    UNION ALL
    SELECT DATE_TRUNC(CURRENT_DATE('Asia/Tokyo'), MONTH)
)

SELECT *
FROM expected
WHERE NOT EXISTS (
    SELECT 1
    FROM actual
    WHERE actual.month = expected.month
)