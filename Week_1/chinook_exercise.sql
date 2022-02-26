/* SQL Exercise
====================================================================
We will be working with database chinook.db
You can download it here: https://drive.google.com/file/d/0Bz9_0VdXvv9bWUtqM0NBYzhKZ3c/view?usp=sharing&resourcekey=0-7zGUhDz0APEfX58SA8UKog

 The Chinook Database is about an imaginary video and music store. Each track is stored using one of the digital formats and has a genre. The store has also some playlists, where a single track can be part of several playlists. Orders are recorded for customers, but are called invoices. Every customer is assigned a support employee, and Employees report to other employees.
*/


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE


--==================================================================
/* TASK I
Which artists did not make any albums at all? Include their names in your answer.
*/
SELECT artists.Name FROM artists
    LEFT JOIN albums ON artists.ArtistId=albums.ArtistId
    WHERE albums.AlbumId IS NULL;

/* TASK II
Which artists recorded any tracks of the Latin genre?
*/

SELECT DISTINCT artists.Name FROM artists
    INNER JOIN albums ON artists.ArtistId=albums.ArtistId
    INNER JOIN tracks ON albums.AlbumId=tracks.AlbumId
    INNER JOIN genres ON tracks.GenreId=genres.GenreId
    WHERE genres.GenreId = 7;

/* TASK III
Which video track has the longest length?
*/
SELECT tracks.Name, MAX(Milliseconds) AS 'longest_length' FROM tracks
     LEFT JOIN media_types ON tracks.MediaTypeId=media_types.MediaTypeId
     WHERE media_types.MediaTypeId = 3;

/* TASK IV
Find the names of customers who live in the same city as the top employee (The one not managed by anyone).
*/

SELECT customers.FirstName, customers.LastName, customers.City FROM customers
     JOIN employees ON customers.City = employees.City
     WHERE employees.City IN 
       (SELECT employees.City FROM employees WHERE ReportsTo IS NULL);
     
/* TASK V
Find the managers of employees supporting Brazilian customers. ~~~~~~~~~~~
*/

SELECT employees.FirstName, employees.LastName FROM employees
    WHERE EmployeeId IN (
        SELECT ReportsTo FROM employees
        JOIN customers ON EmployeeId=SupportRepId
        WHERE customers.Country = 'Brazil');

    /* below is finding employees that support Brazilian customers */
        SELECT DISTINCT employees.FirstName, ReportsTo FROM employees
        JOIN customers ON EmployeeId=SupportRepId
        WHERE customers.Country = 'Brazil';

/* TASK VI
Which playlists have no Latin tracks?
*/

SELECT DISTINCT playlists.Name, playlists.PlaylistId FROM playlists
    JOIN playlist_track ON playlists.PlaylistId=playlist_track.PlaylistId
    JOIN tracks ON playlist_track.TrackId=tracks.TrackId
    JOIN media_types ON tracks.MediaTypeId=media_types.MediaTypeId
    WHERE media_types.Name != 'Latin';