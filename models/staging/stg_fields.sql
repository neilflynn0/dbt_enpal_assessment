{{ config(
    tags=['daily','crm','marketing'],
    indexes=[ {'columns': ['ID'], 'unique': True} ],
    post_hook=["analyze {{ this }}"]
) }}

SELECT
    ID::integer               AS ID,                
    FIELD_KEY::text           AS FIELD_KEY,             
    NAME::text                AS NAME,                 
    FIELD_VALUE_OPTIONS::text   AS FIELD_VALUE_OPTIONS
FROM {{ source('postgres_public','fields') }}
