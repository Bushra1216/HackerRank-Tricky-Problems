with cte as(
     select a.hacker_id, a.name, 
            count(challenge_id) as total_challenge 
     from
          Hackers a 
     join     
         Challenges b 
     on a.hacker_id=b.hacker_id
     group by a.hacker_id, 
              a.name
),
cte2 as(
    select total_challenge, 
           count(*) as hc_cnt 
    from  cte 
    group by total_challenge
),
cte3 as(
    select hacker_id, name, total_challenge 
    from cte 
    where total_challenge = (select max(total_challenge) from cte)
),
cte4 as(
    select x.hacker_id, x.name, x.total_challenge 
    from cte as x
    join cte2 as y
    on x.total_challenge = y.total_challenge
    where x.total_challenge< (select max(total_challenge) from cte)
    and y.hc_cnt<2
  ),
cte5 as(
   select * from cte3 UNION select * from cte4
)
select * from cte5 
order by total_challenge desc,
         hacker_id asc;
