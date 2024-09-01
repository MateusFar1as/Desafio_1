SELECT 
    prod.ProductKey, 
    prod.ProductName, 
    prod.ModelName, 
    COUNT(ret.ProductKey) AS Total_retornos
FROM 
    returns AS ret
INNER JOIN 
    products AS prod 
    ON prod.ProductKey = ret.ProductKey
GROUP BY 
    prod.ProductKey, 
    prod.ProductName, 
    prod.ModelName
ORDER BY 
    Total_retornos DESC
LIMIT 5;
