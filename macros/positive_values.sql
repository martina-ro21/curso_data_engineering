{% test positive_values(model, col_name) %}

    select {{col_name}}
    from {{model}}
    where {{col_name}}<0

{% endtest %}