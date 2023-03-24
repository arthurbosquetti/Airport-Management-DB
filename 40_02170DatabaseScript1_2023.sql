#Starting script for creating tables for each member of the airport management database
drop database if exists AirportManagement;

# ___________________DATABASE SETUP _____________________
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

# __________________SCHEMA IMPLEMENTATION___________________
# Terminal schema
create table Terminal(
    TerminalID char(1) not null,
    constraint id_format check (TerminalID regexp '^[1-9]$'),
    primary key(TerminalID)
    );

# Airports schema
create table Airports
	(AirportCode char(3),
    constraint code_format check (AirportCode regexp '^[A-Z]\{3,3\}$'),
    AirportName varchar(50),
    Country varchar(40) not null,
    City varchar(40),
    primary key(AirportCode)
    );

# Passenger schema
create table Passenger
	(PassportID char(9) not null,
    FirstName varchar(20) not null,
    LastName varchar(30) null,
    Email varchar(40) not null,
    constraint email_format check (Email like '%@%'),
    Phone char(8),
    constraint code_format check (Phone regexp '^[0-9]*$'),
    primary key(PassportID)
    );

# Place schema
create table Place
	(PlacesID varchar(4),
    Terminal char(1) not null,
    Service varchar(10),
    foreign key(Terminal) references Terminal(TerminalID),
    primary key (PlacesID)
    );

# Activity schema
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

# Flight schema
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

# Gate schema
create table Gate(
	GateID varchar(3) not null,
	FlightID char(10) not null,
    LDate datetime,
	AllocationStart Time,
	AllocationEnd Time,
	FloorLevel decimal(1,0),
    Terminal char(1) not null,
	constraint id_format check (GateID regexp '^[A-Z][0-9][0-9]$'),
	foreign key(Terminal) references Terminal(TerminalID),
    foreign key(FlightID, LDate) references Flights(FlightID, LocalDate),
    primary key(GateID, Terminal)
	);

# Ticket schema
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

# Luggage schema   
create table Luggage
	(LuggageID char(8) not null,
    Weight decimal (4,2) not null,
    Delivered bool,
    OwnerID char(9) not null,
    Ticket char(13) not null,
    primary key(LuggageID),
    foreign key(Ticket) references Ticket(TicketID),
    constraint code_format check (LuggageID regexp '^[0-9]*$')
    );
    
SHOW ENGINE INNODB STATUS;
#|-----------> SCHEMA IMPLEMENTATION COMPLETE <--------------|

# ____________________DATABASE POPULATION_____________________
insert into Terminal(TerminalID) values ('1'), ('2'), ('3'), ('4'), ('5');

insert into Place values ('P001', '1', 'Duty-Free'), ('P002', '1', 'Check-In'),
                         ('P003', '1', 'Check-Out'), ('P004', '1', 'Food'),
                         ('P005', '1', 'Clothes'), ('P006', '2', 'Duty-Free'),
                         ('P007', '2', 'Clothes'), ('P008', '2', 'Check-In'),
                         ('P009', '2', 'Check-Out'), ('P010', '2', 'Books'),
                         ('P011', '3', 'Duty-Free'), ('P012', '3', 'Perfume'),
                         ('P013', '2', 'Clothes'), ('P014', '3', 'Check-In'),
                         ('P015', '3', 'Check-Out'), ('P016', '3', 'Gifts'), 
						 ('P017', '4', 'Duty-Free'), ('P018', '4', 'News'),
                         ('P019', '4', 'Check-In'), ('P020', '4', 'Check-Out'),
						 ('P021', '5', 'Check-In'), ('P022', '5', 'Check-Out'),
						 ('P023', '5', 'Duty-Free'), ('P024', '5', 'Food');

insert into Activity values ('A001', 'Check-In', 'Checked in for flight', 'P002', '000000000'),
	('A002', 'Food', 'Bought a burger', 'P004', '000000000'),
    ('A003', 'Clothes', 'Bought a shirt', 'P005', '000000000'),
    ('A004', 'Check-Out', 'Checked out of the airport', 'P003', '000000000'),
    ('A005', 'Duty-Free', 'Bought a bottle of whiskey', 'P001', '000000000'),
    ('A006', 'Check-In', 'Checked in for flight', 'P008', '000000000'),
    ('A007', 'Books', 'Bought a book', 'P010', '000000000'),
    ('A008', 'Clothes', 'Tried on a pair of jeans', 'P007', '000000000'),
    ('A009', 'Check-Out', 'Checked out of the airport', 'P009', '000000000'),
    ('A010', 'Gifts', 'Bought a souvenir', 'P016', '000000000'),
    ('A011', 'Duty-Free', 'Bought a watch', 'P011', '000000000'),
    ('A012', 'Clothes', 'Tried on a shirt', 'P013', '000000000'),
    ('A013', 'Check-In', 'Checked in for the flight', 'P008', '000000000'),
    ('A014', 'Perfume', 'Bought a bottle of perfume', 'P012', '000000000'),
    ('A015', 'Food', 'Ordered a pizza', 'P004', '000000000');