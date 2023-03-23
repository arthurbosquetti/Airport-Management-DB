#inserts - Rosie

##### PASSENGER #####
-- create table Passenger
-- 	(PassportID char(9),
--     FirstName varchar(20) not null,
--     LastName varchar30) null,
--     Email varchar(40) not null,
--     constraint email_format check (Email like '%@%.%'),
--     Phone char(8),
--     constraint code_format check (Phone like '[0-9]*'),
--     primary key(PassportID)
--     );

# Passenger inserts
insert Passenger values
	('204238E99','Arthur','Fosquetti','arthurfos@gmail.com','27305028'),
    ('123986412','Jeppe','Snikkelsen','jepsnik@hotmail.com','17349228'),
    ('32KL08344','Marek','Nijolek','mareknijolek@yahoo.com','29907628'),
    ('221467909','Adrian','Snoozedenco ','asnoozedenco@gmail.com','47569022'),
    ('145532235','Rosalie','Batch','rosaliebatch@hotmail.com','23235514'),
    ('324177Q21','Adrian','Palch','arthurbosq@gmail.com','27459121'),
    ('E2149HJ30','Bianca','Onea','biaonea@hotmail.com','44789012'),
    ('289NM70S1','Sidse','Snomsen','sidses@yahoo.com','57801273'),
    ('732913932','Yasmin','Fosquetti','slayfosquetti@gmail.com','33890923'),
    ('H90732S12','Carina','Nijolek','carinanijo@hotmail.com','29461073'),
    ('462837UIO','Paul','McCartney','pmccartney@hotmail.com','38399922'),
    ('420404420','Snoop','Dog','snoopydoggy@private.com','77832430'),
    ('11209Y27Q','Jonas','Knocksen','pmccartney@hotmail.com','83901322'),
    ('TQ12OK942','Marilyn','Monroe','marimonroe1@gmail.com','33997283'),
    ('7301421HD','Neil','Armstrong','nielastro1@yahoo.com','66249129'),
    ('LOL660923','John','Doe','johndoe123@hotmail.com','09823475');


##### LUGGAGE #####
-- create table Luggage
-- 	(LuggageID char(8),
--     Weight decimal (4,2) not null,
--     Delivered bool,
--     OwnerID char(9) not null,
--     Ticket char(13) not null,
--     primary key(LuggageID),
--     foreign key(Ticket) references Ticket(TicketID),
--     constraint code_format check (LuggageID like '[0-9]*')
--     );

# Luggage inserts
insert Luggage values
	('19287365','18.40',false,'204238E99','223EU89441637'),
    ('19287366','7.20',false,'204238E99','223EU89441637'),
    ('92837234','19.40',false,'32KL08344','420OL1722640K'),
    ('16252410','17.30',false,'221467909','223EU89441638'),
    ('16252411','19.10',false,'221467909','223EU89441638'),
    ('16252412','5.20',false,'221467909','223EU89441638'),
    ('76336251','14.50',false,'145532235','AUT5541903212'),
    ('23235541','11.20',false,'324177Q21','AUT5541903213'),
    ('77362513','19.30',false,'E2149HJ30','98022MH1370X1'),
    ('77362514','10.20',false,'E2149HJ30','98022MH1370X1'),
    ('16372827','13.70',false,'289NM70S1','4815162342LOS'),
    ('72626221','3.20',false,'732913932','4815162342LOT'),
    ('98987772','10.20',false,'H90732S12','AUT5541903214'),
    ('98987773','17.40',false,'H90732S12','AUT5541903214'),
    ('16627123','4.20',false,'420404420','420OL1722640I'),
    ('16627124','4.20',false,'420404420','420OL1722640I'),
    ('16627125','4.20',false,'420404420','420OL1722640I'),
    ('16627126','4.20',false,'420404420','420OL1722640I'),
    ('87693432','16.60',false,'11209Y27Q','8274SW1277464'),
    ('46391472','18.10',false,'7301421HD','BV1938466382D'),
    ('46391473','20.00',false,'7301421HD','BV1938466382D'),
    ('12344569','9.40',false,'LOL660923','420OL1722640J'),
    ('92108366','12.30',false,'11209Y27Q','8274SW1277464');


##### TICKETS #####
-- 	(TicketID char(13) not null,
--     Class ENUM('First class','Gold', 'Member', 'Economy'),
--     Passenger char(9) not null,
--     FlightID char(10) not null,
--     TimeSlot datetime,
--     foreign key(Passenger) references Person(PassportID),
--     foreign key(FlightID) references Flights(FlightID),
--     primary key(TicketID)
--     );

# Ticket inserts
insert Ticket values 
	('223EU89441637','Member','204238E99','',''),
	('AUT5541903211','Gold','123986412','',''),
	('420OL1722640K','Economy','32KL08344','',''),
    ('223EU89441638','Member','221467909','',''),
    ('AUT5541903212','First class','145532235','',''),
    ('AUT5541903213','First class','324177Q21','',''),
    ('98022MH1370X1','First class','E2149HJ30','',''),
    ('4815162342LOS','Economy','289NM70S1','',''),
    ('4815162342LOT','Economy','732913932','',''),
    ('AUT5541903214','Economy','H90732S12','',''),
    ('223EU89441639','Member','462837UIO','',''),
    ('420OL1722640I','First class','420404420','',''),
    ('8274SW1277464','Economy','11209Y27Q','',''),
    ('98022MH1370X2','Gold','TQ12OK942','',''),
    ('BV1938466382D','Gold','7301421HD','',''),
    ('420OL1722640J','Economy','LOL660923','','');
