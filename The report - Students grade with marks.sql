---The Report problem
select
case
when Grades.Grade<8 then 'NULL'
else Students.Name
END AS tb, Grades.Grade as gd,Students.Marks as mk
from Students INNER JOIN Grades ON Students.Marks between  Grades.Min_Mark and Grades.Max_Mark 
order by Grades.Grade desc,Students.Name asc,Students.Marks asc;
