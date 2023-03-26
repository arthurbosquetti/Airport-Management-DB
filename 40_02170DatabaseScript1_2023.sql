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
create table Airport
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
	(PlaceID varchar(4) not null,
    TerminalID char(1) not null,
    Service varchar(10),
    foreign key(TerminalID) references Terminal(TerminalID) on delete cascade,
    primary key (PlaceID)
    );

# Activity schema
create table Activity
	(ActivityID varchar(4),
    Service varchar(10),
    ActivityDescription varchar(40),
    PlaceID varchar(4) not null,
    PassportID char(9) not null,
    foreign key(PlaceID) references Place(PlaceID) on delete cascade,
    foreign key(PassportID) references Passenger(PassportID) on delete cascade,
    primary key(ActivityID)
	);

# Flight schema
create table Flight
	(FlightID char(7) not null,
    constraint id_format check (FlightID regexp '^[A-Z]\{3,3\}[0-9]\{4,4\}$'),
    DepartureTime datetime,
    ArrivalTime datetime,
    Aircraft varchar(20),
    Airline varchar(20),
    PassengerCapacity decimal(3,0),
    LuggageCapacity decimal(4,0),
    SourceCode char(3),
    DestinationCode char(3),
    primary key(FlightID),
    foreign key(SourceCode) references Airport(AirportCode) on delete set null,
    foreign key(DestinationCode) references Airport(AirportCode) on delete set null
    );
    

# Gate schema
create table Gate(
	GateID varchar(3) not null,
	FlightID char(7),
	AllocationStart Time,
	AllocationEnd Time,
	FloorLevel decimal(1,0),
    Terminal char(1) not null,
	constraint id_format check (GateID regexp '^[A-Z][0-9][0-9]$'),
	foreign key(Terminal) references Terminal(TerminalID) on delete cascade,
    foreign key(FlightID) references Flight(FlightID) on delete set null,
    primary key(GateID, Terminal)
	);

# Ticket schema
create table Ticket
	(TicketID char(13) not null,
    Class ENUM('First class','Gold', 'Member', 'Economy'),
    PassportID char(9) not null,
    FlightID char(10),
    TimeSlot date,
    foreign key(PassportID) references Passenger(PassportID) on delete cascade,
    foreign key(FlightID) references Flight(FlightID) on delete set null,
    primary key(TicketID)
    );

# Luggage schema   
create table Luggage
	(LuggageID char(8) not null,
    Weight decimal (4,2) not null,
    Delivered bool,
    PassportID char(9) not null,
    Ticket char(13) not null,
    primary key(LuggageID),
    foreign key(Ticket) references Ticket(TicketID),
    foreign key(PassportID) references Passenger(PassportID),
    constraint code_format check (LuggageID regexp '^[0-9]*$')
    );
    
SHOW ENGINE INNODB STATUS;
#|-----------> SCHEMA IMPLEMENTATION COMPLETE <--------------|

# ____________________DATABASE POPULATION_____________________
insert into Terminal(TerminalID) values ('1'), ('2'), ('3'), ('4'), ('5');

