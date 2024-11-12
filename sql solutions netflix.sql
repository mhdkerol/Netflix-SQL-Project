-- Schema Table --
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix 
(
    show_id VARCHAR(5),
    type VARCHAR(10),
    title VARCHAR(250),
    director VARCHAR(550),
    casts VARCHAR(1050),
    country VARCHAR(550),
    date_added VARCHAR(55),
    release_year INT,
    rating VARCHAR(250),
    duration VARCHAR(15),
    listed_in VARCHAR(250),
    description VARCHAR(550)
);

SELECT * FROM netflix;

-- 16 Business Problems --

-- 1. Count the number of Movies vs TV Shows --

SELECT
    COUNT(CASE WHEN type = 'TV Show' THEN 1 END) AS count_tv_show,
    COUNT(CASE WHEN type = 'Movie' THEN 1 END) AS count_movie
FROM netflix;

-- OR --

SELECT 
    type, 
    COUNT(*) AS total_content
FROM netflix 
GROUP BY type;


-- 2. Find the most common rating for movies and TV shows --

SELECT 
    type, 
    rating,
    COUNT(*) AS total_count,
    RANK() OVER (PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking
FROM netflix
GROUP BY type, rating
ORDER BY type, COUNT(*) DESC;


-- 3. List all movies released in a specific year (e.g., 2020) --

SELECT * 
FROM netflix
WHERE release_year = 2020 AND type = 'Movie';


-- 4. Find the top 5 countries with the most content on Netflix --

SELECT 
    UNNEST(STRING_TO_ARRAY(country, ', ')) AS country_unnest,
    COUNT(show_id) AS total_content
FROM netflix
GROUP BY country_unnest
ORDER BY total_content DESC
LIMIT 5;


-- 5. Find the total count for listing_id for which the country is United States or United Kingdom --

SELECT 
    UNNEST(STRING_TO_ARRAY(listed_in, ', ')) AS category,
    COUNT(show_id)
FROM netflix
WHERE country LIKE '%United States%' 
   OR country LIKE '%United Kingdom%'
GROUP BY 1
ORDER BY 2 DESC;


-- 6. Identify the longest movie --

SELECT *
FROM (
    SELECT 
        title AS Movie,
        split_part(duration, ' ', 1)::numeric AS duration
    FROM netflix
    WHERE type = 'Movie'
) AS subquery
WHERE duration = (
    SELECT MAX(split_part(duration, ' ', 1)::numeric)
    FROM netflix
    WHERE type = 'Movie'
);


-- 7. What are the Netflix shows or movies added in the past 5 years that are available in Japan? --

SELECT *
FROM (
    SELECT *
    FROM netflix 
    WHERE TO_DATE(date_added, 'Month-DD-YYYY') >= CURRENT_DATE - INTERVAL '5 years'
) AS recent_shows_added_Japan
WHERE country LIKE '%Japan%';


-- 8. Find all the movies/TV shows by director 'Rajiv Chilaka'! --

SELECT *
FROM netflix
WHERE director LIKE '%Rajiv Chilaka%';


-- 9. List all TV shows with more than 5 seasons --

SELECT *
FROM netflix
WHERE type = 'TV Show'
    AND SPLIT_PART(duration, ' ', 1)::numeric > 5;


-- 10. Count the number of content items in each genre --

SELECT 
    COUNT(show_id),
    UNNEST(STRING_TO_ARRAY(listed_in, ', ')) AS genre
FROM netflix
GROUP BY genre
ORDER BY count DESC;


-- 11. Find each year and the average numbers of content release in India on Netflix.
-- Return top 5 years with the highest average content release! --

SELECT 
    EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD YYYY')) AS Year,
    COUNT(*) AS yearly_content,
    ROUND(COUNT(*)::numeric / (SELECT COUNT(*) FROM netflix WHERE country = 'India')::numeric * 100, 2) AS avg_content_per_year
FROM netflix
WHERE country = 'India'
GROUP BY 1
ORDER BY avg_content_per_year DESC
LIMIT 5;


-- 12. List all movies that are documentaries --

SELECT * 
FROM netflix
WHERE type = 'Movie'
    AND listed_in ILIKE '%Documentaries%';


-- 13. Find all content without a director --

SELECT * 
FROM netflix
WHERE director IS NULL;


-- 14. Find how many movies actor 'Salman Khan' appeared in the last 10 years! --

SELECT *
FROM netflix
WHERE casts ILIKE '%Salman Khan%'
    AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;


-- 15. Find the top 10 actors who have appeared in the highest number of movies produced in India. --

SELECT 
    UNNEST(STRING_TO_ARRAY(casts, ', ')) AS Actors, 
    COUNT(*)
FROM netflix
WHERE country ILIKE '%India%'
    AND type = 'Movie'
GROUP BY Actors
ORDER BY 2 DESC
LIMIT 10;


-- 16. Categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field. 
-- Label content containing these keywords as 'Bad' and all other content as 'Good'. Count how many items fall into each category. --

WITH new_table AS (
    SELECT *,
    CASE
        WHEN description ILIKE '%kill%'
            OR description ILIKE '%violence%'
        THEN 'Bad'
        ELSE 'Good'
    END AS category_content
    FROM netflix
)

SELECT category_content, 
    COUNT(*) AS total_content
FROM new_table
GROUP BY 1;
