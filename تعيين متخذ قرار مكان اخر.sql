declare 
 old_id varchar2(8):='3109' ;
 new_id varchar2(8):='3659';
begin 

update BU_APPS.ROLE_USERS
set USER_PIDM=f_get_pidm(new_id)
where USER_PIDM=f_get_pidm(old_id);

update USERS_ATTRIBUTES
set USER_PIDM=f_get_pidm(new_id)
where USER_PIDM=f_get_pidm(old_id);


update wf_request_flow
set USER_PIDM=f_get_pidm(new_id)
where USER_PIDM=f_get_pidm(old_id)
and ACTION_CODE is null   ;

end ; 
SELECT * FROM REQUEST_MASTER
WHERE REQUEST_NO IN (SELECT REQUEST_NO FROM   wf_request_flow
 
where USER_PIDM=f_get_pidm('3109')
and ACTION_CODE is null     )  ;


SELECT m.REQUEST_NO,   OBJECT_CODE, REQUEST_STATUS ,ROLE_CODE, USER_PIDM,f_get_std_id(USER_PIDM),f_get_std_name(user_pidm), ACTION_CODE, NOTES FROM REQUEST_MASTER m ,wf_request_flow f
WHERE m.REQUEST_NO =f.REQUEST_NO     
 
and 
 ACTION_CODE is null 
--and USER_PIDM=f_get_pidm('3109')  
   
and exists (select '1' from request_details where request_no=m.request_no
and item_code like '%DEPARTMENT%'
and item_value=:dept)  ;