# Airport inserts
insert into Airport values
	('CPH', 'Copenhagen International Airport', 'Denmark', 'Copenhagen'),
    ('FLN', 'Aeroporto International de Florianopolis', 'Brazil', 'Florianopolis'),
    ('AMS', 'Amsterdam Airport Schipol', 'Netherlands', 'Amsterdam'),
    ('FRA', 'Frankfurt Airport', 'Germany', 'Frankfurt'),
    ('GRU', 'Aeroporto Internacional de SP', 'Brazil', 'Guarulhos'),
    ('SYD', 'Sydney Kingsford Smith Airport', 'Australia', 'Sydney'),
    ('LDZ', 'Lodz Airport', 'Poland', 'Lodz'),
    ('GVA', 'Geneva Airport', 'Switzerland', 'Geneva'),
    ('HKG', 'Hong Kong International Airport', 'Hong Kong', 'Chek Lap Kok'),
	('AAL', 'Aalborg Airport', 'Denmark', 'Aalborg'),
    ('JFK', 'John F. Kennedy International Airport', 'United States of America', 'New York'),
    ('LUX', 'Luxembourg Airport', 'Luxembourg', 'Luxembourg'),
    ('LHR', 'Heathrow Airport', 'England', 'London'),
    ('HND', 'Haneda Airport', 'Japan', 'Tokyo'),
    ('JNB', 'O.R. Tambo International Airport', 'South Africa', 'Johannesburg');

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
    ('000000012','Snoop','Dogg','snoopydoggy@private.com','77832430'),
    ('000000013','Jonas','Knocksen','pmccartney@hotmail.com','83901322'),
    ('000000014','Marilyn','Monroe','marimonroe1@gmail.com','33997283'),
    ('000000015','Neil','Armstrong','nielastro1@yahoo.com','66249129'),
    ('000000016','John','Doe','johndoe123@hotmail.com','79823475'),
    ('000000017','Jane','Door','door@hotmail.com', '79866475'),
    ('000000018','John','Smith','smithisthebest@hotmail.com','79866575' ),
    ('000000019','Jane','Yuyu','janethejohn@hotmail.com', '79866475'),
    ('000000020','Yuri','Da Silva','yudas@gmail.com', '12312345'),
    ('000000021','Twoja','Stara','tokopara@gmail.com', '21376942'),
    ('000000022','Syn','Kolezanki','twojejmamy@gmail.com', '2856301'),
    ('000000023','Tonald','Drump','whitehouse@gmail.com', '66699966');

# Place inserts
insert into Place values 
    # PlacesID, TerminalID, Service
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
    # ActivityID, Service, ActivityDescription, PlaceID, PassportID
    ('A001', 'Check-In', 'Checked in for flight', 'P002', '000000001'),
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

# Flights inserts
insert into Flight values
    # FlightID, DepTime, ArrTime, Aircraft, Airline, PassengerCapacity, LuggageCapacity, SourceCode, DestinationCode
    ("LAT2359", "2023-04-22 10:50:00.00",  "2023-04-23 19:30:00.00", "Boeing 737", "Latam", 100, 1500, "FLN", "CPH"),
    ("LAT6893", "2023-04-22 19:30:00.00",  "2023-04-23 10:34:00.00", "Boeing 767", "Latam", 100, 1500, "AMS", "CPH"),
    ("MAX1234", "2023-04-22 12:00:00.00",  "2023-04-22 20:35:00.00", "Boeing 777", "Maxiflight", 100, 1500, "FRA", "CPH"),
    ("SAS9921", "2023-04-22 11:45:00.00",  "2023-04-22 12:30:00.00", "Boeing 767", "Scandinavian", 100, 1500, "AAL", "CPH"),
    ("RYN5032", "2023-04-22 11:45:00.00",  "2023-04-23 10:30:00.00", "Boeing 777", "Rynair", 100, 1500, "SYD", "CPH"),
    ("GOL5021", "2023-04-22 12:15:00.00",  "2023-04-22 13:35:00.00", "Boeing 767", "Gol", 100, 1500, "GRU", "FLN"),
    ("MAL6666", "2023-04-22 06:05:00.00",  "2023-04-22 08:45:00.00", "Boeing 777", "Malokair", 100, 1500, "CPH", "GVA"),
    ("MAL6692", "2023-04-22 18:30:00.00",  "2023-04-22 19:34:00.00", "Boeing 767", "Malokair", 100, 1500, "GVA", "CPH"),
    ("BAL6821", "2023-04-22 10:10:00.00",  "2023-04-22 13:20:00.00", "Boeing 767", "Ballights", 100, 1500, "HKG", "HND"),
    ("BAL5326", "2023-04-22 12:20:00.00",  "2023-04-22 15:30:00.00", "Boeing 777", "Ballights", 100, 1500, "HND", "HKG"),
    ("PLO2305", "2023-04-22 23:25:00.00",  "2023-04-22 02:00:00.00", "Boeing 737", "Plane On Air", 100, 1500, "CPH", "LUX"),
    ("SNP0913", "2023-03-22 14:10:00.00",  "2023-03-22 23:10:00.00", "Boeing 767", "Snoop Lines", 100, 1500, "JFK", "CPH"),
    ("LOT2137", "2023-04-22 12:05:00.00",  "2023-04-22 13:00:00.00", "Airbus A380", "LOT", 560, 9000, "CPH", "HKG"),
    ("LOT9202", "2023-04-22 12:05:00.00",  "2023-04-22 13:00:00.00", "Airbus A320", "LOT", 90, 1300, "CPH", "FLN"),
    ("POT5311", "2023-04-22 15:55:00.00",  "2023-04-22 18:00:00.00", "Boeing 767", "Portugal Air", 100, 1500, "CPH", "LUX"),
    ("XAM2432", "2023-04-22 14:00:00.00",  "2023-04-22 16:00:00.00", "Boeing 777", "Xam Flights", 100, 1500, "LHR", "CPH"),
    ("PLO0239", "2023-04-22 09:00:00.00",  "2023-04-22 11:40:00.00", "Boeing 737", "Plane On Air", 100, 1500, "LUX", "CPH"),
    ("AMS1240", "2023-03-22 09:30:00.00",  "2023-03-22 11:00:00.00", "Boeing 767", "Amsterdair", 100, 1500, "CPH", "AMS"),
    ("HPE5320", "2023-03-22 16:45:00.00",  "2023-03-22 09:30:00.00", "Boeing 737", "Hippie Flights", 100, 1500, "CPH", "HND"),
    ("PLG1245", "2023-04-22 19:40:00.00",  "2023-04-23 05:50:00.00", "Boeing 777", "Pluggin Air", 100, 1500, "CPH", "JNB");

