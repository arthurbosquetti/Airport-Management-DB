##### updates and deletes (section 8 on table modifications)

# updating a flight to redirect it through cph airport
update Flight set DestinationCode =
	case 
    when DestinationCode = 'HKG' then DestinationCode = 'CPH'
    when DestinationCode = 'FLN' then DestinationCode = 'CPH'
    else DestinationCode
    end;


# upgrading gold-members to first class by updating the table
update Ticket set Class =
	case 
    when Class = 'Gold' then Class = 'First Class'
    else Class
    end;

# deleting or updating places in the airport along with their descriptions

# deleting or updating the terminal numbers

# deleting (loosing) the luggage for a certain flight or "miss placing it"

# updating the terminal/gate for flights




