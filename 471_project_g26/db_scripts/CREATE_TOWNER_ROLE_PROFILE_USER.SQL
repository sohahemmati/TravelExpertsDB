SET echo on
REM ==================================================================
REM ***************************** SOHA HEMMATI ***********************
REM ==================================================================



REM ================== INITIAL FORMAT SETTING ========================

SET PAGESIZE 40
SET LINESIZE 120
SET FEEDBACK ON
SET VERIFY ON

--TTITLE '********************* CREATE USER TABLE OWNER *************'
--BTITLE '*********************   By Soha Hemmati    ****************'


COL PROFILE FOR A20
COL RESOURCE_NAME FOR A30
COL LIMIT FOR A20
COL USERNAME FOR A20
COL ACCOUNT_STATUS FOR A20
COL PROFILE FOR A18
COL USERNAME FOR A10
COL ACCOUNT_STATUS FOR A16
COL DEFAULT_TABLESPACE FOR A20
COL TEMPORARY_TABLESPACE FOR A20
COL PROFILE FOR A20

REM ==================================== CREATE TABLE OWNER ROLE ==============================

DROP ROLE  towner_role;




CREATE ROLE towner_role;




SELECT	 * 
FROM 	DBA_ROLES
WHERE 	ROLE LIKE '%TOWNER%';



REM============================GRANT PRIVILEGES TO TOWNER ROLE===========================


Grant    CREATE SESSION        to towner_role;

Grant    CREATE TABLE          to towner_role;

Grant    CREATE CLUSTER        to towner_role;

Grant    CREATE SYNONYM        to towner_role;

Grant    CREATE VIEW           to towner_role;

Grant    CREATE SEQUENCE       to towner_role;

Grant    CREATE DATABASE LINK  to towner_role;

Grant    CREATE PROCEDURE      to towner_role;

Grant    CREATE TRIGGER        to towner_role;

Grant    CREATE TYPE           to towner_role;

Grant    CREATE OPERATOR       to towner_role;

Grant    CREATE INDEXTYPE      to towner_role;

Grant    BACKUP ANY TABLE      to towner_role;





SELECT 	* 
FROM 	ROLE_SYS_PRIVS
WHERE 	ROLE LIKE '%TOWNER%';



REM ====================== CREATE TABLE OWNER PROFILE ===================================


drop profile  towner_profile;



SHOW PARAMETER RESOURCE_LIMIT



ALTER SYSTEM SET RESOURCE_LIMIT = TRUE; 


REM " IN THE PFILE ADD [Resource_Limit=True] BECAUSE ABOVE STATEMENT ONLY CHANGE CURRENT SESSION. " 


SHOW PARAMETER RESOURCE_LIMIT


REM  RUN SCRIPT utlpwdmg.sql  from C:\oracle\product\11.2.0\dbhome_1\RDBMS\ADMIN

@C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\utlpwdmg.sql



CREATE PROFILE towner_profile LIMIT 
CPU_PER_SESSION 10000
CPU_PER_CALL 3000
CONNECT_TIME 480
IDLE_TIME 10
SESSIONS_PER_USER 4
LOGICAL_READS_PER_SESSION DEFAULT
LOGICAL_READS_PER_CALL 20000
COMPOSITE_LIMIT 5000000
PASSWORD_LIFE_TIME 30
PASSWORD_GRACE_TIME 5
PASSWORD_REUSE_MAX 10
PASSWORD_REUSE_TIME 60
PASSWORD_LOCK_TIME 5/1440
FAILED_LOGIN_ATTEMPTS 3
PASSWORD_VERIFY_FUNCTION verify_function_11g;



SELECT 	* 
FROM 	DBA_PROFILES
WHERE 	PROFILE LIKE '%TOWNER%';




REM =============================== CREATE TABLE_OWNER USER ===================================


DROP USER  towner;

CREATE USER 		towner
IDENTIFIED BY 		travelxp123
DEFAULT TABLESPACE 	user_data
TEMPORARY TABLESPACE 	temp
QUOTA 200M ON 		user_data
QUOTA 100M ON 		adhoc
QUOTA 50M  ON		indx
QUOTA 20M  ON		read_only
PASSWORD EXPIRE
ACCOUNT LOCK
PROFILE 		towner_profile;





SELECT 		USERNAME, ACCOUNT_STATUS, EXPIRY_DATE, DEFAULT_TABLESPACE,
		TEMPORARY_TABLESPACE,PROFILE, AUTHENTICATION_TYPE
FROM 		DBA_USERS
WHERE 		USERNAME='TOWNER';




SELECT 		TABLESPACE_NAME, USERNAME, MAX_BYTES 
FROM 		dba_ts_quotas;



CONN towner/travelxp123



ALTER USER TOWNER ACCOUNT UNLOCK;



CONN towner/travelxp123



show user



SELECT  * 
FROM 	session_privs;



conn sys/oracle as sysdba



SELECT     USERNAME,ACCOUNT_STATUS, LOCK_DATE, EXPIRY_DATE, CREATED
FROM       USER_USERS
WHERE      USERNAME='TOWNER';


SELECT 	USERNAME,ACCOUNT_STATUS, DEFAULT_TABLESPACE, TEMPORARY_TABLESPACE,PROFILE
FROM 	DBA_USERS 
WHERE	USERNAME='TOWNER';






REM ================================  GRANT TOWNER_ROLE TO USER ===========================

GRANT TOWNER_ROLE TO TOWNER;

SELECT 	* 
FROM 	ROLE_TAB_PRIVS
WHERE 	OWNER='TOWNER';

REM =================== CLEARING SETTING =============================== 

TTITLE OFF
BTITLE OFF
SET linesize 80
SET Long 80
SET FEEDBACK OFF
SET VERIFY OFF
SET ECHO OFF


SPOOL OFF