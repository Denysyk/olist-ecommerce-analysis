-- Revenue і кількість замовлень по місяцях
SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(SUM(op.payment_value)::numeric, 2) AS revenue
FROM orders o
JOIN order_payments op ON o.order_id = op.order_id
WHERE o.order_status = 'delivered'
GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp)
ORDER BY month;

-- Топ 10 категорій за revenue
SELECT
    COALESCE(pct.product_category_name_english, p.product_category_name, 'unknown') AS category,
    COUNT(DISTINCT oi.order_id) AS orders,
    ROUND(SUM(oi.price)::numeric, 2) AS revenue,
    ROUND(AVG(r.review_score)::numeric, 2) AS avg_review
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN product_category_translation pct ON p.product_category_name = pct.product_category_name
LEFT JOIN order_reviews r ON oi.order_id = r.order_id
GROUP BY category
ORDER BY revenue DESC
LIMIT 10;