##### updates and deletes (section 8 on table modifications)

set sql_safe_updates = 0;
# updating a flight to redirect it through cph airport
update Flight set DestinationCode = 'CPH' where destinationcode = 'hkg' or destinationcode = 'fln';
select * from flight;

# cancel all flights from Malokair for that day
delete from flight where airline='malokair';
select * from flight;

# upgrading all passengers by  one class
update Ticket set Class = 
	case
    when class = 'Gold' then class
    when class = 'First class' then 'Gold'
    when class = 'Member' then 'First class'
    when class = 'Economy' then 'Member'
    end;
select * from ticket;

# mark all luggage from Passenger '000000001' as delivered
update luggage set delivered=true where PassportID = '000000001';
select * from luggage;







