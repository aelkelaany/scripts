select   REQUEST_NO from request_details dept
where    dept.ITEM_CODE LIKE '%DEPARTMENT%'
and dept.item_value!='1607' 

and exists (select '1' from request_master where request_no=dept.request_no and object_code='WF_REG_MAINTAIN') 

AND EXISTS (
select '1' from request_details PIDM
where 
PIDM.REQUEST_NO=DEPT.REQUEST_NO
AND PIDM.SEQUENCE_NO=DEPT.SEQUENCE_NO
AND   PIDM.ITEM_CODE LIKE '%STUDENT_PIDM%'
and F_GET_DEPT(PIDM.item_value) ='1607' 
 
)

AND EXISTS (

select '1' from request_details TERM
where 
TERM.REQUEST_NO=DEPT.REQUEST_NO
AND TERM.SEQUENCE_NO=DEPT.SEQUENCE_NO
AND   TERM.ITEM_CODE LIKE '%TERM%'
and TERM.item_value='144510' 

)
ORDER BY 1
;

UPDATE request_details SET ITEM_VALUE='16'
WHERE ITEM_CODE='COLLEGE'
AND REQUEST_NO IN (
select   REQUEST_NO from request_details dept
where    dept.ITEM_CODE LIKE '%DEPARTMENT%'
and dept.item_value!='1607' 

and exists (select '1' from request_master where request_no=dept.request_no and object_code='WF_REG_MAINTAIN') 

AND EXISTS (
select '1' from request_details PIDM
where 
PIDM.REQUEST_NO=DEPT.REQUEST_NO
AND PIDM.SEQUENCE_NO=DEPT.SEQUENCE_NO
AND   PIDM.ITEM_CODE LIKE '%STUDENT_PIDM%'
and F_GET_DEPT(PIDM.item_value) ='1607' 
 
)

AND EXISTS (

select '1' from request_details TERM
where 
TERM.REQUEST_NO=DEPT.REQUEST_NO
AND TERM.SEQUENCE_NO=DEPT.SEQUENCE_NO
AND   TERM.ITEM_CODE LIKE '%TERM%'
and TERM.item_value='144510' 

)

)
;
--------------------------------** DEPT

UPDATE request_details SET ITEM_VALUE='1607'
WHERE ITEM_CODE='DEPARTMENT'
AND REQUEST_NO IN (
select   REQUEST_NO from request_details dept
where    dept.ITEM_CODE LIKE '%DEPARTMENT%'
and dept.item_value!='1607' 

and exists (select '1' from request_master where request_no=dept.request_no and object_code='WF_REG_MAINTAIN') 

AND EXISTS (
select '1' from request_details PIDM
where 
PIDM.REQUEST_NO=DEPT.REQUEST_NO
AND PIDM.SEQUENCE_NO=DEPT.SEQUENCE_NO
AND   PIDM.ITEM_CODE LIKE '%STUDENT_PIDM%'
and F_GET_DEPT(PIDM.item_value) ='1607' 
 
)

AND EXISTS (

select '1' from request_details TERM
where 
TERM.REQUEST_NO=DEPT.REQUEST_NO
AND TERM.SEQUENCE_NO=DEPT.SEQUENCE_NO
AND   TERM.ITEM_CODE LIKE '%TERM%'
and TERM.item_value='144510' 

)

)
