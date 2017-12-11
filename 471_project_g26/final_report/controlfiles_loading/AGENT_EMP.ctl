-- sqlldr towner/travelxp456 control=C:\Users\Nick\Desktop\471project\controlfiles_loading\agent_emp.ctl, log=C:\Users\Nick\Desktop\471project\controlfiles_loading\agent_emp.log


LOAD DATA

INFILE*
BADFILE 'C:\Users\Nick\Desktop\471project\controlfiles_loading\agent_emp.bad'
DISCARDFILE 'C:\Users\Nick\Desktop\471project\controlfiles_loading\agent_emp.dsc'

APPEND INTO TABLE agent_emp 

FIELDS TERMINATED BY "," OPTIONALLY ENCLOSED BY '"' 

TRAILING NULLCOLS

(emp_num          INTEGER EXTERNAL,
 emp_id     	  CHAR,
 emp_fname     	  CHAR,
 emp_lname	  CHAR,
 office_id	  INTEGER EXTERNAL)

BEGINDATA
1,JD,Janet,Delton,1
2,JL,Judy,Lisle,1
3,DR,Dennis C.,Reynolds,1
4,JC,John,Coville,1
5,JD,Janice W.,Dahl,1
6,BD,Bruce J.,Dixon,1
7,BJ,Beverly S.,Jones,1
8,JM,Jane,Merrill,1
9,BP,Brain S.,Peterson,1