#CUNY SPS Bridge SQL Assignment 1
#Chinedu Onyeka
#Date: July 25th, 2021


#Problem 1: Which destination is the furthest distance away in the flights database
SELECT origin, dest, distance FROM flights
GROUP BY origin, dest
ORDER BY distance DESC;
#The destination with the furthest distance is JFK -> HNL with a distance of 4983


#Problem 2: What are the different number of engines in the planes table
SELECT * FROM planes
GROUP BY engines
ORDER BY seats DESC;
#The different number of engines are 1,2,3, and 4. The aircraft with most seats is AIRBUS A330-223 with tailnum N854NW


#Problem 3: Show the total number of flights
SELECT COUNT(flight) AS Total_Flights FROM flights;
#The total number of flights is 336776


#Problem 4: Show the total number of flights by airline (carrier)
SELECT carrier, COUNT(carrier) AS num_flights FROM flights
GROUP BY carrier;


#Problem 5: Show all of the airlines by number of flights in descending order.
SELECT carrier, COUNT(carrier) AS num_flights FROM flights
GROUP BY carrier
ORDER BY num_flights DESC;


#Problem 6: Show only the top 5 airlines, by number of flights, ordered by number of flights in descending order
SELECT carrier, COUNT(carrier) AS num_flights FROM flights
GROUP BY carrier
ORDER BY num_flights DESC
LIMIT 5;


#Problem 7: Show only the top 5 airlines, by number of flights of distance 1000 miles or greater, 
#ordered by number of flights in descending order
SELECT carrier, COUNT(carrier) AS num_flights, distance  FROM flights
WHERE distance > 1000
GROUP BY carrier
ORDER BY num_flights DESC
LIMIT 5;


#Problem 8: Create a question that (a) uses data from the flights database, and 
#(b) requires aggregation to answer it, and write down both the question, and the query that answers the question.

#question: What are the airports that flights originate from? and how many flights originate from each airport?

SELECT origin, COUNT(origin) AS num_flights FROM flights
GROUP BY origin;
#Flights originate from EWR, LGA, and JFK airports

