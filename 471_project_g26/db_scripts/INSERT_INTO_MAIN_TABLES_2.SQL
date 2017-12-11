SET echo on
REM ==================================================================
REM ***************************** SOHA HEMMATI ***********************
REM ==================================================================



REM ================== INITIAL FORMAT SETTING ========================

SET PAGESIZE 30
SET LINESIZE 150
SET FEEDBACK ON
SET VERIFY ON

--TTITLE '********************* INSERT DATA INTO TRAVELXP TABLES(MAIN TABLES) *********************'
--BTITLE '************************************   By Soha Hemmati    *******************************'


COL AGENT_ADDRESS FOR A30
COL AGENT_NAME FOR A15
COL TABLE_NAME FOR A20
COL TABLESPACE_NAME FOR A20
COL OWNER FOR A20
col CARD_NUMBER for 9999999999999999
COL CUSTOMER_FNAME FOR A15
COL CUSTOMER_LNAME FOR A15
COL CUSTOMER_EMAIL FOR A25
COL CUSTOMER_EMAIL HEADING 'EMAIL'
COL CUSTOMER_FNAME HEADING 'FNAME'
COL CUSTOMER_LNAME HEADING 'LNAME'
COL customer_birth_date HEADING 'BIRTH_DATE'
COL CUSTOMER_DEPENDENT HEADING 'DEPENDENT'
COL CUSTOMER_HOME_PHONE HEADING  'H_PHONE'
COL CUSTOMER_BUSINESS_PHONE HEADING  'B_PHONE'
COL CUSTOMER_ADDRESS HEADING 'ADDRESS'
COL CUSTOMER_ZIPCODE HEADING 'ZIPCODE'
COL CUSTOMER_CITY HEADING 'CITY'
COL CUSTOMER_PROVINCE HEADING 'PROVINCE'
COL CUSTOMER_COUNTRY HEADING 'COUNTRY'
COL CUSTOMER_ADDRESS FOR A31
COL CUSTOMER_PROVINCE FOR A15
COL CUSTOMER_COUNTRY FOR A15
COL SUPPLIER_NAME FOR A25
COL SUPPLIER_COMPANY_NAME FOR A28
COL supplier_company_name FOR A35
COL SUPPLIER_COUNTRY FOR A10
COL SUPPLIER_PROVINCE FOR A10
COL SUPPLIER_PROVINCE HEADING 'PROVINCE'
COL SUPPLIER_COUNTRY HEADING 'COUNTRY'
COL REPRESENTATIVE FOR A25
COL SUPPLIER_WEBSITE FOR A35
COL SUPPLIER_EMAIL FOR A35

CONN towner/travelxp456

REM ========================== CUSTOMER TABLE =============================

INSERT INTO CUSTOMER
               (customer_id,
                customer_fname,
                customer_lname,
                customer_birth_date,
                customer_email,
                customer_home_phone,
                customer_business_phone,
                customer_address,
                customer_city,
		customer_zipcode,
		customer_province,
		customer_country
		)
SELECT
              cust_id,
              fname,
              Lname,
              birth_date,
              email,
              home_phone,
              b_phone,
              address,
	      city,
	      postal_code,
	      province,
	      country
FROM CUSTOMER_DATA;

Commit;

REM *** Because of the many number of columns I could not print the result of query in on line so I devide the query in two steps:

SELECT	 CUSTOMER_ID, CUSTOMER_FNAME, CUSTOMER_LNAME, CUSTOMER_BIRTH_DATE,
	 CUSTOMER_EMAIL, CUSTOMER_HOME_PHONE, CUSTOMER_BUSINESS_PHONE
FROM     CUSTOMER
WHERE    rownum <=10
ORDER BY CUSTOMER_ID;

SELECT	 CUSTOMER_ID, CUSTOMER_ADDRESS, CUSTOMER_ZIPCODE,CUSTOMER_CITY, CUSTOMER_PROVINCE,
	 CUSTOMER_COUNTRY
FROM     CUSTOMER
where rownum <=10
ORDER BY CUSTOMER_ID;

SELECT COUNT(*) FROM CUSTOMER;

REM========================== CREDIT_CARD TABLE ============================

TRUNCATE TABLE CREDIT_CARD;

DROP SEQUENCE credit_card_seq;

CREATE SEQUENCE credit_card_seq
START WITH 1
MAXVALUE   10000
INCREMENT BY 1
NOCACHE
NOCYCLE;

REM   I used control file for loading data to this table.

select * from credit_card  where rownum <=10;

select count(*) from credit_card;


REM============================== REWARD TABLE ==============================

DROP SEQUENCE reward_seq;

CREATE SEQUENCE reward_seq
START WITH 1
MAXVALUE   10000
INCREMENT BY 1
NOCACHE
NOCYCLE;

