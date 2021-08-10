/* CUNY SPS BRIDGE SQL Assignment 3 */
# Name: Chinedu Onyeka
# Date: August 8th, 2021

/* This project is where you show off your ability to (1) translate a business requirement into a database design, (2) design
a database using one-to-many and many-to-many relationships, and (3) know when to use LEFT and/or RIGHT JOINs to
build result sets for reporting.
An organization grants key-card access to rooms based on groups that key-card holders belong to. You may assume that
users below to only one group. Your job is to design the database that supports the key-card system.
There are six users, and four groups. Modesto and Ayine are in group “I.T.” Christopher and Cheong woo are in group
“Sales”. There are four rooms: “101”, “102”, “Auditorium A”, and “Auditorium B”. Saulat is in group
“Administration.” Group “Operations” currently doesn’t have any users assigned. I.T. should be able to access Rooms
101 and 102. Sales should be able to access Rooms 102 and Auditorium A. Administration does not have access to any
rooms. Heidy is a new employee, who has not yet been assigned to any group. */

#Create Database and Tables

DROP DATABASE IF EXISTS keycard;
CREATE DATABASE IF NOT EXISTS keycard;
USE keycard;

#Create the Groups table
CREATE TABLE IF NOT EXISTS org_group(
group_id INT PRIMARY KEY,
group_name VARCHAR(50)
);

#Create the Users table
CREATE TABLE IF NOT EXISTS org_users(
user_id SERIAL PRIMARY KEY NOT NULL,
user_name VARCHAR(50) NOT NULL,
group_id INT REFERENCES org_group(group_id) ON DELETE CASCADE
);

#Create the Rooms table
CREATE TABLE IF NOT EXISTS org_rooms(
room_id INT NOT NULL PRIMARY KEY,
room_name VARCHAR(50)
);

#Create the Access table
CREATE TABLE IF NOT EXISTS access_rooms(
group_id INT REFERENCES org_group(group_id) ON DELETE CASCADE,
room_id INT REFERENCES org_rooms(room_id) ON DELETE CASCADE
);

#Populate the Groups table
INSERT INTO org_group
VALUES
(1, "I.T"),
(2, "Sales"),
(3, "Administration"),
(4, "Operations");

#Populate the users table
INSERT INTO org_users
VALUES
(1, "Modesto", 1),
(2, "Ayine", 1),
(3, "Christopher", 2),
(4, "Cheong Woo", 2),
(5, "Saulat", 3),
(6, "Heidy", NULL);

#Populate the Rooms table
INSERT INTO org_rooms
VALUES
(1, "101"),
(2, "102"),
(3, "Auditorium A"),
(4, "Auditorium B");

#Populate the Access table
INSERT INTO access_rooms
VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 3);

/* Next, write SELECT statements that provide the following information:
• All groups, and the users in each group. A group should appear even if there are no users assigned to the group.
• All rooms, and the groups assigned to each room. The rooms should appear even if no groups have been
assigned to them.
• A list of users, the groups that they belong to, and the rooms to which they are assigned. This should be sorted
alphabetically by user, then by group, then by room. */

# All groups, and the users in each group. A group should appear even if there are no users assigned to the group
SELECT g.group_name, u.user_name
FROM org_group g
LEFT JOIN org_users u
ON g.group_id = u.group_id;

#All rooms, and the groups assigned to each room. The rooms should appear even if no groups have been assigned to them
SELECT r.room_name, g.group_name 
FROM org_rooms r
LEFT JOIN access_rooms a
ON a.room_id = r.room_id
LEFT JOIN org_group g
ON a.group_id = g.group_id;


# A list of users, the groups that they belong to, and the rooms to which they are assigned. This should be sorted 
# alphabetically by user, then by group, then by room. 
SELECT u.user_name, g.group_name, r.room_name
FROM org_users AS u
LEFT JOIN org_group g
ON u.group_id = g.group_id
LEFT JOIN access_rooms AS a
ON u.group_id = a. group_id
LEFT JOIN org_rooms r
ON r.room_id = a.room_id
ORDER BY user_name, group_name, r.room_name;