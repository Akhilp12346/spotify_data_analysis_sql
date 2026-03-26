--SQL Porject Spotify Datasets
-- creating table

-- create table
DROP TABLE IF EXISTS spotify;

CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability DOUBLE PRECISION,
    energy DOUBLE PRECISION,
    loudness DOUBLE PRECISION,
    speechiness DOUBLE PRECISION,
    acousticness DOUBLE PRECISION,
    instrumentalness DOUBLE PRECISION,
    liveness DOUBLE PRECISION,
    valence DOUBLE PRECISION,
    tempo DOUBLE PRECISION,
    duration_min DOUBLE PRECISION,
    title VARCHAR(255),
    channel VARCHAR(255),
    views DOUBLE PRECISION,
    likes DOUBLE PRECISION,     -- changed from BIGINT
    comments DOUBLE PRECISION,  -- changed from BIGINT
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream DOUBLE PRECISION,    -- changed from BIGINT
    energy_liveness DOUBLE PRECISION,
    most_played_on VARCHAR(50)
);

SELECT*
FROM spotify