-- # Airport
-- create table Airports
-- 	(AirportCode char(3),
--     constraint code_format check (AirportCode like '[A-Z]*'),
--     AirportName varchar(50),
--     Country varchar(40) not null,
--     City varchar(40),
--     primary key(AirportCode)
--     );

insert into airports values
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
    
insert into flights2 values
	("LAT2359", "2023-04-22 10:50:00.00",  "2023-04-23 19:30:00.00", "Boeing 737", "Latam", 100, "FLN", "CPH"),
    ("LAT6893", "2023-04-22 19:30:00.00",  "2023-04-23 10:34:00.00", "Boeing 767", "Latam", 100, "AMS", "CPH"),
    ("MAX1234", "2023-04-22 12:00:00.00",  "2023-04-22 20:35:00.00", "Boeing 777", "Maxiflight", 100, "FRA", "CPH"),
	("SAS9921", "2023-04-22 11:45:00.00",  "2023-04-22 12:30:00.00", "Boeing 767", "Scandinavian Airlines", 100, "AAL", "CPH"),
    ("RYN5032", "2023-04-22 11:45:00.00",  "2023-04-23 10:30:00.00", "Boeing 777", "Rynair", 100, "SYD", "CPH"),
	("GOL5021", "2023-04-22 12:15:00.00",  "2023-04-22 13:35:00.00", "Boeing 767", "Gol", 100, "GRU", "FLN"),
    ("MAL6666", "2023-04-22 06:05:00.00",  "2023-04-22 08:45:00.00", "Boeing 777", "Malokair", 100, "CPH", "GVA"),
	("MAL6982", "2023-04-22 18:30:00.00",  "2023-04-22 19:34:00.00", "Boeing 767", "Malokair", 100, "GVA", "CPH"),
	("BAL6821", "2023-04-22 10:10:00.00",  "2023-04-22 13:20:00.00", "Boeing 767", "Ballights", 100, "HKG", "HND"),
	("BAL5326", "2023-04-22 12:20:00.00",  "2023-04-22 15:30:00.00", "Boeing 777", "Ballights", 100, "HND", "HKG"),
    ("PLO2305", "2023-04-22 23:25:00.00",  "2023-04-22 02:00:00.00", "Boeing 737", "Plane On Air", 100, "CPH", "LUX"),
	("SNP0913", "2023-04-22 14:10:00.00",  "2023-04-22 23:10:00.00", "Boeing 767", "Snoop Lines", 100, "JFK", "CPH"),
    ("POT5311", "2023-04-22 15:55:00.00",  "2023-04-22 18:00:00.00", "Boeing 767", "Portugal Air", 100, "CPH", "LUX"),
	("XAM2432", "2023-04-22 14:00:00.00",  "2023-04-22 16:00:00.00", "Boeing 777", "Xam Flights", 100, "LHR", "CPH"),
    ("PLO0239", "2023-04-22 09:00:00.00",  "2023-04-22 11:40:00.00", "Boeing 737", "Plane On Air", 100, "LUX", "CPH"),
	("AMS1240", "2023-04-22 09:30:00.00",  "2023-04-22 11:00:00.00", "Boeing 767", "Amsterdair", 100, "CPH", "AMS"),
    ("HPE5320", "2023-04-22 16:45:00.00",  "2023-04-22 09:30:00.00", "Boeing 737", "Hippie Flights", 100, "CPH", "HND"),
	("PLG1245", "2023-04-22 19:40:00.00",  "2023-04-23 05:50:00.00", "Boeing 777", "Pluggin Air", 100, "CPH", "JNB");



-- create table Flights
-- 	(FlightID char(7) not null,
-- 	   constraint id_format check (FlightID like '[A-Z]\{3,3\}[0-9]\{4,4\}'),
--     DepartureTime time,
--     ArrivalTime time,
--     Aircraft varchar(20),
--     Airline varchar(30),
--     Capacity decimal(3,0),
--     SourceCode char(3),
--     DestinationCode char(3),
--     primary key(FlightID),
--     foreign key(SourceCode) references Airports(AirportCode)
--     );















