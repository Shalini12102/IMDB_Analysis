USE imdb;

/* Now that you have imported the data sets, let’s explore some of the tables. 
 To begin with, it is beneficial to know the shape of the tables and whether any column has null values.
 Further in this segment, you will take a look at 'movies' and 'genre' tables.*/



-- Segment 1:
-- Q1. Find the total number of rows in each table of the schema?
-- Type your code below:
-- Replace 'table_name' with the name of each table in your schema
SELECT TABLE_NAME, TABLE_ROWS
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'imdb';

/*ANSWER 1
+-------------------------------+
| TABLE_NAME	 |   TABLE_ROWS |
+-------------------------------+
|director_mapping|      3867	|
| genre		 |	14662	|
| movie	 	 |	7668	|
| names		 |	24115	|
| ratings	 |	7927	|
| role_mapping	 |	13454	|
+-------------------------------+
*/

-- Q2. Which columns in the movie table have null values?
-- Type your code below:

SELECT 'id' AS column_name, COUNT(*) AS null_count FROM movie WHERE id IS NULL UNION ALL
SELECT 'title' AS column_name, COUNT(*) AS null_count FROM movie WHERE title IS NULL UNION ALL
SELECT 'year' AS column_name, COUNT(*) AS null_count FROM movie WHERE year IS NULL UNION ALL
SELECT 'date_published' AS column_name, COUNT(*) AS null_count FROM movie WHERE date_published IS NULL UNION ALL
SELECT 'duration' AS column_name, COUNT(*) AS null_count FROM movie WHERE duration IS NULL UNION ALL
SELECT 'country' AS column_name, COUNT(*) AS null_count FROM movie WHERE country IS NULL UNION ALL
SELECT 'worlwide_gross_income' AS column_name, COUNT(*) AS null_count FROM movie WHERE worlwide_gross_income IS NULL UNION ALL
SELECT 'languages' AS column_name, COUNT(*) AS null_count FROM movie WHERE languages IS NULL UNION ALL
SELECT 'production_company' AS column_name, COUNT(*) AS null_count FROM movie WHERE production_company IS NULL;

/*ANSWER 2
+---------------------------+-------------------+
|     column_name	    |	null_count	|
+---------------------------+-------------------+
| id		    	    |  	  0		|
| title		    	    |	  0		|
| year 		    	    |	  0		|
| date_published    	    |	  0		|	
| duration	    	    |	  0		|			
| country 	    	    |	  20		|
| worlwide_gross_income	    |	  3724		|
| languages		    |	  194		|
| production_company	    |	  528		|
+---------------+-------------------------------+
*/
	


-- Now as you can see four columns of the movie table has null values. Let's look at the at the movies released each year. 
-- Q3. Find the total number of movies released each year? How does the trend look month wise? (Output expected)

/* Output format for the first part:

+---------------+-------------------+
| Year		| number_of_movies  |
+-------------------+---------------+
| 2017		|	2134	    |
| 2018		|	.	    |
| 2019		|	.	    |
+---------------+-------------------+


Output format for the second part of the question:
+---------------+-------------------+
| month_num	| number_of_movies  |
+---------------+-------------------+
| 1		|	 134	    |
| 2		|	 231	    |
| .		|	  .	    |
+---------------+-------------------+ */
-- Type your code below:

#Code for first part:
SELECT year AS Year, 
    COUNT(id) AS number_of_movies
FROM 
    movie
GROUP BY 
    Year
ORDER BY
	Year;
    
/*ANSWER 3.1 
Output format for the first part:

+---------------+-------------------+
| Year		|number_of_movies   |
+---------------+-------------------+
| 2017		|	3052	    |
| 2018		|	2944	    |
| 2019		|	2001	    |
+---------------+-------------------+

*/

#Code for the second part of the question:
SELECT 
    MONTH(date_published) AS month_num, 
    COUNT(id) AS number_of_movies
FROM 
    movie
GROUP BY 
    month_num
ORDER BY 
    month_num;

/*ANSWER 3.2
Output format for the second part of the question:
+---------------+-------------------+
| month_num	|  number_of_movies |
+---------------+-------------------+
| 1		|	 804	    |
| 2		|	 640	    |
| 3		|	 824 	    |	
| 4		|        680	    |
| 5		|        625	    |
| 6		|	 580	    |
| 7		|	 493	    |
| 8		|	 678	    |
| 9		|	 809	    |
| 10		|	 801	    |
| 11		|	 625	    |
| 12		|	 438	    |
+---------------+-------------------+
 */


/*The highest number of movies is produced in the month of March.
So, now that you have understood the month-wise trend of movies, let’s take a look at the other details in the movies table. 
We know USA and India produces huge number of movies each year. Lets find the number of movies produced by USA or India for the last year.*/
  
-- Q4. How many movies were produced in the USA or India in the year 2019??
-- Type your code below:

SELECT 
    COUNT(id) AS number_of_movies
FROM 
    movie
WHERE (country LIKE '%USA%' OR country LIKE '%India%') AND
    year = 2019 ;
    
/* ANSWER 4
number_of_movies
1059
*/


/* USA and India produced more than a thousand movies(you know the exact number!) in the year 2019.
Exploring table Genre would be fun!! 
Let’s find out the different genres in the dataset.*/

-- Q5. Find the unique list of the genres present in the data set?
-- Type your code below:
SELECT genre
FROM genre
GROUP BY genre;

/*ANSWER 5
+-----------------+
| genre	   	  |
+-----------------+
| Drama		  |
| Fantasy	  |
| Thriller	  |
| Comedy	  |
| Horror	  |
| Family	  |
| Romance	  |
| Adventure	  |
| Action	  | 
| Sci-Fi	  |
| Crime		  |
| Mystery	  |
| Others	  |
+-----------------+
*/


/* So, RSVP Movies plans to make a movie of one of these genres.
Now, wouldn’t you want to know which genre had the highest number of movies produced in the last year?
Combining both the movie and genres table can give more interesting insights. */

-- Q6.Which genre had the highest number of movies produced overall?
-- Type your code below:

SELECT 
    genre, 
    COUNT(*) AS number_of_movies
FROM 
    genre
GROUP BY 
    genre
ORDER BY 
    number_of_movies DESC
LIMIT 1;

/*ANSWER 6
genre   number_of_movies
Drama	4285
*/

/* So, based on the insight that you just drew, RSVP Movies should focus on the ‘Drama’ genre. 
But wait, it is too early to decide. A movie can belong to two or more genres. 
So, let’s find out the count of movies that belong to only one genre.*/

-- Q7. How many movies belong to only one genre?
-- Type your code below:

SELECT COUNT(*) AS single_genre_movies
FROM genre
WHERE genre NOT LIKE '%,%';

/*ANSWER 7
single_genre_movies
14662
*/

/* There are more than three thousand movies which has only one genre associated with them.
So, this figure appears significant. 
Now, let's find out the possible duration of RSVP Movies’ next project.*/

-- Q8.What is the average duration of movies in each genre? 
-- (Note: The same movie can belong to multiple genres.)


