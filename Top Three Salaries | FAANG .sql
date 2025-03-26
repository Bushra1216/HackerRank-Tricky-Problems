with cte as(
     select a.name,
            a.salary,
            b.department_name,
            dense_rank() over(partition by department_name order by salary desc) as rnk
    from 
       employee as a 
    join
       department as b
    on a.department_id=b.department_id
 )
 
select department_name,
        name,
        salary
from cte
where rnk<=3
order by department_name
    
