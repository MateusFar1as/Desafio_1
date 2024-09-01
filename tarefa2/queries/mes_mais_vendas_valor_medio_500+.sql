WITH monthly_sales AS (
    SELECT 
        MONTH(s15.OrderDate) AS mes, 
        ROUND(SUM(prod.ProductPrice), 2) AS total_valor, 
        COUNT(*) AS num_vendas
    FROM 
        sales_2015 AS s15
    INNER JOIN 
        products AS prod 
        ON prod.ProductKey = s15.ProductKey
    GROUP BY 
        MONTH(s15.OrderDate)
    
    UNION ALL
    
    SELECT 
        MONTH(s16.OrderDate) AS mes, 
        ROUND(SUM(prod.ProductPrice), 2) AS total_valor, 
        COUNT(*) AS num_vendas
    FROM 
        sales_2016 AS s16
    INNER JOIN 
        products AS prod 
        ON prod.ProductKey = s16.ProductKey
    GROUP BY 
        MONTH(s16.OrderDate)
    
    UNION ALL
    
    SELECT 
        MONTH(s17.OrderDate) AS mes, 
        ROUND(SUM(prod.ProductPrice), 2) AS total_valor, 
        COUNT(*) AS num_vendas
    FROM 
        sales_2017 AS s17
    INNER JOIN 
        products AS prod 
        ON prod.ProductKey = s17.ProductKey
    GROUP BY 
        MONTH(s17.OrderDate)
),
monthly_avg_sales AS (
    SELECT 
        mes, 
        SUM(total_valor) AS total_valor, 
        SUM(num_vendas) AS total_vendas
    FROM 
        monthly_sales
    GROUP BY 
        mes
)
SELECT 
    mes, 
    total_valor,
    (total_valor / total_vendas) AS avg_valor_por_venda
FROM 
    monthly_avg_sales
WHERE 
    (total_valor / total_vendas) > 500
ORDER BY 
    total_valor DESC
LIMIT 1;