/* Output format:

+---------------+-------------------+
| genre		| avg_duration	    |
+---------------+-------------------+
| thriller	|	105	    |
|    .		|	 .	    |
|    .		|	 .	    |
+---------------+-------------------+ */
-- Type your code below:

SELECT genre, 
    ROUND(AVG(m.duration), 2) AS avg_duration
FROM 
    movie as m
JOIN 
    genre as g ON m.id = g.movie_id
GROUP BY 
    g.genre
ORDER BY 
    avg_duration DESC;
    
    
 /*ANSWER 8
 +----------------+---------------------+
| 	genre	  |	avg_duration    |
+-----------------+---------------------+
|	Action	  |	112.88		|
|	Romance	  |	109.53		|
|	Crime	  |	107.05		|
|	Drama	  |	106.77		|
|	Fantasy	  |	105.14		|
|	Comedy	  |	102.62		|
|	Adventure |	101.87		|
|	Mystery	  |	101.80		|	
|	Thriller  |	101.58		|
|	Family	  |	100.97		|
|	Others	  |	100.16		|
|	Sci-Fi	  |	97.94		|
|	Horror	  |	92.72		|
+-----------------+---------------------+ 
 
 */


/* Now you know, movies of genre 'Drama' (produced highest in number in 2019) has the average duration of 106.77 mins.
Lets find where the movies of genre 'thriller' on the basis of number of movies.*/

-- Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of number of movies produced? 
-- (Hint: Use the Rank function)


/* Output format:
+---------------+-------------------+---------------------+
| genre		|   movie_count	    |	genre_rank        |	
+---------------+-------------------+---------------------+
|drama		|	2312	    |	   2		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:

SELECT 
    genre, 
    COUNT(movie_id) AS movie_count,
    RANK() OVER (ORDER BY COUNT(movie_id) DESC) AS genre_rank
FROM genre
GROUP BY genre;

/*ANSWER 9
+---------------+-----------------------+---------------+
| genre		| movie_count 	        | genre_rank	|
+---------------+-----------------------+---------------+
| Drama		|	4285		|    1		|	
| Comedy	| 	2412		|    2		|
| Thriller	| 	1484		|    3		|
| Action	| 	1289		|    4		|
| Horror	| 	1208		|    5		|
| Romance	|	906		|    6		|
| Crime		| 	813		|    7		|
| Adventure 	|	591		|    8		|
| Mystery	| 	555		|    9		|
| Sci-Fi	| 	375		|    10		|
| Fantasy	| 	342		|    11		|
| Family	| 	302		|    12		|
| Others	| 	100		|    13		|
+---------------+-----------------------+---------------+
*/

/*Thriller movies is in top 3 among all genres in terms of number of movies
 In the previous segment, you analysed the movies and genres tables. 
 In this segment, you will analyse the ratings table as well.
To start with lets get the min and max values of different columns in the table*/




-- Segment 2:
-- Q10.  Find the minimum and maximum values in  each column of the ratings table except the movie_id column?
/* Output format:
+----------------+-------------------+---------------------+----------------------+-------------------+-------------------+
| min_avg_rating | max_avg_rating    |	min_total_votes    |	max_total_votes   | min_median_rating | min_median_rating |
+----------------+-------------------+---------------------+----------------------+-------------------+-------------------+
|	0	 |	5	     |	       177	   |	   2000	    	  |	  0	      |	      8		  |
+----------------+-------------------+---------------------+----------------------+-------------------+-----------------+*/
-- Type your code below:

SELECT 
    MIN(avg_rating) AS min_avg_rating,
    MAX(avg_rating) AS max_avg_rating,
    MIN(total_votes) AS min_total_votes,
    MAX(total_votes) AS max_total_votes,
    MIN(median_rating) AS min_median_rating,
    MAX(median_rating) AS max_median_rating
FROM ratings;
    
/* ANSWER 10
+----------------+-------------------+---------------------+----------------------+--------------------+-------------------+
| min_avg_rating | max_avg_rating    |	min_total_votes    |  max_total_votes 	  |  min_median_rating |  min_median_rating|
+----------------+-------------------+---------------------+----------------------+--------------------+-------------------+
|  1.0		 |	10.0	     |	      100	   |	  725138 	  |		1      |	10	   |
+----------------+-------------------+---------------------+----------------------+--------------------+-----------------+*/


/* So, the minimum and maximum values in each column of the ratings table are in the expected range. 
This implies there are no outliers in the table. 
Now, let’s find out the top 10 movies based on average rating.*/


-- Q11. Which are the top 10 movies based on average rating?
/* Output format:
+----------+----------------+----------------+
| title	   |	avg_rating  |  movie_rank    |
+----------+----------------+----------------+
| Fan	   |	  9.6	    |	  5 	     |
| .	   |	   .	    |	  .	     |
| .	   |	   .	    |	  .	     |
| .	   |	   .	    |	  .	     |
+----------+----------------+----------------+*/
-- Type your code below:
-- Keep in mind that multiple movies can be at the same rank. You only have to find out the top 10 movies (if there are more than one movies at the 10th place, consider them all.)

WITH RankedMovies AS (
    SELECT 
        title, 
        avg_rating, 
        RANK() OVER (ORDER BY avg_rating DESC) AS movie_rank
    FROM 
        ratings as r
    JOIN 
        movie as m
    ON 
        r.movie_id = m.id
)
SELECT 
    title, 
    avg_rating, 
    movie_rank
FROM 
    RankedMovies
WHERE 
    movie_rank <= 10
ORDER BY 
    movie_rank, title;

/*ANSWER 11

+--------------------------------+--------------+---------------+
| title				 |  avg_rating	|  movie_rank   |
+--------------------------------+--------------+---------------+
| Kirket			 |	10.0	|	1	|
| Love in Kilnerry		 |	10.0	|	1	|
| Gini Helida Kathe		 |	9.8	|	3	|
| Runam		 		 |	9.7	|	4	|
| Android Kunjappan Version 5.25 |	9.6	|	5	|
| Fan				 |	9.6	|	5	|
| Safe				 |	9.5	|	7	|
| The Brighton Miracle		 |	9.5	|	7	|
| Yeh Suhaagraat Impossible	 |	9.5	|	7	|
| Ananthu V/S Nusrath		 |	9.4	|	10	|
| Family of Thakurganj		 |	9.4	|	10	|
| Our Little Haven		 |	9.4	|	10	|
| Shibu				 |	9.4	|	10	|
| Zana				 |	9.4	|	10	|
+--------------------------------+--------------+---------------+
*/


/* Do you find you favourite movie FAN in the top 10 movies with an average rating of 9.6? If not, please check your code again!!
So, now that you know the top 10 movies, do you think character actors and filler actors can be from these movies?
Summarising the ratings table based on the movie counts by median rating can give an excellent insight.*/

-- Q12. Summarise the ratings table based on the movie counts by median ratings.
/* Output format:

+---------------+---------------+
| median_rating	|  movie_count	|
+---------------+---------------+
|	1	|	105	|
|	.	|	 .	|
|	.	|	 .	|
+---------------+---------------+ */
-- Type your code below:
-- Order by is good to have

