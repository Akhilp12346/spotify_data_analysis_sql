-- Data Analysis--

--retrieve the name of all track that have more than 1 billion streams
SELECT
track
FROM spotify
WHERE stream > 1000000000

--list all the album along with their respective artists

SELECT
	DISTINCT album,
	artist
FROM spotify
ORDER BY album

-- Get the total no of comments for track where licensed = TRUE
--SELECT DISTINCT licensed FROM spotify

SELECT
	SUM(comments) as Total_comments
FROM spotify
WHERE licensed = true

--find all the tracks that belongs to the single
--SELECT DISTINCT album_type FROM spotify


SELECT
	track,
	album_type
FROM spotify
WHERE album_type = 'single'


-- count the total no of tracks by each artists

SELECT  
	artist,
	COUNT(*)as total_tracks
FROM spotify
GROUP BY artist
ORDER BY 2 DESC


-- Calculate average danceability of tracks in each album
SELECT 
	album,
	(AVG(danceability))as Avg_daceability
FROM spotify
GROUP BY 1
ORDER BY 2 DESC


-- find the top  5 tracks with highest energy values
SELECT
	track,
	MAX(energy) AS highest_energy
FROM spotify
GROUP BY 1
ORDER BY highest_energy DESC
LIMIT 5

-- list all the tracks along with their Total views and total likes where official_video = TRUE

SELECT
		track,
		SUM(views) as total_views,
		SUM(likes) as total_likes
FROM spotify
WHERE official_video = true
GROUP BY track
ORDER BY total_views DESC

-- for each album ,calculate the total views of all associated tracks 

SELECT
	album,
	track,
	SUM(views) as total_views
FROM spotify
GROUP BY 1,2
ORDER BY 3 DESC

-- Retrieve the track names that have been streamed on spotify more than youtube
SELECT*
FROM
(
	SELECT
		track,
		COALESCE(SUM(CASE WHEN most_played_on = 'Youtube' THEN stream END),0) AS streamed_on_youtube,
	 	COALESCE(SUM(CASE WHEN most_played_on = 'Spotify' THEN stream END),0)AS streamed_on_Spotify
	FROM spotify 
	GROUP BY track
)t
WHERE 
	streamed_on_Spotify > streamed_on_youtube
	AND
	streamed_on_youtube <>0

--find the top 3 most-viewed tracks for each artists using window function 

WITH rank_artist AS (
SELECT
	artist,
	track,
	SUM(views) as total_views,
	DENSE_RANK() OVER(PARTITION BY artist ORDER BY SUM(views) DESC ) AS rank
FROM spotify
GROUP BY 1,2
)
SELECT *
FROM rank_artist
WHERE rank <= 3

--write a query to find tracks where the liveness score is more than average

SELECT
	track,
	artist,
	liveness
FROM spotify
WHERE liveness > (SELECT AVG(liveness)FROM spotify)


--use a WITH clause to find the difference  between the lowest and highest energy value in each album

WITH difference AS(
SELECT
	album,
	MAX(energy) as highest_energy,
	MIN(energy) as  lowest_energy
FROM spotify
GROUP BY album
)
SELECT
	album,
	highest_energy - lowest_energy AS energy_diff
FROM difference
ORDER BY 2 DESC

	
--Find tracks where the energy-to-liveness ratio is greater than 1.2 write a sql query

SELECT *
FROM spotify
WHERE liveness != 0
  AND (energy / liveness) > 1.2;



--Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.
SELECT 
    track,
    views,
    likes,
    SUM(likes) OVER (ORDER BY views) AS cumulative_likes
FROM spotify
ORDER BY views DESC;

-- 2nd approach
SELECT 
    track,
    views,
    likes,
    SUM(likes) OVER (
        ORDER BY views 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_likes
FROM spotify
ORDER BY views DESC