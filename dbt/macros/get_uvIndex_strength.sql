{#
    This macro returns the description of the payment_type 
#}

{% macro get_uvIndex_strength(uvindex) -%}

    case 
            when {{ 'uvindex' }} between 0 and 2 then 'Low'
            when {{ 'uvindex' }} between 3 and 5 then 'Moderate'
            when {{ 'uvindex' }} between 6 and 7 then 'High'
            when {{ 'uvindex' }} between 8 and 10 then 'Very High'
            else 'Extreme'
        end

{%- endmacro %}