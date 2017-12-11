-- sqlldr towner/travelxp456 control=C:\Users\Nick\Desktop\471project\controlfiles_loading\class_type.ctl, log=C:\Users\Nick\Desktop\471project\controlfiles_loading\class_type.log 


LOAD DATA

INFILE*
BADFILE 'C:\Users\Nick\Desktop\471project\controlfiles_loading\class_type.bad'
DISCARDFILE 'C:\Users\Nick\Desktop\471project\controlfiles_loading\class_type.dsc'

TRUNCATE INTO TABLE class_type

FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"' 

TRAILING NULLCOLS

(class_code    		CHAR,
 class_name   		CHAR)

BEGINDATA
FST,First Class
BSN,Business
ECN,Economy
OCNV,Ocean View
INT, Interior
DLX,Deluxe
DBL,Double
SNG,Single
