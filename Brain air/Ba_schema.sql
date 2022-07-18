/* 
BrianAir Project Report: Salvador Marti Roman (salma742) and Mowniesh Asokan (mowas455)
*/


use project;




DROP TABLE IF EXISTS ba_is_paid_by CASCADE;
DROP TABLE IF EXISTS ba_provides CASCADE;
DROP TABLE IF EXISTS ba_main_contact CASCADE;
DROP TABLE IF EXISTS ba_travels_in CASCADE;
DROP TABLE IF EXISTS ba_reservation CASCADE;
DROP TABLE IF EXISTS ba_flight CASCADE;
DROP TABLE IF EXISTS ba_price_table CASCADE;
DROP TABLE IF EXISTS ba_year CASCADE;
DROP TABLE IF EXISTS ba_week_day CASCADE;
DROP TABLE IF EXISTS ba_weekly_schedule CASCADE;
DROP TABLE IF EXISTS ba_flight_route CASCADE;
DROP TABLE IF EXISTS ba_airport CASCADE;
DROP TABLE IF EXISTS ba_person CASCADE;

SELECT 'Creating tables' AS 'Message';
   
CREATE TABLE ba_person (
    Customer_id INT AUTO_INCREMENT,
    First_name VARCHAR(10),
    Last_name VARCHAR(10),
    Is_passenger BOOLEAN,
    Passport_no INT,
    CONSTRAINT pk_ba_person PRIMARY KEY (Customer_id)
)  ENGINE=INNODB;

CREATE TABLE ba_airport (
    Airport_code VARCHAR(3),
    Airport_name  VARCHAR(30),
    Country VARCHAR(30),  
	CONSTRAINT pk_ba_airport PRIMARY KEY (Airport_code)
) ENGINE=INNODB;

CREATE TABLE ba_flight_route (
  Airport_departs VARCHAR(3),
  Airport_arrives  VARCHAR(3),
  CONSTRAINT pk_ba_flight_route PRIMARY KEY (Airport_departs,Airport_arrives),
  CONSTRAINT fk_ba_flight_departs FOREIGN KEY (Airport_departs)
        REFERENCES ba_airport (Airport_code),
  CONSTRAINT fk_ba_flight_arrives FOREIGN KEY (Airport_arrives)
        REFERENCES ba_airport (Airport_code)
) ENGINE=INNODB;

CREATE TABLE ba_weekly_schedule (
  Schedule_code INT AUTO_INCREMENT,
  Flight_airport_departs VARCHAR(30),
  Flight_airport_arrives VARCHAR(30),
  Departure_time TIME,
  Weekday_day VARCHAR(10),
  Weekday_year INT,
  CONSTRAINT pk_ba_weekly_schedule PRIMARY KEY (Schedule_code),
  CONSTRAINT fk_ba_airport_fdeparts FOREIGN KEY (Flight_airport_departs)
        REFERENCES ba_flight_route (Airport_departs),
  CONSTRAINT fk_ba_airport_farrives FOREIGN KEY (Flight_airport_arrives)
		REFERENCES ba_flight_route (Airport_arrives)
)  ENGINE=INNODB;

CREATE TABLE ba_week_day (
    Year_year INT,
    Day_week VARCHAR(10),
    Weekday_factor DOUBLE,
    CONSTRAINT pk_ba_week_day PRIMARY KEY (Year_year,Day_week)
    ##############################
	#CONSTRAINT fk_ba_week_day_day FOREIGN KEY (Day_week)
        #REFERENCES ba_weekly_schedule (Weekday_day)
    )  ENGINE=INNODB;
	

CREATE TABLE ba_year (
     Y_year INT,
     Year_factor DOUBLE,
	 CONSTRAINT pk_ba_year PRIMARY KEY (Y_year),
     CONSTRAINT fk_ba_year_y FOREIGN KEY (Y_year)
            REFERENCES ba_week_day (Year_year)
       )ENGINE = INNODB;

