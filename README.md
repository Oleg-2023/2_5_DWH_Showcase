# 2_5_DWH_Showcase
## Учебное задание по теме DWH. Витрины данных
### Задание
1. Добавить недостающую таблицу будет вашим первым заданием.
   На мой взгляд данных достаточно для создания витрины данных. Запрос собирающий данные для витрины без дополнительной таблицы приведен в файле __Script_without_addition_table.sql__

2. Собрать витрину данных. Как уже изначально было озвучено, аналитикам нужно оценить, насколько отдел планирования хорошо делает свою работу.
Допустим, что данные собираются и агрегируются, так же требуется более простой запрос.
Тогда возможно добавить таблицу __shops_summary__ со следующими колонками:  
 __shops_summary_id__ - первичный ключ  
 __shop_name__ - наименование магазина (считаем, что магазинов всегда будет небольшое кол-во, все названия уникальные)  
 __product_id__ - код товара. Внешний ключ  
 __fact_cnt__ - сумма всех продаж на плановую дату  
 __plan_date__ - плановая дата (последнее число планового месяца)*  
 __plan_cnt__ - план продаж на месяц*  
   ___Примечания:___ _*Последние два поля перенесены из таблицы plan, другое решение - ввести в таблицу plan поле plan_id и сделать на него внешний ключ, но в задании про возможность изменять существующие таблицы не сказано._    
![image](https://github.com/Oleg-2023/2_5_DWH_Showcase/assets/144448179/d3ff6a08-8fe1-47a5-b839-60d140b98ce7)

