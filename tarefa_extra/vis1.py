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
    SELECT 
        DATE_FORMAT(OrderDate, '%y-%m') as MonthYear, 
        SUM(SalesCount) as TotalSales
    FROM (
        SELECT OrderDate, COUNT(*) as SalesCount FROM sales_2015 GROUP BY OrderDate
        UNION ALL
        SELECT OrderDate, COUNT(*) as SalesCount FROM sales_2016 GROUP BY OrderDate
        UNION ALL
        SELECT OrderDate, COUNT(*) as SalesCount FROM sales_2017 GROUP BY OrderDate
    ) as combined_sales
    GROUP BY MonthYear
    ORDER BY MonthYear;
""")

results = cursor.fetchall()

months, salesCounts = zip(*results)
peak_months = sorted(zip(months, salesCounts), key=lambda x: x[1], reverse=True)[:3]


plt.plot(months, salesCounts, color="skyblue")


for month, sales in peak_months:
    index = months.index(month)
    plt.plot(month, sales, 'ro', markersize=10)
    plt.annotate(f'{month}: {sales}', (month, sales), textcoords="offset points", xytext=(0,10), ha='center')


plt.xlabel("Mês")
plt.ylabel("Vendas")
plt.title("Vendas por mês")
plt.tight_layout()
plt.show()

conn.close()
