WITH combined_sales AS (
    SELECT 
        prod.ProductKey, 
        prod.ProductName, 
        COUNT(prod.ProductKey) AS vendas
    FROM 
        products AS prod
    INNER JOIN 
        product_subcategories AS ps 
        ON ps.ProductSubcategoryKey = prod.ProductSubcategoryKey
    LEFT JOIN 
        sales_2016 AS s16 
        ON s16.ProductKey = prod.ProductKey
    WHERE 
        ps.ProductCategoryKey = 1
    GROUP BY 
        prod.ProductKey, prod.ProductName
    
    UNION ALL
    
    SELECT 
        prod.ProductKey, 
        prod.ProductName, 
        COUNT(prod.ProductKey) AS vendas
    FROM 
        products AS prod
    INNER JOIN 
        product_subcategories AS ps 
        ON ps.ProductSubcategoryKey = prod.ProductSubcategoryKey
    LEFT JOIN 
        sales_2017 AS s17 
        ON s17.ProductKey = prod.ProductKey
    WHERE 
        ps.ProductCategoryKey = 1
    GROUP BY 
        prod.ProductKey, prod.ProductName
)
SELECT 
    comb.ProductKey, 
    comb.ProductName, 
    SUM(comb.vendas) AS total_vendas
FROM 
    combined_sales AS comb
GROUP BY 
    comb.ProductKey, comb.ProductName
ORDER BY 
    total_vendas DESC
LIMIT 10;


