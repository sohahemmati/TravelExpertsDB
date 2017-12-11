REM REFER TO MAIN_TABLES2.SQL FOR SOME OF THESE TABLES

SET echo on
REM ==================================================================
REM ***************************** SOHA HEMMATI ***********************
REM ==================================================================

REM ================== INITIAL FORMAT SETTING ========================

SET PAGESIZE 15
SET LINESIZE 100
SET FEEDBACK ON
SET VERIFY ON

--TTITLE '********************* CREATE TRAVELXP TABLES(MAIN TABLES) *********************'
--BTITLE '******************************   By Soha Hemmati    ***************************'

COL AGENT_ADDRESS FOR A30
COL AGENT_NAME FOR A15

REM=========================== CREATE MAIN TABLES  =============================

CONN towner/travelxp456

DROP TABLE 	city    	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	customer	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	credit_card 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	traveller 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	invoice 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	itinerary 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	booking 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	supplier 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	product 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	supplier_product  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	tax     	  CASCADE CONSTRAINTS PURGE;

=============================================================
DROP SEQUENCE region_seq;
DROP SEQUENCE class_type_seq;
DROP SEQUENCE affiliation_seq;
DROP SEQUENCE trip_type_seq;
DROP SEQUENCE agent_emp_seq;
DROP SEQUENCE agent_office_seq;
DROP SEQUENCE product_category_seq;

PURGE RECYCLEBIN;

REM ====================== CUSTOMER TABLE =====================

CREATE TABLE CUSTOMER
       (customer_id  	NUMBER(10) 
	constraint   	customer_id_pk     primary key
        DEFERRABLE INITIALLY DEFERRED
USING INDEX
	(CREATE INDEX customer_id_idx  ON customer(customer_id)
TABLESPACE indx),
        customer_fname   	VARCHAR2(20), 
        customer_lname    	VARCHAR2(20),
	customer_birth_date 	DATE,
	customer_email 		VARCHAR2(40),
	customer_home_phone 	varchar2(18),
	customer_business_phone  VARCHAR2(18),
	customer_address 	VARCHAR2(50),
	customer_zipcode 	VARCHAR2(10),
	customer_dependent 	NUMBER(3)
	CONSTRAINT   	customer_dependent_fk   REFERENCES   CUSTOMER(customer_id)
        DEFERRABLE INITIALLY DEFERRED,
	city_id 			number(3)
	CONSTRAINT   	cust_city_id_fk   REFERENCES   CITY(city_id)
        DEFERRABLE INITIALLY DEFERRED)	
TABLESPACE user_data
STORAGE (INITIAL 10M
            NEXT 10M
            MINEXTENTs 2
            MAXEXTENTS 100
            PCTINCREASE 0)
            PCTFREE 10
            PCTUSED 40
            INITRANS 2
            MAXTRANS 100;


DESC CUSTOMER

REM ============================ ITINERARY TABLE ============================================

CREATE TABLE ITINERARY
       (itinerary_id  	NUMBER(10) 
		constraint   	itinerary_id_pk     primary key
       		 DEFERRABLE INITIALLY DEFERRED
USING INDEX
		(CREATE INDEX itinerary_id_idx  ON  ITINERARY(itinerary_id)
TABLESPACE indx),
        itinerary_num	 NUMBER(10),
	num_of_traveller NUMBER(3))
TABLESPACE user_data
STORAGE (INITIAL 10m
            NEXT 10m
            MINEXTENTs 2
            MAXEXTENTS 100
            PCTINCREASE 0)
            PCTFREE 10
            PCTUSED 40
            INITRANS 2
            MAXTRANS 100;

DROP SEQUENCE itinerary_seq;

CREATE SEQUENCE itinerary_seq
START WITH 1
MAXVALUE   10000
INCREMENT BY 1
NOCACHE
NOCYCLE;

REM ============================ BOOKING TABLE ============================================