SELECT 
    median_rating, 
    COUNT(*) AS movie_count
FROM 
    ratings
GROUP BY 
    median_rating
ORDER BY 
    median_rating;

/*ANSWER 12
1	94
2	119
3	283
4	479
5	985
6	1975
7	2257
8	1030
9	429
10	346
*/


/* Movies with a median rating of 7 is highest in number. 
Now, let's find out the production house with which RSVP Movies can partner for its next project.*/

-- Q13. Which production house has produced the most number of hit movies (average rating > 8)??
/* Output format:
+------------------+-------------------+---------------------+
|production_company|movie_count	       |  prod_company_rank  |
+------------------+-------------------+---------------------+
| The Archers	   |  1		       |      1	    	     |
+------------------+-------------------+---------------------+*/
-- Type your code below:

SELECT 
    production_company, 
    COUNT(*) AS movie_count,
     RANK() OVER (ORDER BY COUNT(*) DESC) AS prod_company_rank
FROM 
    movie as m
JOIN 
    ratings as r
ON 
    m.id = r.movie_id
WHERE 
    r.avg_rating > 8 and production_company IS NOT NULL
GROUP BY 
    production_company
ORDER BY 
    movie_count DESC
LIMIT 5;


/*ANSWER 13
+------------------------+--------------+-----------------------+
| production_company	 | movie_count	| prod_company_rank     |
+------------------------+--------------+-----------------------+
| Dream Warrior Pictures |	3	|	1		|
| National Theatre Live	 |	3	|	1		|
| Lietuvos Kinostudija	 |	2	|	3		|
| Swadharm Entertainment |	2	|	3		|
| Panorama Studios	 |	2	|	3		|
+------------------------+--------------+-----------------------+
*/

-- It's ok if RANK() or DENSE_RANK() is used too
-- Answer can be Dream Warrior Pictures or National Theatre Live or both

-- Q14. How many movies released in each genre during March 2017 in the USA had more than 1,000 votes?
/* Output format:

+---------------+----------------+
| genre		|  movie_count	 |
+---------------+----------------+
| thriller	|	105	 |
|  .		|	 .	 |
|  .		|	 .	 |
+---------------+----------------+ */
-- Type your code below:

SELECT 
    genre, COUNT(m.id) AS movie_count
FROM 
    movie  m
JOIN 
    ratings  r ON m.id = r.movie_id
JOIN 
	genre  g on m.id = g.movie_id
WHERE 
    m.country like '%USA%'
    AND MONTH(date_published)= 3 AND m.year=2017
    AND total_votes > 1000
GROUP BY 
    genre
ORDER BY 
    movie_count DESC;

/*ANSWER 14
+---------------+---------------+
| genre  	|  movie_count  |
+---------------+---------------+
| Drama		|	24	|
| Comedy	|	9	|
| Action	|	8	|
| Thriller	|	8	|
| Sci-Fi	|	7	|
| Crime		|	6	|
| Horror	|	6	|
| Mystery	|	4	|
| Romance	|	4	|
| Fantasy	|	3	|
| Adventure	|	3	|
| Family	|	1	|
+---------------+---------------+

*/



-- Lets try to analyse with a unique problem statement.
-- Q15. Find movies of each genre that start with the word ‘The’ and which have an average rating > 8?
/* Output format:
+---------------+---------------+-----------------------+
| title		| avg_rating	|	genre	        |
+---------------+---------------+-----------------------+
| Theeran	|   8.3		|	Thriller	|
|	.	|    .		|	   .		|
|	.	|    .		|	   .		|
|	.	|    .		|	   .		|
+---------------+---------------+-----------------------+*/
-- Type your code below:

SELECT 
	m.title, 
    r.avg_rating, 
    g.genre
FROM 
    movie as m
JOIN 
	genre as g ON g.movie_id = m.id
JOIN 
    ratings as r ON r.movie_id = m.id  
WHERE 
    m.title LIKE 'The%' 
    AND r.avg_rating > 8
ORDER BY 
    g.genre, r.avg_rating DESC;

/*ANSWER 15
+----------------------------------------+--------------+---------------+
|      title				 | avg_rating	|	genre	|
+----------------------------------------+--------------+---------------+
| Theeran Adhigaaram Ondru		 |	8.3  	|	Action	|
| The Irishman				 |	8.7	|	Crime	|
| The Gambinos				 |	8.4	|	Crime	|
| Theeran Adhigaaram Ondru		 |	8.3	|	Crime	|
| The Brighton Miracle			 |	9.5	|	Drama	|
| The Colour of Darkness		 |	9.1	|	Drama	|
| The Blue Elephant 2			 |	8.8	|	Drama	|
| The Irishman				 |	8.7	|	Drama	|
| The Mystery of Godliness: The Sequel   |	8.5	|	Drama	|
| The Gambinos				 |	8.4	|	Drama	|
| The King and I			 |	8.2	|	Drama	|
| The Blue Elephant 2			 |	8.8	|	Horror	|
| The Blue Elephant 2			 |	8.8	|	Mystery	|
| The King and I			 |	8.2	|	Romance	|
| Theeran Adhigaaram Ondru		 |	8.3	|	Thriller|
+----------------------------------------+--------------+---------------+
*/


-- You should also try your hand at median rating and check whether the ‘median rating’ column gives any significant insights.
-- Q16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?
-- Type your code below:

SELECT 
    COUNT(*) AS movies_with_median_rating_8
FROM 
    movie m
JOIN 
    ratings r ON m.id = r.movie_id
WHERE 
    m.date_published BETWEEN '2018-04-01' AND '2019-04-01'
    AND r.median_rating = 8;
    
/*ANSWER 16
movies_with_median_rating_8
361
*/


-- Once again, try to solve the problem given below.
-- Q17. Do German movies get more votes than Italian movies? 
-- Hint: Here you have to find the total number of votes for both German and Italian movies.
-- Type your code below:

SELECT 
    country,
    SUM(r.total_votes) AS total_votes
FROM 
    movie m
JOIN 
    ratings r ON m.id = r.movie_id
WHERE 
    country IN ('Germany', 'Italy')
GROUP BY 
    country;

/*ANSWER17
+---------+-------------+
| country | total_votes |
+---------+-------------+
| Germany |	106710  |
| Italy	  | 77965       |
+---------+-------------+
*/

-- Answer is Yes

/* Now that you have analysed the movies, genres and ratings tables, let us now analyse another table, the names table. 
Let’s begin by searching for null values in the tables.*/



-- Segment 3:
-- Q18. Which columns in the names table have null values??
/*Hint: You can find null values for individual columns or follow below output format
+---------------+-------------------+---------------------+-----------------------+
| name_nulls	|  height_nulls	    | date_of_birth_nulls | known_for_movies_nulls|
+---------------+-------------------+---------------------+-----------------------+
|    0		|	123	    |	     1234	  |	 12345	    	  |
+---------------+-------------------+---------------------+-----------------------+*/
-- Type your code below:

