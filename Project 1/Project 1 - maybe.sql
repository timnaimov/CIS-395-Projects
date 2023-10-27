-- 1.  Enhance the primary keys of each base tables (relations) to utilize automatic generation of the primary keys.

use hoteldb;

alter table booking modify column hotelNo int;
alter table booking modify column guestNo int;
alter table booking modify column roomNo int;

alter table hotel modify column hotelNo int auto_increment;
alter table room modify column roomNo int;
alter table room modify column hotelNo int;
alter table guest modify column guestNo int auto_increment;
alter table booking modify column hotelNo int primary key auto_increment;

-- 2. Enhance the tables guest, hotel which store address information. Include real-world address fields as applicable.
alter table hotel add column stateCd char(2);
alter table hotel add column zip varchar(20);
alter table hotel add column countryCd varchar(200);

alter table guest add column stateCd char(2);
alter table guest add column zip varchar(20);
alter table guest add column countryCd varchar(200);

/* insert into hotel (hotelNo, stateCd, zip, countryCd) values (1,'NJ','20434','United States');
insert into hotel (hotelNo, stateCd, zip, countryCd) values (2,'NY','100434', 'United States');
insert into hotel (hotelNo, stateCd, zip, countryCd) values (3,'LD','A-345','England');
insert into hotel (hotelNo, stateCd, zip, countryCd) values (4,'HK','45675', 'China');
insert into hotel (hotelNo, stateCd, zip, countryCd) values(5,'MN','F673D', 'Philippines');
insert into hotel (hotelNo, stateCd, zip, countryCd) values(122,'BK','11228', 'United States'); */

-- 3
alter table guest add column registrationNumber int not null primary key auto_increment unique;
alter table guest add constraint reservation unique (guestNo, hotelNo, roomNo, startdate);

alter table booking modify column dateTo datetime;

-- 5
create table taxes( countryCD varchar(2) not null, stateCd varchar(2) not null, taxrate dec not null);

select r.price, g.stateCd, t.taxrate, r.price * t.taxrate 
as final_price from guest g, room r, taxes t
join room on guest.(registrationNumber) = room.(registrationNumber) 
join guest on guest.(stateCd) = t.(stateCd)

select r.price, r.hotelNo, h.hotelNo, h.stateCd, t.state, 
t.taxrate, b.guestNo, g.guestNo, r.price * t.taxrate 
as final_price from hotel h join room r on hotel.hotelNo = room.hotelNo 
join taxes t on h.(stateCd) = t.(stateCd) join booking b on guest

select r.price, r.hotelNo, h.hotelNo, h.stateCd, t.taxRate, t.state, 
r.price + (r.price * t.taxrate) as final_price from hotel h 
join room r on hotel.hotelNo = room.hotelNo join taxes t on hotel.stateCd = taxes.stateCd