CREATE TABLE BOOKING
(
	booking_id 	NUMBER(10)
	constraint   	booking_id_pk     primary key
        DEFERRABLE INITIALLY DEFERRED
USING INDEX
	(CREATE INDEX booking_id_idx  ON  BOOKING(booking_id)
TABLESPACE indx),
	booking_date 		DATE,
	trip_start_date 	DATE,
	trip_end_date 		DATE,
	commission_amount  	NUMBER(8,2),
	destination_desc 	VARCHAR2(50),
	itinerary_id 		NUMBER(10)
		constraint   	book_itinerary_id_fk   REFERENCES ITINERARY(itinerary_id)
       		 DEFERRABLE INITIALLY DEFERRED ,
	city_id 			NUMBER(3)
		constraint   	book_city_id_fk   REFERENCES CITY(city_id)
       		 DEFERRABLE INITIALLY DEFERRED ,
	emp_num 			NUMBER(3) 
		constraint   	book_emp_num_fk   REFERENCES AGENT_EMP(emp_num)
        	DEFERRABLE INITIALLY DEFERRED ,
    trip_code      		VARCHAR2(3)
		constraint   	book_trip_code_fk   REFERENCES TRIP_TYPE(trip_code)
        	DEFERRABLE INITIALLY DEFERRED) 
STORAGE (INITIAL 10M
            NEXT 10M
            MINEXTENTs 2
            MAXEXTENTS 100
            PCTINCREASE 0)
            PCTFREE 10
            PCTUSED 40
            INITRANS 2
            MAXTRANS 100
TABLESPACE user_data;

DROP SEQUENCE booking_seq;

CREATE SEQUENCE booking_seq
START WITH 1
MAXVALUE   10000
INCREMENT BY 1
NOCACHE
NOCYCLE;

REM=================== TRAVELLER TABLE - COMPOSITE PK & FK ====================


CREATE TABLE TRAVELLER
       (customer_id  	NUMBER(10),
        booking_id NUMBER(10)     
		CONSTRAINT   	booking_travel_id_fk    REFERENCES 	BOOKING(booking_id)
		DEFERRABLE INITIALLY DEFERRED
		CONSTRAINT   	customer_travel_id_fk   REFERENCES 	CUSTOMER(customer_id)
		DEFERRABLE INITIALLY DEFERRED,
		constraint   	customer_booking_id_pk     primary key (customer_id,booking_id)
USING INDEX
	(CREATE INDEX customer_booking_id_idx  ON traveller(customer_id,booking_id)
TABLESPACE indx))
STORAGE (INITIAL 10M
            NEXT 10M
            MINEXTENTs 2
            MAXEXTENTS 100
            PCTINCREASE 0)
            PCTFREE 10
            PCTUSED 40
            INITRANS 2
            MAXTRANS 100;

DESC TRAVELLER

REM========================== CREDIT_CARD TABLE ===============================

CREATE TABLE CREDIT_CARD
       (card_id  		NUMBER(10), 
	card_number 	  	VARCHAR2(25), 
        card_type   	VARCHAR2(10),
	expiry_date 	DATE,
	customer_id 	NUMBER(10)
	CONSTRAINT   	customer_id_fk   REFERENCES 	CUSTOMER(customer_id)
        DEFERRABLE INITIALLY DEFERRED,
CONSTRAINT card_customer_id_pk  PRIMARY KEY (card_id,customer_id)
USING INDEX
	(CREATE INDEX card_customer_id_idx  ON  CREDIT_CARD(card_id,customer_id)
TABLESPACE indx))
	STORAGE (INITIAL 10M
            NEXT 10M
            MINEXTENTs 2
            MAXEXTENTS 100
            PCTINCREASE 0)
            PCTFREE 10
            PCTUSED 40
            INITRANS 2
            MAXTRANS 100;

DESC CREDIT_CARD

DROP SEQUENCE CREDIT_CARD_seq;

CREATE SEQUENCE CREDIT_CARD_seq
START WITH 1
MAXVALUE   10000
INCREMENT BY 1
NOCACHE
NOCYCLE;

