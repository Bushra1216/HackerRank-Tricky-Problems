

select ticker, 
       to_char(high_m, 'Mon-YYYY') as highest_mth,
       max_open as highest_open, 
       to_char(low_m, 'Mon-YYYY'), 
       low_open as lowest_open 
from(
select distinct 
    ticker, 
    first_value(date) over(partition by ticker order by open desc) as high_m,
    first_value(open) over(partition by ticker order by open desc) as max_open,
    first_value(date) over(partition by ticker order by open asc) as low_m,
    first_value(open) over(partition by ticker order by open asc) as low_open
from stock_prices) subq
order by ticker;
