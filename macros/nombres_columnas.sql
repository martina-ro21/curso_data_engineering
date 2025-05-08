{% macro nombres_columnas(esquema, tabla) %}
    {% set sql %}
        SELECT COLUMN_NAME
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_SCHEMA = '{{ esquema }}'
        AND TABLE_NAME = '{{ tabla }}'
    {% endset %}

    {% set results = run_query(sql) %}

    {% if execute %}
        {# Imprimir los resultados para ver qué contiene #}
        {% do log(results, info=true) %}

        {% for col in results.columns[0].values() %}
            - name: {{ col }}
              description: ""
        {% endfor %}
    {% endif %}
{% endmacro %}
