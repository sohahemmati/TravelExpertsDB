-- sqlldr towner/travelxp456 control=C:\Users\Nick\Desktop\471project\controlfiles_loading\prod_cat.ctl, log=C:\Users\Nick\Desktop\471project\controlfiles_loading\prod_cat.log 


LOAD DATA

INFILE 	 'C:\Users\Nick\Desktop\471project\controlfiles_loading\prod_cat.cvs'
BADFILE 'C:\Users\Nick\Desktop\471project\controlfiles_loading\prod_cat.bad'
DISCARDFILE 'C:\Users\Nick\Desktop\471project\controlfiles_loading\prod_cat.dsc'

TRUNCATE INTO TABLE product_category

FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"' 

TRAILING NULLCOLS

(product_cat_id    		INTEGER EXTERNAL,
 product_cat_name     		CHAR,
 product_cat_min_range     	INTEGER EXTERNAL,
 product_cat_max_range		INTEGER EXTERNAL
 )


