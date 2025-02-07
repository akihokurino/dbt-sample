{% macro generate_date_range() %}
SELECT
date
FROM UNNEST(
    GENERATE_DATE_ARRAY(
        DATE_SUB(CURRENT_DATE('Asia/Tokyo'), INTERVAL 10 YEAR),
        CURRENT_DATE(),
        INTERVAL 1 DAY
    )
) AS date
{% endmacro %}