# DataCO_Supply_Chain_Analysis_MySQL_Python_Power-BI  

## SUPPLY CHAIN PERFORMANCE ANALYSIS

**Prepared by**: Prasad Ingale
**Date:** 04/06/2026
**Dataset:** DataCo Global Supply Chain | 180,519 Orders
**Tools Used:** MySQL · Python · Power BI

### **Executive Summary:**    

This analysis examines 180,519 supply chain orders across 5 global markets to identify the root causes of late deliveries. Our analysis found that 54.83 % of all orders were delivered late, resulting in significant customer experience risk. The highest delay rates were observed in central Africa region. First Class shipping emerged as the most problematic shipping mode with a 95.32% late delivery rate. This report outlines key findings and actionable recommendations to reduce late delivery rates.

### **Key Findings:**  

1.	Overall Late Delivery Rate:  
54.83 % of all 180,519 orders were flagged as late deliveries. This means nearly 1 in 2 orders fails to reach the customer within the scheduled timeframe, directly impacting customer satisfaction scores."

2.	Regional Performance:  
At the market level, Europe recorded the highest late delivery rate at 55.21%, followed closely by Pacific Asia at 55.05%. Drilling deeper into regional data, Central Africa (57.96%) and South Asia (56.27%) emerged as the worst performing individual regions — suggesting that while Europe leads at market level, specific regions within Africa and Pacific Asia require the most urgent operational attention.

3.	Shipping Mode Impact:   
First Class shipping recorded the highest late delivery rate at 95.32% with an average delay gap of 1.00 day beyond the scheduled date. Second Class followed closely at 76.63% with a 1.99-day average gap — the worst delay gap across all shipping modes. In contrast, Standard Class shipping maintained the best on-time performance at 38.07% despite processing 107,752 orders — nearly 60% of all orders in the dataset.

4.	Product Category Insight:  
Cleats and Men’s Footewear - products recorded the highest volume of late orders at 13K and 12K respectively. These categories also carry above-average order values, meaning delays here represent disproportionate revenue risk.

5.	Customer Segment Analysis:  
The Consumer segment represents the largest order volume at 94 thousand orders but also carries the highest late delivery exposure. Despite this, average profit per order remains positive at $22.18, indicating that service improvement investments in this segment would yield strong ROI.

Recommendations:
1.	First Class and Second-Class shipping drive the majority of late deliveries at 95.32% and 76.63% respectively. We recommend a carrier performance audit for these two modes and introducing automatic escalation alerts when high-value First Class orders show delay risk.

2.	Targeted Operational Intervention in High-Risk Regions While Europe leads at market level with a 55.21% late delivery rate, the regional drilldown reveals that Central Africa (57.96%) and South Asia (56.27%) are the worst performing individual regions in the entire dataset. We recommend a two-track approach:
Immediate action — conduct a logistics routing and carrier performance audit specifically in Central Africa and South Asia where delays are most acute
Market-level review — initiate an SLA renegotiation with European distribution partners given the highest overall market volume of 50,252 orders at 55.21% late rate
Addressing these two tracks simultaneously would cover both the highest volume market and the highest delay rate regions. Expected outcome: 10–15% reduction in late delivery rates across these priority markets within two quarters.
3.	Flag high-risk category + shipping combinations First Class shipping is failing at a 95.32% late delivery rate while Second Class carries the worst average delay gap of 1.99 days — both unacceptable given these customers expect premium service. We recommend an immediate carrier audit for both modes to identify SLA breaches, alongside an automated routing rule that escalates high-value First Class orders to priority handling before they miss delivery windows. Standard Class processes 60% of all orders at only 38.07% late rate — its operational practices should be benchmarked and applied to underperforming modes. Expected outcome: Reducing First Class late delivery rate to below 60% would improve the overall company late delivery rate by approximately 8–10 percentage points.

4.	Implement real-time delay alerting Currently delays are only visible after the fact. Integrating delivery gap monitoring into operations dashboards (such as this Power BI report) would allow proactive intervention before a shipment becomes late.

5.	Review scheduling accuracy- The average delivery gap of 0.57 days suggests that scheduled delivery dates may be systematically underestimated. Recalibrating scheduling algorithms to reflect actual carrier performance would improve customer promise accuracy immediately.

### **Limitations & Next Steps:**
This analysis is based on historical order data and does not account for real-time inventory or carrier API data. Future analysis could incorporate live data feeds, weather disruption data, and carrier performance scores to build a predictive delay model. Additionally, integrating customer satisfaction scores would allow direct correlation between delivery delays and churn risk.
Delivery Status Distribution

### Visuals:

<img width="814" height="400" alt="image" src="https://github.com/user-attachments/assets/3fbcb9e7-9e71-41a0-aaea-6de499d4c946" />

<img width="812" height="362" alt="image" src="https://github.com/user-attachments/assets/c6576d60-4ed1-4de4-a334-d91a20e3847a" />

<img width="940" height="464" alt="image" src="https://github.com/user-attachments/assets/ca137523-7855-49c2-9705-b2276f2b930e" />   

<img width="940" height="419" alt="image" src="https://github.com/user-attachments/assets/496595c6-b2cd-41cc-8183-c8ba88c7f785" />   

<img width="940" height="354" alt="image" src="https://github.com/user-attachments/assets/608948a9-2138-4f4b-a974-7d34e31dcf88" />  

<img width="940" height="554" alt="image" src="https://github.com/user-attachments/assets/bd2f5e61-2761-4742-aca9-e9dde75beffa" />  

### **Power BI Dashboard**

<img width="940" height="523" alt="image" src="https://github.com/user-attachments/assets/32eae25c-08e7-4e68-a202-a777942993a6" />   

<img width="940" height="546" alt="image" src="https://github.com/user-attachments/assets/1ebab99d-3ea0-4965-9ac0-f394eba4c582" />   

<img width="940" height="557" alt="image" src="https://github.com/user-attachments/assets/4dd738ce-5cc5-4376-a066-e11a79011a46" />   

<img width="940" height="560" alt="image" src="https://github.com/user-attachments/assets/7e865f06-c518-485b-bf9a-1ba3c6b165a7" />




 


 
 
