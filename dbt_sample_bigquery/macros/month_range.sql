{% macro generate_month_range() %}
SELECT
DATE_TRUNC(date, MONTH) AS month,
FROM UNNEST(
    GENERATE_DATE_ARRAY(
        DATE_SUB(CURRENT_DATE('Asia/Tokyo'), INTERVAL 10 YEAR),
        CURRENT_DATE(),
        INTERVAL 1 DAY
    )
) AS date
GROUP BY month
{% endmacro %}