SELECT 
    COUNT(CASE WHEN name IS NULL THEN 1 END) AS name_nulls,
    COUNT(CASE WHEN height IS NULL THEN 1 END) AS height_nulls,
    COUNT(CASE WHEN date_of_birth IS NULL THEN 1 END) AS date_of_birth_nulls,
    COUNT(CASE WHEN known_for_movies IS NULL THEN 1 END) AS known_for_movies_nulls
FROM 
    names;


/*ANSWER 18
+---------------+-------------------+---------------------+-----------------------+
| name_nulls	| height_nulls	    | date_of_birth_nulls | known_for_movies_nulls|
+---------------+-------------------+---------------------+-----------------------+
|   0		|  17335	    |	      13431	  |	   15226	  |
+---------------+-------------------+---------------------+-----------------------+			
*/



/* There are no Null value in the column 'name'.
The director is the most important person in a movie crew. 
Let’s find out the top three directors in the top three genres who can be hired by RSVP Movies.*/

-- Q19. Who are the top three directors in the top three genres whose movies have an average rating > 8?
-- (Hint: The top three genres would have the most number of movies with an average rating > 8.)
/* Output format:

+---------------+-------------------+
| director_name	| movie_count	    |
+---------------+-------------------+
|James Mangold	|	4	    |
|	.	|	.	    |
|	.	|	.	    |
+---------------+-------------------+ */
-- Type your code below:


WITH TopGenres AS (
    SELECT genre, COUNT(g.movie_id) as movie_count_1
    FROM genre g
    JOIN ratings r ON g.movie_id = r.movie_id
    WHERE r.avg_rating > 8
    GROUP BY genre
    ORDER BY movie_count_1 DESC
    LIMIT 3
)
SELECT n.name as director_name, COUNT(*) AS movie_count
FROM names n
JOIN director_mapping dm ON n.id=dm.name_id
JOIN genre g ON dm.movie_id = g.movie_id
JOIN ratings r ON dm.movie_id = r.movie_id
WHERE g.genre IN (SELECT genre FROM TopGenres) AND r.avg_rating > 8
GROUP BY n.name
ORDER BY movie_count DESC
LIMIT 3;

/*ANSWER 19

+---------------+---------------+
| director_name	| movie_count	|
+---------------+---------------+
|James Mangold	|	4	|
|Joe Russo	|	3	|
|Anthony Russo	|	3	|
+---------------+---------------+ 

*/


/* James Mangold can be hired as the director for RSVP's next project. Do you remeber his movies, 'Logan' and 'The Wolverine'. 
Now, let’s find out the top two actors.*/

-- Q20. Who are the top two actors whose movies have a median rating >= 8?
/* Output format:

+---------------+---------------+
| actor_name	| movie_count	|
+---------------+---------------+
|Christain Bale	|  10		|
|	.	|   .		|
+---------------+---------------+ */
-- Type your code below:

-- Step 1: Find actors and count their movies with median rating >= 8
SELECT 
    n.name as actor_name ,  -- Actor's name
    COUNT(*) AS movie_count  -- Count of movies
FROM 
	role_mapping as rm     
JOIN 
	names n ON rm.name_id = n.id
JOIN 
    ratings r ON rm.movie_id = r.movie_id  -- Link actors with their movies
WHERE 
    r.median_rating >= 8 AND rm.category LIKE 'actor' -- Filter for movies with median rating >= 8
GROUP BY 
    name  -- Group by actor
ORDER BY 
    movie_count DESC-- Sort by movie count in descending order
 LIMIT 2; -- Show only the top 2 actors
 
/*ANSWER 20
+---------------+---------------+
| actor_name	| movie_count	|
+---------------+---------------+
|Mammootty	|	8	|
|Mohanlal	|	5	|
+---------------+---------------+
*/



/* Have you find your favourite actor 'Mohanlal' in the list. If no, please check your code again. 
RSVP Movies plans to partner with other global production houses. 
Let’s find out the top three production houses in the world.*/

-- Q21. Which are the top three production houses based on the number of votes received by their movies?
/* Output format:
+------------------+--------------------+-----------------------+
|production_company| vote_count	        | prod_comp_rank        |
+------------------+--------------------+-----------------------+
| The Archers	   |	830		|	1	  	|
|	.	   |	.		|	.		|
|	.	   |	.		|	.		|
+------------------+--------------------+-----------------------+
*/
-- Type your code below:

SELECT 
    m.production_company,  -- Name of the production company
    SUM(r.total_votes) AS vote_count,  -- Total votes received by their movies
    RANK() OVER (ORDER BY SUM(r.total_votes) DESC) AS prod_comp_rank  -- Rank production houses by votes
FROM 
    movie m
JOIN 
    ratings r ON m.id = r.movie_id  -- Link production companies with movie ratings
GROUP BY 
    m.production_company  -- Group by production company name
ORDER BY 
    vote_count DESC  -- Sort by total votes in descending order
LIMIT 3;  -- Show only the top 3 production houses

/*ANSWER 21
+-----------------------+---------------+---------------------+
|production_company 	| vote_count	| prod_comp_rank      |
+-----------------------+---------------+---------------------+
| Marvel Studios	|  2656967	|	1	      |
| Twentieth Century Fox	|  2411163	|	2	      |
| Warner Bros.		|  2396057	|	3	      |
+-----------------------+---------------+---------------------+
*/



/*Yes Marvel Studios rules the movie world.
So, these are the top three production houses based on the number of votes received by the movies they have produced.

Since RSVP Movies is based out of Mumbai, India also wants to woo its local audience. 
RSVP Movies also wants to hire a few Indian actors for its upcoming project to give a regional feel. 
Let’s find who these actors could be.
*/

-- Q22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the list?
-- Note: The actor should have acted in at least five Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)

/* Output format:
+---------------+---------------+---------------+------------------+--------------+
| actor_name	|  total_votes	|   movie_count | actor_avg_rating |  actor_rank  |
+---------------+---------------+---------------+------------------+--------------+
|  Yogi Babu	|	3455	|	11	|	8.42	   |	1	  |
|	.	|	.	|	 .	|	  .	   |	.	  |
|	.	|	.	|	 .	|	  .	   |	.	  |
|	.	|	.	|	 .	|	  .	   |	.	  |
+---------------+---------------+---------------+------------------+--------------+*/
-- Type your code below:

-- Step 1: Calculate the total votes, movie count, and average rating for each actor
WITH ActorStats AS (
    SELECT 
        n.name AS actor_name,  -- Actor's name
        COUNT(r.movie_id) AS movie_count,  -- Number of movies
        SUM(r.total_votes) AS total_votes,  -- Total votes
        ROUND(SUM(r.avg_rating * r.total_votes) / SUM(r.total_votes), 2) AS actor_avg_rating  -- Weighted average rating
    FROM 
        movie AS m
    JOIN 
        role_mapping AS rm ON m.id = rm.movie_id  -- Link roles to movies
    JOIN 
        names AS n ON n.id = rm.name_id  -- Link names to roles 
    JOIN 
        ratings AS r ON m.id = r.movie_id  -- Link movies to ratings
    WHERE 
        m.country LIKE '%India%'  -- Movies released in India
        AND rm.category = 'actor'  -- Filter for actors
    GROUP BY 
        n.name
    HAVING 
        movie_count >= 5  -- Consider actors with at least 5 movies
)
SELECT 
    actor_name, 
    movie_count, 
    total_votes, 
    actor_avg_rating,
    RANK() OVER (ORDER BY actor_avg_rating DESC, total_votes DESC) AS actor_rank
