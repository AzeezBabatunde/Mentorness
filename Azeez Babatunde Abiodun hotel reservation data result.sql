-- create table Hotel_Reservation_Data(
-- Booking_ID					varchar(30),
-- no_of_adults				int,
-- no_of_children				int,
-- no_of_weekend_nights		int,
-- no_of_week_nights			int,
-- type_of_meal_plan			varchar(50),
-- room_type_reserved			varchar(50),
-- lead_time					int,
-- arrival_date					varchar(50),
-- market_segment_type			varchar(30),
-- avg_price_per_room			decimal,
-- booking_status				varchar(50)
-- );

--SELECT * FROM Hotel_Reservation_Data;

/* TASK:-  To get the total number of reservations made, we will check the count of booking_id*/

-- SELECT COUNT(booking_id)
-- from  Hotel_Reservation_Data

/*INSIGHT:- There are total of 700 reservations.*/

/* TASK:-  To get the most selected meal plan among guests*/

-- select type_of_meal_plan, count(*) as count_of_meal_plan
-- from Hotel_Reservation_Data
-- group by type_of_meal_plan
-- order by count_of_meal_plan desc;

/*INSIGHT:- 
From the code above we can see that meal plan 1 has the highest number 
of selection among guests.*/

/* TASK:- To get the average price per room for reservation involving children.*/

-- select round(avg(avg_price_per_room)) as avg_price_per_room_with_children
-- from Hotel_Reservation_Data
-- where no_of_children > 0;

/*INSIGHT:- 
From the above code we can see that the average price per room for 
reservation involving children is 145 when we round to nearest whole number.*/

/*Task:- To get reservations made in a specific year 
First, I wiil check for reservation in each years*/

-- select substring(arrival_date,7,4) as Year,
-- count(*) as Total_Reservations
-- from Hotel_Reservation_Data
-- group by substring(arrival_date,7,4)
-- order by Year;

/*OBSERVATION:- From the result of above code we can see that some filled the arrival_date as 
2001,2018 while some filled in the date format but with year written as 018, 18
and 2018 respectively, to get a accurate result we need to first modify the column 
such that all all arrival date will be in the same date format of DD-MM-YYYY and the years 
2018 will display as 2018 while 2017 display as 2017.*/

/*Step 1 
modify the arrival date to date format by filling the 2001 and 2018 rows with 
01-01-2001, 01-01-2017 and 01-01-2018.*/

-- update Hotel_Reservation_Data
-- set arrival_date =
--  	case
-- 		when length(arrival_date) = 4 then concat('01-01-', substring(arrival_date,1,6))
-- 		else arrival_date
-- 	end;

--select arrival_date from Hotel_Reservation_Data

/*Step 2
Modify the arival date such that the years 2018 will display as 2018 while 2017 display as 2017.*/

-- update Hotel_Reservation_Data
-- set arrival_date =
-- 	case
-- 		when substring(arrival_date,7,2) = '18' then concat('20', substring(arrival_date,7,2))
-- 		when substring(arrival_date,7,3) = '018' then concat('20', substring(arrival_date,7,2))
-- 		when substring(arrival_date,7,2) = '17' then concat('20', substring(arrival_date,7,2))
-- 		when substring(arrival_date,7,3) = '017' then concat('20', substring(arrival_date,7,2))
-- 		when substring(arrival_date,7,3) = '001' then concat('20', substring(arrival_date,7,2))
-- 		else arrival_date
-- 	end
-- ;

--SELECT * FROM Hotel_Reservation_Data;

/*Now we can check the reservations made in each years again to see if our corrections are made*/

-- select substring(arrival_date,7,4) as Year,
-- count(*) as Total_Reservations
-- from Hotel_Reservation_Data
-- group by substring(arrival_date,7,4)
-- order by Year;

/*Task:- To get the total number of reservations made in a given year e.g 2018 from the arrival date column*/

-- select count(*) as Year_2018_Reservations
-- from Hotel_Reservation_Data
-- where substring(arrival_date,7,4) = '2018';

/*INSIGHT:- 
There was a total of 370 reservations made in year 2018*/

/*Task:- To check the most commonly booked room type*/

-- select room_type_reserved, count(*) as count_of_reserved_room_type
-- from Hotel_Reservation_Data
-- group by room_type_reserved
-- order by count_of_reserved_room_type desc;

/* INSIGHT:- 
Room_type 1 is the most commonly reserved room type with total of 534 reservations.
*/

/* Task:- To check the number of reservations that fall on weekends*/

-- select count(no_of_weekend_nights)
-- from Hotel_Reservation_Data
-- where no_of_weekend_nights > 0;

/* INSIGHT:- 
There are total of 383 weekend reservations.
*/

/*Task:- To check  the highest and lowest lead time for reservations*/

-- select min(lead_time) as Lowest_reservation_lead_time
-- from Hotel_Reservation_Data

-- select max(lead_time) as highest_reservation_lead_time
-- from Hotel_Reservation_Data

