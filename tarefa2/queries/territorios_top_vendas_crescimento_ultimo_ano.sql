WITH territory_sales AS (
    SELECT 
        s16.TerritoryKey, 
        ROUND(SUM(prod.ProductPrice), 2) AS valor_acima_media
    FROM 
        sales_2016 AS s16
    INNER JOIN 
        products AS prod 
        ON prod.ProductKey = s16.ProductKey
    GROUP BY 
        s16.TerritoryKey
),
average_sales AS (
    SELECT 
        ROUND(SUM(prod.ProductPrice), 2) / COUNT(DISTINCT s16.TerritoryKey) AS valor_medio
    FROM 
        sales_2016 AS s16
    INNER JOIN 
        products AS prod 
        ON prod.ProductKey = s16.ProductKey
)
SELECT 
    ts.TerritoryKey, 
    ts.valor_acima_media
FROM 
    territory_sales AS ts
CROSS JOIN 
    average_sales AS avg
WHERE 
    ts.valor_acima_media >= avg.valor_medio
ORDER BY 
    ts.valor_acima_media DESC;