truncate table reward;

insert into reward values(reward_seq.nextval,'AC-154334165','Aeroplan', 302);

insert into reward values(reward_seq.nextval,'875 443 132','Marriott  Rewards',302);

insert into reward values(reward_seq.nextval,'AC-154334164','Aeroplan',280);

select * from reward;

select count(*) from reward;
commit;

REM ============================ ITINERARY_INVOICE TABLE =============================

INSERT INTO itin_invoice
             (itin_invc_id,
	     itin_invc_no,
	     itin_invc_date,
	     no_of_traveller,
	     billed_amount,
	     pay_type)
SELECT
             itinerary_id,
	     itinerary_num,
	     billing_date,
	     num_of_travelers,
	     billed_amt,
	     bill_description
FROM sale_data;

commit;

select * from itin_invoice  where rownum <=10;

select count(*) from itin_invoice;

REM *** I added sequence numbers(1-1341) in sale excel sheet and next sequence will create by  
REM *** following sequence


DROP SEQUENCE    itin_invoice_seq;

CREATE SEQUENCE  itin_invoice_seq
START WITH 1342
MAXVALUE   10000
INCREMENT BY 1
NOCACHE
NOCYCLE;


REM ============================ BOOKING TABLE =================================

REM ********************* PREPARING BEFORE INSERTING DATA TO BOOKING ***********************

update sale_data
set emp_num = 1
where agent = 'JD';

update sale_data
set emp_num = 2
where agent = 'JL';

update sale_data
set emp_num = 3
where agent = 'DR';

update sale_data
set emp_num = 4
where agent = 'JC';

update sale_data
set emp_num = 5
where agent = 'JD';

update sale_data
set emp_num = 6
where agent = 'BD';

update sale_data
set emp_num = 7
where agent = 'BJ';

update sale_data
set emp_num = 8
where agent = 'JM';

update sale_data
set emp_num = 9
where agent = 'BP';

COMMIT;

SELECT emp_num,agent from sale_data where rownum<=10;

SELECT distinct  emp_num,agent from sale_data where emp_num is null;

SELECT distinct  emp_num,agent from sale_data where emp_num is null;

select count(*) from sale_data where emp_num is null;

select count(*) from sale_data where agent is null;


REM************************ NOW INSERT DATA TO BOOKING TABLE***********************

TRUNCATE TABLE booking;

INSERT INTO booking
             (booking_id,
             booking_no,
             booking_date,
             trip_start_date,
	     trip_end_date,
	     destination_desc,
	     destination_code,
	     itin_invc_id,
	     emp_num
             )
SELECT
             booking_id,
             booking_num,
             sale,
             trip_start,
	     trip_end,
	     destination,
	     dest_id,
	     itinerary_id,
	     emp_num
FROM sale_data;

commit;

REM I find 2 rows which their dest_id were wrong then I flag them as incorrect data and update them.

update sale_data
set DEST_ID = 'SP'
where DEST_ID = 'SPCF';

commit;

select * from BOOKING where rownum <=10;

select count(*) from BOOKING;

REM ============================ TRAVELLER TABLE  ===========================

TRUNCATE TABLE traveller;

INSERT INTO  traveller select cust_id,booking_id from sale_data;

commit;

select * from traveller where rownum <=5;

select count(*) from traveller;

REM======================== SUPPLIER TABLE =================================
TRUNCATE TABLE SUPPLIER;


DROP SEQUENCE supplier_seq;

CREATE SEQUENCE supplier_seq
   START WITH 1
   MAXVALUE   10000
   INCREMENT BY 1
   NOCACHE
   NOCYCLE;

INSERT INTO supplier
             (supplier_id,
             supplier_num,
             supplier_name,
             supplier_company_name,
             supplier_office,
             supplier_phone,
             supplier_fax,
             supplier_address1,
             supplier_address2,
             supplier_zipcode,
	     supplier_city,
	     supplier_province,
	     supplier_country,
             supplier_email,
             supplier_website,
             representative,
             affiliation_code
             )
SELECT
              supplier_seq.nextval,
              product_supplier,
              Contact_Name,
              company,
              supplier_office,
              PHONE,
              fax,
              address1,
              address2,
              zip_postal,
	      city,
	      prov_state,
	      country,
              email,
              web,
              represents,
              affiliation
FROM supplier_data;

commit;

SELECT COUNT(*) FROM SUPPLIER;

SELECT          SUPPLIER_ID, SUPPLIER_NUM, SUPPLIER_NAME, SUPPLIER_COMPANY_NAME,
               SUPPLIER_OFFICE, SUPPLIER_PHONE
  FROM         SUPPLIER
  WHERE        SUPPLIER_ID <=10
  ORDER BY     SUPPLIER_ID;



