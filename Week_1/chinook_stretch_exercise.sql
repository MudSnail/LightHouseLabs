/* SQL Stretch Exercise
====================================================================
We will be working with database chinook.db
You can download it here: https://drive.google.com/file/d/0Bz9_0VdXvv9bWUtqM0NBYzhKZ3c/view?usp=sharing&resourcekey=0-7zGUhDz0APEfX58SA8UKog

 The Chinook Database is about an imaginary video and music store. 
 Each track is stored using one of the digital formats and has a genre. 
 The store has also some playlists, where a single track can be part of 
 several playlists. Orders are recorded for customers, but are called invoices. 
 Every customer is assigned a support employee, and Employees report to other 
 employees.
*/



--==================================================================
/* TASK I
How many audio tracks in total were bought by German customers? 
And what was the total price paid for them?
hint: use subquery to find all of tracks with their prices
mediatype = 4 (purchaced AAC audio file)
*/
SELECT SUM(Quantity) AS "Total_Tracks", 
    SUM(invoice_items.UnitPrice) AS "Total_Price"
    FROM invoice_items
    JOIN invoices ON invoice_items.InvoiceId=invoices.InvoiceId
    WHERE BillingCountry = 'Germany' IN (
        SELECT tracks.UnitPrice, TrackId, Name FROM tracks
        JOIN invoice_items ON tracks.TrackId=invoice_items.TrackId);


/* TASK II
What is the space, in bytes, occupied by the playlist “Grunge”, and how much 
would it cost? (Assume that the cost of a playlist is the sum of the price of
 its constituent tracks).
 Grunge playlist ID = 16 (table playlists)
*/

SELECT Bytes, SUM(UnitPrice) AS "Price" FROM tracks
    JOIN playlist_track ON tracks.TrackID=playlist_track.TrackID
    JOIN playlists ON playlist_track.PlaylistID=playlists.PlaylistID
    WHERE playlists.Name = 'Grunge';

/* TASK III
List the names and the countries of those customers who are supported by an 
employee who was younger than 35 when hired. 
*/

SELECT customers.FirstName, customers.Country FROM customers
    JOIN employees ON customers.SupportRepId=employees.EmployeeId
    WHERE EmployeeId IN (
        SELECT EmployeeId, (HireDate - BirthDate) AS 'Age' 
            FROM employees
            WHERE Age < 35);

SELECT EmployeeId, BirthDate, HireDate, (HireDate-BirthDate) AS 'Age'
    FROM employees
    WHERE Age < 35;