REM======================== SUPPLIER TABLE =================================

CREATE TABLE SUPPLIER
       (supplier_id   	NUMBER(10) 
	constraint    	supplier_id_pk      primary key
        DEFERRABLE INITIALLY DEFERRED
USING INDEX
	(CREATE INDEX supplier_id_idx  ON SUPPLIER(supplier_id)
TABLESPACE indx),
        supplier_num	  	NUMBER(10), 
        supplier_name   	VARCHAR2(40),
	supplier_company_name  	VARCHAR2(80),
	supplier_region_id 	VARCHAR2(3),
	supplier_phone 		varchar2(18),
	supplier_fax 		VARCHAR2(18),
	supplier_address1 	VARCHAR2(100),
	supplier_address2 	VARCHAR2(100),
	supplier_zipcode 	VARCHAR2(10),
	supplier_email 		VARCHAR2(40),
	supplier_website 	VARCHAR2(40),
	representative 		VARCHAR2(50),
	city_id 			NUMBER(4)
	CONSTRAINT   	sup_city_id_fk   REFERENCES   CITY(city_id)
        DEFERRABLE INITIALLY DEFERRED,
	affiliation_code  	VARCHAR(30)
	CONSTRAINT   	sup_affiliation_code_fk   REFERENCES   AFFILIATION(affiliation_code)
        DEFERRABLE INITIALLY DEFERRED)	
TABLESPACE user_data
STORAGE (INITIAL 10M
            NEXT 10M
            MINEXTENTs 2
            MAXEXTENTS 100
            PCTINCREASE 0)
            PCTFREE 10
            PCTUSED 40
            INITRANS 2
            MAXTRANS 100;

DESC SUPPLIER

DROP SEQUENCE SUPPLIER_seq;

CREATE SEQUENCE SUPPLIER_seq
START WITH 1
MAXVALUE   10000
INCREMENT BY 1
NOCACHE
NOCYCLE;

REM =========================== PRODUCT TABLE ===================================

CREATE TABLE PRODUCT
       (product_id 	NUMBER(10)
		constraint   	product_id_pk     primary key
        	DEFERRABLE INITIALLY DEFERRED
USING INDEX
	(CREATE INDEX product_id_idx  ON  PRODUCT(product_id)
TABLESPACE indx),
	product_name 		VARCHAR2(20),
	product_base_price 	NUMBER(10,2),
	product_cat_id 		NUMBER(3)
	constraint   	product__cat_id_fk   REFERENCES PRODUCT_CATEGORY(product_cat_id)
        DEFERRABLE INITIALLY DEFERRED) 
STORAGE (INITIAL 10M
            NEXT 10M
            MINEXTENTs 2
            MAXEXTENTS 100
            PCTINCREASE 0)
            PCTFREE 10
            PCTUSED 40
            INITRANS 2
            MAXTRANS 100
TABLESPACE user_data;

REM=================== SUPPLIER_PRODUCT TABLE ===================================

CREATE TABLE SUPPLIER_PRODUCT
       (supplier_id NUMBER(10) 
		constraint   	supp_prod_supplier_id_fk   REFERENCES SUPPLIER(supplier_id)
        	DEFERRABLE INITIALLY DEFERRED,
        product_id 	NUMBER(10)
		constraint   	supp_prod_product_id_fk   REFERENCES PRODUCT(product_id)
        	DEFERRABLE INITIALLY DEFERRED, 
	CONSTRAINT supplier_product_id_pk  PRIMARY KEY (supplier_id,product_id)
USING INDEX
	(CREATE INDEX supplier_product_id_idx  ON  SUPPLIER_PRODUCT(supplier_id,product_id)
TABLESPACE indx))
STORAGE (INITIAL 10M
            NEXT 10M
            MINEXTENTs 2
            MAXEXTENTS 100
            PCTINCREASE 0)
            PCTFREE 10
            PCTUSED 40
            INITRANS 2
            MAXTRANS 100
