--============================ SUPPLIER_DATA CONTROL FILE ======================================

--sqlldr towner/travelxp456 control='C:\Users\Nick\Desktop\471project\adhoctables_loading\supplier_data_adhoc\supplier_data.ctl' log='C:\Users\Nick\Desktop\471project\adhoctables_loading\supplier_data_adhoc\supplier_data.log'

options(skip=1,direct=true) 
LOAD DATA
INFILE 'C:\Users\Nick\Desktop\471project\adhoctables_loading\supplier_data_adhoc\SupplierData.csv'
BADFILE 'C:\Users\Nick\Desktop\471project\adhoctables_loading\supplier_data_adhoc\SupplierData.bad'
DISCARDFILE 'C:\Users\Nick\Desktop\471project\adhoctables_loading\supplier_data_adhoc\SupplierData.dsc'
TRUNCATE INTO TABLE supplier_data
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS    
(product_supplier		INTEGER EXTERNAL,
product_category		INTEGER EXTERNAL,
supplier_office                 CHAR,
product_description		CHAR,
Contact_Name		        CHAR,
company				CHAR,
address1			CHAR,
address2			CHAR,
city  				CHAR,
prov_state			CHAR,
zip_postal			CHAR,
country                         CHAR,
phone  				CHAR,
fax	  			CHAR,
email				CHAR,
web				CHAR,
represents			CHAR,
affiliation			CHAR)

















