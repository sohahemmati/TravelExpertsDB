SET echo on
REM ==================================================================
REM ***************************** SOHA HEMMATI ***********************
REM ==================================================================

REM ================== INITIAL FORMAT SETTING ========================

SET PAGESIZE 35
SET LINESIZE 100
SET FEEDBACK ON
SET VERIFY ON

--TTITLE '********************* CREATE TRAVELXP TABLES(CODE TABLES) *********************'
--BTITLE '******************************   By Soha Hemmati    ***************************'

COL AGENT_ADDRESS FOR A30
COL AGENT_NAME FOR A15

REM=========================== CREATE CODE TABLES and loading data =============================

CONN towner/travelxp456

DROP TABLE 	destination	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	class_type 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	affiliation 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	agent_EMP 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	trip_type 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	agent_office 	  CASCADE CONSTRAINTS PURGE;
DROP TABLE 	product_category  CASCADE CONSTRAINTS PURGE;
DROP TABLE	payment_type	  CASCADE CONSTRAINTS PURGE;
DROP TABLE	tax		  CASCADE CONSTRAINTS PURGE;

PURGE RECYCLEBIN;

REM =========================== DESTINATION TABLE =================================


CREATE TABLE DESTINATION
       (destination_code VARCHAR2(10) 
		constraint destination_dest_id_pk     primary key
        	DEFERRABLE INITIALLY DEFERRED
USING INDEX
		(CREATE INDEX destination_dest_id_idx  ON DESTINATION(destination_code)
TABLESPACE indx),
        destination_name     	VARCHAR2(30))
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

DESC DESTINATION

REM   FOR Loading Data to REGION Table I Used Control File 

SELECT * FROM DESTINATION;

REM ============================== CLASS_TYPE TABLE =================================
 
DROP TABLE 	class_type 	  CASCADE CONSTRAINTS PURGE;

CREATE TABLE CLASS_TYPE
       (class_code VARCHAR2(6)
			constraint class_code_pk primary key
			DEFERRABLE INITIALLY DEFERRED
			USING INDEX
				(CREATE INDEX class_code_idx ON CLASS_TYPE(class_code)
				TABLESPACE indx),
		class_name VARCHAR2(15))
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


DESC CLASS_TYPE

REM  FOR Loading Data to CLASS_TYPE Table I Used Control File

SELECT * FROM CLASS_TYPE;


REM ============================== AFFILIATION TABLE ===============================

DROP TABLE 	affiliation 	  CASCADE CONSTRAINTS PURGE;

CREATE TABLE AFFILIATION
       (affiliation_code   	VARCHAR2(30)
	constraint    		affiliation_code_pk      primary key
        DEFERRABLE INITIALLY DEFERRED
USING INDEX
	(CREATE INDEX affil_code__idx  ON AFFILIATION(affiliation_code)
TABLESPACE indx),
       affiliation_name VARCHAR2(40))
TABLESPACE user_data
STORAGE (INITIAL  10K
            NEXT  10K
            MINEXTENTs  2
            MAXEXTENTS  100
            PCTINCREASE  0)
            PCTFREE  10
            PCTUSED  40
            INITRANS  2
            MAXTRANS  100;


DESC AFFILIATION

REM  FOR Loading Data to AFFILIATION Table I Used Control File

REM =============================== TRIP_TYPE TABLE ====================================

DROP TABLE 	trip_type 	  CASCADE CONSTRAINTS PURGE;

CREATE TABLE TRIP_TYPE
       (trip_code      		VARCHAR2(3)
	constraint    	trip_type_code_pk      primary key
        DEFERRABLE INITIALLY DEFERRED
USING INDEX
	(CREATE INDEX trip_type_code_idx  ON TRIP_TYPE(trip_code)
TABLESPACE indx),
       trip_type      		VARCHAR2(10))
TABLESPACE user_data
STORAGE (INITIAL  10K
            NEXT  10K
            MINEXTENTs  2
            MAXEXTENTS  10000
            PCTINCREASE  0)
            PCTFREE  10
            PCTUSED  40
            INITRANS  2
            MAXTRANS  100;

DESC TRIP_TYPE

INSERT INTO TRIP_TYPE
		    (trip_code,trip_type)
VALUES		    ('B','Business');

INSERT INTO TRIP_TYPE
		    (trip_code,trip_type)
VALUES		    ('L','Leisure');

INSERT INTO TRIP_TYPE
		    (trip_code,trip_type)
VALUES		    ('G','Group');

COMMIT;

select * from trip_type;

REM= FOR Loading Data to TRIP_TYPE Table I Can Use Insert Statement Because it has less than 5 records

REM ================================ PRODUCT_CATEGORY TABLE =============================

DROP TABLE 	product_category  CASCADE CONSTRAINTS PURGE;

