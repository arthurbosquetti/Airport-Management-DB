#|------------------------>SQL DATA QUERIES<-----------------------|
-- Create user that can access the database and corresponding view
drop user if exists 'cphstaff'@'localhost';
create user 'cphstaff'@'localhost' identified by 'hygge4ever';
grant all on AirportManagement.* to 'cphstaff'@'localhost';
show grants for 'cphstaff'@'localhost';
revoke select, index on AirportManagement.Airports from 'cphstaff'@'localhost';
revoke select, index, update, delete on AirportManagement.Flights from 'cphstaff'@'localhost';

-- Create virtual table (view) for flights related to CPH airport
create view CPHFlight as
    select * from Flight 
    where SourceCode = 'CPH' or DestinationCode = 'CPH';
    
-- Show the contents of the view
select * from CPHFlight;
select Count(FlightID) from CPHFlight; #-no of flights in view
select Count(FlightID) from Flight; #-no of flights in original table

-- Query the flights with destination airport information (joining on DestinationCode)
select * from CPHFlight as T join Airport as S on T.DestinationCode = S.AirportCode;

-- Allow user access to all privileges on the view
grant all on AirportManagement.CPHFlight to 'cphstaff'@'localhost';

-- Query the passengers linked to the flights
select * from CPHFlight natural join Passenger natural join Ticket;

-- Query how many passengers in each class are flying to/from CPH
-- order results in decreasing order
select Class, Count(PassportID) as MemberNo 
    from CPHFlight natural join Passenger natural join Ticket
    #where DestinationCode = 'GVA'
    group by Class
    order by MemberNo desc;

-- Query shows the amount of visitors in CPH Airport
select Count(PassportID) as NoVisitors from Passenger;

-- Query count the number of passengers buying clothes
select Count(Person) as ShopVisitors 
	from Activity natural join Place
		where Place.Service = 'Clothes';

-- Query shows the relation 
select * from Ticket natural join CPHFlight natural join Luggage;

-- Query shows a table with FlightID, SourceCode, DestinationCode and sum of 
-- luggage weight where destination airport is CPH.
select FlightID, SourceCode, ArrivalTime, DestinationCode, Sum(Weight) as TotalWeight
	from Ticket natural join CPHFlight natural join Luggage
    where DestinationCode = 'CPH'
    group by FlightID;

-- Query shows the average luggage weight of planes landing in CPH Airport   
select Avg(S.TotalWeight) from
	(select FlightID,SourceCode, DestinationCode, Sum(Weight) as TotalWeight
	from Ticket natural join CPHFlight natural join Luggage
    where DestinationCode = 'CPH'
    group by FlightID) as S;

    
-- Query shows the lost luggage (failed delivery to destination).
select FirstName, LastName, Email, LuggageID
	from Passenger natural join Luggage natural join Flight natural join Ticket
    where Delivered = false and DepartureTime < current_time();
    
# |-------------------------------->SQL Programming<-------------------------------|

