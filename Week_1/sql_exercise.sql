/* SQL Exercise
====================================================================
We will be working with database imdb.db
You can download it here: https://drive.google.com/file/d/1E3KQDdGJs4a0i1RoYb8DEq0PFxCgI6cN/view?usp=sharing
*/


-- MAKE YOURSELF FAMILIAR WITH THE DATABASE AND TABLES HERE





--==================================================================
/* TASK I
 Find the id's of movies that have been distributed by “Universal Pictures”.
*/

SELECT movie_id FROM movie_distributors
JOIN distributors USING (distributor_id)
WHERE name = 'Universal Pictures';

/* TASK II
 Find the name of the companies that distributed movies released in 2006.
*/

SELECT name FROM distributors
    JOIN movie_distributors USING (distributor_id)
    JOIN movies USING (movie_id)
    WHERE year = 2006;


/* TASK III
Find all pairs of movie titles released in the same year, after 2010.
hint: use self join on table movies.
*/

SELECT A.title AS Title1, B.title AS Title2
    FROM movies A, movies B
    WHERE A.movie_id = B.movie_id
    AND A.year > 2010;

/* TASK IV
 Find the names and movie titles of directors that also acted in their movies.
*/

SELECT DISTINCT movies.title, people.name FROM movies
    INNER JOIN directors USING (movie_id)
    INNER JOIN roles USING (person_id)
    INNER JOIN people USING (person_id)
    WHERE role NOT LIKE 'Director%';


/* TASK V
Find ALL movies realeased in 2011 and their aka titles.
hint: left join
*/

SELECT movies.title AS movie_title, aka_titles.title AS AKA_title 
    FROM movies
    LEFT JOIN aka_titles USING (movie_id)
    WHERE year = 2011;


/* TASK VI
Find ALL movies realeased in 1976 OR 1977 and their composer's name.
*/

SELECT title, name FROM movies
    INNER JOIN composers USING (movie_id)
    INNER JOIN people USING (person_id)
    WHERE year = 1976 OR year = 1977;


/* TASK VII
Find the most popular movie genres.
*/

SELECT DISTINCT label FROM genres
    INNER JOIN movie_genres USING (genre_id)
    INNER JOIN movies USING (movie_id)
    WHERE rating > 8.8;


/* TASK VIII
Find the people that achieved the 10 highest average ratings for the movies 
they cinematographed.
*/

SELECT people.name, AVG(movies.rating) AS ave_rating FROM people
    INNER JOIN cinematographers USING (person_id)
    INNER JOIN movies USING (movie_id)
    GROUP BY people.name
    ORDER BY ave_rating DESC
    LIMIT 10;


/* TASK IX
Find all countries which have produced at least one movie with a rating higher than
8.5.
hint: subquery
*/

SELECT DISTINCT name FROM countries 
    INNER JOIN movie_countries USING (country_id)
    INNER JOIN movies USING (movie_id)
    WHERE rating IN (
        SELECT rating FROM movies
        WHERE rating > 8.5);


/* TASK X
Find the highest-rated movie, and report its title, year, rating, and country. There
can be ties; if so, you should report for each of them.
*/

SELECT title, year, rating, countries.name FROM movies
    INNER JOIN movie_countries USING (movie_id)
    INNER JOIN countries USING (country_id)
    ORDER BY rating DESC
    LIMIT 5;



/* STRETCH BONUS
Find the pairs of people that have directed at least 5 movies and whose 
carees do not overlap (i.e. The release year of a director's last movie is 
lower than the release year of another director's first movie).
*/

SELECT a.name AS name1, b.name AS name2
    FROM people A, people B
    WHERE A.movie_id = B.movie_id


SELECT name, COUNT(movie_id) AS no_of_movies FROM people
    INNER JOIN directors USING (person_id)
    INNER JOIN movies USING (movie_id)
    GROUP BY name
    HAVING no_of_movies >= 5;


