# Netflix SQL Analysis Project

This project contains SQL queries designed to perform detailed analysis on the Netflix dataset. The dataset includes information about Netflix shows, movies, directors, actors, genres, release dates, and other metadata. Through various business problem scenarios, this project explores key insights from the data.

## Table of Contents

- [Dataset Overview](#dataset-overview)
- [Schema](#schema)
- [Business Problems](#business-problems)
- [Query Breakdown](#query-breakdown)
- [How to Use](#how-to-use)
- [Contributing](#contributing)
- [License](#license)

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