TABLESPACE user_data;

DESC SUPPLIER_PRODUCT

REM =========================== TAX TABLE ============================================

CREATE TABLE TAX
       (tax_id  	NUMBER(3) 
		constraint   	tax_id_pk     primary key
       		 DEFERRABLE INITIALLY DEFERRED
USING INDEX
		(CREATE INDEX tax_id_idx  ON  TAX(tax_id)
TABLESPACE indx),
        tax_code 	VARCHAR2(10),
	tax_description VARCHAR2(20))
TABLESPACE user_data
STORAGE (INITIAL 10K
            NEXT 10K
            MINEXTENTs 2
            MAXEXTENTS 100
            PCTINCREASE 0)
            PCTFREE 10
            PCTUSED 40
            INITRANS 2
            MAXTRANS 100;

DROP SEQUENCE tax_seq;

CREATE SEQUENCE tax_seq
START WITH 1
MAXVALUE   10000
INCREMENT BY 1
NOCACHE
NOCYCLE;

REM ============================ INVOICE TABLE ============================================

CREATE TABLE INVOICE
       (invoice_id  	NUMBER(10) 
		constraint   	invoice_id_pk     primary key
       		DEFERRABLE INITIALLY DEFERRED
USING INDEX
		(CREATE INDEX invoice_id_idx  ON  INVOICE(invoice_id)
TABLESPACE indx),
        invoice_date	DATE,
	billed_amount	NUMBER(10,2),
	pay_type_id	NUMBER(3)
		constraint   	invoice_pay_type_id_fk   REFERENCES PAYMENT_TYPE(pay_type_id)
        	DEFERRABLE INITIALLY DEFERRED ,
	itinerary_id		NUMBER(10)
		constraint   	book_itinerary_id_fk   REFERENCES ITINERARY(itinerary_id)
       		 DEFERRABLE INITIALLY DEFERRED)
TABLESPACE user_data
STORAGE (INITIAL 10m
            NEXT 10m
            MINEXTENTs 2
            MAXEXTENTS 100
            PCTINCREASE 0)
            PCTFREE 10
            PCTUSED 40
            INITRANS 2
            MAXTRANS 100;

DROP SEQUENCE invoice_seq;

CREATE SEQUENCE invoice_seq
START WITH 1
MAXVALUE   10000
INCREMENT BY 1
NOCACHE
NOCYCLE;

REM ============================ CITY TABLE ============================================

CREATE TABLE CITY
       (city_id  	NUMBER(10) 
		constraint   	city_id_pk     primary key
       		DEFERRABLE INITIALLY DEFERRED
USING INDEX
		(CREATE INDEX city_id_idx  ON  CITY(city_id)
TABLESPACE indx),
        city_name	 VARCHAR2(30),
	province_name	 VARCHAR2(30),
	province_initial VARCHAR2(30),
	country_name	 VARCHAR2(30),
	destination_code VARCHAR2(10)	 
		constraint   	city_destination_code_fk   REFERENCES DESTINATION(destination_code)
        	DEFERRABLE INITIALLY DEFERRED)
STORAGE (INITIAL 10m
            NEXT 10m
            MINEXTENTs 2
            MAXEXTENTS 100
            PCTINCREASE 0)
            PCTFREE 10
            PCTUSED 40
            INITRANS 2
            MAXTRANS 100
TABLESPACE user_data;

==============================================================================================

CONN sys/oracle as sysdba

SELECT TABLE_NAME, TABLESPACE_NAME,OWNER FROM DBA_TABLES
 WHERE OWNER = 'TOWNER';

REM ============= MORE VERIFICATION WILL BE IN VERFICATION SECTION

CONN towner/travelxp456

REM =================== CLEARING SETTING =============================== 

TTITLE OFF
BTITLE OFF
SET linesize 80
SET Long 80
SET FEEDBACK OFF
SET VERIFY OFF
SET ECHO OFF
SPOOL OFF
