#|------------> SQL DATA QUERIES <------------|
-- Create user that can access the database and corresponding view
drop user if exists 'cphstaff'@'localhost';
create user 'cphstaff'@'localhost' identified by 'hygge4ever';
grant all on AirportManagement.* to 'cphstaff'@'localhost';
show grants for 'cphstaff'@'localhost';
revoke select, index on AirportManagement.Airports from 'cphstaff'@'localhost';
revoke select, index, update, delete on AirportManagement.Flights from 'cphstaff'@'localhost';

-- Create virtual table (view) for flights related to CPH airport
create view CPHFlights as
    select * from Flights 
    where SourceCode = 'CPH' or DestinationCode = 'CPH';
    
-- Show the contents of the view
select * from CPHFlights;
select Count(FlightID) from CPHFlights; #-no of flights in view
select Count(FlightID) from Flights; #-no of flights in original table

-- Query the flights with destination airport information (joining on DestinationCode)
select * from CPHFlights as T join Airports as S on T.DestinationCode = S.AirportCode;

-- Allow user access to all privileges on the view
grant all on AirportManagement.CPHFlights to 'cphstaff'@'localhost';

-- Query the passengers linked to the flights
select * from CPHFlights natural join Passenger natural join Ticket;

-- Query how many passengers in each class are flying to/from CPH
-- order results in decreasing order
select Class, Count(PassportID) as MemberNo 
    from CPHFlights natural join Passenger natural join Ticket
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
select * from Ticket natural join CPHFlights natural join Luggage;

-- Query shows a table with FlightID, SourceCode, DestinationCode and sum of 
-- luggage weight where destination airport is CPH.
select FlightID,SourceCode, DestinationCode, Sum(Weight) as TotalWeight
	from Ticket natural join CPHFlights natural join Luggage
    where DestinationCode = 'CPH'
    group by FlightID;

-- Query shows the average luggage weight of planes landing in CPH Airport   
select Avg(S.TotalWeight) from
	(select FlightID,SourceCode, DestinationCode, Sum(Weight) as TotalWeight
	from Ticket natural join CPHFlights natural join Luggage
    where DestinationCode = 'CPH'
    group by FlightID) as S;

    
-- Query shows the lost luggage (failed delivery to destination).
select FirstName, LastName, LuggageID
	from Passenger natural join Luggage natural join Flights natural join Ticket
    where Delivered = false and DepartureTime < current_time();
    
# |-------------------------->SQL Programming<----------------------------|

