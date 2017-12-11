purge recyclebin;
REM ==================================================================
REM ***************************** SOHA HEMMATI ***********************
REM ==================================================================


REM ================== INITIAL FORMAT SETTING ========================

SET PAGESIZE 40
SET LINESIZE 120
SET FEEDBACK ON
SET VERIFY ON

--TTITLE '********************* CRAETE TABLES IN ADHOC *********************'
--BTITLE '*********************   By Soha Hemmati    ***********************'


COL TABLE_NAME FOR A15
COL TABLESPACE_NAME FOR A15
COL OWNER FOR A15



REM ==================================== CREATE CUSTOMER_DATA TABLE  ==============================

Drop  Table customer_data;

Drop  Table supplier_data;

Drop Table sale_data;

PURGE RECYCLEBIN;


CREATE TABLE        customer_data(
         cust_id      NUMBER(5) PRIMARY KEY,  
         fname        VARCHAR2(15) NOT NULL,
         Lname        VARCHAR2(15) NOT NULL,
         agent        VARCHAR2(3),
         email        VARCHAR2(30),
         home_phone   VARCHAR2(15),
         B_PHONE      VARCHAR2(15),
         birth_date   DATE,
         address      VARCHAR2(50),
	 city         VARCHAR2(10),
	 postal_code  VARCHAR2(10),
	 province     VARCHAR2(10),
	 country      VARCHAR2(10))          
TABLESPACE ADHOC;





DESC CUSTOMER_DATA




REM ==================================== CREATE SUPPLIER_DATA TABLE  ==============================



CREATE TABLE supplier_data(
         product_supplier NUMBER(5),  
         product_category NUMBER(5),
         supplier_office CHAR(5),
         product_description VARCHAR2(30),
	 Contact_Name VARCHAR2(30),
	 company VARCHAR2(75),
	 address1 VARCHAR2(100),
	 address2 VARCHAR2(100),
	 city VARCHAR2(30),
	 prov_state VARCHAR2(50),
	 zip_postal VARCHAR2(10),
	 country VARCHAR2(30),
	 PHONE VARCHAR2(15),
	 fax VARCHAR2(15),
     email VARCHAR2(40),
     web VARCHAR2(40),
	 represents VARCHAR2(50),
         affiliation VARCHAR2(30))
TABLESPACE ADHOC;         




DESC SUPPLIER_DATA




REM ==================================== CREATE SALE_DATA TABLE  ==============================




CREATE TABLE sale_data(
         sale date,  
         cust_id NUMBER(10),
	 itinerary_id NUMBER(10),
	 itinerary_num NUMBER(10),
	 emp_num NUMBER(5),
	 agent CHAR(3),
	 booking_id NUMBER(10),
	 booking_num VARCHAR2(20),
	 product_category NUMBER(5),
	 product_supplier_id NUMBER(10),
     supplier_office CHAR(2),
	 trip_start date,
	 trip_end date,
	 class VARCHAR2(5),
	 num_of_travelers NUMBER(3),
	 product_id NUMBER(10),
	 product VARCHAR2(50),
	 description VARCHAR2(50),
	 destination 		VARCHAR2(35),
	 dest_id 		varchar2(5),
	 credit_card 		VARCHAR2(10),
	 expiry_date 		date,
	 card_number 		VARCHAR2(20),
	 billing_date 		date,
	 bill_description 	VARCHAR2(15),
	 base_price 		NUMBER(10),
	 total_price 		NUMBER(8,2),
	 billed_amt 		NUMBER(8,2),
	 agency_fee_code 	char(3),
	 agency_fee_amount 	NUMBER(5))
TABLESPACE ADHOC;         




DESC SALE_DATA





conn sys/oracle as sysdba




select table_name, tablespace_name, owner from DBA_tables
   WHERE TABLESPACE_NAME='ADHOC';



REM =================== CLEARING SETTING =============================== 

TTITLE OFF
BTITLE OFF
SET linesize 80
SET Long 80
SET FEEDBACK OFF
SET VERIFY OFF
SET ECHO OFF


SPOOL OFF



