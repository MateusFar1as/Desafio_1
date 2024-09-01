SELECT 
    cus.CustomerKey, 
    cus.FirstName, 
    cus.LastName, 
    COUNT(s16.CustomerKey) AS total_compras
FROM 
    customers AS cus
INNER JOIN 
    sales_2016 AS s16 
    ON s16.CustomerKey = cus.CustomerKey
WHERE 
    EXISTS (
        SELECT 1 FROM sales_2016 AS s16_q1
        WHERE s16_q1.CustomerKey = cus.CustomerKey
        AND s16_q1.OrderDate >= '2016-01-01' AND s16_q1.OrderDate < '2016-04-01'
    ) 
    AND EXISTS (
        SELECT 1 FROM sales_2016 AS s16_q2
        WHERE s16_q2.CustomerKey = cus.CustomerKey
        AND s16_q2.OrderDate >= '2016-04-01' AND s16_q2.OrderDate < '2016-07-01'
    )
    AND EXISTS (
        SELECT 1 FROM sales_2016 AS s16_q3
        WHERE s16_q3.CustomerKey = cus.CustomerKey
        AND s16_q3.OrderDate >= '2016-07-01' AND s16_q3.OrderDate < '2016-10-01'
    )
    AND EXISTS (
        SELECT 1 FROM sales_2016 AS s16_q4
        WHERE s16_q4.CustomerKey = cus.CustomerKey
        AND s16_q4.OrderDate >= '2016-10-01' AND s16_q4.OrderDate < '2017-01-01'
    )
GROUP BY 
    cus.CustomerKey, cus.FirstName, cus.LastName
ORDER BY 
    total_compras DESC
LIMIT 1;
