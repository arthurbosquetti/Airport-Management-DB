#|------------------------>SQL DATA QUERIES<-----------------------|
-- Create user that can access the database and corresponding view
drop user if exists 'cphstaff'@'localhost';
create user 'cphstaff'@'localhost' identified by 'hygge4ever';

-- grant all privileges on AirportManagement.* to 'cphstaff'@'localhost' with grant option;
-- revoke all privileges on AirportManagement from 'cphstaff'@'localhost';
-- show grants for 'cphstaff'@'localhost';

# Get all GRANT commands, copy (unquoted) and paste on the script.
-- select concat("grant all on airportmanagement.", table_name, " to 'cphstaff'@'localhost';") 
-- 	from information_schema.TABLES where table_schema = "airportmanagement";
# Paste the GRANT commands here:
grant all on airportmanagement.Passenger to 'cphstaff'@'localhost';
grant all on airportmanagement.Activity to 'cphstaff'@'localhost';
grant all on airportmanagement.Airport to 'cphstaff'@'localhost';
grant all on airportmanagement.Flight to 'cphstaff'@'localhost';
grant all on airportmanagement.Luggage to 'cphstaff'@'localhost';
grant all on airportmanagement.Ticket to 'cphstaff'@'localhost';
grant all on airportmanagement.Terminal to 'cphstaff'@'localhost';
grant all on airportmanagement.Gate to 'cphstaff'@'localhost';
grant all on airportmanagement.Place to 'cphstaff'@'localhost';

revoke select, index on AirportManagement.Airport from 'cphstaff'@'localhost';
revoke select, index, update, delete, insert on AirportManagement.Flight from 'cphstaff'@'localhost';

show grants for 'cphstaff'@'localhost';


-- Create virtual table (view) for flights related to CPH airport
drop view if exists CPHFlight;
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
select Count(PassportID) as ShopVisitors 
	from Activity natural join Place
		where Place.Service = 'Clothes';

-- Query shows the relation between flights, tickets and luggage
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
select FirstName, LastName, PassportID, Email, LuggageID
	from Passenger natural join Luggage natural join Flight natural join Ticket
    where Delivered = false and DepartureTime < current_time();

# |-------------------------------->SQL Programming<-------------------------------|

-- Function to determine if there's delayed luggage linked to a certain ticket
delimiter //
create function PendingLuggage(tkt char(13)) returns boolean
begin
return exists (select * from Luggage 
		natural join Ticket natural join Flight
		where TicketID = tkt and Delivered=false
			and DepartureTime < current_time());
end; //
delimiter ;
#drop function PendingLuggage;

-- Result of function call on specific ticket ID
select PendingLuggage('420OL1722640I');
-- Result column of function applied to the entire Ticket table
select TicketID, Class, PassportID, FlightID, 
	PendingLuggage(TicketID) as Pending from Ticket;


-- Procedure that allocates a free gate if available to a flight ID at given terminal
delimiter //
create procedure AllocateGate(IN flight char(7), IN terminal char(1))
begin
    if (select GateID from Gate where TerminalID = terminal and FlightID is null) is null
    then signal SQLSTATE 'HY000'
		set mysql_errno = 1525, message_text='All gates are currently in use';
	else 
		update Gate set FlightID = flight where TerminalID = terminal and FlightID is null limit 1;
    end if;
end;//
delimiter ;

#drop procedure AllocateGate;
call AllocateGate('POT5311', '1');
call AllocateGate('LOT2137', '2');
select * from Gate;

# -- Trigger regarding arrival/departure time and destination on the flight:
delimiter //
create trigger CheckTimeAirport
before insert on Flight for each row
begin 
	if new.ArrivalTime <= new.DepartureTime 
	then signal sqlstate 'HY000'
		set mysql_errno = 1580,
        message_text = 'Arrival time should follow departure time';
end if;
if new.SourceCode = new.DestinationCode
	then signal sqlstate 'HY000'
		set mysql_errno = 1590,
			message_text = 'A flight cannot have the same source and destination airport';
end if;
end //
delimiter ;

# -- Event for gate allocation approaching time:

# |-------------------->Table Modifications (update/delete statements)<------------|

set sql_safe_updates = 0;

-- Updating flights to Honk-Kong and Florianopolis, to redirect them through Copenhagen airport, unless they flew from Copenhagen
update Flight
set DestinationCode = 'CPH'
where SourceCode != 'CPH' and DestinationCode in ('HKG', 'FLN');

select * from CPHFlight;


-- Upgrading economy-class passengers of flight GOL5021, which don't have a luggage to first class by updating the table
update Ticket left join Luggage
on Luggage.PassportID = Ticket.PassportID
set Class = 'First class'
where Luggage.PassportID is null and Ticket.FlightID = 'GOL5021' and Ticket.Class = 'Economy';

select * from Ticket;


-- Deleting all activities in terminal 3
delete a from Activity a
join Place on a.PlaceID = Place.PlaceID
where Place.TerminalID = '3';

select * from Activity;


-- Upgrading all passengers by  one class
update Ticket set Class = 
	case
    when class = 'Gold' then class
    when class = 'First class' then 'Gold'
    when class = 'Member' then 'First class'
    when class = 'Economy' then 'Member'
    end;
select * from ticket;


-- Cancel all flights from Malokair for that day
delete from Flight where airline='malokair';

select * from Flight;


-- Mark all luggage from Passenger '000000001' as delivered
update luggage set delivered=true where PassportID = '000000001';

select * from luggage;
