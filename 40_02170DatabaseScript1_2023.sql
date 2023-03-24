#Starting script for creating tables for each member of the airport management database
drop database if exists AirportManagement;

create database AirportManagement;
use AirportManagement;

SET FOREIGN_KEY_CHECKS=0;
drop table if exists Terminal;
drop table if exists Gate;
drop table if exists Place;
drop table if exists Activity;
drop table if exists Passenger;
drop table if exists Luggage;
drop table if exists Ticket;
drop table if exists Flights;
drop table if exists Airports;

SET FOREIGN_KEY_CHECKS=1;

# Terminal
create table Terminal(
    TerminalID char(1) not null,
    constraint id_format check (TerminalID like '[1-9]'),
    primary key(TerminalID)
    );

# Airports
create table Airports
	(AirportCode char(3),
    constraint code_format check (AirportCode like '[A-Z]*'),
    AirportName varchar(50),
    Country varchar(40) not null,
    City varchar(40),
    primary key(AirportCode)
    );

# Passenger
create table Passenger
	(PassportID char(9) not null,
    FirstName varchar(20) not null,
    LastName varchar(30) null,
    Email varchar(40) not null,
    constraint email_format check (Email like '%@%.%'),
    Phone char(8),
    constraint code_format check (Phone like '[0-9]*'),
    primary key(PassportID)
    );

# Place
create table Place
	(PlacesID varchar(4),
    Terminal char(1) not null,
    Service varchar(7),
    foreign key(Terminal) references Terminal(TerminalID),
    primary key (PlacesID)
    );

# Activity
create table Activity
	(ActivityID varchar(4),
    Service varchar(7),
    ActivityDescription varchar(40),
    Place varchar(4) not null,
    Person char(9) not null,
    foreign key(Place) references Place(PlacesID),
    foreign key(Person) references Passenger(PassportID),
    primary key(ActivityID)
	);

# Flight
create table Flights
	(FlightID char(10) not null,
    LocalDate datetime,
    DepartureTime time,
    ArrivalTime time,
    Aircraft varchar(20),
    Airline varchar(20),
    PassengerCapacity decimal(3,0),
    LuggageCapacity decimal(3,0),
    SourceCode char(3),
    DestinationCode char(3),
    primary key(FlightID, LocalDate),
    foreign key(SourceCode) references Airports(AirportCode),
    foreign key(DestinationCode) references Airports(AirportCode)
    );

# Gate
create table Gate(
	GateID varchar(3) not null,
	FlightID char(10) not null,
    LDate datetime,
	AllocationStart Time,
	AllocationEnd Time,
	FloorLevel decimal(1,0),
    Terminal char(1) not null,
	constraint id_format check (GateID like '[A-Z][0-9][0-9]'),
	foreign key(Terminal) references Terminal(TerminalID),
    foreign key(FlightID, LDate) references Flights(FlightID, LocalDate),
    primary key(GateID, Terminal)
	);

# Ticket
create table Ticket
	(TicketID char(13) not null,
    Class ENUM('First class','Gold', 'Member', 'Economy'),
    Passenger char(9) not null,
    FlightID char(10) not null,
    TimeSlot datetime,
    foreign key(Passenger) references Passenger(PassportID),
    foreign key(FlightID) references Flights(FlightID),
    primary key(TicketID)
    );

# Luggage    
create table Luggage
	(LuggageID char(8) not null,
    Weight decimal (4,2) not null,
    Delivered bool,
    OwnerID char(9) not null,
    Ticket char(13) not null,
    primary key(LuggageID),
    foreign key(Ticket) references Ticket(TicketID),
    constraint code_format check (LuggageID like '[0-9]*')
    );
    
SHOW ENGINE INNODB STATUS