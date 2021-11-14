This technique is usually used when we inspect an important event and want to inspect the impact before and after a certain point in time.

Taking the week_date value of 2020-06-15 as the baseline week where the Data Mart sustainable packaging changes came into effect.

We would include all week_date values for 2020-06-15 as the start of the period after the change and the previous week_date values would be before

Using this analysis aproach, 
We shall find  total sales for the 4 weeks (12 weeks) before and after 2020-06-15? 
What is the growth or reduction rate in actual values and percentage of sales? 

select *, ((cast(growth_red as float)*100)/sales_bef)as perc_growth
from
      (select *, (sales_after-sales_bef) as growth_red
      from        
          (select sum(case when week_no between 21 and 24 then sales end) as sales_bef,
                  sum(case when week_no between 26 and 29 then sales end) as sales_after
          from clean_weekly_sales
          where calender_year = '2020')t1)t2