FROM 
    ActorStats
where 
	movie_count>=5
ORDER BY 
    actor_rank;

/*ANSWER 22

+---------------+-------------------+---------------+------------------+-------------+
| actor_name	|	total_votes		|	movie_count	| actor_avg_rating |actor_rank	 |
+---------------+-------------------+---------------+------------------+-------------+
Vijay Sethupathi		5					23114			8.42			1
Fahadh Faasil			5					13557			7.99			2
Yogi Babu				11					8500			7.83			3
Joju George				5					3926			7.58			4
Ammy Virk				6					2504			7.55			5
Dileesh Pothan			5					6235			7.52			6
Kunchacko Boban			6					5628			7.48			7
Pankaj Tripathi			5					40728			7.44			8
Rajkummar Rao			6					42560			7.37			9
Dulquer Salmaan			5					17666			7.30			10
Amit Sadh				5					13355			7.21			11
Tovino Thomas			8					11596			7.15			12
Mammootty				8					12613			7.04			13
Nassar					5					4016			7.03			14
Karamjit Anmol			6					1970			6.91			15
Hareesh Kanaran			5					3196			6.58			16
Naseeruddin Shah		5					12604			6.54			17
Anandraj				6					2750			6.54			18
Mohanlal				7					17622			6.47			19
Siddique				7					5953			6.43			20
Aju Varghese			5					2237			6.43			21
Prakash Raj				6					8548			6.37			22
Jimmy Sheirgill			6					3826			6.29			23
Mahesh Achanta			6					2716			6.21			24
Biju Menon				5					1916			6.21			25
Suraj Venjaramoodu		6					4284			6.19			26
Abir Chatterjee			5					1413			5.80			27
Sunny Deol				5					4594			5.71			28
Radha Ravi				5					1483			5.70			29
Prabhu Deva				5					2044			5.68			30
Atul Sharma				5					9604			4.78			31
*/



-- Top actor is Vijay Sethupathi

-- Q23.Find out the top five actresses in Hindi movies released in India based on their average ratings? 
-- Note: The actresses should have acted in at least three Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |	actress_avg_rating 	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Tabu		|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

WITH ActressStats AS (
    SELECT 
        n.name AS actress_name,  -- Actress's name
        COUNT(r.movie_id) AS movie_count,  -- Number of movies
        SUM(r.total_votes) AS total_votes,  -- Total votes
        ROUND(SUM(r.avg_rating * r.total_votes) / SUM(r.total_votes), 2) AS actress_avg_rating  -- Weighted average rating
    FROM 
        movie AS m
    JOIN 
        role_mapping AS rm ON m.id = rm.movie_id  -- Link roles to movies
    JOIN 
        names AS n ON n.id = rm.name_id  -- Link names to roles
    JOIN 
        ratings AS r ON m.id = r.movie_id  -- Link movies to ratings
    WHERE 
        m.country LIKE '%India%'  -- Movies released in India
        AND m.languages = 'Hindi'  -- Filter for Hindi movies
        AND rm.category = 'actress'  -- Filter for actresses
    GROUP BY 
        n.name
    HAVING 
        movie_count >= 3  -- Consider actresses with at least 3 movies
)
SELECT 
    actress_name, 
    total_votes, 
    movie_count, 
    actress_avg_rating,
    RANK() OVER (ORDER BY actress_avg_rating DESC, total_votes DESC) AS actress_rank  -- Ranking based on average rating and total votes
FROM 
    ActressStats
ORDER BY 
    actress_rank
LIMIT 5;  -- Get the top 5 actresses

/*ANSWER 23

+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |	actress_avg_rating 	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|Taapsee Pannu	|		18061		|	       3		  |	   7.74    		 	 |		1	       |
|Divya Dutta	|		8579		|	       3		  |	   6.88		    	 |		2	       |
|Kriti Kharbanda|		2549		|	       3		  |	   4.80	    		 |		3	       |
|Sonakshi Sinha	|		4025		|	       4		  |	   4.18	    		 |		4	       |
+---------------+-------------------+---------------------+----------------------+-----------------+
*/


/* Taapsee Pannu tops with average rating 7.74. 
Now let us divide all the thriller movies in the following categories and find out their numbers.*/


/* Q24. Consider thriller movies having at least 25,000 votes. Classify them according to their average ratings in
   the following categories:  

			Rating > 8: Superhit
			Rating between 7 and 8: Hit
			Rating between 5 and 7: One-time-watch
			Rating < 5: Flop
	
    Note: Sort the output by average ratings (desc).
--------------------------------------------------------------------------------------------*/
/* Output format:
+---------------+-------------------+
| movie_name	|	movie_category	|
+---------------+-------------------+
|	Get Out		|			Hit		|
|		.		|			.		|
|		.		|			.		|
+---------------+-------------------+*/

-- Type your code below:

SELECT 
    m.title AS movie_name,  -- Movie name
    CASE 
        WHEN r.avg_rating > 8 THEN 'Superhit'
        WHEN r.avg_rating BETWEEN 7 AND 8 THEN 'Hit'
        WHEN r.avg_rating BETWEEN 5 AND 7 THEN 'One-time-watch'
        WHEN r.avg_rating < 5 THEN 'Flop'
    END AS movie_category  -- Categorize based on rating
FROM 
    movie AS m
JOIN 
    ratings AS r ON m.id = r.movie_id  -- Link movies to ratings
JOIN 
    genre AS g ON m.id = g.movie_id  -- Link movies to genres
WHERE 
    g.genre = 'Thriller'  -- Filter for thriller movies
    AND r.total_votes >= 25000  -- At least 25,000 votes
ORDER BY 
    r.avg_rating DESC;  -- Sort by average ratings (desc)

