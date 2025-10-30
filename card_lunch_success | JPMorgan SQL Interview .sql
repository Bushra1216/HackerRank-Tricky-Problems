-- Write a query that outputs the name of the credit card, and how many cards were issued in its launch month. The launch month is the earliest record in the monthly_cards_issued table for a given card. Order the results starting from the biggest issued amount

-- organized card_name by earliest isuue_year with ascending month and assign row number in earliest credit card launches
with cte as(
select card_name,
       issued_amount, 
       issue_month,
       issue_year,
       rank() over(partition by issue_year order by issue_month asc) as rnk
from monthly_cards_issued 
)
select card_name, issued_amount from cte where rnk=1; -- and finally select earliest record with biggest issued amount.
