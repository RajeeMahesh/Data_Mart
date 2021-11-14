1.What day of the week is used for each week_date value?
select (case when day = 1 then 'Monday'
             when day = 2 then 'Tuesday'
        	 when day = 3 then 'Wednesday'
        	 when day = 4 then 'thursday'
        	 when day = 5 then 'friday'
        	 when day = 6 then 'Saturday'
        	 when day = 0 then 'Sunday' end) as day
from         	 
(select extract(dow from week_date) as day 
from clean_weekly_sales) t1

2.What range of week numbers are missing from the dataset?
select range, count(range)
from 
      (select week_no, (case when week_no between 1 and 10 then '1-10'
                   when week_no between 11 and 20 then '11-20'
                   when week_no between 21 and 30 then '21-30'
                   when week_no between 31 and 40 then '31-40'
                   when week_no between 41 and 50 then '41-50'
                   when week_no between 51 and 60 then '51-60'end) as range
      from clean_weekly_sales) t1
group by range    
      
3.How many total transactions were there for each year in the dataset?
select calender_year, sum(transactions)
from clean_weekly_sales
group by calender_year
order by calender_year

4.What is the total sales for each region for each month?
select region, month_no, concat('$',sum(sales))
from clean_weekly_sales
group by region, month_no
order by region, month_no

5.What is the total count of transactions for each platform
/*same logic*/

6.What is the percentage of sales for Retail vs Shopify for each month?
select *, (select sum(sales) from clean_weekly_sales), concat(((sep*100)/(select sum(sales) from clean_weekly_sales)),'%') as percentage
from 
      (select platform, sum(sales) as sep
      from clean_weekly_sales
      group by platform
      order by platform) t1
      
7.What is the percentage of sales by demographic for each year in the dataset?
select demographic, calender_year, sum(sales), (select sum(sales) from clean_weekly_sales), 
		concat(((sum(sales)*100)/(select sum(sales) from clean_weekly_sales)),'%') as perc
from clean_weekly_sales 
group by demographic, calender_year
order by demographic, calender_year
      
8.Which age_band and demographic values contribute the most to Retail sales?
select demographic, age_band, sum(sales), (select sum(sales) from clean_weekly_sales),
	   ((sum(sales)*100)/(select sum(sales) from clean_weekly_sales))as percentage
from clean_weekly_sales
group by demographic, age_band 
order by percentage desc

9.Can we use the avg_transaction column to find the average transaction size for each year for Retail vs Shopify? If not - how would you calculate it instead?
/*qn not clear */