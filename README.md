Netflix SQL Analysis Project
This project contains SQL queries designed to perform detailed analysis on the Netflix dataset. The dataset includes information about Netflix shows, movies, directors, actors, genres, release dates, and other metadata. Through various business problem scenarios, this project explores key insights from the data.

Table of Contents
Dataset Overview
Schema
Business Problems Solved
Query Breakdown
How to Use
Contributing
License
Dataset Overview
The dataset consists of Netflix movies and TV shows, including the following fields:

show_id: Unique identifier for each show
type: Specifies whether it is a Movie or TV Show
title: Name of the movie or TV show
director: Director's name(s)
casts: List of main actors
country: Countries where the content was produced
date_added: Date the content was added to Netflix
release_year: Year the movie or show was released
rating: Content rating (e.g., PG, R)
duration: Length of the content (e.g., minutes for movies, seasons for TV shows)
listed_in: Genres or categories the content falls under
description: Short description or synopsis of the content
Schema
The database schema is defined as follows:

sql
Copy code
CREATE TABLE netflix (
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
Business Problems Solved
This project aims to answer the following business-related questions using SQL queries:

Count the number of Movies vs TV Shows.
Find the most common rating for Movies and TV Shows.
List all movies released in a specific year (e.g., 2020).
Find the top 5 countries with the most content on Netflix.
Find the total count for categories where the country is the United States or United Kingdom.
Identify the longest movie in terms of duration.
List Netflix shows or movies added in the past 5 years available in Japan.
Find all movies/TV shows directed by 'Rajiv Chilaka'.
List all TV shows with more than 5 seasons.
Count the number of content items in each genre.
Find the top 5 years with the highest average content released in India.
List all movies that are documentaries.
Find all content without a director.
Find how many movies actor 'Salman Khan' appeared in the last 10 years.
Find the top 10 actors with the highest number of movies produced in India.
Categorize content as 'Good' or 'Bad' based on keywords like 'kill' or 'violence'.
Query Breakdown
Each SQL query is focused on solving a specific business problem, optimized for performance and readability. The queries make use of SQL functions like:

GROUP BY and ORDER BY for aggregation and sorting.
CASE for conditional logic.
UNNEST and STRING_TO_ARRAY to handle multiple values in single fields.
PARTITION BY and RANK() to rank data based on custom criteria.
