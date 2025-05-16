

with cte as(
      select Task_Id, 
             Start_Date, 
             End_Date, 
             LAG(End_Date) OVER(ORDER BY Start_Date) AS previous_end
      from Projects
),
cte2 as(
      select Start_Date, 
             End_date,
             previous_end,
             CASE 
               WHEN Start_Date = previous_end THEN 0 
               ELSE 1 
             END AS new_project
      from cte
),
project_group as(
      select Start_Date, 
             End_date, 
             SUM(new_project) OVER(ORDER BY Start_Date) AS project_no
      from cte2
),
project_days_count as(
      select project_no, 
             MIN(Start_Date) AS st, 
             MAX(End_Date) AS en,
             DATEDIFF(DAY, MIN(Start_Date), MAX(End_Date)) + 1 AS total_days
      from project_group
      group by project_no
)
select st, en
from project_days_count
ORDER BY total_days asc, st;