CREATE TABLE PRODUCT_CATEGORY
       (product_cat_id  	NUMBER(10) 
	constraint   	product_cat_id_pk     primary key
        DEFERRABLE INITIALLY DEFERRED
USING INDEX
	(CREATE INDEX product_cat_id_idx  ON PRODUCT_CATEGORY(product_cat_id)
TABLESPACE indx),
        product_cat_name      	VARCHAR2(35),
	product_cat_min_range    NUMBER(5),
	product_cat_mAX_range    NUMBER(5))
	TABLESPACE user_data
STORAGE (INITIAL  10K
            NEXT  10K
            MINEXTENTs  2
            MAXEXTENTS  100
            PCTINCREASE  0)
            PCTFREE  10
            PCTUSED  40
            INITRANS  2
            MAXTRANS  100;

DESC PRODUCT_CATEGORY

REM  FOR Loading Data to PRODUCT_CATEGORY Table I Used Control File

SELECT * FROM PRODUCT_CATEGORY;

REM ================================ AGENT_EMP TABLE ======================================

DROP TABLE 	agent_EMP 	  CASCADE CONSTRAINTS PURGE;

CREATE TABLE AGENT_EMP
       (emp_num  		NUMBER(5) 
	constraint    	agent_num_pk      primary key
        DEFERRABLE INITIALLY DEFERRED
USING INDEX
	(CREATE INDEX agent_num_idx  ON AGENT_EMP(emp_num)
TABLESPACE indx),
       emp_id      		VARCHAR2(5),
       emp_fname      		VARCHAR2(20),
       emp_lname 		VARCHAR2(20),
       office_id 		NUMBER(5))       
TABLESPACE user_data
STORAGE (INITIAL  10K
            NEXT  10K
            MINEXTENTs  2
            MAXEXTENTS  100
            PCTINCREASE  0)
            PCTFREE  10
            PCTUSED  40
            INITRANS  2
            MAXTRANS  100;

DESC AGENT_EMP

REM  FOR Loading Data to AGENT_EMP Table I Used Control File

SELECT * FROM AGENT_EMP;

REM ================================ AGENT_OFFICE TABLE ======================================

DROP TABLE 	agent_office 	  CASCADE CONSTRAINTS PURGE;

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

DESC AGENT_OFFICE

INSERT INTO AGENT_OFFICE
		    (office_id,agent_name,agent_address,agent_zipcode,agent_phone,agent_fax)
VALUES		    (1,'Travel Experts','1155 8th Ave S.W. Calgary AB.','T2P 1N3','403-271-9873','403-271-9872');

COMMIT;

SELECT * FROM  AGENT_OFFICE; 

REM= FOR Loading Data to AGENT_OFFICE Table I Can Use Insert Statement Because it has less than 5 records

REM ================================ PAYMENT_TYPE TABLE ======================================

DROP TABLE	payment_type	  CASCADE CONSTRAINTS PURGE;

CREATE TABLE PAYMENT_TYPE
       (pay_type  	VARCHAR2(15) 
	constraint   	pay_type_id_pk     primary key
        DEFERRABLE INITIALLY DEFERRED
USING INDEX
	(CREATE INDEX pay_type_idx  ON PAYMENT_TYPE(pay_type)
TABLESPACE indx))
STORAGE (INITIAL 10K
            NEXT 10K
            MINEXTENTs 2
            MAXEXTENTS 100
            PCTINCREASE 0)
            PCTFREE 10
            PCTUSED 40
            INITRANS 2
            MAXTRANS 100
TABLESPACE user_data;

DESC PAYMENT_TYPE

INSERT INTO PAYMENT_TYPE VALUES ('FINAL PAYMENT');
INSERT INTO PAYMENT_TYPE VALUES ('FULL PAYMENT');
INSERT INTO PAYMENT_TYPE VALUES ('DEPOSIT');

COMMIT;

SELECT * FROM  PAYMENT_TYPE;

REM =========================== TAX TABLE ============================================

DROP TABLE tax CASCADE CONSTRAINTS PURGE;

CREATE TABLE TAX
         (tax_id     		NUMBER(3)
               constraint      tax_id_pk     primary key
               DEFERRABLE INITIALLY DEFERRED
    USING INDEX
               (CREATE INDEX tax_id_idx  ON  TAX(tax_id)
    TABLESPACE indx),
           tax_code   		VARCHAR2(10),
           tax_amount 		NUMBER(8,2),
           tax_description 	VARCHAR2(20),
           tax_year   		VARCHAR2(4))
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
DESC TAX

REM ================================= Only A simple Verification ================

CONN sys/oracle as sysdba

SELECT TABLE_NAME, TABLESPACE_NAME,OWNER FROM DBA_TABLES
 WHERE OWNER = 'TOWNER';

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
