{{ config(
    tags=['daily','crm','marketing'],
    indexes=[
        {'columns': ['deal_id','change_time']}, 
        {'columns': ['change_time']}     
    ],
    post_hook=["analyze {{ this }}"]
) }}

SELECT
    deal_id::integer        AS deal_id, 
    change_time::timestamptz AS change_time,
    changed_field_key::text AS changed_field_key,
    new_value::text         AS new_value
FROM {{ source('postgres_public','deal_changes') }}
