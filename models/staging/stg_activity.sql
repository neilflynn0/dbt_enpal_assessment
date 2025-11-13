{{ config(
    tags=['daily','crm','marketing'],
    indexes=[
        {'columns': ['activity_id']}, 
        {'columns': ['due_to']}                     
    ],
    post_hook=["analyze {{ this }}"]
) }}

SELECT
    activity_id::integer              AS activity_id,
    "type"::text                      AS type,    
    assigned_to_user::text            AS assigned_to_user,
    deal_id::text                     AS deal_id,
    done::boolean                     AS done,
    due_to::timestamptz               AS due_to         

 FROM {{ source('postgres_public','activity') }}
