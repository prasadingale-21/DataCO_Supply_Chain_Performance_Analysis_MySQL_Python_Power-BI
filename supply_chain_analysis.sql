use supply_chain;

CREATE TABLE orders (
    Type                        VARCHAR(50),
    Days_for_shipping_real      INT,
    Days_for_shipment_scheduled INT,
    Benefit_per_order           DECIMAL(10,2),
    Sales_per_customer          DECIMAL(10,2),
    Delivery_Status             VARCHAR(50),
    Late_delivery_risk          INT,
    Category_Id                 INT,
    Category_Name               VARCHAR(100),
    Customer_City               VARCHAR(100),
    Customer_Country            VARCHAR(100),
    Customer_Email              VARCHAR(150),
    Customer_Fname              VARCHAR(50),
    Customer_Id                 INT,
    Customer_Lname              VARCHAR(50),
    Customer_Password           VARCHAR(100),
    Customer_Segment            VARCHAR(50),
    Customer_State              VARCHAR(50),
    Customer_Street             VARCHAR(150),
    Customer_Zipcode            VARCHAR(20),
    Department_Id               INT,
    Department_Name             VARCHAR(100),
    Market                      VARCHAR(50),
    Order_City                  VARCHAR(100),
    Order_Country               VARCHAR(100),
    Order_Customer_Id           INT,
    order_date_DateOrders       VARCHAR(50),
    Order_Id                    INT,
    Order_Item_Cardprod_Id      INT,
    Order_Item_Discount         DECIMAL(10,2),
    Order_Item_Discount_Rate    DECIMAL(10,4),
    Order_Item_Id               INT,
    Order_Item_Product_Price    DECIMAL(10,2),
    Order_Item_Profit_Ratio     DECIMAL(10,4),
    Order_Item_Quantity         INT,
    Sales                       DECIMAL(10,2),
    Order_Item_Total            DECIMAL(10,2),
    Order_Profit_Per_Order      DECIMAL(10,2),
    Order_Region                VARCHAR(100),
    Order_State                 VARCHAR(100),
    Order_Status                VARCHAR(50),
    Order_Zipcode               VARCHAR(20),
    Product_Card_Id             INT,
    Product_Category_Id         INT,
    Product_Description         TEXT,
    Product_Image               VARCHAR(255),
    Product_Name                VARCHAR(150),
    Product_Price               DECIMAL(10,2),
    Product_Status              INT,
    shipping_date_DateOrders    VARCHAR(50),
    Shipping_Mode               VARCHAR(50)
);

-- How many rows loaded?
select count(*) from orders;

-- Preview first 10 rows
	

-- Check for any completely critical columns

select 
	count(*) as total_rows,
    SUM(CASE WHEN Delivery_Status IS NULL THEN 1 ELSE 0 END) AS Missing_delivery_status,
    SUM(CASE WHEN Days_for_shipping_real IS NULL THEN 1 ELSE 0 END) AS Missing_Actual_Days,
	SUM(CASE WHEN Order_Id IS NULL THEN 1 ELSE 0 END) AS Missing_order_id
FROM orders;

