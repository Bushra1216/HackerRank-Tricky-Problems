### Google Interview SQL problem | Window Function | Odd and Even Measurements




 with cte as(
      select measurement_time,
              cast(measurement_time as date) as measurement_day, 
              measurement_value, 
              ROW_NUMBER() over(partition by CAST(measurement_time as date) order by measurement_time asc) as rnk
      from measurements
  ),
 cte1 as(
     select measurement_day,
            sum(measurement_value) as odd_sum 
     from cte
     where rnk % 2=1
     group by measurement_day
),

cte2 as(
    select measurement_day,
           sum(measurement_value) as even_sum 
    from cte
    where rnk % 2=0
    group by measurement_day
)
select cte1.measurement_day, 
       cte1.odd_sum, 
       cte2.even_sum 
from cte1 
FULL OUTER JOIN cte2
on cte1.measurement_day=cte2.measurement_day
order by measurement_day




