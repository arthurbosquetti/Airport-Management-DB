#Starting script for creating tables for each member of the airport management database
use airportmanagement;

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS Terminal;
DROP TABLE IF EXISTS Gate;
SET FOREIGN_KEY_CHECKS=1;
# Gate
create table Gate(
	GateId varchar(3) not null,
	FlightID varchar(8),
	AllocationStart Time,
	AllocationEnd Time,
	FloorLevel decimal(1,0),
    Terminal varchar(1),
	constraint id_format check (GateId like '[A-Z][0-9][0-9]')
	#foreign key(Terminal) references Terminal(TerminalID),
    #foreign key(FlightID) references Flights(FlightID)
	);
    
# Terminal
create table Terminal(
TerminalID varchar(1),
primary key(TerminalID)
);


# Place
create table Place
	(PlacesID varchar(4),
    Terminal varchar(1),
    Service varchar(4),
    foreign key(Terminal) references Terminal(TerminalID),
    primary key (PlacesID, Terminal)
    );
    
# Activity
create table Activity
	(ActivityID varchar(4),
    Service varchar(4),
    ActivityDescription varchar(20),
    Place varchar(4),
    Person varchar(20),
    foreign key(Place) references Place(PlacesID),
    foreign key(Person) references Person(PassportID),
    primary key(ActivityID)
	);
    
# Person
create table Passenger
	(PassportID varchar(20),
    FirstName varchar(20),
    LastName varchar(20),
    Email varchar(20),
    Phone decimal(8,0),
    primary key(PassportID)
    );
    
create table Luggage
	(LuggageID decimal(8,0),
    Weight decimal (4,2),
    Delivered bool,
    OwnerID varchar(20),
    Ticket varchar(8),
    primary key(LuggageID),
    foreign key(Tickey) references Ticket(TicketID)
    );

create table Ticket
	(TicketID varchar(20),
    Class ENUM('First class','Gold', 'Member', 'Economy'),
    Passenger varchar(20),
    FlightID varchar(10),
    TimeSlot time,
    foreign key(Passenger) references Person(PassportID),
    foreign key(FlightID) references Flights(FlightID)
    );

create table Flights
	(FlightID varchar(10) not null,
    LocalDate date,
    DepartureTime time,
    ArrivalTime time,
    Aircraft varchar(20),
    Airline varchar(20),
    Capacity decimal(3,0),
    SourceCode varchar(3),
    DestinationCode varchar(3),
    primary key(FlightId, LocalDate),
    foreign key(SourceCode) references Airport(AirportCode)
    );

create table Airports
	(AirportCode varchar(3),
    AirportName varchar(20),
    Country varchar(20),
    City varchar(20)
    );
    
    
    
SHOW ENGINE INNODB STATUS