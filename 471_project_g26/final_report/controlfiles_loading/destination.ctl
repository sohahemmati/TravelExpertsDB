-- sqlldr towner/travelxp456 control=C:\Users\Nick\Desktop\471project\controlfiles_loading\destination.ctl, log=C:\Users\Nick\Desktop\471project\controlfiles_loading\destination.log 


LOAD DATA

INFILE*
BADFILE 'C:\Users\Nick\Desktop\471project\controlfiles_loading\destination.bad'
DISCARDFILE 'C:\Users\Nick\Desktop\471project\controlfiles_loading\destination.dsc'

TRUNCATE INTO TABLE DESTINATION

FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"' 

TRAILING NULLCOLS

(destination_code	  CHAR,
 destination_name     	  CHAR)
 

BEGINDATA
MED,Mediterranean
ANZ,Australia & New Zealand
AFR,Africa
ASIA,Asia
SA,South America
EU,Europe & United Kingdom
MEAST,Middle East
SP,South Pacific
NA,North America
OTHR,Other