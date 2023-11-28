select * from Spotify2023
select track_name, artist_name from Spotify2023
where streams IS NULL

--checking for nulls
select * from Spotify2023
where track_name IS NULL -- no nulls found

--number of songs present
select COUNT(track_name) as total_no_of_songs from Spotify2023 

--duplicate songs
select * from Spotify2023

select track_name, artist_name, released_day from Spotify2023
group by track_name, artist_name,  released_day
having COUNT(*)>1

--counting the no of years we have 
select distinct(released_year) from Spotify2023
order by released_year ASC

--Spotify was launched in the year 2006 so we will only consider the data from 2008
select COUNT(*) from Spotify2023
where released_year between 2008 AND 2023;

--top 10 song with highest streams
select TOP 10 artist_name, track_name, max(streams) as highest_stream from Spotify2023
group by  artist_name, track_name
order by highest_stream DESC;

--Blinding Lights has the highest streaming with 3.7B+ views

--most streamed artist
select TOP 10 artist_name, sum(streams) as highest_steaming_artist from Spotify2023
group by  artist_name
order by highest_steaming_artist DESC;

--Most streamed artist - The Weeknd

select distinct(artist_name)from Spotify2023
--group by  artist_name
--order by highest_stream DESC;

--Top 10 artist with most no of songs 

select  TOP 10 artist_name, COUNT(track_name) as no_of_songs, COUNT(track_name) /(select  COUNT(*) from Spotify2023) as percen  from Spotify2023
--WHERE streams = (SELECT MAX(streams) FROM Spotify2023)
group by artist_name
order by no_of_songs DESC


--select artist_name, track_name,  streams as highest_stream from Spotify2023
--group by artist_name 
--group by  artist_name, streams
--order by highest_stream DESC;

--no of times artist shows up in playlist

select TOP 10 artist_name, SUM(spotify_playlists) as spotify_palylist_count, 
SUM(apple_playlists) as apple_palylist_count, 
SUM(deezer_playlists) as deezer_palylist_count 
from Spotify2023
group by artist_name
order by spotify_palylist_count DESC

select deezer_playlists from Spotify2023
order by deezer_playlists desc
--ekta coloumn add for release year
--kon year e streaming besi hyeche
--amount of trcaks released each year between 2008-2023

--year with Hihest streaming in 2023
WITH DateCTE AS(
SELECT CONVERT(DATE, 
               CAST(released_year AS VARCHAR(4)) + '-' + 
               RIGHT('0' + CAST(released_month AS VARCHAR(2)), 2) + '-' +
               RIGHT('0' + CAST(released_day AS VARCHAR(2)), 2)
              ) AS date_col
FROM Spotify2023)
--most streaming year
Select TOP 10 released_year,SUM(streams) as Highest_Stream from Spotify2023
group by released_year
Order By Highest_Stream DESC
                                                                                             
--no of relases each month for every year

select released_month, COUNT(track_name) AS no_of_releases from Spotify2023
group by released_month

--where released_month BETWEEN  '2006' AND '2023'
group by released_month
order by no_of_releases DESC

--avg stream of artist per year
select TOP 10 artist_name, AVG(streams) as avg_stream from Spotify2023
where released_year='2023'
group by artist_name
Order by avg_stream DESC

--top number of playlis the song is included in

select TOP 5 spotify_playlists, track_name from Spotify2023
order by spotify_playlists DESC
