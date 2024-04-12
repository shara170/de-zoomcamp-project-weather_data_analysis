{#
    This macro returns the description of the payment_type 
#}

{% macro get_uvHealthConcern_strength(uvhealthconcern) -%}

    case 
            when {{ 'uvhealthconcern' }} between 0 and 2 then 'Low'
            when {{ 'uvhealthconcern' }} between 3 and 5 then 'Moderate'
            when {{ 'uvhealthconcern' }} between 6 and 7 then 'High'
            when {{ 'uvhealthconcern' }} between 8 and 10 then 'Very High'
            else 'Extreme'
        end

{%- endmacro %}