SELECT      SUPPLIER_ID,SUPPLIER_FAX, SUPPLIER_address1, SUPPLIER_address2, 	    SUPPLIER_ZIPCODE
FROM        SUPPLIER
WHERE       SUPPLIER_ID <=10
ORDER BY    SUPPLIER_ID;



SELECT      SUPPLIER_ID,SUPPLIER_CITY, SUPPLIER_PROVINCE, SUPPLIER_COUNTRY, 	    SUPPLIER_EMAIL
FROM        SUPPLIER
WHERE       SUPPLIER_ID <=10
ORDER BY    SUPPLIER_ID;


SELECT       SUPPLIER_ID, SUPPLIER_WEBSITE, REPRESENTATIVE, AFFILIATION_CODE
FROM         SUPPLIER
WHERE        SUPPLIER_ID <=10
ORDER BY     SUPPLIER_ID;



REM =========================== PRODUCT ==============================

REM *************************** DATA PREPARING ****************************

/*    For insert data into product_sold table I need to update the product_category and
      product_supplier_id columns in sale_data table in adhoc .*/




select * from product_category;


select product_category from sale_data
where product_category < 100
or   product_category > 649;


REM   There is a row that is less than 100 it will violent my constraint then 
REM   I have to delete this row and flag it as a incorrect data to show to client.


Delete from sale_data
Where  product_category=35;

COMMIT;

select distinct product_category from sale_data
order by product_category;


update sale_data
set product_category = 1
where product_category between 100 and 149;

update sale_data
set product_category = 2
where product_category between 150 and 199;

update sale_data
set product_category = 3
where product_category between 200 and 249;

update sale_data
set product_category = 4
where product_category between 250 and 299;

update sale_data
set product_category = 5
where product_category  between 300 and 349;

update sale_data
set product_category = 6
where product_category between 350 and 399;

update sale_data
set product_category = 7
where product_category between 400 and 449;

update sale_data
set product_category = 8
where product_category between 450 and 499;

update sale_data
set product_category = 9
where product_category between 500 and 549;

update sale_data
set product_category = 10
where product_category between 550 and 599;

update sale_data
set product_category = 11
where product_category between 600 and 649;


COMMIT;


REM  Also I need to update product_supplier_id column in sale_data in adhoc WITH SUPPLIER_ID in
REM  SUPPLIER table. 


--1

update sale_data
set product_supplier_id = 1
where product_supplier_id = 12;

--3 rows updated.

--2
update sale_data
set product_supplier_id = 2
where product_supplier_id = 30
/
--3
update sale_data
set product_supplier_id = 3
where product_supplier_id = 37
/

.
.
.
.
--168
update sale_data
set product_supplier_id = 1187
where product_supplier_id = 13554
/
--169
update sale_data
set product_supplier_id = 1191
where product_supplier_id = 13590
/
--170
update sale_data
set product_supplier_id = 1193
where product_supplier_id = 13596
/

update sale_data
set product_supplier_id = 150
where product_supplier_id =1194 
/
commit;

INSERT INTO product
             (product_id,
             booking_id,
             product_name,
             prod_start_date,
             prod_end_date,
             prod_description,
             prod_base_price,
	     class_code,
             prod_cat_id)
SELECT
              product_id,
	      booking_id,
              product,
              trip_start,
              trip_end,
              description,
              base_price,
	      class,
	      product_category
FROM sale_data;

commit;

SELECT       PRODUCT_ID, BOOKING_ID,SUPPLIER_ID, PROD_NAME,PROD_START_DATE,PROD_END_DATE
FROM 	     PRODUCT
WHERE        rownum <=10;

SELECT       PRODUCT_ID, PROD_DESCRIPTION,PROD_BASE_PRICE,CLASS_CODE,
	     PROD_CAT_ID,TAX_ID 
FROM 	     PRODUCT
WHERE        rownum <=10;

===========================  Supplier_Product Table ===================================

TRUNCATE TABLE  Supplier_Product

INSERT INTO supplier_product
                     (product_id,
                      booking_id,
                      supplier_id,
                      booking_num)
SELECT
                      product_id,
                      booking_id,
                      product_supplier_id,
                      booking_num
FROM sale_data;


select count(*) from supplier_product;


select * from supplier_product
    where rownum<10;

REM =========================== TAX TABLE ============================================

REM I don't have data related to tax but I insert one record as an example:

TRUNCATE TABLE TAX ;

DROP SEQUENCE tax_seq;

CREATE SEQUENCE tax_seq
START WITH 1
MAXVALUE   10000
INCREMENT BY 1
NOCACHE
NOCYCLE;

INSERT INTO tax
VALUES       (tax_seq.nextval,'GST', 0.5,'EXAMPLE','2010');


COMMIT;

SELECT * FROM TAX;


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