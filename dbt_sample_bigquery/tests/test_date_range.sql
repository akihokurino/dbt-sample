WITH
actual AS ({{ generate_date_range() }}),
expected AS (
    SELECT DATE_SUB(CURRENT_DATE('Asia/Tokyo'), INTERVAL 10 YEAR) AS date
    UNION ALL
    SELECT DATE_SUB(DATE_SUB(CURRENT_DATE('Asia/Tokyo'), INTERVAL 10 YEAR), INTERVAL -1 DAY)
    UNION ALL
    SELECT CURRENT_DATE('Asia/Tokyo')
)

SELECT *
FROM expected
WHERE NOT EXISTS (
    SELECT 1
    FROM actual
    WHERE actual.date = expected.date
)