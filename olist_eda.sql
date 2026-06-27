-- Загальна картина
SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    COUNT(DISTINCT oi.seller_id) AS total_sellers,
    COUNT(DISTINCT oi.product_id) AS total_products,
    ROUND(SUM(op.payment_value)::numeric, 2) AS total_revenue,
    ROUND(AVG(op.payment_value)::numeric, 2) AS avg_order_value
FROM orders o
JOIN order_payments op ON o.order_id = op.order_id
JOIN order_items oi ON o.order_id = oi.order_id;

-- Розподіл статусів замовлень
SELECT
    order_status,
    COUNT(*) AS order_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;