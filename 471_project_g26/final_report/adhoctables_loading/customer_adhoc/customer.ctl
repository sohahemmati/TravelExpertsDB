--================================ CUSTOMER CONTROL FILE  ==============================

--sqlldr towner/travelxp456 control='C:\Users\Nick\Desktop\471project\adhoctables_loading\customer_adhoc\customer.ctl', log='C:\Users\Nick\Desktop\471project\adhoctables_loading\customer_adhoc\customer.log'

options(skip=1,direct=true) 
LOAD DATA
INFILE 'C:\Users\Nick\Desktop\471project\adhoctables_loading\customer_adhoc\customerData.csv'
BADFILE 'C:\Users\Nick\Desktop\471project\adhoctables_loading\customer_adhoc\customer.bad'
DISCARDFILE 'C:\Users\Nick\Desktop\471project\adhoctables_loading\customer_adhoc\customer.dsc'
TRUNCATE INTO TABLE customer_data
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS    
(cust_id			INTEGER EXTERNAL ,
fname		                CHAR ,
Lname			        CHAR ,
agent                           CHAR ,
email  				CHAR ,
home_phone 			CHAR ,  -- THE EXACT NUMBER OF HOME_PHONE MUST BE 10 BUT 2 RECORDS ARE MORE THEN 10
b_phone  			CHAR ,
birth_date  			DATE "DD/MM/YYYY",
address  			CHAR ,
city  				CHAR ,
postal_code  			CHAR ,
province 		        CHAR ,
country                         CHAR 
 )   


















