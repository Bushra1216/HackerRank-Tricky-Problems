with cte as(
     select EXTRACT(year from transaction_date) as year,
            product_id, spend
     from user_transactions
     group by EXTRACT(year from transaction_date),
              product_id,
              spend
     order by product_id
),

cte2 as(
   select year, product_id, 
         spend as curr_year_spend,
         LAG(spend) over(partition by product_id order by year) as prev_year_spend
   from cte
)

select year, product_id, curr_year_spend, prev_year_spend,
       round((curr_year_spend/prev_year_spend-1)*100,2) as yoy_rate
from cte2
