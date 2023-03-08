
SELECT *
FROM breweries;

SELECT DISTINCT BRANDS
FROM breweries;
select DISTINCT COUNTRIES
FROM breweries;

#PROFIT ANALYSIS#

#1.Within the Space of the last three years, what was the profit worth of the breweries#
SELECT BRANDS,sum(PROFIT) as TOTAL_PROFIT
FROM breweries;

#2.Compare the total profit between these two territories#
SELECT 
sum(CASE WHEN COUNTRIES IN ('Nigeria','Ghana') THEN PROFIT ELSE 0 END) AS Anglophone,
    sum(CASE WHEN COUNTRIES IN('senegal','Benin','Togo') THEN PROFIT ELSE 0 END) AS Francophone
FROM breweries;

#3.Country that generated the highest profit in 2019#
SELECT COUNTRIES,sum(PROFIT) Profit
FROM breweries
WHERE YEARS = '2019'
GROUP BY COUNTRIES
ORDER BY Profit DESC;

#4.Year with the highest profit#
SELECT YEARS,sum(PROFIT) Total_profit
FROM breweries
GROUP BY YEARS
ORDER BY Total_profit DESC;

#5.Which month in the three years was the least profit generated#
SELECT YEARS,MONTHS,PROFIT
FROM breweries
GROUP BY YEARS,MONTHS,PROFIT
ORDER BY PROFIT ASC;

#6.What was the minimum profit in the month of December 2018#
SELECT YEARS,MONTHS,PROFIT
FROM breweries
WHERE MONTHS = 'december' AND YEARS ='2018'
GROUP BY YEARS,MONTHS,PROFIT
ORDER BY PROFIT ASC;

#7.Compare the profit in percentage for each of the month in 2019#
WITH profit_percentage AS(
SELECT MONTHS,
           sum(PROFIT) AS profit_per_month,
           sum(sum(PROFIT)) OVER() AS Total_profit
           FROM breweries WHERE YEARS ='2019'
           GROUP BY MONTHS
)
SELECT MONTHS,
concat(ROUND(profit_per_month *100/Total_profit,1), '%') as profit_percent
FROM profit_percentage;
           
#8.Which particular brand generated the highest profit in Senegal#
SELECT BRANDS,sum(PROFIT) AS TOTAL_PROFIT 
FROM breweries
WHERE COUNTRIES = 'senegal'
GROUP BY BRANDS
ORDER BY TOTAL_PROFIT DESC
limit 1;

#BRAND ANALYSIS#

#1.Within the last two years, the brand manager wants to know the top three brands consumed in the francophone countries#
SELECT BRANDS,sum(QUANTITY) AS QUANTITY_CONSUMED
FROM breweries
WHERE COUNTRIES IN  ('Togo','Benin','Senegal') AND YEARS IN ('2019',2018)
GROUP BY BRANDS
ORDER BY QUANTITY_CONSUMED DESC
LIMIT 3;


#2.Find out the top consumer brands in Ghana#
SELECT BRANDS,sum(QUANTITY) AS QUANTITY_CONSUMED
FROM breweries
WHERE COUNTRIES = 'Ghana'
GROUP BY BRANDS
ORDER BY QUANTITY_CONSUMED DESC
LIMIT 1;

#3.Find out the details of beers consumed in the past three years in the most oil reached country in West Africa#
SELECT BRANDS,sum(QUANTITY) as QUANTITY_CONSUMED,
       sum(COST) AS TOTAL_COST,
       sum(Profit) AS TOTAL_PROFIT
FROM breweries
WHERE BRANDS NOT LIKE '%malt%' AND COUNTRIES ='Nigeria'
GROUP BY BRANDS
ORDER BY qQUANTITY_CONSUMED DESC;

#4.Favourite malt brand in anglophone region between 2018 and 2019#
SELECT BRANDS,SUM(QUANTITY) as TOTAL_QUANTITY 
FROM breweries
WHERE BRANDS IN ('grand malt','beta malt') AND YEARS IN ('2018','2019') AND COUNTRIES IN ('Nigeria','Ghana')
GROUP BY BRANDS
ORDER BY TOTAL_QUANTITY DESC;

#5.Which brands sold the highest in 2019 in Nigeria#
SELECT BRANDS,SUM(QUANTITY)*SUM(UNIT_PRICE) AS SALES
FROM breweries
WHERE YEARS ='2019' AND COUNTRIES='Nigeria'
GROUP BY BRANDS
ORDER BY SALES DESC;


#6.Favorities brand in South-South region in Nigeria#
SELECT BRANDS,SUM(QUANTITY) as QUANTITY_CONSUMED
FROM breweries
WHERE  COUNTRIES='Nigeria' AND REGION ='southsouth'
GROUP BY BRANDS
ORDER BY QUANTITY_CONSUMED DESC;

#7.Beer consumption in Nigeria#
SELECT BRANDS,SUM(QUANTITY) AS TOTAL_CONSUMPTION
FROM breweries
WHERE BRANDS NOT LIKE '%malt%' AND COUNTRIES ='Nigeria'
GROUP BY BRANDS
ORDER BY TOTAL_CONSUMPTION DESC;


#8.Level of consumption of budweiser in the regions in Nigeria#
SELECT BRANDS,REGION,SUM(QUANTITY) AS TOTAL_CONSUMPTION
FROM breweries
WHERE BRANDS = 'budweiser' AND COUNTRIES ='Nigeria'
GROUP BY BRANDS,REGION
ORDER BY TOTAL_CONSUMPTION;

#9.Level of consumption of budweiser in the regions in Nigeria in 2019 (Decision Promo)#
SELECT BRANDS,REGION,
SUM(QUANTITY) AS QUANTITY_CONSUMED
FROM breweries
WHERE COUNTRIES = 'Nigeria' AND BRANDS = 'budweiser' AND YEARS = '2019'
GROUP BY BRANDS,REGION
ORDER BY QUANTITY_CONSUMED;

#COUNTRIES ANALYSIS#

#1.Country with the highest consumption of beer#
SELECT COUNTRIES,SUM(QUANTITY) AS TOTAL_CONSUMPTION
FROM breweries
WHERE BRANDS  NOT LIKE '%malt%'
GROUP BY COUNTRIES 
ORDER BY TOTAL_CONSUMPTION desc;


#2.Highest Sales personnel of budweiser in senegal#
SELECT SALES_REP,(SUM(QUANTITY)*SUM(UNIT_PRICE)) as SALES
FROM breweries
WHERE BRANDS = 'budweiser' AND COUNTRIES = 'Senegal'
GROUP BY SALES_REP
ORDER BY SALES DESC;

#3.Country with the highest profit of fourth quarter in 2019#
SELECT COUNTRIES, SUM(PROFIT) AS TOTAL_PROFIT
FROM breweries
WHERE YEARS ='2019' AND MONTHS IN ('October','November','December')
GROUP BY COUNTRIES
ORDER BY TOTAL_PROFIT DESC
LIMIT 1;


















