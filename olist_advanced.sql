-- Розподіл оцінок і зв'язок з часом доставки
SELECT
    r.review_score,
    COUNT(*) AS reviews,
    ROUND(AVG(
        EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_estimated_delivery_date)) / 86400
    )::numeric, 1) AS avg_days_vs_estimate
FROM order_reviews r
JOIN orders o ON r.order_id = o.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY r.review_score
ORDER BY r.review_score;

-- Категорії з найгіршими і найкращими відгуками (мін. 100 замовлень)
WITH category_reviews AS (
    SELECT
        COALESCE(pct.product_category_name_english, p.product_category_name, 'unknown') AS category,
        COUNT(*) AS reviews,
        ROUND(AVG(r.review_score)::numeric, 2) AS avg_score
    FROM order_reviews r
    JOIN order_items oi ON r.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    LEFT JOIN product_category_translation pct ON p.product_category_name = pct.product_category_name
    GROUP BY category
    HAVING COUNT(*) >= 100
)
SELECT category, reviews, avg_score,
    RANK() OVER (ORDER BY avg_score DESC) AS rank
FROM category_reviews
ORDER BY avg_score DESC
LIMIT 10;



