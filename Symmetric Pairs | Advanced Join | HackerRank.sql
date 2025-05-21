


with cte as(
     select A.x as x1, 
            A.y as y1,
            B.x as x2,
            B.y as y2
    from Functions as A
    JOIN Functions as B
    on A.x=B.y 
    and A.y=B.x
    where A.x<=B.x
)
select x1, y1 
from cte
group by x1,y1 
having count(*)> case when x1=y1 THEN 1 ELSE 0 END
order by x1 asc;
