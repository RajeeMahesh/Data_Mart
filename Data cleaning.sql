with clean_weekly_sales as 
    (select week_date, extract(week from week_date) as week_no,
    extract(month from week_date) as month_no, extract(year from week_date) as calender_year, 
    region, platform,
            (case when segment is null or segment like'%null%' then ''
                 else segment end) as segment,
            (case when segment like '%1' then 'young adults' 
                 when segment like '%2' then 'middle aged'
                 when segment is null or segment like '%null%' then ''
                 else 'retirees'
            end) as age_band,
            (case when segment like 'C%' then 'couples'
                  when segment like 'F%' then 'families'
                  when segment is null or segment like '%null%' then ''
             end) as demographic, customer_type, transactions, sales, sales/transactions as avg_trans
    from 
        (select to_date(week_date,'dd-mm-yy') as week_date, region, platform, segment, customer_type, transactions, sales
        from data_mart.weekly_sales)t1) 