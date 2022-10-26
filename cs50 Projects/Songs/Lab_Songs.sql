-- LAB Songs

-- 1 write a SQL query to list the names of all songs in the database.
--Your query should output a table with a single column for the name of each song.
SELECT name
FROM songs;

-- 2 write a SQL query to list the names of all songs in increasing order of tempo.
-- Your query should output a table with a single column for the name of each song.
SELECT name
FROM songs
ORDER BY tempo ASC;

-- 3  write a SQL query to list the names of the top 5 longest songs, in descending order of length.
-- Your query should output a table with a single column for the name of each song.
SELECT name
FROM songs
ORDER BY duration_ms DESC
Limit 5;

-- 4 write a SQL query that lists the names of any songs that have danceability, energy, and valence greater than 0.75.
-- Your query should output a table with a single column for the name of each song.

SELECT name
FROM songs
WHERE danceability > 0.75
AND energy > 0.75
AND valence > 0.75;

-- In 5.sql, write a SQL query that returns the average energy of all the songs.
-- Your query should output a table with a single column and a single row containing the average energy.

SELECT AVG(energy)
FROM songs;

-- 6 In 6.sql, write a SQL query that lists the names of songs that are by Post Malone.
-- Your query should output a table with a single column for the name of each song.
-- You should not make any assumptions about what Post Malone’s artist_id is.

SELECT songs.name
FROM songs, artists
WHERE songs.artist_id = artists.id
AND artists.name = 'Post Malone';

-- In 7.sql, write a SQL query that returns the average energy of songs that are by Drake.
-- Your query should output a table with a single column and a single row containing the average energy.
-- You should not make any assumptions about what Drake’s artist_id is.

SELECT AVG(energy)
FROM artists, songs
WHERE songs.artist_id = artists.id
AND artists.name = 'Drake';

-- In 8.sql, write a SQL query that lists the names of the songs that feature other artists.
-- Songs that feature other artists will include “feat.” in the name of the song.
-- Your query should output a table with a single column for the name of each song.

SELECT songs.name
FROM artists, songs
WHERE songs.artist_id = artists.id
AND songs.name LIKE '%feat%';
