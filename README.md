
---

# Apple Store Data Analysis

This project involves data analysis of the Apple Store dataset to gain insights into app ratings, genres, pricing, and more. The SQL queries and conclusions drawn from the analysis are provided below.

## Data Preparation

To begin the analysis, we combined data from multiple tables using UNION ALL to create a comprehensive dataset named `appleStore_description_combined`.

## Overview

- Number of Unique Apps in Apple Store Database: **[Insert Count]**
- Number of Unique Apps in Combined Database: **[Insert Count]**
- Missing Values in Key Fields of Apple Store Database: **[Insert Count]**
- Missing Values in `app_desc` Field of Combined Database: **[Insert Count]**

## Apps per Genre

We analyzed the distribution of apps across different genres:

```sql
SELECT prime_genre, COUNT(*) AS NumApps
FROM AppleStore
GROUP BY prime_genre
ORDER BY NumApps DESC
```

## Ratings Overview

- Minimum User Rating: **[Insert Rating]**
- Maximum User Rating: **[Insert Rating]**
- Average User Rating: **[Insert Rating]**

## Data Analysis

### Paid vs. Free Apps

We compared the ratings of paid and free apps:

```sql
SELECT CASE
            WHEN price > 0 THEN 'Paid'
            ELSE 'Free'
       END AS App_Type,
       AVG(user_rating) AS Avg_Rating
FROM AppleStore
GROUP BY App_Type
```

### Supported Languages

We examined whether the number of supported languages affects ratings:

```sql
SELECT CASE
            WHEN lang_num < 10 THEN '<10 languages'
            WHEN lang_num BETWEEN 10 and 30 THEN '10-30 languages'
            ELSE '>10 languages'
       END AS Languages_Bucket,
       AVG(user_rating) AS Avg_Rating
FROM AppleStore
GROUP BY Languages_Bucket
ORDER BY Avg_Rating DESC
```

### Low-Rated Genres

Identified genres with low ratings:

```sql
SELECT prime_genre,
       AVG(user_rating) AS Avg_Rating
FROM AppleStore
GROUP BY prime_genre
ORDER BY Avg_Rating ASC
LIMIT 10
```

### Description Length vs. User Rating

We explored the correlation between app description length and user ratings:

```sql
SELECT CASE
            WHEN LENGTH(b.app_desc) < 500 THEN 'Short'
            WHEN LENGTH(b.app_desc) BETWEEN 500 AND 1000 THEN 'Medium'
            ELSE 'Long'
       END AS Description_Length_Bucket,
       AVG(a.user_rating) AS Average_Rating
FROM AppleStore AS a
JOIN appleStore_description_combined AS b ON a.id = b.id
GROUP BY Description_Length_Bucket
ORDER BY Average_Rating DESC
```

### Top-Rated Apps per Genre

Identified the top-rated apps for each genre:

```sql
SELECT prime_genre,
       track_name,
       user_rating
FROM (
      SELECT prime_genre,
             track_name,
             user_rating,
             RANK() OVER (PARTITION BY prime_genre ORDER BY user_rating DESC, rating_count_tot DESC) AS rank
      FROM AppleStore
      ) AS a
WHERE a.rank = 1
```

## Conclusions

1. Paid apps tend to have better ratings, suggesting that quality apps can consider charging a fee.

2. Apps supporting between 10 and 30 languages receive better ratings, emphasizing the importance of targeting the right languages for the target audience.

3. Finance and books apps have lower ratings, indicating an opportunity for developers to create higher-quality apps in these categories.

4. Apps with longer descriptions tend to have better ratings, highlighting the importance of providing a clear understanding of app features.

5. Aim for an average rating above 3.5 to stand out in the app market.

6. Games and entertainment categories face high competition, suggesting a saturated market.

---

