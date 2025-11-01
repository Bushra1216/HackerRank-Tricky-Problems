-- Write a query to obtain the third transaction of every user. Output the user id, spend and transaction date.

select user_id, 
       spend, 
       transaction_date 
from
  (
    select user_id, spend, transaction_date, row_number() over(partition by user_id order by transaction_date asc) as rowing
    from transactions
  ) subq
where rowing=3;
