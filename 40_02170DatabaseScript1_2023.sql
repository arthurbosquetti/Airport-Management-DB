#Starting script for creating tables for each member of the airport management database
create database AirportManagement;
use AirportManagement;

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS Terminal;
DROP TABLE IF EXISTS Gate;
drop table if exists Place;
drop table if exists Activity;
drop table if exists Passenger;
drop table if exists Luggage;
drop table if exists Ticket;
drop table if exists Flights;
drop table if exists Airports;

SET FOREIGN_KEY_CHECKS=1;

# Gate
create table Gate(
	GateId varchar(3) not null,
	FlightID varchar(10),
	AllocationStart Time,
	AllocationEnd Time,
	FloorLevel decimal(1,0),
    Terminal varchar(1) not null,
	constraint id_format check (GateId like '[A-Z][0-9][0-9]'),
	foreign key(Terminal) references Terminal(TerminalID),
    foreign key(FlightID) references Flights(FlightID),
    primary key(GateId, Terminal)
	);
    
# Terminal
create table Terminal(
TerminalID char(1),
constraint id_format check (TerminalID like '[1-9]'),
primary key(TerminalID)
);


# Place
create table Place
	(PlacesID varchar(4),
    Terminal varchar(1),
    Service varchar(4),
    foreign key(Terminal) references Terminal(TerminalID),
    primary key (PlacesID)
    );
    
# Activity
create table Activity
	(ActivityID varchar(4),
    Service varchar(4),
    ActivityDescription varchar(40),
    Place varchar(4) not null,
    Person varchar(20) not null,
    foreign key(Place) references Place(PlacesID),
    foreign key(Person) references Person(PassportID),
    primary key(ActivityID)
	);
    
# Person
create table Passenger
	(PassportID char(9),
    FirstName varchar(20) not null,
    LastName varchar(20) null,
    Email varchar(35) not null,
    constraint email_format check (Email like '%@%.%'),
    Phone decimal(8,0),
    primary key(PassportID)
    );
    
create table Luggage
	(LuggageID decimal(8,0),
    Weight decimal (4,2) not null,
    Delivered bool,
    OwnerID char(9) not null,
    Ticket varchar(8) not null,
    primary key(LuggageID),
    foreign key(Ticket) references Ticket(TicketID)
    );

create table Ticket
	(TicketID varchar(20),
    Class ENUM('First class','Gold', 'Member', 'Economy'),
    Passenger varchar(20) not null,
    FlightID varchar(10) not null,
    TimeSlot datetime,
    foreign key(Passenger) references Person(PassportID),
    foreign key(FlightID) references Flights(FlightID),
    primary key(TicketID)
    );

create table Flights
	(FlightID varchar(10) not null,
    LocalDate datetime,
    DepartureTime time,
    ArrivalTime time,
    Aircraft varchar(20),
    Airline varchar(20),
    Capacity decimal(3,0),
    SourceCode char(3),
    DestinationCode char(3),
    primary key(FlightID, LocalDate),
    foreign key(SourceCode) references Airport(AirportCode)
    );

create table Airports
	(AirportCode char(3),
    constraint code_format check (AirportCode like '[A-Z]*'),
    AirportName varchar(20),
    Country varchar(20) not null,
    City varchar(20),
    primary key(AirportCode)
    );
    
    
    
SHOW ENGINE INNODB STATUS