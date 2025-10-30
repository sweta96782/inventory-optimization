select * from retail_store_inventory;
-- Retrieve the top selling products
SELECT 
    `Product ID`,
    Category,
    SUM(`Units Sold`) as Total_Sales
FROM retail_store_inventory
GROUP BY `Product ID`, Category
ORDER BY Total_Sales DESC
LIMIT 20;

-- 2. LOW STOCK ALERTS
SELECT 
    `Product ID`,
    `Store ID`,
    `Inventory Level`,
    `Units Sold`
FROM retail_store_inventory
WHERE `Inventory Level` < 100
ORDER BY `Inventory Level`;

-- MONTHLY SALES TRENDS
SELECT 
    YEAR(Date) as Year,
    MONTH(Date) as Month,
    SUM(`Units Sold`) as Monthly_Sales
FROM retail_store_inventory
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY Year, Month;

-- Retrieve the sales done by category
SELECT 
    Category,
    SUM(`Units Sold`) as Total_Units,
    AVG(Price) as Average_Price,
    SUM(`Units Sold` * Price) as Total_Revenue
FROM retail_store_inventory
GROUP BY Category
ORDER BY Total_Revenue DESC;

-- Retrieve the Sales done in each region
SELECT Region,
    SUM(`Units Sold`) as Total_Sales,
    COUNT(DISTINCT `Product ID`) as Products_Count
FROM retail_store_inventory
GROUP BY Region
ORDER BY Total_Sales DESC;

-- Retrieve the Products running out of stock
SELECT 
    `Product ID`,
    Category,
    AVG(`Units Sold`) as Daily_Sales,
    MIN(`Inventory Level`) as Current_Stock,
    MIN(`Inventory Level`) / AVG(`Units Sold`) as Days_Left
FROM retail_store_inventory
GROUP BY `Product ID`, Category
HAVING Days_Left < 30
ORDER BY Days_Left;

-- 7. Retrieve the total sales and average sales done in the seasons
SELECT 
    Seasonality,
    SUM(`Units Sold`) as Total_Sales,
    AVG(`Units Sold`) as Average_Daily_Sales
FROM retail_store_inventory
GROUP BY Seasonality
ORDER BY Total_Sales DESC;

-- PRICE vs SALES ANALYSIS
SELECT 
    `Product ID`,
    AVG(Price) as Average_Price,
    SUM(`Units Sold`) as Total_Sales
FROM retail_store_inventory
GROUP BY `Product ID`
ORDER BY Average_Price DESC;

-- PROMOTIONAL EFFECTIVENESS
SELECT 
    `Holiday/Promotion`,
    AVG(`Units Sold`) as Avg_Sales,
    AVG(Discount) as Avg_Discount
FROM retail_store_inventory
GROUP BY `Holiday/Promotion`;

-- INVENTORY vs SALES RATIO
SELECT 
    `Product ID`,
    Category,
    AVG(`Inventory Level`) as Avg_Stock,
    AVG(`Units Sold`) as Avg_Sales,
    AVG(`Inventory Level`) / AVG(`Units Sold`) as Stock_to_Sales_Ratio
FROM retail_store_inventory
GROUP BY `Product ID`, Category
ORDER BY Stock_to_Sales_Ratio DESC;

-- WEATHER IMPACT ON SALES
SELECT 
    `Weather Condition`,
    AVG(`Units Sold`) as Average_Sales
FROM retail_store_inventory
WHERE `Weather Condition` IS NOT NULL
GROUP BY `Weather Condition`
ORDER BY Average_Sales DESC;

-- 12. TOP PERFORMING STORES
SELECT 
    `Store ID`,
    Region,
    SUM(`Units Sold`) as Total_Sales,
    COUNT(DISTINCT `Product ID`) as Products_Sold
FROM retail_store_inventory
GROUP BY `Store ID`, Region
ORDER BY Total_Sales DESC
LIMIT 10;