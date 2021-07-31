/*
CUNY SPS Bridge SQL Assignment 2
Name: Chinedu Onyeka
Date: July 30th, 2021
*/


/*
In this assignment, we’ll practice working with one-to-many relationships in SQL. Suppose you are tasked with keeping
track of a database that contain the best “how-to” videos on MySQL.
You may want to first create a new database (schema) for this assignment.
1. Videos table. Create one table to keep track of the videos. This table should include a unique ID, the title of the
video, the length in minutes, and the URL. Populate the table with at least three related videos from YouTube or
other publicly available resources.
2. Create and populate Reviewers table. Create a second table that provides at least two user reviews for each of
at least two of the videos. These should be imaginary reviews that include columns for the user’s name
(“Asher”, “Cyd”, etc.), the rating (which could be NULL, or a number between 0 and 5), and a short text review
(“Loved it!”). There should be a column that links back to the ID column in the table of videos.
3. Report on Video Reviews. Write a JOIN statement that shows information from both tables.
*/

CREATE DATABASE IF NOT EXISTS how_to_videos;
USE how_to_videos;
DROP TABLE IF EXISTS videos;
DROP TABLE IF EXISTS reviewers;

#Problem1:  
#Create the Videos table
CREATE TABLE videos(
video_id VARCHAR(10) UNIQUE NOT NULL,
title VARCHAR(255) NOT NULL,
length NUMERIC(20) NOT NULL,
url VARCHAR(255) NOT NULL,

PRIMARY KEY(video_id)
);
#populate the videos table
INSERT INTO videos
VALUES
('SQLJ1','Databases - Episode 6 - Joining Tables',5.4,'https://youtu.be/79EBoVPUzkE'),
('SQLJ2','OneToMany',5.0,'https://youtu.be/tX4_j-74lPQ'),
('SQLJ3','Databases - Episode 1 - Introduction',3.8,'https://youtu.be/kaKa6N9lEG8');

#Problem 2:
#Create Reviewers table
CREATE TABLE reviewers(
user_name VARCHAR(50) UNIQUE NOT NULL,
video_id VARCHAR(10) UNIQUE NOT NULL REFERENCES videos(video_id) ON DELETE CASCADE,
title VARCHAR(255) NOT NULL REFERENCES videos(title) ON DELETE CASCADE,
rating VARCHAR(100),

PRIMARY KEY(user_name)
);
#populate the reviewers table
INSERT INTO reviewers
VALUES
('Asher','SQLJ1', 'Databases - Episode 6 - Joining Tables', '4 - Loved it!' ),
('Cyd', 'SQLJ3', 'Databases - Episode 1 - Introduction', '5 - Great Introduction');

#Problem 3:
#Write a join statement to join both tables (videos and reviewers)
SELECT v.*, r.user_name, r.rating
FROM videos v 
LEFT JOIN reviewers r
ON v.video_id = r.video_id;