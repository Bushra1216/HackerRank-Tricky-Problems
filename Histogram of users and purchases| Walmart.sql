with cte as(
     SELECT
          transaction_date, user_id,count(product_id) as purchase_count,
          ROW_NUMBER() over(partition by user_id order by transaction_date DESC) as numbering
  from user_transactions
  group by user_id,transaction_date
  order by purchase_count ASC
)

select transaction_date, 
       user_id, 
       purchase_count
from cte 
where numbering=1
order by transaction_date
