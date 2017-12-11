# THIS HAS ALTERATIONS LATER NEEDED FOR SOME TABLES.


SET echo on
REM ==================================================================
REM ***************************** SOHA HEMMATI ***********************
REM ==================================================================



REM ================== INITIAL FORMAT SETTING ========================

SET PAGESIZE 30
SET LINESIZE 100
SET FEEDBACK ON
SET VERIFY ON

--TTITLE '********************* CREATE TRAVELXP TABLES(MAIN TABLES) *********************'
--BTITLE '******************************   By Soha Hemmati    ***************************'


COL AGENT_ADDRESS FOR A30
COL AGENT_NAME FOR A15
COL TABLE_NAME FOR A20
COL TABLESPACE_NAME FOR A20
COL OWNER FOR A20

REM=========================== CREATE MAIN TABLES  =============================

CONN towner/travelxp456


DROP TABLE 	customer	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	credit_card 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	traveller 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	itin_invoice 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	booking 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	supplier 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	tax     	  CASCADE CONSTRAINTS PURGE;


PURGE RECYCLEBIN;



REM ======================================= CUSTOMER TABLE ========================================


CREATE TABLE CUSTOMER
       (customer_id  	NUMBER(10) 
	constraint   	customer_id_pk     primary key
        DEFERRABLE INITIALLY DEFERRED
USING INDEX
	(CREATE INDEX customer_id_idx  ON customer(customer_id)
TABLESPACE indx),
        customer_fname  	VARCHAR2(20), 
        customer_lname   	VARCHAR2(20),
	customer_birth_date 	DATE,
	customer_email 		VARCHAR2(40),
	customer_home_phone 	varchar2(18),
	customer_business_phone  VARCHAR2(18),
	customer_address 	VARCHAR2(50),
	customer_zipcode 	VARCHAR2(10),
	customer_city 		VARCHAR2(30),
	customer_province 	VARCHAR2(20),
	customer_country 	VARCHAR2(30),
	customer_dependent 	NUMBER(3))
STORAGE (INITIAL 10M
            NEXT 10M
            MINEXTENTs 2
            MAXEXTENTS 100
            PCTINCREASE 0)
            PCTFREE 10
            PCTUSED 40
            INITRANS 2
            MAXTRANS 100;

ALTER TABLE customer
MODIFY(	CUSTOMER_FNAME  VARCHAR2(20) NOT NULL);

ALTER TABLE customer
MODIFY(	CUSTOMER_LNAME  VARCHAR2(20) NOT NULL);

ALTER TABLE customer
MODIFY(	CUSTOMER_HOME_PHONE  VARCHAR2(40) NOT NULL);



DESC CUSTOMER


REM========================== CREDIT_CARD TABLE ===============================


