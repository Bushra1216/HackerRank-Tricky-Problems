
with cte as(
     select count(a.employee_id) as emp, 
            count(distinct b.query_id) as unique_qr_count
    from employees as a 
    left join queries as b
    on a.employee_id=b.employee_id
    and 
       extract(MONTH from query_starttime) in(7,8,9)
   group by a.employee_id
)

select distinct unique_qr_count as unique_queries, 
       count(emp)
from cte
group by unique_qr_count
order by unique_qr_count
