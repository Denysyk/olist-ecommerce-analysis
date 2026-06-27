-- Рейтинг продавців за revenue з window function
WITH seller_stats AS (
    SELECT
        oi.seller_id,
        s.seller_city,
        s.seller_state,
        COUNT(DISTINCT oi.order_id) AS orders,
        ROUND(SUM(oi.price)::numeric, 2) AS revenue,
        ROUND(AVG(r.review_score)::numeric, 2) AS avg_review
    FROM order_items oi
    JOIN sellers s ON oi.seller_id = s.seller_id
    LEFT JOIN order_reviews r ON oi.order_id = r.order_id
    GROUP BY oi.seller_id, s.seller_city, s.seller_state
)
SELECT
    seller_id,
    seller_city,
    seller_state,
    orders,
    revenue,
    avg_review,
    RANK() OVER (ORDER BY revenue DESC) AS revenue_rank,
    ROUND(100.0 * revenue / SUM(revenue) OVER (), 2) AS revenue_share_pct
FROM seller_stats
ORDER BY revenue_rank
LIMIT 10;

-- UNION: порівняння нових vs повторних покупців
WITH customer_orders AS (
    SELECT
        customer_unique_id,
        COUNT(o.order_id) AS order_count
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY customer_unique_id
)
SELECT 'new' AS customer_type, COUNT(*) AS customers
FROM customer_orders WHERE order_count = 1
UNION ALL
SELECT 'returning' AS customer_type, COUNT(*) AS customers
FROM customer_orders WHERE order_count > 1
ORDER BY customers DESC;