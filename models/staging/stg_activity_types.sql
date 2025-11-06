{{ config(
    tags=['daily','crm','marketing'],
    indexes=[
        {'columns': ['id'], 'unique': True}
    ],
    post_hook=["analyze {{ this }}"]
) }}

SELECT
    id::integer  AS id,
    name::text   AS name,
    active::text AS active,          
    type::text   AS "type"        
FROM {{ source('postgres_public','activity_types') }}