declare 
 old_id varchar2(8):='5844' ;
 new_id varchar2(8):='5579';
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
 
where USER_PIDM=f_get_pidm('5844')
and ACTION_CODE is null     ) 