# Gate inserts
insert into Gate values
    # GateID, FlightID, AllocationStart, AllocationEnd, FloorLevel, TerminalID
    ( 'A10', "LAT2359", null, null, 0, '1' ),
    ( 'A11', "MAX1234", null, null, 0, '1'),
    ( 'A33', "SAS9921", null, null, 1, '1'),
    ( 'B01', "RYN5032", null, null, 0, '2'),
    ( 'B02', "MAL6666", null, null, 1, '2'),
    ( 'C33', "BAL5326", null, null, 0, '5');


# Ticket inserts
insert into Ticket values 
    # TicketID, Class, PassengerID, FlightID, ValidDate
	('223EU89441637','Member','000000001','LAT2359', '2023-04-22'),
	('AUT5541903212','Gold','000000002','LAT6893', '2023-04-22'),
	('420OL1722640K','Economy','000000003','MAX1234', '2023-04-22'),
    ('223EU89441638','Member','000000004','SAS9921', '2023-04-22'),
    ('AUT5541903213','First class','000000008','RYN5032', '2023-04-22'),
    ('AUT6729483818','Economy','000000021','GOL5021','2023-04-22'),
    ('AUT5781398346','Economy','000000022','GOL5021','2023-04-22'),
    ('AUT2345623584','Member','000000023','GOL5021','2023-04-22'),
    ('AUT5541903214','First class','000000011','GOL5021','2023-04-22'),
    ('98022MH1370X1','First class','000000015', 'MAL6666','2023-04-22'),
    ('4815162342LOS','Economy','000000009','MAL6692','2023-04-22'),
    ('4815162342LOT','Economy','000000010','BAL6821','2023-04-22'),
    ('AUT5541903215','Economy','000000014','BAL5326','2023-04-22'),
    ('223EU89441639','Member','000000017','PLO2305','2023-04-22'),
    ('420OL1722640I','First class','000000012','SNP0913','2023-04-22'),
    ('8274SW1277464','Economy','000000016','POT5311','2023-04-22'),
    ('98022MH1370X2','Gold','000000018','XAM2432','2023-04-22'),
    ('BV1938466382D','Gold','000000019', 'AMS1240','2023-04-22'),
    ('420OL1722640J','Economy','000000020', 'HPE5320','2023-04-22');

# Luggage inserts
insert into Luggage values
    # LuggageID, Weight, Delivered, PassportID, TicketID
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
    ('87693432','16.60',false,'000000016','8274SW1277464'),
    ('45378284','14.10',false,'000000022','AUT2345623584');


select * from Passenger;
select * from Flight;
select * from Ticket;
select * from Airport;
select * from Luggage;
select * from Place;
select * from Activity;
select * from Terminal;
select * from Luggage;