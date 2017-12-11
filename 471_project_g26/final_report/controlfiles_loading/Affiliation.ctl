-- sqlldr towner/travelxp456 control=C:\Users\Nick\Desktop\471project\controlfiles_loading\affiliation.ctl, log=C:\Users\Nick\Desktop\471project\controlfiles_loading\affiliation.log 


LOAD DATA

INFILE*
BADFILE 'C:\Users\Nick\Desktop\471project\controlfiles_loading\affiliation.bad'
DISCARDFILE 'C:\Users\Nick\Desktop\471project\controlfiles_loading\affiliation.dsc'

TRUNCATE INTO TABLE affiliation

FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"' 

TRAILING NULLCOLS

(affiliation_code    		CHAR,
 affiliation_name   		CHAR)

BEGINDATA
ACTA,Association of Canadian Travel Agents
ACTANEW,	
ACTANEWP,	
ACTAPGY,	
NEW,	
NEWPGY,	
PGY,	
