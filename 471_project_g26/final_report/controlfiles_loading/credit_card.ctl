--sqlldr towner/travelxp456 control=C:\Users\Nick\Desktop\471project\controlfiles_loading\credit_card.ctl log=C:\Users\Nick\Desktop\471project\controlfiles_loading\credit_card.log

options(skip=1)
LOAD DATA 
INFILE 'C:\Users\Nick\Desktop\471project\controlfiles_loading\CARD1.csv'
badfile 'C:\Users\Nick\Desktop\471project\controlfiles_loading\credit_card.bad'
discardfile 'C:\Users\Nick\Desktop\471project\controlfiles_loading\credit_card_disc.dsc'
truncate
INTO TABLE credit_card
fields terminated by ',' optionally enclosed by '"'
TRAILING NULLCOLS
(customer_id		INTEGER EXTERNAL,
card_id		"credit_card_seq.nextval",
card_number		char,
card_type		char,
expiry_date		date "dd/mm/yyyy")


