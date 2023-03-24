INSERT INTO Terminal(TerminalID) VALUES ('1');
INSERT INTO Terminal(TerminalID) VALUES ('2');
INSERT INTO Terminal(TerminalID) VALUES ('3');
INSERT INTO Terminal(TerminalID) VALUES ('4');
INSERT INTO Terminal(TerminalID) VALUES ('5');

insert into Place values ('P001', '1', 'Duty-Free');
insert into Place values ('P002', '1', 'Check-In');
insert into Place values ('P003', '1', 'Check-Out');
insert into Place values ('P004', '1', 'Food');
insert into Place values ('P005', '1', 'Clothes');

insert into Place values ('P006', '2', 'Duty-Free');
insert into Place values ('P007', '2', 'Clothes');
insert into Place values ('P008', '2', 'Check-In');
insert into Place values ('P009', '2', 'Check-Out');
insert into Place values ('P010', '2', 'Books');

insert into Place values ('P011', '3', 'Duty-Free');
insert into Place values ('P012', '3', 'Perfume');
insert into Place values ('P013', '2', 'Clothes');
insert into Place values ('P014', '3', 'Check-In');
insert into Place values ('P015', '3', 'Check-Out');
insert into Place values ('P016', '3', 'Gifts');

insert into Place values ('P017', '4', 'Duty-Free');
insert into Place values ('P018', '4', 'News');
insert into Place values ('P019', '4', 'Check-In');
insert into Place values ('P020', '4', 'Check-Out');

insert into Place values ('P021', '5', 'Check-In');
insert into Place values ('P022', '5', 'Check-Out');
insert into Place values ('P023', '5', 'Duty-Free');
insert into Place values ('P024', '5', 'Food');

insert into Activity values ('A001', 'Check-In', 'Checked in for flight', 'P002', '000000000');
insert into Activity values ('A002', 'Food', 'Bought a burger', 'P004', '000000000');
insert into Activity values ('A003', 'Clothes', 'Bought a shirt', 'P005', '000000000');
insert into Activity values ('A004', 'Check-Out', 'Checked out of the airport', 'P003', '000000000');
insert into Activity values ('A005', 'Duty-Free', 'Bought a bottle of whiskey', 'P001', '000000000');
insert into Activity values ('A006', 'Check-In', 'Checked in for flight', 'P008', '000000000');
insert into Activity values ('A007', 'Books', 'Bought a book', 'P010', '000000000');
insert into Activity values ('A008', 'Clothes', 'Tried on a pair of jeans', 'P007', '000000000');
insert into Activity values ('A009', 'Check-Out', 'Checked out of the airport', 'P009', '000000000');
insert into Activity values ('A010', 'Gifts', 'Bought a souvenir', 'P016', '000000000');
insert into Activity values ('A011', 'Duty-Free', 'Bought a watch', 'P011', '000000000');
insert into Activity values ('A012', 'Clothes', 'Tried on a shirt', 'P013', '000000000');
insert into Activity values ('A013', 'Check-In', 'Checked in for the flight', 'P008', '000000000');
insert into Activity values ('A014', 'Perfume', 'Bought a bottle of perfume', 'P012', '000000000');
insert into Activity values ('A015', 'Food', 'Ordered a pizza', 'P004', '000000000');
