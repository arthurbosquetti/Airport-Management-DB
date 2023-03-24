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
    Service varchar(10),
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
    TimeSlot date,
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

insert into Place values 
    # PlacesID, Terminal, Service
    ('P001', '1', 'Duty-Free'), ('P002', '1', 'Check-In'),
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

insert into Activity values 
    # ActivityID, Service, ActivityDescription, Place, Person
    ('A001', 'Check-In', 'Checked in for flight', 'P002', '00000001'),
	('A002', 'Food', 'Bought a burger', 'P004', '000000002'),
    ('A003', 'Clothes', 'Bought a shirt', 'P005', '000000003'),
    ('A004', 'Check-Out', 'Checked out of the airport', 'P003', '000000004'),
    ('A005', 'Duty-Free', 'Bought a bottle of whiskey', 'P001', '000000005'),
    ('A006', 'Check-In', 'Checked in for flight', 'P008', '000000006'),
    ('A007', 'Books', 'Bought a book', 'P010', '000000007'),
    ('A008', 'Clothes', 'Bought on a pair of jeans', 'P007', '000000008'),
    ('A009', 'Check-Out', 'Checked out of the airport', 'P009', '000000009'),
    ('A010', 'Gifts', 'Bought a souvenir', 'P016', '000000010'),
    ('A011', 'Duty-Free', 'Bought a watch', 'P011', '000000011'),
    ('A012', 'Clothes', 'Bought on a shirt', 'P013', '000000012'),
    ('A013', 'Check-In', 'Checked in for the flight', 'P008', '000000013'),
    ('A014', 'Perfume', 'Bought a bottle of perfume', 'P012', '000000014'),
    ('A015', 'Food', 'Ordered a pizza', 'P004', '000000015');


# Passenger inserts
insert Passenger values
    # PassportID, FirstName, LastName, Email, Phone
	('000000001','Arthur','Fosquetti','arthurfos@gmail.com','27305028'),
    ('000000002','Jeppe','Snikkelsen','jepsnik@hotmail.com','17349228'),
    ('000000003','Marek','Nijolek','mareknijolek@yahoo.com','29907628'),
    ('000000004','Adrian','Snoozedenco ','asnoozedenco@gmail.com','47569022'),
    ('000000005','Rosalie','Batch','rosaliebatch@hotmail.com','23235514'),
    ('000000006','Adrian','Palch','arthurbosq@gmail.com','27459121'),
    ('000000007','Bianca','Onea','biaonea@hotmail.com','44789012'),
    ('000000008','Sidse','Snomsen','sidses@yahoo.com','57801273'),
    ('000000009','Yasmin','Fosquetti','slayfosquetti@gmail.com','33890923'),
    ('000000010','Carina','Nijolek','carinanijo@hotmail.com','29461073'),
    ('000000011','Paul','McCartney','pmccartney@hotmail.com','38399922'),
    ('000000012','Snoop','Dog','snoopydoggy@private.com','77832430'),
    ('000000013','Jonas','Knocksen','pmccartney@hotmail.com','83901322'),
    ('000000014','Marilyn','Monroe','marimonroe1@gmail.com','33997283'),
    ('000000015','Neil','Armstrong','nielastro1@yahoo.com','66249129'),
    ('000000016','John','Doe','johndoe123@hotmail.com','79823475'),
    ('000000017','Jane','Door','door@hotmail.com', '79866475'),
    ('000000018','John','Smith','smithisthebest@hotmail.com','79866575' ),
    ('000000019','Jane','Yuyu','janethejohn@hotmail.com', '79866475'),
    ('000000020','Yuri','Da Silva','yudas@gmail.com', '79866475');
   

# Luggage inserts
insert into Luggage values
    # LuggageID, Weight, Delivered, OwnerID, Ticket
    ('19287364','12.30',false,'000000001','223EU89441637'),
	('19287365','18.40',false,'000000001','223EU89441637'),
    ('19287366','7.20',false, '000000001','223EU89441637'),
    ('92837234','19.40',false,'000000003','420OL1722640K'),
    ('16252410','17.30',false,'000000004','223EU89441638'),
    ('16252411','19.10',false,'000000004','223EU89441638'),
    ('16252412','5.20',false, '000000004','223EU89441638'),
    ('76336251','14.50',false,'000000007','AUT5541903212'),
    ('23235541','11.20',false,'000000008','AUT5541903213'),
    ('77362513','19.30',false,'000000015','98022MH1370X1'),
    ('77362514','10.20',false,'000000015','98022MH1370X1'),
    ('16372827','13.70',false,'000000009','4815162342LOS'),
    ('72626221','3.20',false, '000000010','4815162342LOT'),
    ('98987772','10.20',false,'000000011','AUT5541903214'),
    ('98987773','17.40',false,'000000014','AUT5541903214'),
    ('16627123','4.20',false,'000000012','420OL1722640I'),
    ('16627124','4.20',false,'000000012','420OL1722640I'),
    ('16627125','4.20',false,'000000012','420OL1722640I'),
    ('16627126','4.20',false,'000000012','420OL1722640I'),
    ('87693432','16.60',false,'000000016','8274SW1277464');

# Ticket inserts
insert Ticket values 
    # TicketID, Class, PassengerID, FlightID, TimeSlot
	('223EU89441637','Member','204238E99','000000001',''),
	('AUT5541903212','Gold','123986412','000000007',''),
	('420OL1722640K','Economy','32KL08344','000000003',''),
    ('223EU89441638','Member','221467909','000000004',''),
    ('AUT5541903213','First class','145532235','000000008',''),
    ('AUT5541903214','First class','324177Q21','000000011',''),
    ('98022MH1370X1','First class','E2149HJ30','000000015',''),
    ('4815162342LOS','Economy','289NM70S1','000000009',''),
    ('4815162342LOT','Economy','732913932','000000010',''),
    ('AUT5541903214','Economy','H90732S12','000000014',''),
    ('223EU89441639','Member','462837UIO','000000017',''),
    ('420OL1722640I','First class','420404420','000000012',''),
    ('8274SW1277464','Economy','11209Y27Q','000000016',''),
    ('98022MH1370X2','Gold','TQ12OK942','000000018',''),
    ('BV1938466382D','Gold','7301421HD','000000019',''),
    ('420OL1722640J','Economy','LOL660923','000000020','');