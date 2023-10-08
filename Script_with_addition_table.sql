/* Считаем что ежедневно триггерами в таблице
   shop_summary суммируются продажи по магазинам
   за плановый месяц   
 */ 
SELECT s.shop_name,
       p.product_name,
       s.fact_cnt AS sales_fact,
       s.plan_cnt AS sales_plan, 
       (s.fact_cnt::NUMERIC / s.plan_cnt)::NUMERIC(5,2)  AS sales_fact_on_plan,
       s.fact_cnt * p.price AS income_fact,
       s.plan_cnt * p.price AS income_plan,
       -- Тоже самое, что и  отношение продаж
       (s.fact_cnt*p.price / (s.plan_cnt * p.price))::NUMERIC(5,2) AS income_fact_on_plan
-- По условиям plan-date - последняя дата планового месяца
-- Устанавливаем дату для получения отчета
FROM shops_summary s
  INNER JOIN products p ON s.product_id = p.product_id 
WHERE s.plan_date = '2023-10-31'
ORDER BY s.shop_name, sales_fact_on_plan DESC