-- Query 1 — Overall Late Delivery Rate
-- Business question: "What % of our total orders are being delivered late?" — This is the headline KPI of your entire project.

 SELECT 
	COUNT(*) AS Total_Orders,
    SUM(CASE WHEN Late_delivery_risk = 1 THEN 1 ELSE 0 END) AS Late_Orders,
    ROUND(SUM(CASE WHEN Late_delivery_risk = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS Late_Delivery_Percent
FROM orders;

-- Query 2 — Late Delivery Rate by Region & Market
-- Business question: "Which geographic markets are underperforming on deliveries?"

 SELECT 
	Market,
    Order_Region,
	COUNT(*) AS Total_Orders,
    SUM(CASE WHEN Late_delivery_risk = 1 THEN 1 ELSE 0 END) AS Late_Orders,
    ROUND(SUM(CASE WHEN Late_delivery_risk = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS Late_Delivery_Percent
FROM orders
GROUP BY Market, Order_Region
ORDER BY Late_Delivery_Percent DESC;

-- Query 3 — Late Delivery by Shipping Mode
-- Business question: "Which shipping methods are causing the most delays?"

 SELECT 
	Shipping_Mode,
	COUNT(*) AS Total_Orders,
    SUM(CASE WHEN Late_delivery_risk = 1 THEN 1 ELSE 0 END) AS Late_Orders,
    ROUND(SUM(CASE WHEN Late_delivery_risk = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS Late_Delivery_Percent,
    ROUND(AVG(Days_for_shipping_real), 2) AS Avg_Actual_Days_Shipping,
    ROUND(AVG(Days_for_shipment_scheduled), 2) AS Avg_scheduled_Days,
    ROUND(AVG(Days_for_shipping_real - Days_for_shipment_scheduled), 2) AS Avg_delay_gap
FROM orders
GROUP BY Shipping_Mode
ORDER BY Late_Delivery_Percent DESC;

-- Query 4 — Late Delivery by Product Category
-- Business question: "Which product types are associated with the most delays?"

 SELECT 
	Department_Name,
    Category_Name,
	COUNT(*) AS Total_Orders,
    SUM(CASE WHEN Late_delivery_risk = 1 THEN 1 ELSE 0 END) AS Late_Orders,
    ROUND(SUM(CASE WHEN Late_delivery_risk = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS Late_Delivery_Percent,
    ROUND(AVG(Days_for_shipping_real - Days_for_shipment_scheduled), 2) AS Avg_delay_gap
FROM orders
GROUP BY Department_Name, Category_Name
ORDER BY Late_Delivery_Percent DESC;

-- Query 5 — Customer Segment Profitability vs Delay Rate
-- Business question: "Are our most profitable customers also the ones experiencing the most delays? Or are we losing money AND failing them?"

 
 WITH Segment_Summary AS (
 SELECT 
	Customer_Segment,
	COUNT(*) AS Total_Orders,
    SUM(CASE WHEN Late_delivery_risk = 1 THEN 1 ELSE 0 END) AS Late_Orders,
    ROUND(SUM(CASE WHEN Late_delivery_risk = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS Late_Delivery_Percent,
    ROUND(AVG(Order_Profit_Per_Order), 2) AS Avg_Profit_per_Order,
    ROUND(SUM(Sales), 2 ) AS Total_Sales,
    ROUND(SUM(Order_Profit_Per_Order), 2) AS Total_Profit
FROM orders
GROUP BY Customer_Segment
)
SELECT
	Customer_Segment,
    Total_Orders,
    Late_Orders,
    Late_Delivery_Percent,
    Avg_Profit_per_Order,
    Total_Sales,
    Total_Profit,
    CASE
		WHEN Late_Delivery_Percent > 50 AND Avg_Profit_per_Order > 0 THEN 'High Delay - Profitable'
        WHEN Late_Delivery_Percent > 50 AND Avg_Profit_per_Order <= 0 THEN 'High Delay - Losing Money'
        WHEN Late_Delivery_Percent <= 50 AND Avg_Profit_per_Order > 0 THEN 'On Track - Profitable'
        ELSE 'On Track - Review Needed'
	END AS Segment_Health
    FROM Segment_Summary
    ORDER BY Total_Profit DESC;
    
-- Monthly Trend Using Window Function
-- Business question: "Is our late delivery situation getting better or worse over time?"

SELECT
	DATE_FORMAT(STR_TO_DATE(order_date_DateOrders, '%m/%d/%Y %H:%i'), '%Y-%m') AS order_month,
    COUNT(*) AS Total_Orders,
    SUM(CASE WHEN Late_delivery_risk = 1 THEN 1 ELSE 0 END) AS Late_Orders,
    ROUND(
		SUM(CASE WHEN Late_delivery_risk = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS Late_Delivery_Percent,
    ROUND(
		AVG(SUM(CASE WHEN Late_delivery_risk = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100) OVER(ORDER BY DATE_FORMAT(STR_TO_DATE(order_date_DateOrders, '%m/%d/%Y %H:%i'), '%Y-%m')
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS Rolling_3m_late_Percent
FROM orders
GROUP BY order_month
ORDER BY order_month;
