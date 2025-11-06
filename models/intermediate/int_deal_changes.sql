{{ config(
    tags=['monthly','crm','marketing'],
    indexes=[
        {'columns': ['month']},
        {'columns': ['funnel_step']}
    ],
    post_hook=["analyze {{ this }}"]
) }}

WITH 
stage_deal_changes AS (
    SELECT 
        DATE_TRUNC('month', change_time::DATE) AS month,
        deal_id,
        CAST(new_value AS INTEGER) AS stage_id,
        change_time
    FROM {{ ref('stg_deal_changes') }}
    WHERE changed_field_key = 'stage_id'
)

SELECT 
    sc.month,
    s.stage_name AS kpi_name,
    s.stage_id AS funnel_step,
    COUNT(DISTINCT sc.deal_id) AS deals_count
FROM stage_deal_changes sc
JOIN {{ ref('stg_stages') }} s 
    ON sc.stage_id = s.stage_id
GROUP BY sc.month, s.stage_id, s.stage_name