spool C:\Users\559006\Desktop\WORKSHOPS\WSH4_CreateTables_SQLLoader\CREATE MAIN TABLES.txt


SET echo on
REM ==================================================================
REM *********** ZOHREH NEJADIAN ****** WORKSHOP 4 *************
REM ==================================================================



REM ================== INITIAL FORMAT SETTING ========================

SET PAGESIZE 15
SET LINESIZE 100
SET FEEDBACK ON
SET VERIFY ON

--TTITLE '********************* CREATE TRAVELXP TABLES(MAIN TABLES) *********************'
--BTITLE '********************* By Zohreh Nejadian **********************'


COL AGENT_ADDRESS FOR A30
COL AGENT_NAME FOR A15




REM=========================== CREATE MAIN TABLES  =============================

CONN towner/t123owner

DROP TABLE 	customer	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	traveller 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	reward	 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	credit_card 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	supplier 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	supplier_product  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	product 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	product_category  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	product_tax 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	tax     	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	booking 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	commission_status CASCADE CONSTRAINTS PURGE;
DROP TABLE 	itinerary 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	invoice 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	payment_type 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	city    	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	province 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	country 	  CASCADE CONSTRAINTS PURGE;

=============================================================
DROP SEQUENCE region_seq;
DROP SEQUENCE fee_type_seq;
DROP SEQUENCE class_type_seq;
DROP SEQUENCE affiliation_seq;
DROP SEQUENCE trip_type_seq;
DROP SEQUENCE agent_emp_seq;
DROP SEQUENCE agent_office_seq;
DROP SEQUENCE product_category_seq;


PURGE RECYCLEBIN;


==============================================

CREATE TABLE customer
       (customer_id  	NUMBER(10) 
	constraint   	customer_id_pk     primary key
        DEFERRABLE INITIALLY DEFERRED
USING INDEX
	(CREATE INDEX customer_id_idx  ON customer(customer_id)
TABLESPACE indx),
        customer_fname  	VARCHAR2(20), 
        customer_lname   	VARCHAR2(20),
	customer_birth_date	DATE,
	customer_email		VARCHAR2(40),
	customer_home_phone	varchar2(18),
	customer_business_phone VARCHAR2(18),
	customer_address	VARCHAR2(50),
	customer_zipcode	VARCHAR2(10),
	customer_dependent	NUMBER(3),
	city_id			number(3))	
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

================================ta inja
DROP SEQUENCE region_seq;

CREATE SEQUENCE region_seq
START WITH 1
MAXVALUE   10000
INCREMENT BY 1
NOCACHE
NOCYCLE;

REM=================== FOR Loading Data to REGION Table I Used Control File 

CREATE TABLE FEE_TYPE
       (fee_id 		NUMBER(5) 
	constraint   	fee_id_pk     primary key
        DEFERRABLE INITIALLY DEFERRED
USING INDEX
	(CREATE INDEX fee_id_idx  ON FEE_TYPE(fee_id)
TABLESPACE indx),
       fee_code     		VARCHAR2(3),
       fee_description     	VARCHAR2(30),
       fee_amount		NUMBER(8,2))
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


DROP SEQUENCE fee_type_seq;

CREATE SEQUENCE fee_type_seq
START WITH 1
MAXVALUE   10000
INCREMENT BY 1
NOCACHE
NOCYCLE;

REM=================== FOR Loading Data to FEE_TYPE Table I Used Control File

CREATE TABLE CLASS_TYPE
       (class_id  	NUMBER(5) 
	constraint   	class_id_pk     primary key
        DEFERRABLE INITIALLY DEFERRED
USING INDEX
	(CREATE INDEX class_code_idx  ON CLASS_TYPE(class_id)
TABLESPACE indx),
	class_code  	VARCHAR2(10),
        class_name     	VARCHAR2(15))
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


DROP SEQUENCE class_type_seq;

CREATE SEQUENCE class_type_seq
START WITH 1
MAXVALUE   10000
INCREMENT BY 1
NOCACHE
NOCYCLE;

REM=================== FOR Loading Data to CLASS_TYPE Table I Used Control File

CREATE TABLE AFFILIATION
       (affiliation_id  	NUMBER(5) 
	constraint   		affil_id_pk     primary key
        DEFERRABLE INITIALLY DEFERRED
USING INDEX
	(CREATE INDEX affil_code__idx  ON AFFILIATION(affiliation_id)
TABLESPACE indx),
       affiliation_code  	VARCHAR2(10),
       affiliation_name     	VARCHAR2(30))
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



DROP SEQUENCE affiliation_seq;

CREATE SEQUENCE affiliation_seq
START WITH 1
MAXVALUE   10000
INCREMENT BY 1
NOCACHE
NOCYCLE;

REM=================== FOR Loading Data to AFFILIATION Table I Used Control File

