import mysql.connector
import matplotlib.pyplot as plt

conn = mysql.connector.connect(
    host="localhost",
    user="user",
    password="password",
    database="adventure",
    charset="utf8mb4",
    collation="utf8mb4_unicode_ci",
)

cursor = conn.cursor()
cursor.execute("""
WITH combined_sales AS (
    SELECT 
        prod.ProductKey, 
        prod.ProductName, 
        prod.ProductCost,
        prod.ProductPrice,
        COUNT(prod.ProductKey) AS vendas
    FROM 
        products AS prod
    INNER JOIN 
        product_subcategories AS ps 
        ON ps.ProductSubcategoryKey = prod.ProductSubcategoryKey
    LEFT JOIN 
        sales_2015 AS s15 
        ON s15.ProductKey = prod.ProductKey
    WHERE 
        ps.ProductCategoryKey = 1
    GROUP BY 
        prod.ProductKey, prod.ProductName, prod.ProductCost, prod.ProductPrice
    
    UNION ALL
    
    SELECT 
        prod.ProductKey, 
        prod.ProductName, 
        prod.ProductCost,
        prod.ProductPrice,
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
        prod.ProductKey, prod.ProductName, prod.ProductCost, prod.ProductPrice
    
    UNION ALL
    
    SELECT 
        prod.ProductKey, 
        prod.ProductName, 
        prod.ProductCost,
        prod.ProductPrice,
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
        prod.ProductKey, prod.ProductName, prod.ProductCost, prod.ProductPrice
)
SELECT 
    comb.ProductName, 
    SUM(comb.vendas) AS total_vendas,
    SUM(comb.vendas) * (comb.ProductPrice - comb.ProductCost) AS lucro_total
FROM 
    combined_sales AS comb
GROUP BY 
    comb.ProductName, comb.ProductPrice, comb.ProductCost
ORDER BY 
    lucro_total DESC
LIMIT 10;
""")

results = cursor.fetchall()

ProductName, total_vendas, lucro_total = zip(*results)

fig, ax = plt.subplots()
bars = ax.bar(ProductName, total_vendas, color="skyblue")

for bar, lucro in zip(bars, lucro_total):
    yval = bar.get_height()
    ax.text(
        bar.get_x() + bar.get_width() / 2, 
        yval, 
        f'{lucro:.2f}', 
        va='bottom',
        ha='center',
        fontsize=10
    )

ax.set_xlabel("Nome Produto")
ax.set_ylabel("Vendas Totais")
ax.set_title("Vendas Totais e Lucros Por Produto")
plt.xticks(rotation=45, ha='right')
plt.tight_layout()
plt.show()

conn.close()
