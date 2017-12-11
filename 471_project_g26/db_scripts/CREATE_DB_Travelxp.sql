REM ==================================================================
REM ************************** SOHA HEMMATI **************************
REM ==================================================================


REM ================== INITIAL FORMAT SETTING ========================
 
 SET PAGESIZE 45
 SET LINESIZE 100
 SET FEEDBACK ON
 SET VERIFY ON
 
 --TTITLE '************** CREATE DATABASE TRAVEL EXPERT ***********'
 --BTITLE '********************* By Soha Hemmati **********************'
 
 
 COLUMN name FORMAT A15
 COLUMN user FORMAT A15
 COL USERNAME FOR A20
 COL PASSWORD FOR A15
 COL DEFAULT_TABLESPACE FOR A20
 COL TEMPORARY_TABLESPACE FOR A20
 COL FILE_NAME FOR A30

REM********************* CREATE DATABASE TRAVEL EXPERT ********************

connect sys/us as sysdba

startup nomount pfile="C:\Travelxp\C\Pfiles\initTravel.ora";

select instance_name,status,database_status, active_state from v$instance;


CREATE DATABASE Travelxp
MAXINSTANCES 1
MAXLOGHISTORY 1
MAXLOGFILES 12
MAXLOGMEMBERS 3
MAXDATAFILES 100
DATAFILE
 	'c:\Travelxp\system01.dbf' SIZE 1G
 	AUTOEXTEND ON NEXT 10M MAXSIZE 3G
SYSAUX
	 DATAFILE 'c:\Travelxp\D\sysaux01.dbf' SIZE 1G
 	 AUTOEXTEND ON NEXT 5M MAXSIZE 2G
DEFAULT TEMPORARY TABLESPACE
	 TEMP TEMPFILE 'c:\Travelxp\D\Temp01.TMP' SIZE 20M
 	 AUTOEXTEND ON NEXT 1024K MAXSIZE 500M
UNDO TABLESPACE "UNDOTBS1"
	DATAFILE 'c:\TRAVELXP\G\undotbs01.dbf' SIZE 1GM
 	AUTOEXTEND ON NEXT 1024K MAXSIZE 2G
CHARACTER SET WE8MSWIN1252
NATIONAL CHARACTER SET US7ASCII
LOGFILE GROUP 1 ('c:\Travelxp\c\Travel01a.log', 'c:\Travelxp\D\Travel01b.log',
		 'c:\Travelxp\E\Travel01c.log') SIZE 5M ,
        GROUP 2 ('c:\Travelxp\C\Travel02a.log', 'c:\Travelxp\D\Travel02b.log',
		 'c:\Travelxp\E\Travel02c.log') SIZE 5M ,
        GROUP 3 ('c:\Travelxp\C\Travel03a.log', 'c:\Travelxp\D\Travel03b.log',
		 'c:\Travelxp\E\Travel03c.log') SIZE 5M 

USER SYS IDENTIFIED BY "oracle"
USER SYSTEM IDENTIFIED BY "oracle";


REM****************** RUN Catalog and Catproc and Pupbld SCRIPT *******************


@C:\oracle\ora11\rdbms\admin\catalog.sql

DESC DBA_USERS



@C:\oracle\ora11\rdbms\admin\catproc.sql


SELECT dbms_registry_sys.time_stamp('CATPROC') AS timestamp FROM DUAL;



connect system/oracle

@C:\oracle\ora11\sqlplus\admin\pupbld.sql


select program from v$session;



REM*********************** VERIFY DATABASE TRAVEL EXPERT  ********************

select NAME,CREATED,log_mode, open_mode, user from v$database;

select instance_name,status,database_status, active_state from v$instance;



select name from v$controlfile;

SELECT FILE_NAME, TABLESPACE_NAME, STATUS, ONLINE_STATUS FROM DBA_DATA_FILES; 

select member from v$logfile;

select name from v$tempfile;



show parameter db_create
show parameter db_block_size
show parameter db_cache_size
show parameter compatible
show parameter log_buffer
show parameter memory_target
show parameter undo_management
show parameter undo_tablespace

REM*********************** CREATE ADDITIONAL TABLESPACES  ********************


DROP TABLESPACE ADHOC
INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;




SELECT             TABLESPACE_NAME, EXTENT_MANAGEMENT
FROM               DBA_TABLESPACES;



CREATE TABLESPACE ADHOC
DATAFILE 	'C:\Travelxp\E\ADHOC01.DBF' SIZE 100M
		AUTOEXTEND ON NEXT 10M MAXSIZE 300M
EXTENT 	MANAGEMENT DICTIONARY
DEFAULT STORAGE
(initial 10M NEXT 10M MINEXTENTS 2 MAXEXTENTS 100 PCTINCREASE 0);



CREATE TABLESPACE INDX
DATAFILE 	'C:\Travelxp\E\INDX01.DBF' SIZE 200M
		AUTOEXTEND ON NEXT 5M MAXSIZE 350M;


CREATE TABLESPACE USER_DATA
DATAFILE 	'C:\Travelxp\E\UserData01.DBF' SIZE 100M
		AUTOEXTEND ON NEXT 5M MAXSIZE 300M;

ALTER DATABASE DEFAULT TABLESPACE user_data;


CREATE TABLESPACE READ_ONLY
DATAFILE 	'C:\Travelxp\D\Read_Only01.DBF' SIZE 29M
		AUTOEXTEND ON NEXT 5M MAXSIZE 40M;




SELECT             TABLESPACE_NAME, EXTENT_MANAGEMENT, INITIAL_EXTENT,
               	   NEXT_EXTENT, MIN_EXTENTS, MAX_EXTENTS, MAX_SIZE, PCT_INCREASE
FROM               DBA_TABLESPACES;


SELECT TABLESPACE_NAME,FILE_NAME,STATUS FROM DBA_DATA_FILES;


select name from v$tempfile;


SELECT PROPERTY_NAME, PROPERTY_VALUE FROM DATABASE_PROPERTIES;



REM***************************** CREATE DBA USER ***************************


DROP USER agency CASCADE
/

CREATE USER agency 
IDENTIFIED BY agency 
DEFAULT TABLESPACE USER_DATA
QUOTA 20m ON USER_DATA
TEMPORARY TABLESPACE temp
QUOTA 5m ON system

/

GRANT DBA TO agency;
/

connect agency/agency 

SHOW user


SELECT    USERNAME, PASSWORD,DEFAULT_TABLESPACE, TEMPORARY_TABLESPACE
FROM 	  DBA_USERS;

REM*********************** CREATE SPFILE FROM PFILE ************************



CONN sys/oracle as sysdba



CREATE spfile
FROM	pfile= 'C:\Travelxp\C\Pfiles\initTravel.ora';


SHUTDOWN IMMEDIATE


STARTUP


SELECT NAME, TYPE, VALUE FROM V$PARAMETER
WHERE NAME LIKE  '%spfile%';




 REM ==================CLEARING SETTING ===============================
 
 TTITLE OFF
 BTITLE OFF
 SET linesize 80
 SET Long 80
 SET FEEDBACK OFF
 SET VERIFY OFF
 SET ECHO OFF
