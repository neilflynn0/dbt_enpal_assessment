{{ config(
    tags=['daily','crm','marketing'],
    indexes=[ {'columns': ['id'], 'unique': True} ],
    post_hook=["analyze {{ this }}"]
) }}

SELECT
    id::integer       AS id,
    name::text        AS name,
    email::text       AS email,
    modified::timestamptz AS modified
FROM {{ source('postgres_public','users') }}