CREATE TABLE TRIP_TYPE
       (trip_id 		NUMBER(5) 
	constraint   	trip_type_id_pk     primary key
        DEFERRABLE INITIALLY DEFERRED
USING INDEX
	(CREATE INDEX trip_type_id_idx  ON TRIP_TYPE(trip_id)
TABLESPACE indx),
       trip_code     		VARCHAR2(3),
       trip_type     		VARCHAR2(10))
TABLESPACE user_data
STORAGE (INITIAL 10K
            NEXT 10K
            MINEXTENTs 2
            MAXEXTENTS 10000
            PCTINCREASE 0)
            PCTFREE 10
            PCTUSED 40
            INITRANS 2
            MAXTRANS 100;


DROP SEQUENCE trip_type_seq;

CREATE SEQUENCE trip_type_seq
START WITH 1
MAXVALUE   10000
INCREMENT BY 1
NOCACHE
NOCYCLE;


INSERT INTO TRIP_TYPE
		    (trip_id,trip_code,trip_type)
VALUES		    (trip_type_seq.nextval,'B','Business');

INSERT INTO TRIP_TYPE
		    (trip_id,trip_code,trip_type)
VALUES		    (trip_type_seq.nextval,'L','Leisure');


INSERT INTO TRIP_TYPE
		    (trip_id,trip_code,trip_type)
VALUES		    (trip_type_seq.nextval,'G','Group');




COMMIT;

select * from trip_type;


REM= FOR Loading Data to TRIP_TYPE Table I Can Use Insert Statement Because it has less than 5 records



CREATE TABLE PRODUCT_CATEGORY
       (product_cat_id  	NUMBER(10) 
	constraint   	product_cat_id_pk     primary key
        DEFERRABLE INITIALLY DEFERRED
USING INDEX
	(CREATE INDEX product_cat_id_idx  ON PRODUCT_CATEGORY(product_cat_id)
TABLESPACE indx),
        product_cat_name     	VARCHAR2(35),
	product_cat_min_range   NUMBER(5),
	product_cat_mAX_range   NUMBER(5),
	product_unit_price      NUMBER(10,2))
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


DROP SEQUENCE product_category_seq;

CREATE SEQUENCE product_category_seq
START WITH 1
MAXVALUE   10000
INCREMENT BY 1
NOCACHE
NOCYCLE;


REM=================== FOR Loading Data to PRODUCT_CATEGORY Table I Used Control File



CREATE TABLE AGENT_EMP
       (emp_num 		NUMBER(5) 
	constraint   	agent_num_pk     primary key
        DEFERRABLE INITIALLY DEFERRED
USING INDEX
	(CREATE INDEX agent_num_idx  ON AGENT_EMP(emp_num)
TABLESPACE indx),
       emp_id     		VARCHAR2(5),
       emp_fname     		VARCHAR2(20),
       emp_lname		VARCHAR2(20))       
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


DROP SEQUENCE agent_emp_seq;

CREATE SEQUENCE agent_emp_seq
START WITH 1
MAXVALUE   10000
INCREMENT BY 1
NOCACHE
NOCYCLE;

REM=================== FOR Loading Data to AGENT_EMP Table I Used Control File

CREATE TABLE AGENT_OFFICE
       (office_id 		NUMBER(5) 
	constraint   	office_id_pk     primary key
        DEFERRABLE INITIALLY DEFERRED
USING INDEX
	(CREATE INDEX office_id_idx  ON AGENT_OFFICE(office_id)
TABLESPACE indx),
        agent_name     		VARCHAR2(25),
	agent_address  		VARCHAR2(40),
	agent_zipcode  		VARCHAR2(10),
	agent_phone    		VARCHAR2(18),
	agent_fax     		VARCHAR2(18))            
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


DROP SEQUENCE agent_office_seq;

CREATE SEQUENCE agent_office_seq
START WITH 1
MAXVALUE   10000
INCREMENT BY 1
NOCACHE
NOCYCLE;



INSERT INTO AGENT_OFFICE
		    (office_id,agent_name,agent_address,agent_zipcode,agent_phone,agent_fax)
VALUES		    (agent_office_seq.nextval,'Travel Experts','1155 8th Ave S.W. Calgary AB.','T2P 1N3','403-271-9873','403-271-9872');


COMMIT;

SELECT * FROM  AGENT_OFFICE; 

REM= FOR Loading Data to AGENT_OFFICE Table I Can Use Insert Statement Because it has less than 5 records



CONN sys/oracle as sysdba

SELECT TABLE_NAME, TABLESPACE_NAME,OWNER FROM DBA_TABLES
 WHERE OWNER = 'TOWNER';


REM ============= MORE VERIFICATION WILL BE IN VERFICATION SECTION



CONN towner/t123owner





REM =================== CLEARING SETTING =============================== 

TTITLE OFF
BTITLE OFF
SET linesize 80
SET Long 80
SET FEEDBACK OFF
SET VERIFY OFF
SET ECHO OFF


SPOOL OFF
