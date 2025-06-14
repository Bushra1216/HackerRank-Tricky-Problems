
WITH cte AS(
     SELECT clg.contest_id, cont.hacker_id, cont.name,  clg.college_id
     FROM Colleges AS clg 
     JOIN Contests AS cont
     ON clg.contest_id=cont.contest_id
),
cte2 AS(
    SELECT chlln.college_id, chlln.challenge_id, clg.contest_id 
    FROM Challenges AS chlln
    JOIN Colleges AS clg
    ON chlln.college_id=clg.college_id
),
cte3 AS(
   SELECT cte.hacker_id, cte.name, cte2.college_id, cte2.contest_id, cte2.challenge_id
   FROM cte2
   JOIN cte
   ON cte2.contest_id=cte.contest_id
   AND cte2.college_id=cte.college_id
),
cte_viewStat AS(
  SELECT cte3.contest_id, cte3.hacker_id, cte3.name,  
         SUM(COALESCE(vw.total_views, 0)) AS total_views,
         SUM(COALESCE(vw.total_unique_views, 0)) AS total_unique_views
  FROM cte3
  LEFT JOIN View_Stats AS vw
  ON cte3.challenge_id=vw.challenge_id
  GROUP BY cte3.contest_id,
           cte3.hacker_id,
           cte3.name
),
cte_totalSubmit AS(
  SELECT cte3.contest_id,
         SUM(COALESCE(ss.total_submissions, 0)) AS total_submissions,
         SUM(COALESCE(ss.total_accepted_submissions, 0)) AS total_accepted_submissions
  FROM cte3
  LEFT JOIN Submission_Stats AS ss
  ON cte3.challenge_id=ss.challenge_id
  GROUP BY cte3.contest_id
),
SELECT cte_viewStat.contest_id, 
       cte_viewStat.hacker_id, 
       cte_viewStat.name, 
       total_submissions, 
       total_accepted_submissions,
       total_views,
       total_unique_views 
FROM cte_totalSubmit
JOIN cte_viewStat
ON 
  cte_totalSubmit.contest_id=cte_viewStat.contest_id
ORDER BY cte_totalSubmit.contest_id;
