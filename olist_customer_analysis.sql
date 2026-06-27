-- Топ 10 міст за кількістю замовлень
SELECT
    c.customer_city,
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(SUM(op.payment_value)::numeric, 2) AS revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_payments op ON o.order_id = op.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_city, c.customer_state
ORDER BY orders DESC
LIMIT 10;

-- Методи оплати
SELECT
    payment_type,
    COUNT(*) AS transactions,
    ROUND(SUM(payment_value)::numeric, 2) AS total_value,
    ROUND(AVG(payment_installments)::numeric, 2) AS avg_installments
FROM order_payments
GROUP BY payment_type
ORDER BY transactions DESC;

-- Середній час доставки по штатах (топ 10)
SELECT
    c.customer_state,
    ROUND(AVG(
        EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_purchase_timestamp)) / 86400
    )::numeric, 1) AS avg_delivery_days,
    COUNT(*) AS orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_delivery_days
LIMIT 10;