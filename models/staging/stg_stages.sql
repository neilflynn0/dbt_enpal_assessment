{{ config(
    tags=['daily','crm','marketing'],
    indexes=[ {'columns': ['stage_id'], 'unique': True} ],
    post_hook=["analyze {{ this }}"]
) }}

SELECT
    stage_id::integer AS stage_id,
    stage_name::text  AS stage_name
FROM {{ source('postgres_public','stages') }}