/*ANSWER 24
+-----------------------------------+-------------------+
| movie_name						|	movie_category	
+-----------------------------------+-------------------+
|Joker								|	Superhit
|Andhadhun							|	Superhit
|Ah-ga-ssi							|	Superhit
|Contratiempo						|	Superhit
|Mission: Impossible - Fallout		|	Hit
|Forushande							|	Hit
|Get Out							|	Hit
|Searching							|	Hit
|Hotel Mumbai						|	Hit
|John Wick: Chapter 3 - Parabellum	|	Hit
|John Wick: Chapter 2				|	Hit
|Miss Sloane						|	Hit
|Den skyldige						|	Hit
|Shot Caller						|	Hit
|Good Time							|	Hit
|Split								|	Hit
|Brimstone							|	Hit
|Elle								|	Hit
|First Reformed						|	Hit
|The Foreigner						|	Hit
|The Killing of a Sacred Deer		|	Hit
|The Mule							|	Hit
|Widows								|	One-time-watch
|Us									|	One-time-watch
|The Autopsy of Jane Doe			|	One-time-watch
|Venom								|	One-time-watch
|Atomic Blonde						|	One-time-watch
|Jungle								|	One-time-watch
|The Equalizer 2					|	One-time-watch
|The Fate of the Furious			|	One-time-watch
|Thoroughbreds						|	One-time-watch
|Glass								|	One-time-watch
|Halloween							|	One-time-watch
|Hunter Killer						|	One-time-watch
|Red Sparrow						|	One-time-watch
|Life								|	One-time-watch
|Anna								|	One-time-watch
|Annabelle: Creation				|	One-time-watch
|Happy Death Day					|	One-time-watch
|Peppermint							|	One-time-watch
|Alien: Covenant					|	One-time-watch
|Roman J. Israel, Esq.				|	One-time-watch
|The Commuter						|	One-time-watch
|Fractured							|	One-time-watch
|The Beguiled						|	One-time-watch
|The Ritual							|	One-time-watch
|Revenge							|	One-time-watch
|American Assassin					|	One-time-watch
|Scary Stories to Tell in the Dark	|	One-time-watch
|Maze Runner: The Death Cure		|	One-time-watch
|The Belko Experiment				|	One-time-watch
|Mile 22							|	One-time-watch
|The Perfection						|	One-time-watch
|Captive State						|	One-time-watch
|Kidnap								|	One-time-watch
|Annabelle Comes Home				|	One-time-watch
|Pet Sematary						|	One-time-watch
|Jigsaw								|	One-time-watch
|Skyscraper							|	One-time-watch
|Would You Rather					|	One-time-watch
|Insidious: The Last Key			|	One-time-watch
|Velvet Buzzsaw						|	One-time-watch
|Sleepless							|	One-time-watch
|In the Tall Grass					|	One-time-watch
|Mute								|	One-time-watch
|The Curse of La Llorona			|	One-time-watch
|Geostorm							|	One-time-watch
|The Circle							|	One-time-watch
|Robin Hood							|	One-time-watch
|The Nun							|	One-time-watch
|Serenity							|	One-time-watch
|xXx: Return of Xander Cage			|	One-time-watch
|Rough Night						|	One-time-watch
|Truth or Dare						|	One-time-watch
|Fifty Shades Freed					|	Flop
|The Open House						|	Flop
|Race 3								|	Flop
*/



/* Until now, you have analysed various tables of the data set. 
Now, you will perform some tasks that will give you a broader understanding of the data in this segment.*/

-- Segment 4:

-- Q25. What is the genre-wise running total and moving average of the average movie duration? 
-- (Note: You need to show the output table in the question.) 
/* Output format:
+---------------+-------------------+---------------------+----------------------+
| genre			|	avg_duration	|running_total_duration|moving_avg_duration  |
+---------------+-------------------+---------------------+----------------------+
|	comdy		|			145		|	       106.2	  |	   128.42	    	 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:

-- Step 1: Calculate average movie duration for each genre
WITH GenreDurations AS (
    SELECT 
        g.genre AS genre, 
        ROUND(AVG(m.duration),2) AS avg_duration  -- Calculate average duration for each genre
    FROM 
        movie AS m
    JOIN 
        genre AS g ON m.id = g.movie_id  -- Link movies to genres
    GROUP BY 
        g.genre
),
-- Step 2: Compute running total and moving average of the average duration
RunningStats AS (
    SELECT 
        genre,
        avg_duration,
        ROUND(SUM(avg_duration) OVER (ORDER BY genre),2) AS running_total_duration,  -- Running total of average duration
        ROUND(AVG(avg_duration) OVER (ORDER BY genre ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) AS moving_avg_duration  
        -- IN ABOVE LINE OF CODE Moving average of the last three genres
    FROM 
        GenreDurations
)
-- Step 3: Select the required columns for the final output
SELECT 
    genre, 
    avg_duration, 
    running_total_duration, 
    moving_avg_duration
FROM 
    RunningStats
ORDER BY 
    genre;  -- Sort the output by genre for clarity

/*ANSWER 25
| genre			|	avg_duration  |running_total_duration | moving_avg_duration  |
+---------------+-----------------+-----------------------+----------------------+
Action			|	112.88		  |		112.88			  |		112.88
Adventure		|	101.87		  |		214.75			  |		107.38
Comedy			|	102.62		  |		317.37			  |		105.79
Crime			|	107.05		  |		424.42			  |		103.85
Drama			|	106.77		  |		531.19			  |		105.48
Family			|	100.97		  |		632.16			  |		104.93
Fantasy			|	105.14		  |		737.30			  |		104.29
Horror			|	92.72		  |		830.02			  |		99.61
Mystery			|	101.80		  |		931.82			  |		99.89
Others			|	100.16		  |		1031.98			  |		98.23
Romance			|	109.53		  |		1141.51			  |		103.83
Sci-Fi			|	97.94		  |		1239.45			  |		102.54
Thriller		|	101.58		  |		1341.03			  |		103.02
*/



-- Round is good to have and not a must have; Same thing applies to sorting


-- Let us find top 5 movies of each year with top 3 genres.

