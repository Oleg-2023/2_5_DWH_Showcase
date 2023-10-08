WITH current_plan AS (
  SELECT shop_name, 
         plan_count, 
         product_id, 
         date_trunc('MONTH', pl.plan_date)::date AS start_date,
         pl.plan_date AS end_date
  FROM plan pl
  -- По условиям plan-date - последняя дата планового месяца
  -- Устанавливаем дату для получения отчета
  WHERE pl.plan_date = '2023-10-31'
),
all_shop_sum AS (
  SELECT shop_name, plan_count, product_id, sum(sales_cnt) AS sales_cnt
  FROM 
  (
    SELECT shop_name, plan_count, p.product_id, sales_cnt	
    FROM current_plan p, shop_dns s
    WHERE  
      shop_name = 'DNS' AND
      p.product_id = s.product_id AND
      "date" BETWEEN start_date AND end_date  
    UNION ALL
    SELECT shop_name, plan_count, p.product_id, sales_cnt
    FROM current_plan p, shop_mvideo s
    WHERE  
      shop_name = 'MVideo' AND
      p.product_id = s.product_id AND
      "date" BETWEEN start_date AND end_date
    UNION ALL
    SELECT shop_name, plan_count, p.product_id, sales_cnt
    FROM current_plan p, shop_mvideo s
    WHERE  
      shop_name = 'Sitilink' AND
      p.product_id = s.product_id AND
      "date" BETWEEN start_date AND end_date    
  ) all_records
  GROUP BY shop_name, plan_count, product_id
)
-- Главный запрос
SELECT s.shop_name,
       p.product_name,
       s.sales_cnt AS sales_fact,
       s.plan_count AS sales_plan, 
       (s.sales_cnt::NUMERIC / s.plan_count)::NUMERIC(5,2)  AS sales_fact_on_plan,
       s.sales_cnt*p.price AS income_fact,
       s.plan_count*p.price AS income_plan,
       -- Тоже самое, что и  отношение продаж
       (s.sales_cnt*p.price / s.plan_count / p.price)::NUMERIC(5,2) AS income_fact_on_plan
FROM all_shop_sum s
  INNER JOIN products p ON s.product_id = p.product_id 
ORDER BY s.shop_name, sales_fact_on_plan DESC