CREATE TABLE CREDIT_CARD
       (customer_id 		NUMBER(10)
	CONSTRAINT   	customer_id_fk   REFERENCES 	CUSTOMER(customer_id)
        DEFERRABLE INITIALLY DEFERRED,
	card_id   		NUMBER(10), 
	card_number 	  	VARCHAR2(30), 
        card_type	  	VARCHAR2(20),
	expiry_date 		DATE,
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

ALTER TABLE CREDIT_CARD
MODIFY( CARD_NUMBER   VARCHAR2(30) NOT NULL);



ALTER TABLE CREDIT_CARD
MODIFY( EXPIRY_DATE  DATE  NOT NULL);


DESC CREDIT_CARD


REM ====================ITINERARY_INVOICE TABLE ================================


CREATE TABLE ITIN_INVOICE
       (itin_invc_id  	NUMBER(10) 
		constraint   	itin_invc_id_pk     primary key
       		 DEFERRABLE INITIALLY DEFERRED
USING INDEX
		(CREATE INDEX itin_invc_id_idx  ON  ITIN_INVOICE(itin_invc_id)
TABLESPACE indx),
	itin_invc_no 	 NUMBER(10),
        itin_invc_date	 DATE,
	no_of_traveller  NUMBER(3),
	billed_amount	 NUMBER(10,2),
	pay_type	 VARCHAR2(15)
		constraint   	invoice_pay_type_id_fk   REFERENCES PAYMENT_TYPE(pay_type)
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



ALTER TABLE ITIN_INVOICE
MODIFY( ITIN_INVC_NO    NUMBER(10)   NOT NULL);


ALTER TABLE ITIN_INVOICE
MODIFY( ITIN_INVC_DATE  DATE   NOT NULL);



DESC ITIN_INVOICE

REM ============================ BOOKING TABLE ============================================


CREATE TABLE BOOKING
       (booking_id 	NUMBER(10)
		constraint   	booking_id_pk     primary key
        	DEFERRABLE INITIALLY DEFERRED
USING INDEX
		(CREATE INDEX booking_id_idx  ON  BOOKING(booking_id)
TABLESPACE indx),
	booking_no 		VARCHAR2(15),
	booking_date 		DATE,
	trip_start_date 		DATE,
	trip_end_date 		DATE,
	destination_desc 	VARCHAR2(50),
	destination_code   	VARCHAR2(10)
		constraint   	book_destin_code_fk   REFERENCES DESTINATION(destination_code)
       		 DEFERRABLE INITIALLY DEFERRED ,
	itin_invc_id            NUMBER(10)
                constraint      book_itin_invc_id_fk   REFERENCES ITIN_INVOICE(itin_invc_id)
       		 DEFERRABLE INITIALLY DEFERRED ,
	emp_num 			NUMBER(3) 
		constraint   	book_emp_num_fk   REFERENCES AGENT_EMP(emp_num)
        	DEFERRABLE INITIALLY DEFERRED ,
        trip_code     		VARCHAR2(3)
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



ALTER TABLE BOOKING
MODIFY( BOOKING_NO    VARCHAR2(15)   NOT NULL);


ALTER TABLE BOOKING
MODIFY( BOOKING_DATE  DATE   NOT NULL);


ALTER TABLE BOOKING
MODIFY( TRIP_START_DATE  DATE   NOT NULL);


ALTER TABLE BOOKING
MODIFY( TRIP_END_DATE  DATE   NOT NULL);



DESC BOOKING



DROP SEQUENCE booking_seq;

CREATE SEQUENCE booking_seq
START WITH 1
MAXVALUE   10000
INCREMENT BY 1
CACHE 100
NOCYCLE;

REM============================== TRAVELLER TABLE  ============================

CREATE TABLE TRAVELLER
       (customer_id  	NUMBER(10)
	CONSTRAINT   	customer1_id_fk   REFERENCES 	CUSTOMER(customer_id)
        DEFERRABLE INITIALLY DEFERRED,
	booking_id 	NUMBER(10)
	CONSTRAINT   	booking_id_fk    REFERENCES 	BOOKING(booking_id)
        DEFERRABLE INITIALLY DEFERRED, 
	constraint   	customer_booking_id_pk     primary key(customer_id,booking_id)
        DEFERRABLE INITIALLY DEFERRED
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
            MAXTRANS 100
TABLESPACE user_data;


DESC TRAVELLER



REM======================== SUPPLIER TABLE =================================


CREATE TABLE SUPPLIER
       (supplier_id  	NUMBER(10) 
	constraint   	supplier_id_pk     primary key
        DEFERRABLE INITIALLY DEFERRED
USING INDEX
	(CREATE INDEX supplier_id_idx  ON SUPPLIER(supplier_id)
TABLESPACE indx),
        supplier_num 	  	NUMBER(10), 
        supplier_name    	VARCHAR2(40),
	supplier_company_name   	VARCHAR2(80),
	supplier_office 		VARCHAR2(5),
	supplier_phone 		varchar2(18),
	supplier_fax 		VARCHAR2(18),
	supplier_address1 	VARCHAR2(100),
	supplier_address2 	VARCHAR2(100),
	supplier_zipcode 	VARCHAR2(10),
	supplier_email 		VARCHAR2(40),
	supplier_website 	VARCHAR2(40),
	representative 		VARCHAR2(50),
	supplier_city 		VARCHAR2(30),
	supplier_province 	VARCHAR2(50),
	supplier_country 	VARCHAR2(30),
	affiliation_code   	VARCHAR2(30)
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



ALTER TABLE SUPPLIER
MODIFY( SUPPLIER_NUM   NUMBER(10)   NOT NULL);


ALTER TABLE SUPPLIER
MODIFY( SUPPLIER_COMPANY_NAME VARCHAR2(80)   NOT NULL);




DESC SUPPLIER



REM =========================== PRODUCT ============================================


CREATE TABLE PRODUCT
       (product_id  		NUMBER(10),
	booking_id 		NUMBER(10)
		constraint   	prod_booking_id_fk   REFERENCES BOOKING(booking_id)
        	DEFERRABLE INITIALLY DEFERRED,
	product_name 		VARCHAR2(20),
	prod_start_date 		DATE,
	prod_end_date 		DATE,
	prod_description 	VARCHAR2(40),
	prod_base_price 		NUMBER(10,2),
	pay_due_date 		DATE,
	class_code  	VARCHAR2(6)
		 constraint   	prod_sold_class_code_fk   REFERENCES CLASS_TYPE(class_code)
       		 DEFERRABLE INITIALLY DEFERRED,
        prod_cat_id 		NUMBER(10)
		constraint   	prod_product_cat_id_fk   REFERENCES PRODUCT_CATEGORY(product_cat_id)
        	DEFERRABLE INITIALLY DEFERRED,
	tax_id  			NUMBER(3)
		constraint   	prod_tax_id_fk   REFERENCES TAX(tax_id)
        	DEFERRABLE INITIALLY DEFERRED,
CONSTRAINT prod_book_pk  PRIMARY KEY (product_id,booking_id)
USING INDEX
	(CREATE INDEX prod_book_idx  ON  PRODUCT(product_id,booking_id)
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



ALTER TABLE PRODUCT
MODIFY( PRODUCT_NAME    VARCHAR2(20)   NOT NULL);


ALTER TABLE PRODUCT
MODIFY( PROD_START_DATE  DATE   NOT NULL);


ALTER TABLE PRODUCT
MODIFY( PROD_END_DATE  DATE   NOT NULL);

ALTER TABLE PRODUCT
MODIFY( PRODUCT_BASE_PRICE   NUMBER(10,2)   NOT NULL);




DESC PRODUCT



REM =========================== SUPPLIER_PRODUCT ====================================

CREATE TABLE SUPPLIER_PRODUCT
       (supplier_id 	NUMBER(10), 
	product_id 	NUMBER(10),
	booking_id 	NUMBER(10),
	booking_num      VARCHAR2(15));


alter table
       supplier_product
     add constraint
       supplier_product_booking_id_pk 
     PRIMARY KEY (supplier_id,product_id, booking_id);


alter table
       supplier_product
     add constraint
       prod_book_id_fk FOREIGN KEY (product_id,booking_id)
     references
       PRODUCT(product_id,booking_id)
     initially deferred deferrable;


alter table
       supplier_product
     add constraint
       supp_prod_id_fk FOREIGN KEY (supplier_id)
     references
       supplier(supplier_id)
     initially deferred deferrable;


REM ================================= Only A simple Verification ================



CONN sys/oracle as sysdba


SELECT TABLE_NAME, TABLESPACE_NAME,OWNER FROM DBA_TABLES
WHERE OWNER = 'TOWNER'
ORDER BY tablespace_name;


REM  MORE VERIFICATION WILL BE IN VERFICATION SECTION



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