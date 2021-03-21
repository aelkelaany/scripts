SELECT username, account_status, created, nvl(trim(GURLOGN_FIRST_NAME||' '||GURLOGN_last_NAME),'€Ì— „ «Õ') emp_name, lock_date
  FROM  dba_users,GURLOGN
 WHERE account_status not like '%LOCKED%'
 AND GURLOGN_USER=username
 --order by lock_date
-- and lock_date is null
 
 AND EXISTS (
 SELECT 'X' FROM GOVUROL2
 WHERE  GOVUROL2_USERID=username
 AND  GOVUROL2_SECURITY_CLASS not like 'BU%'
 )
 
 
 