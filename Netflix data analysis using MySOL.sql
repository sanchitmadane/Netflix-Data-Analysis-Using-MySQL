SELECT * FROM shows.netflix_titles;



## 1) Total number of movies and TV shows:
SELECT 
    type, COUNT(*) AS count
FROM
    netflix_titles
GROUP BY type;



## 2) Top 5 most common genres:
SELECT 
    listed_in, COUNT(*) AS count
FROM
    netflix_titles
GROUP BY listed_in
ORDER BY count DESC
LIMIT 5;




## 3) Countries producing the most content:
SELECT 
    country, COUNT(*) AS count
FROM
    netflix_titles
GROUP BY country
ORDER BY count DESC
LIMIT 10;



## 4) Trend of content addition over the years:
SELECT 
    YEAR(date_added) AS year, COUNT(*) AS count
FROM
    netflix_titles
GROUP BY year
ORDER BY year;



## 5) Longest movies or TV shows:
SELECT 
    title, duration
FROM
    netflix_titles
WHERE
    type = 'Movie'
ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) DESC
LIMIT 10;



## 6) Average duration of movies and TV shows
SELECT 
    type,
    AVG(CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED)) AS avg_duration
FROM
    netflix_titles
WHERE
    duration LIKE '%min%'
        OR duration LIKE '%Season%'
GROUP BY type;



## 7) Top 5 directors with the most content
SELECT 
    director, COUNT(*) AS content_count
FROM
    netflix_titles
WHERE
    director IS NOT NULL
GROUP BY director
ORDER BY content_count DESC
LIMIT 5;



## 8) Most popular genre by country
SELECT 
    country, listed_in AS genre, COUNT(*) AS genre_count
FROM
    netflix_titles
WHERE
    country IS NOT NULL
GROUP BY country , genre
ORDER BY country , genre_count DESC;



## 9) Year with the highest number of content additions
SELECT 
    YEAR(date_added) AS year_added, COUNT(*) AS count
FROM
    netflix_titles
WHERE
    date_added IS NOT NULL
GROUP BY year_added
ORDER BY count DESC
LIMIT 1;



## 10) Most common actor in Netflix content
SELECT 
    actor, COUNT(*) AS appearances
FROM
    (SELECT 
        TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(cast, ',', n.n), ',', - 1)) AS actor
    FROM
        netflix_titles
    JOIN (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) n ON CHAR_LENGTH(cast) - CHAR_LENGTH(REPLACE(cast, ',', '')) >= n.n - 1
    WHERE
        cast IS NOT NULL) AS actor_list
GROUP BY actor
ORDER BY appearances DESC
LIMIT 1;



## 11) Distribution of content ratings (e.g., TV-MA, PG) across years
SELECT 
    rating, YEAR(date_added) AS year_added, COUNT(*) AS count
FROM
    netflix_titles
WHERE
    date_added IS NOT NULL
        AND rating IS NOT NULL
GROUP BY rating , year_added
ORDER BY year_added , rating;







