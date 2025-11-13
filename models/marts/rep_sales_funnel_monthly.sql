{{ config(
    tags=['monthly','crm','marketing'],
    indexes=[
        {'columns': ['month']},
        {'columns': ['funnel_step']}
    ],
    post_hook=["analyze {{ this }}"]

) }}

{{ dbt_utils.union_relations(

    relations=[ref('int_activity'), ref('int_deal_changes')],
    source_column_name = None

) }}