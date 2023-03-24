#|------------> SQL DATA QUERIES <------------|

create user CPHStaff identified by 'hygge4ever';
grant all on AirportManagement.* to CPHStaff;
revoke all on AirportManagement.Flights from CPHStaff;
revoke all on AirportManagement.Airports from CPHStaff;
grant select, index on AirportManagement.Airports to CPHStaff;

create view CPHFlights as
    select * from Flights 
    where SourceCode = 'CPH' or DestinationCode = 'CPH';

grant all on AirportManagement.CPHFlights to CPHStaff;

