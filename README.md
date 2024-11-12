# Netflix SQL Analysis Project

![]()

This project contains SQL queries designed to perform detailed analysis on the Netflix dataset. The dataset includes information about Netflix shows, movies, directors, actors, genres, release dates, and other metadata. Through various business problem scenarios, this project explores key insights from the data.

## Dataset

The data for this project is sourced from the Kaggle dataset:

- **Dataset Link:** [Movies Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## Table of Contents

- [Dataset Overview](#dataset-overview)
- [Business Problems](#business-problems)
- [Solutions](#solutions)
- [Findings and Conclusion](#findings-and-conclusion)

## Dataset Overview

The dataset consists of Netflix movies and TV shows, including the following fields:
- `show_id`: Unique identifier for each show
- `type`: Specifies whether it is a Movie or TV Show
- `title`: Name of the movie or TV show
- `director`: Director's name(s)
- `casts`: List of main actors
- `country`: Countries where the content was produced
- `date_added`: Date the content was added to Netflix
- `release_year`: Year the movie or show was released
- `rating`: Content rating (e.g., PG, R)
- `duration`: Length of the content (e.g., minutes for movies, seasons for TV shows)
- `listed_in`: Genres or categories the content falls under
- `description`: Short description or synopsis of the content


## Business Problems

This project aims to answer the following business-related questions using SQL queries:

1. Count the number of Movies vs TV Shows.
2. Find the most common rating for Movies and TV Shows.
3. List all movies released in a specific year (e.g., 2020).
4. Find the top 5 countries with the most content on Netflix.
5. Find the total count for categories where the country is the United States or United Kingdom.
6. Identify the longest movie in terms of duration.
7. List Netflix shows or movies added in the past 5 years available in Japan.
8. Find all movies/TV shows directed by 'Rajiv Chilaka'.
9. List all TV shows with more than 5 seasons.
10. Count the number of content items in each genre.
11. Find the top 5 years with the highest average content released in India.
12. List all movies that are documentaries.
13. Find all content without a director.
14. Find how many movies actor 'Salman Khan' appeared in the last 10 years.
15. Find the top 10 actors with the highest number of movies produced in India.
16. Categorize content as 'Good' or 'Bad' based on keywords like 'kill' or 'violence'.


## Solutions

### 1. Count the number of Movies vs TV Shows

```sql
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
```

### 2. Find the most common rating for movies and TV shows

```sql
SELECT 
    type, 
    rating,
    COUNT(*) AS total_count,
    RANK() OVER (PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking
FROM netflix
GROUP BY type, rating
ORDER BY type, COUNT(*) DESC;
```

### 3. List all movies released in a specific year (e.g., 2020)

```sql
SELECT * 
FROM netflix
WHERE release_year = 2020 AND type = 'Movie';
```

### 4. Find the top 5 countries with the most content on Netflix

```sql
SELECT 
    UNNEST(STRING_TO_ARRAY(country, ', ')) AS country_unnest,
    COUNT(show_id) AS total_content
FROM netflix
GROUP BY country_unnest
ORDER BY total_content DESC
LIMIT 5;
```


### 5. Find the total count for listing_id for which the country is United States or United Kingdom

```sql
SELECT 
    UNNEST(STRING_TO_ARRAY(listed_in, ', ')) AS category,
    COUNT(show_id)
FROM netflix
WHERE country LIKE '%United States%' 
   OR country LIKE '%United Kingdom%'
GROUP BY 1
ORDER BY 2 DESC;
```

### 6. Identify the longest movie

```sql
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
```

### 7. What are the Netflix shows or movies added in the past 5 years that are available in Japan? 

```sql
SELECT *
FROM (
    SELECT *
    FROM netflix 
    WHERE TO_DATE(date_added, 'Month-DD-YYYY') >= CURRENT_DATE - INTERVAL '5 years'
) AS recent_shows_added_Japan
WHERE country LIKE '%Japan%';
```

### 8. Find all the movies/TV shows by director 'Rajiv Chilaka'!

```sql
SELECT *
FROM netflix
WHERE director LIKE '%Rajiv Chilaka%';
```

### 9. List all TV shows with more than 5 seasons

```sql
SELECT *
FROM netflix
WHERE type = 'TV Show'
    AND SPLIT_PART(duration, ' ', 1)::numeric > 5;
```

### 10. Count the number of content items in each genre

```sql
SELECT 
    COUNT(show_id),
    UNNEST(STRING_TO_ARRAY(listed_in, ', ')) AS genre
FROM netflix
GROUP BY genre
ORDER BY count DESC;
```


### 11. Find each year and the average numbers of content release in India on Netflix.
#### Return top 5 years with the highest average content release!

```sql
SELECT 
    EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD YYYY')) AS Year,
    COUNT(*) AS yearly_content,
    ROUND(COUNT(*)::numeric / (SELECT COUNT(*) FROM netflix WHERE country = 'India')::numeric * 100, 2) AS avg_content_per_year
FROM netflix
WHERE country = 'India'
GROUP BY 1
ORDER BY avg_content_per_year DESC
LIMIT 5;
```


### 12. List all movies that are documentaries

```sql
SELECT * 
FROM netflix
WHERE type = 'Movie'
    AND listed_in ILIKE '%Documentaries%';
```

### 13. Find all content without a director

```sql
SELECT * 
FROM netflix
WHERE director IS NULL;
```

### 14. Find how many movies actor 'Salman Khan' appeared in the last 10 years!

```sql
SELECT *
FROM netflix
WHERE casts ILIKE '%Salman Khan%'
    AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;
```

### 15. Find the top 10 actors who have appeared in the highest number of movies produced in India.

```sql
SELECT 
    UNNEST(STRING_TO_ARRAY(casts, ', ')) AS Actors, 
    COUNT(*)
FROM netflix
WHERE country ILIKE '%India%'
    AND type = 'Movie'
GROUP BY Actors
ORDER BY 2 DESC
LIMIT 10;
```

### 16. Categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field. 
#### Label content containing these keywords as 'Bad' and all other content as 'Good'. Count how many items fall into each category.

```sql
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
```



## Findings & Conclusion

- **Content Distribution:** The dataset showcases a diverse selection of movies and TV shows, spanning various ratings and genres.
- **Common Ratings:** Analysis of the most frequent ratings reveals insights into the target audience for the content.
- **Geographical Insights:** India's significant contribution to content releases highlights regional trends in content distribution.
- **Content Categorization:** Grouping content by specific keywords offers a clearer understanding of the types of content available on Netflix.

This analysis provides a comprehensive view of Netflix's content and can help inform content strategy and decision-making.
