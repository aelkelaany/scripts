--drop TABLE sybcert ;
CREATE TABLE sybcert
(
   sybcert_pidm            NUMBER (8) Primary Key,
   sybcert_print_cnt       NUMBER (3),
   sybcert_userid          VARCHAR2 (30),
   sybcert_activity_date   DATE
);
  
GRANT UPDATE, SELECT ON sybcert TO PUBLIC;
 
CREATE OR REPLACE PUBLIC SYNONYM sybcert FOR BU_APPS.sybcert;

 