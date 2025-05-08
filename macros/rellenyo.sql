{% macro rellenyo(col) %}

    CASE 
        WHEN {{col}} = '' THEN 'Valor desconocido'
        WHEN {{col}} = null THEN 'Valor desconocido'
        ELSE {{col}}
        END 

{% endmacro %}