/* INSIGHT:- 
1)	The lowest lead time for reservation is 0
2)	The highest lead time for reservation is 443.
*/

/* Task:- To check the most common market segment type for reservations.*/

-- select market_segment_type, count(*) as modal_value
-- from Hotel_Reservation_Data
-- group by market_segment_type
-- order by modal_value desc
-- ;

/* INSIGHT:-
Online market segment type is the most common for reservation with modal value of 518.
*/


/* TASK:- To check how many reservations have a booking status of "Confirmed.*/

-- select booking_status, count(*) as modal_value
-- from Hotel_Reservation_Data
-- group by booking_status
-- order by modal_value desc
-- ;

/* INSIGHT:- 
There are 493 confirmed booking status. 
*/


/* TASK:- To check the total number of adults and children across all reservations?	*/

-- select sum(no_of_adults + no_of_children) as Total_sum_of_both_adults_and_children
-- from Hotel_Reservation_Data

/* INSIGHT:-
There are 1385 adults and children across all reservations.
*/


/* TASK:- To check the average number of weekend nights for reservations involving children. */

-- select round(avg(no_of_weekend_nights)) as avg_no_of_weekend_nights_with_children
-- from Hotel_Reservation_Data
-- where no_of_children > 0;


/* INSIGHT:- 
The average number of weekend nights reservation involving children is 1. 
*/

/* TASK:- How many reservations were made in each month of the year.	*/

-- select substring(arrival_date,4,2) as Month,
-- count(*) as Total_Reservations_in_each_Month
-- from Hotel_Reservation_Data
-- group by substring(arrival_date,4,2)
-- order by Month;


/* INSIGHT:- 	
January has the highest number of monthly reservations of 255. 

PLEASE NOTE: We made a modification to the arrival date in the earlier stage where we assumed
and added 01-01 to every arrival date where the row contains only the year YYYY and doesn't 
follow the others in date format DD-MM-YYYY. This is what caused a very high number of january 
reservations.
*/


/* TASK:- To check the average number of nights (both weekend and weekday) spent by guests for 
each room type? 	*/

-- select 
-- 	room_type_reserved,
-- 	round(sum(avg_weekend_nights + avg_week_nights)) as total_sum_of_avg_no_of_nights
-- from (
-- 	select
-- 		room_type_reserved,
-- 		avg(no_of_weekend_nights) as avg_weekend_nights,
-- 		avg(no_of_week_nights) as avg_week_nights
-- 	from
-- 		Hotel_Reservation_Data
-- 	group by
-- 		room_type_reserved
-- 	) as avg_night_per_room_type
-- 	group by
-- 		room_type_reserved;


/* INSIGHT:- 
Room type 4 and room type 6 has the maximum total average of nights per room which is 4	
while the rest have an approximate of 3 when rounded to whole number format.
*/


/* TASK:- To check the most common room type and the average price for that room type, For 
reservations involving children. 	*/

-- select
-- 	room_type_reserved as most_common_room_type,
-- 	round(avg(avg_price_per_room)) as average_price_for_reservaton_with_children
-- from
-- 	Hotel_Reservation_Data
-- where
-- 	no_of_children > 0
-- group by
-- 	room_type_reserved
-- order by
-- 	count(*) desc
-- ;

/* INSIGHT:- 
Room type 1 is the most commonly reserved room with average price of 123.	
*/


/* TASK:- To find the market segment type that generates the highest average price per room. */

-- select market_segment_type, count(avg_price_per_room) as avg_price_per_room_modal_value
-- from Hotel_Reservation_Data
-- group by market_segment_type
-- order by avg_price_per_room_modal_value desc
-- ;


/* INSIGHT:- Online market segment generates the highest number average price per room which 518. */


/* 									GENERAL INSIGHTS

1)	There are total of 700 reservations.
2)	The meal plan 1 has the highest number of selection among guests.
3)	The average price per room for reservation involving children is 145 when we round to nearest whole number.
4)	There was a total of 370 reservations made in year 2018
5)	Room_type 1 is the most commonly reserved room type with total of 534 reservations.
6)	There are total of 383 weekend reservations
7)	The lowest lead time for reservation is 0
8)	The highest lead time for reservation is 443.
9)	Online market segment type is the most common for reservation with modal value of 518
10)	There are 493 confirmed booking status.
11)	There are 1385 adults and children across all reservations.
12)	The average number of weekend nights reservation involving children is 1.
13)	January has the highest number of monthly reservations of 255. 

PLEASE NOTE: We made a modification to the arrival date in the earlier stage where we assumed
and added 01-01 to every arrival date where the row contains only the year YYYY and doesn't 
follow the others in date format DD-MM-YYYY. This is what caused a very high number of january 
reservations.

14)	Room type 4 and room type 6 has the maximum total average of nights per room which is 4	
while the rest have an approximate of 3 when rounded to whole number format.
15)	Room type 1 is the most commonly reserved room with average price of 123.
16)	Online market segment generates the highest number average price per room which 518. 
*/
