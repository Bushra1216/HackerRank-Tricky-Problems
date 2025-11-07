-- identify the top two highest-grossing products within each category in the year 2022. The output should include the category, product, and total spend.

WITH CTE AS(
     SELECT category, 
             product, 
             spend, 
             EXTRACT(YEAR FROM transaction_date) AS year 
      FROM
          product_spend
      WHERE EXTRACT(YEAR FROM transaction_date)=2022
),
CTE2 AS(
   SELECT category,
          product, 
          SUM(spend) AS total_spend FROM CTE
   GROUP BY category,product
),
CTE3 AS(
   SELECT category,
          product, 
          total_spend,
          DENSE_RANK() OVER(PARTITION BY category ORDER BY total_spend DESC) AS rnk
   FROM CTE2)
SELECT  category, 
        product, 
        total_spend FROM CTE3
WHERE rnk<=2;




-- optimized query

WITH CTE AS(
     SELECT category,product, 
            SUM(spend) AS total_spend, 
            DENSE_RANK() OVER(PARTITION BY category ORDER BY SUM(spend) DESC) AS rnk
     FROM product_spend
     WHERE EXTRACT(YEAR FROM transaction_date)=2022
     GROUP BY category,
              product
)
SELECT category, product, total_spend
FROM CTE
WHERE rnk<=2;