-- Q26. Which are the five highest-grossing movies of each year that belong to the top three genres? 
-- (Note: The top 3 genres would have the most number of movies.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| genre			|	year			|	movie_name		  |worldwide_gross_income|movie_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	comedy		|			2017	|	       indian	  |	   $103244842	     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

-- Top 3 Genres based on most number of movies

-- Step 1: Find the top 3 genres with the most number of movies
WITH TopGenres AS (
    SELECT 
        g.genre, 
        COUNT(*) AS genre_movie_count  -- Count of movies in each genre
    FROM 
        movie AS m
    JOIN 
        genre AS g ON m.id = g.movie_id  -- Join movie and genre tables using the genre_id
    GROUP BY 
        g.genre
    ORDER BY 
        genre_movie_count DESC  -- Sort by most movies
    LIMIT 3  -- Limit to top 3 genres
),
-- Step 2: Find the top 5 highest-grossing movies from the top 3 genres
TopMovies AS (
    SELECT 
        g.genre, 
        m.year, 
        m.title AS movie_name, 
        m.worlwide_gross_income,  -- Worldwide gross income of the movie
        RANK() OVER (PARTITION BY m.year, g.genre ORDER BY m.worlwide_gross_income DESC) AS movie_rank  -- Rank movies by worldwide gross income within each year and genre
    FROM 
        movie AS m
    JOIN 
        genre AS g ON m.id = g.movie_id  -- Join movie and genre tables to get the genre
    JOIN 
        TopGenres AS tg ON g.genre = tg.genre  -- Join to ensure movies belong to the top 3 genres
)
-- Step 3: Select the top 5 movies for each year and genre
SELECT 
    genre, 
    year, 
    movie_name, 
    worlwide_gross_income, 
    movie_rank
FROM 
    TopMovies
WHERE 
    movie_rank <= 5  -- Only select the top 5 movies
ORDER BY 
    genre, year, movie_rank;  -- Sort the output by genre, year, and movie rank

/*ANSWER 26
| genre		|   year  |		movie_name				     |worldwide_gross_income| movie_rank	  |
+---------------+---------+----------------------------------+----------------------+-----------------+
Comedy		    2017	 The Healer							$ 9979800				 1
Comedy		    2017	 Tim Timmerman, Hope of America		$ 97727					 2
Comedy		    2017	 Il a déjà tes yeux					$ 9755458				 3
Comedy		    2017	 Jumanji: Welcome to the Jungle		$ 962102237				 4
Comedy		    2017	 All Nighter						$ 96162					 5
Comedy		    2018	 La fuitina sbagliata				$ 992070				 1
Comedy		    2018	 Gung-hab							$ 9899017				 2
Comedy		    2018	 Simmba								$ 9865268			  	 3
Comedy		    2018	 Aleksi								$ 9791					 4
Comedy		    2018	 Os Farofeiros						$ 9786399				 5
Comedy		    2019	 Eaten by Lions						$ 99276					 1
Comedy		    2019	 Friend Zone						$ 9894885				 2
Comedy		    2019	 Organize Isler: Sazan Sarmali		$ 9831515				 3
Comedy		    2019	 Benjamin							$ 97521					 4
Comedy		    2019	 Brochevarevarura					$ 9737					 5
Drama		    2017	 Shatamanam Bhavati					INR 530500000			 1
Drama		    2017	 Winner								INR 250000000			 2
Drama		    2017	 Thank You for Your Service			$ 9995692				 3
Drama		    2017	 The Healer							$ 9979800				 4
Drama		    2017	 Shan guang shao nu					$ 9949926				 5
Drama		    2018	 Antony & Cleopatra					$ 998079				 1
Drama		    2018	 Zaba								$ 991					 2
Drama		    2018	 Canary								$ 98665					 3
Drama		    2018	 Simmba								$ 9865268				 4
Drama		    2018	 Une saison en France				$ 98390					 5
Drama		    2019	 Joker								$ 995064593				 1
Drama		    2019	 Nur eine Frau						$ 9884					 2
Drama		    2019	 Running with the Devil				$ 98682					 3
Drama		    2019	 Charlie Says						$ 98240					 4
Drama		    2019	 Transit							$ 982372				 5
Thriller	    2017	 Gi-eok-ui bam						$ 9968972				 1
Thriller	    2017	 V.I.P.								$ 9710283			 	 2
Thriller	    2017	 Fixeur								$ 9669					 3
Thriller	    2017	 Overdrive							$ 9650552				 4
Thriller	    2017	 Den 12. mann						$ 9567121				 5
Thriller	    2018	 The Villain						INR 1300000000			 1
Thriller	    2018	 Shéhérazade						$ 966225				 2
Thriller	    2018	 Truth or Dare						$ 95330493				 3
Thriller	    2018	 La nuit a dévoré le monde			$ 95208					 4
Thriller	    2018	 Replicas							$ 9206925				 5
Thriller	    2019	 Prescience							$ 9956					 1
Thriller	    2019	 Joker								$ 995064593				 2
Thriller	    2019	 Running with the Devil				$ 98682					 3
Thriller	    2019	 The Boat							$ 98559					 4
Thriller	    2019	Division 19							$ 981					 5
*/




-- Finally, let’s find out the names of the top two production houses that have produced the highest number of hits among multilingual movies.
-- Q27.  Which are the top two production houses that have produced the highest number of hits (median rating >= 8) among multilingual movies?
/* Output format:
+-------------------+-------------------+---------------------+
|production_company |movie_count		|		prod_comp_rank|
+-------------------+-------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:

-- Step 1: Identify movies with median ratings >= 8 (Hits) that are multilingual
WITH HitMovies AS (
    SELECT 
        m.production_company,  -- Production company of the movie
        COUNT(*) AS movie_count  -- Count of movies by production company
    FROM 
        movie AS m
    JOIN 
        ratings AS r ON m.id = r.movie_id  -- Link to ratings table
    WHERE 
        POSITION(',' in languages)>0  -- Check for more than one language (multilingual)
        AND r.median_rating >= 8
        AND production_company IS NOT NULL -- Filter for hits (median rating >= 8)
    GROUP BY 
        m.production_company  -- Group by production company
),
-- Step 2: Rank production companies based on the number of hits
RankedProductionCompanies AS (
    
    SELECT 
        production_company, 
        movie_count,
        RANK() OVER (ORDER BY movie_count DESC) AS prod_comp_rank  -- Rank based on movie count
    FROM 
        HitMovies
)
-- Step 3: Select the top 2 production companies
SELECT 
    production_company, 
    movie_count,
    prod_comp_rank
FROM 
    RankedProductionCompanies
WHERE 
    prod_comp_rank <= 2  -- Limit to top 2 production companies
ORDER BY 
    prod_comp_rank;  -- Sort by rank

/*ANSWER 27
+-----------------------+---------------+---------------------+
|production_company 	|movie_count	| prod_comp_rank      |
+-----------------------+---------------+---------------------+
| Star Cinema		|	7	|	1	      |
| Twentieth Century Fox	|	4	|	2	      |
+-----------------------+---------------+---------------------+
*/

-- Multilingual is the important piece in the above question. It was created using POSITION(',' IN languages)>0 logic
-- If there is a comma, that means the movie is of more than one language


-- Q28. Who are the top 3 actresses based on the number of Super Hit movies (Superhit movie: average rating of movie > 8) in 'drama' genre?

-- Note: Consider only superhit movies to calculate the actress average ratings.
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes
-- should act as the tie breaker. If number of votes are same, sort alphabetically by actress name.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |	  actress_avg_rating |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Laura Dern	|			1016	|	       1		  |	   9.6000		     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/

-- Type your code below:

-- Step 1: Find Superhit movies in the drama genre (average rating > 8)
WITH SuperHitMovies AS (
    SELECT 
        m.id AS movie_id, 
        g.genre,  -- Genre of the movie from the genre table
        m.title AS movie_name, 
        r.avg_rating, 
        r.total_votes
    FROM 
        movie AS m
    JOIN 
        ratings AS r ON m.id = r.movie_id  -- Join ratings table to get avg_rating
    JOIN 
        genre AS g ON m.id = g.movie_id  -- Join genre table to filter by genre
    WHERE 
        g.genre LIKE '%Drama%'  -- Drama genre
        AND r.avg_rating > 8  -- Superhit movie (average rating > 8)
),
-- Step 2: Calculate the weighted average rating for actresses based on superhit movies
ActressStats AS (
    SELECT 
        n.name AS actress_name, 
        SUM(r.total_votes) AS total_votes,  -- Sum of total votes for each actress
        COUNT(DISTINCT sm.movie_id) AS movie_count,  -- Count of superhit movies for each actress
        ROUND(SUM(r.avg_rating * r.total_votes) / SUM(r.total_votes), 2) AS actress_avg_rating  -- Weighted average rating for actress
    FROM 
        role_mapping AS rm
    JOIN 
        names AS n ON rm.name_id = n.id  -- Join to get actress names
    JOIN 
        SuperHitMovies AS sm ON sm.movie_id = rm.movie_id  -- Only consider superhit movies
    JOIN 
        ratings AS r ON sm.movie_id = r.movie_id  -- Get the ratings of superhit movies
    WHERE 
        rm.category = 'actress'  -- Only consider actresses
    GROUP BY 
        n.name  -- Group by actress name
)
-- Step 3: Rank actresses based on movie count, total votes, and name
SELECT 
    actress_name, 
    total_votes, 
    movie_count, 
    actress_avg_rating, 
    RANK() OVER (ORDER BY movie_count DESC, total_votes DESC, actress_name ASC) AS actress_rank
FROM 
    ActressStats
ORDER BY 
    actress_rank
LIMIT 3;  -- Only select top 3 actresses

/*ANSWER 28
+---------------------+--------------+-------------+--------------------+---------------+
| actress_name	      |	 total_votes | movie_count | actress_avg_rating | actress_rank  |
+---------------------+--------------+-------------+--------------------+---------------+
| Parvathy Thiruvothu |	  4974	     |	 2	   |	8.25		|	 1	|
| Amanda Lawrence     |   656	     |	 2	   |	8.94		|	 2	|
| Denise Gough	      |   656	     |	 2	   |	8.94		|	 3	|
+---------------------+--------------+-------------+--------------------+---------------+
*/



/* Q29. Get the following details for top 9 directors (based on number of movies)
Director id
Name
Number of movies
Average inter movie duration in days
Average movie ratings
Total votes
Min rating
Max rating
total movie durations

Format:
+---------------+-------------------+---------------------+----------------------+--------------+---------------+---------------+---------------+----------------+
| director_id	|  director_name    |	number_of_movies  | avg_inter_movie_days | avg_rating	| total_votes   | min_rating	| max_rating    | total_duration |
+---------------+-------------------+---------------------+----------------------+--------------+---------------+---------------+---------------+----------------+
|nm1777967	|   A.L. Vijay	    |	    5		  |	      177	 |  5.65	|	1754    |	3.7	|	6.9	|	613	 |
|	.	|	.	    |	    .		  |	       .	 |   .	    	|	.	|	.	|	.	|	.	 |
|	.	|	.	    |	    .		  |	       .	 |   .	    	|	.	|	.	|	.	|	.	 |
|	.	|	.	    |	    .		  |	       .	 |   .	    	|	.	|	.	|	.	|	.	 |
|	.	|	.	    |	    .		  |	       .	 |   .	    	|	.	|	.	|	.	|	.	 |
|	.	|	.	    |	    .		  |	       .	 |   .	    	|	.	|	.	|	.	|	.	 |
|	.	|	.	    |	    .		  |	       .	 |   .	    	|	.	|	.	|	.	|	.	 |
|	.	|	.	    |	    .		  |	       .	 |   .	    	|	.	|	.	|	.	|	.	 |
|	.	|	.	    |	    .		  |	       .	 |   .	    	|	.	|	.	|	.	|	.	 |
+---------------+-------------------+---------------------+----------------------+--------------+---------------+---------------+---------------+----------------+

--------------------------------------------------------------------------------------------*/
-- Type you code below:

-- Step 1: Gather director stats and calculate required metrics
WITH DirectorStats AS (
    SELECT 
        dm.name_id AS director_id,  -- Director ID
        n.name AS director_name,  -- Director name
        COUNT(m.id) AS number_of_movies,  -- Total number of movies directed
        AVG(r.avg_rating) AS avg_rating,  -- Average rating of movies
        SUM(r.total_votes) AS total_votes,  -- Total votes for movies
        MIN(r.avg_rating) AS min_rating,  -- Minimum rating
        MAX(r.avg_rating) AS max_rating,  -- Maximum rating
        SUM(m.duration) AS total_duration,  -- Total duration of movies
        -- Calculate total days between first and last movie and divide by (number of movies - 1) for average
        CASE 
            WHEN COUNT(m.id) > 1 THEN 
               ROUND((DATEDIFF(MAX(m.date_published), MIN(m.date_published)) / (COUNT(m.id) - 1)))
            ELSE 
                NULL  -- If only one movie, no average interval can be calculated
        END AS avg_inter_movie_days
    FROM 
        movie AS m
    JOIN 
        ratings AS r ON m.id = r.movie_id  -- Join to ratings table
    JOIN 
        director_mapping AS dm ON m.id = dm.movie_id  -- Join to director mapping table
    JOIN 
        names AS n ON dm.name_id = n.id  -- Join to names table for director names
    GROUP BY 
        dm.name_id, n.name  -- Group by director ID and name
),

-- Step 2: Rank directors by the number of movies directed
RankedDirectors AS (
    SELECT 
        director_id,
        director_name,
        number_of_movies,
        ROUND(avg_rating, 2) AS avg_rating,
        total_votes,
        ROUND(min_rating, 2) AS min_rating,
        ROUND(max_rating, 2) AS max_rating,
        total_duration,
        ROUND(avg_inter_movie_days, 2) AS avg_inter_movie_days,
        RANK() OVER (ORDER BY number_of_movies DESC) AS director_rank
    FROM 
        DirectorStats
)

-- Step 3: Select the top 9 directors
SELECT 
    director_id,
    director_name,
    number_of_movies,
    avg_inter_movie_days,
    avg_rating,
    total_votes,
    min_rating,
    max_rating,
    total_duration
FROM 
    RankedDirectors
WHERE 
    director_rank <= 9
ORDER BY 
    director_rank;


/*ANSWER 29
+---------------+-------------------+---------------------+----------------------+--------------+---------------+---------------+------------+--------------------+
| director_id	|  director_name    |	number_of_movies  | avg_inter_movie_days | avg_rating	| total_votes   | min_rating	| max_rating | total_duration     |
+---------------+-------------------+---------------------+----------------------+--------------+---------------+---------------+------------+--------------------+
| nm2096009     | Andrew Jones	    |		5	  |	191		 |	3.02	|   1989	|  2.7		|  3.2	     |	432		  |
| nm1777967	| A.L. Vijay	    |		5	  |	177		 |	5.42	|   1754	|  3.7		|  6.9	     |	613		  |
| nm6356309	| Özgür Bakar	    |		4	  |	112		 |	3.75	|   1092	|  3.1		|  4.9	     |	374		  |
| nm2691863	| Justin Price	    |		4	  |	315		 |	4.50	|   5343	|  3.0		|  5.8	     |	346		  |
| nm0814469	| Sion Sono	    |		4	  |	331		 |	6.03	|   2972	|  5.4		|  6.4	     |	502		  |
| nm0831321	| Chris Stokes	    |		4	  |	198		 |	4.33	|   3664	|  4.0		|  4.6	     |	352		  |
| nm0425364	| Jesse V. Johnson  |		4	  |	299		 |	5.45	|   14778	|  4.2		|  6.5	     |	383		  |
| nm0001752	| Steven Soderbergh |		4	  |	254		 |	6.48	|   171684	|  6.2		|  7.0	     |	401		  |
| nm0515005	| Sam Liu	    |		4	  |	260		 |	6.23	|   28557	|  5.8		|  6.7	     |	312		  |
+---------------+-------------------+---------------------+----------------------+--------------+---------------+------------+---------------+--------------------+
*/
