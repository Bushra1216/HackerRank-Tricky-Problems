 
 
 
 ---Hackerrank Top Competitors problem
SELECT sub_tb.hacker_id,Hackers.name 
FROM
(SELECT tb1.hacker_id,COUNT(DISTINCT challenge_id) AS total_chllng 
FROM
(SELECT Submissions.hacker_id,Challenges.difficulty_level,Challenges.challenge_id, Submissions.score
FROM Submissions INNER JOIN Challenges on Submissions.challenge_id=Challenges.challenge_id) AS tb1
INNER JOIN 
Difficulty ON tb1.difficulty_level = Difficulty.difficulty_level AND Difficulty.score=tb1.score GROUP BY tb1.hacker_id 
HAVING COUNT(DISTINCT challenge_id)>1) AS sub_tb
INNER JOIN Hackers ON sub_tb.hacker_id=Hackers.hacker_id ORDER BY total_chllng DESC, sub_tb.hacker_id;