CREATE TABLE ba_price_table(
    Airport_departs VARCHAR(3),
    Airport_arrives VARCHAR(3),
    Year_year INT,
    Base_price DOUBLE,
    CONSTRAINT fk_ba_price_table_d FOREIGN KEY (Airport_departs)
            REFERENCES ba_flight_route (Airport_departs),
	CONSTRAINT fk_ba_price_table_a FOREIGN KEY (Airport_arrives)
            REFERENCES ba_flight_route (Airport_arrives),
	 CONSTRAINT fk_ba_price_table_y FOREIGN KEY (Year_year)
            REFERENCES ba_year (Y_year)
	   )ENGINE = INNODB;
   
 CREATE TABLE ba_flight(
    Flight_number INT AUTO_INCREMENT,
    Weekly_schedule_code INT,
    Week_number INT,
    CONSTRAINT pk_ba_flight PRIMARY KEY (Flight_number),
    CONSTRAINT fk_ba_flight_weekly_scode FOREIGN KEY (Weekly_schedule_code)
            REFERENCES ba_weekly_schedule (Schedule_code) 
    )ENGINE = INNODB;
      
   
 CREATE TABLE ba_reservation(
    Reservation_number INT AUTO_INCREMENT,
    Is_booking VARCHAR(30),
    Flight_number INT,
    CONSTRAINT pk_ba_reservation PRIMARY KEY (Reservation_number),
    CONSTRAINT fk_ba_reservation_flno FOREIGN KEY (Flight_number)
            REFERENCES ba_flight (Flight_number)
    )ENGINE = INNODB;      
       
       
CREATE TABLE ba_travels_in(
     Reservation_number INT,
     Passenger_customerID INT,
     CONSTRAINT pk_ba_travels_in PRIMARY KEY (Reservation_number),
     CONSTRAINT fk_ba_travels_in_rno FOREIGN KEY (Reservation_number)
            REFERENCES ba_reservation (Reservation_number), 
     CONSTRAINT fk_ba_travels_in_pid FOREIGN KEY (Passenger_customerID)
            REFERENCES ba_person (Customer_id)   
     )ENGINE = INNODB;


CREATE TABLE ba_main_contact(
   Reservation_number INT,
   Passenger_customerID INT,
   Email VARCHAR(30),
   Phone_number BIGINT,
   CONSTRAINT pk_ba_main_contact PRIMARY KEY (Reservation_number),
   CONSTRAINT fk_ba_main_contact_rno FOREIGN KEY (Reservation_number)
            REFERENCES ba_reservation (Reservation_number),  
   CONSTRAINT fk_ba_main_contact_pid FOREIGN KEY (Passenger_customerID)
            REFERENCES ba_person (Customer_id)    
     )ENGINE = INNODB;

CREATE TABLE ba_provides(
   Reservation_number INT,
   CustomerID INT,
   Ticket_number INT,
   CONSTRAINT pk_ba_provides PRIMARY KEY (Reservation_number),
   CONSTRAINT fk_ba_provides_rno FOREIGN KEY (Reservation_number)
            REFERENCES ba_reservation (Reservation_number), 
   CONSTRAINT fk_ba_provides_pid FOREIGN KEY (CustomerID)
            REFERENCES ba_person (Customer_id)   
   )ENGINE = INNODB;
   
CREATE TABLE ba_is_paid_by(
   Reservation_number INT,
   CustomerID INT,
   Final_price DOUBLE,
   Credit_cardNO BIGINT,
   CONSTRAINT pk_ba_is_paid_by PRIMARY KEY (Reservation_number),
   CONSTRAINT fk_ba_is_paid_by_rno FOREIGN KEY (Reservation_number)
            REFERENCES ba_reservation (Reservation_number), 
   CONSTRAINT fk_ba_is_paid_by_pid FOREIGN KEY (CustomerID)
            REFERENCES ba_person (Customer_id) 
   
)ENGINE = INNODB;

-- Add unique Key constraint.

ALTER TABLE ba_person ADD CONSTRAINT uk_ba_person UNIQUE (Customer_id, Passport_no);
ALTER TABLE ba_airport ADD CONSTRAINT uk_ba_airport UNIQUE (Airport_code, Airport_name, Country);
ALTER TABLE ba_weekly_schedule ADD CONSTRAINT uk_ba_weekly_schedule UNIQUE (Schedule_code);
# ALTER TABLE ba_week_day ADD CONSTRAINT uk_ba_week_day UNIQUE (Year_year,Day_week);
ALTER TABLE ba_flight ADD CONSTRAINT uk_ba_flight UNIQUE (Flight_number, Week_number);
ALTER TABLE ba_reservation ADD CONSTRAINT uk_ba_reservation UNIQUE (Reservation_number);
ALTER TABLE ba_provides ADD CONSTRAINT uk_ba_provides UNIQUE (Ticket_number);
ALTER TABLE ba_is_paid_by ADD CONSTRAINT uk_ba_is_paid_by UNIQUE (Credit_cardNO);


SELECT 'Creating stored procedures' AS 'Message';

DELIMITER //
CREATE PROCEDURE `addYear` (IN year INT, IN factor DOUBLE)
BEGIN
	DECLARE compid INT DEFAULT 0;
    
	SELECT id INTO compid FROM ba_company;
	INSERT INTO ba_profitfactor VALUES (compid, year, factor) ON DUPLICATE KEY UPDATE pfactor=factor;  
END;
//
DELIMITER ;