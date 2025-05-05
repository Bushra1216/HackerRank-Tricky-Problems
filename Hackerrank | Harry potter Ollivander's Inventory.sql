with cte as(
        select a.id, 
               b.age, 
               a.coins_needed, 
               a.power, row_number() over(partition by b.age,a.power order by a.coins_needed asc) as rnk 
        from
             Wands as a 
        join 
           Wands_Property as b 
           on a.code=b.code 
        where b.is_evil=0
)
select id, age, coins_needed, power 
from cte 
where rnk=1
order by power desc, 
         age desc;
