# Brazilian E-Commerce Analysis (Olist)

SQL analysis of a Brazilian e-commerce dataset covering 100k+ orders across 2016–2018, with focus on sales performance, customer behavior, delivery efficiency, and seller rankings.

## Stack

- PostgreSQL, pgAdmin, DBeaver
- Tableau Public
- Dataset: [Brazilian E-Commerce Public Dataset by Olist (Kaggle)](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

## Dataset

9 relational tables: orders, customers, order items, payments, reviews, products, sellers, geolocation, product category translations.

- 99,441 orders
- 3,095 unique sellers
- 32,951 unique products
- 71 product categories (translated to English)
- Coverage: September 2016 — October 2018

## SQL Files

- `olist_eda.sql` — dataset overview, order status distribution, volume metrics (JOIN, window functions)
- `olist_sales_analysis.sql` — monthly revenue trends, top categories by revenue and review score (JOIN, LEFT JOIN)
- `olist_customer_analysis.sql` — top cities by orders and revenue, payment method breakdown, average delivery time by state (JOIN, GROUP BY)
- `olist_seller_analysis.sql` — top sellers by revenue with market share ranking, new vs returning customers (CTE, RANK, UNION ALL)
- `olist_advanced.sql` — review score vs delivery performance, top and bottom categories by review score (JOIN, CTE, RANK)

## Key Findings

**Sales**
- Total revenue: $20.3M across 98,665 delivered orders
- Clear growth trend from late 2016 through mid-2018, with a notable spike in November 2017 (Black Friday)
- Health & beauty and watches/gifts are the highest-revenue categories

**Customers**
- São Paulo accounts for 15k+ orders — nearly 3x the second-largest city (Rio de Janeiro)
- 96.9% of customers made only one purchase — retention is a significant gap for the platform
- Credit card is the dominant payment method (76% of transactions, avg 3.5 installments)

**Delivery**
- SP delivers fastest at 8.8 days avg; northern states (RR, AP) average 28+ days
- Orders with review score 1 arrived on average 3.4 days later than estimated, while score 5 orders arrived 12.7 days earlier than estimated.

**Sellers**
- Top seller holds only 1.68% of total revenue — market is highly fragmented
- Most top sellers are concentrated in São Paulo state

## Dashboard

[Tableau Public — Brazilian E-Commerce Analysis](https://public.tableau.com/app/profile/denys.brativnyk/viz/BrazilianE-CommerceAnalysis_17825683940040/Dashboard1)
