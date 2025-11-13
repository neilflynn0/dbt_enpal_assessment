{{ config(
    tags=['monthly','crm','marketing'],
    indexes=[
        {'columns': ['month']},
        {'columns': ['funnel_step']}
    ],
    post_hook=["analyze {{ this }}"]
) }}

WITH 
sales_call_1 AS (
    SELECT 
        DATE_TRUNC('month', a.due_to::DATE) AS month,
        'Sales Call 1' AS kpi_name,
        2.1::NUMERIC(3,1) AS funnel_step,
        COUNT(DISTINCT a.deal_id) AS deals_count
    FROM {{ ref('stg_activity') }} a
    WHERE a.type = 'meeting'
    AND a.done = TRUE
    GROUP BY DATE_TRUNC('month', a.due_to::DATE)
),
sales_call_2 AS (
    SELECT 
        DATE_TRUNC('month', a.due_to::DATE) AS month,
        'Sales Call 2' AS kpi_name,
        3.1::NUMERIC(3,1) AS funnel_step,
        COUNT(DISTINCT a.deal_id) AS deals_count
    FROM {{ ref('stg_activity') }} a
    WHERE a.type = 'sc_2'
    AND a.done = TRUE
    GROUP BY DATE_TRUNC('month', a.due_to::DATE)
)

SELECT 
    month,
    kpi_name,
    funnel_step,
    deals_count
FROM sales_call_1

UNION ALL

SELECT 
    month,
    kpi_name,
    funnel_step,
    deals_count
FROM sales_call_2