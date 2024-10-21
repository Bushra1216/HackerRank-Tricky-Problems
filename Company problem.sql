----New Companies founder->lead manager->.....

WITH cte AS (
    SELECT Company.company_code,Company.founder, count(distinct Lead_manager.lead_manager_code) AS total_lead_manager, count(distinct Senior_Manager.senior_manager_code) AS total_senior_manager, 
          count(distinct Manager.manager_code) AS total_manager,count(distinct Employee.employee_code) AS employ_count 
    FROM Company
    LEFT JOIN Lead_Manager ON Company.company_code = Lead_manager.company_code
    LEFT JOIN Senior_Manager ON Company.company_code = Senior_Manager.company_code
    LEFT JOIN Manager ON Company.company_code = Manager.company_code
    LEFT JOIN Employee ON Company.company_code = Employee.company_code
    group by Company.company_code,Company.founder
)

SELECT company_code,
founder,
total_lead_manager,
total_senior_manager,
total_manager,employ_count
FROM cte order by company_code;