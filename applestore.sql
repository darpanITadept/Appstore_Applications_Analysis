CREATE TABLE appleStore_description_combined AS 

SELECT * FROM appleStore_description1

UNION ALL

SELECT * FROM appleStore_description2

UNION ALL

SELECT * FROM appleStore_description3

UNION ALL

SELECT * FROM appleStore_description4


-- checking the number of unique apps in both tablesAppleStore

SELECT COUNT(DISTINCT id) AS UniqueAppIDs
From AppleStore

SELECT COUNT(DISTINCT id) AS UniqueAppIDs
From appleStore_description_combined

--checking for any missing valuesAppleStores in key fieldsAppleStore
SELECT COUNT(*) as MissingValues
FROM AppleStore
WHERE track_name IS NULL OR user_rating IS Null or prime_genre IS NULL


SELECT count(*) as MissingValues
FROM appleStore_description_combined
WHERE app_desc IS NULL



--Finding out the number of apps per genre

SELECT prime_genre, COUNT(*) AS NumApps
FROM AppleStore
GROUP BY prime_genre
ORDER BY NumApps DESC

--Get an overview of the apps' ratings
select min(user_rating) AS MinRating,
max(user_rating) As MaxRating,
avg(user_rating) AS AvgRating
From AppleStore


**DATA ANALYSIS**AppleStore
-- Determine wheather paid apps have higher ratings than free apps

SELECT CASE 
			WHEn price  > 0 Then 'Paid'
            Else 'Free'
       END AS App_Type,
       avg(user_rating) AS Avg_Rating
FROM AppleStore
GROUP BY App_Type


--Check if apps with more supported languages have higher ratings
SELECT CASE 
when lang_num < 10 THEN '<10 languages'
when lang_num BETWEEN 10 and 30 then '10-30 languages' 
else '>10 languages'
end as languages_bucket,
avg(user_rating) as Avg_Rating
from AppleStore
GROUP by languages_bucket
order by Avg_Rating DESC

--Checking generes with low ratings

select prime_genre,
avg(user_rating) As Avg_Rating
From AppleStore
GROUP By prime_genre
ORder by Avg_Rating ASC
LIMIT 10

--Check if there is a correlation between the length of the app description and the user rating

SELECT CASe 

when length(b.app_desc) <500 then 'Short'
when length(b.app_desc) BETWEEN 500 and 1000 then 'Medium'
else 'Long'
end as description_length_bucket,
avg(a.user_rating) AS average_rating
from 

AppleStore AS A 

JOIN 

appleStore_description_combined as B 
ON 

A.id = B.id


Group by description_length_bucket
order by average_rating DESC


-- Check the top-rated apps for each genre 

select 
	prime_genre,
    track_name,
    user_rating
from (
  	  SELECT
      prime_genre,
      track_name,
      user_rating,
      RANK() OVER(PARTITION BY prime_genre order by user_rating DESC, rating_count_tot DESc) AS rank
      FROM
      AppleStore
      ) AS a 
WHERE
a.rank = 1
  
  
*--------------------------------------*
--Final recommendation for our clients |
*--------------------------------------*
--1.) Paid apps have better ratings. - Therefore, we can suggest our clients that if the quality 
-- of their app is good then they can consider charging a certain amount for the app.

--2.) Apps Supporting between 10 and 30 languages have better ratings. - Therefore, its not about the 
-- the quantity of the languages your app supports, but focusing on the right languages for the 
-- target audience 

--3.) Finance and books apps have low ratings. - Therefore, this suggests that the user needs are 
-- not fully met. It indicates a market opportunity for the developers to create quality app in 
-- this category better than the current offering.demo

--4.) Apps with a longer Description have better Ratings. - Therefore, users prefer to have a clear 
-- understanding of the apps features before they download. 

--5.) A new app should aim for an average rating about 3.5 - Therefore, in order to stand out from 
-- the crowd we should aim for the rating of above 3.5

--6.) Games and entertainment have high competition - Therefore, suggesting that the market might 
-- be saturated. 

  
























