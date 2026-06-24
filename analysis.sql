-- Анализ продаж сети магазинов Харьков

-- 1. Трафик по магазинам (средний за рабочий день)
SELECT 
    s.store_name,
    ROUND(AVG(dm.visitors), 1) AS avg_daily_visitors
FROM daily_metrics dm
JOIN stores s ON dm.store_id = s.store_id
WHERE dm.visitors > 0
GROUP BY s.store_name
ORDER BY avg_daily_visitors DESC;

-- 2. Конверсия по магазинам
SELECT 
    s.store_name,
    ROUND(SUM(dm.transactions_count) / SUM(dm.visitors) * 100, 1) AS conversion_rate
FROM daily_metrics dm
JOIN stores s ON dm.store_id = s.store_id
WHERE dm.visitors > 0
GROUP BY s.store_name
ORDER BY conversion_rate DESC;

-- 3. Средний чек по магазинам
SELECT 
    s.store_name,
    ROUND(SUM(dm.revenue) / SUM(dm.transactions_count), 0) AS avg_transaction
FROM daily_metrics dm
JOIN stores s ON dm.store_id = s.store_id
WHERE dm.transactions_count > 0
GROUP BY s.store_name
ORDER BY avg_transaction DESC;
