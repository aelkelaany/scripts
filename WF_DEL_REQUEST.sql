exec p_Delete_wf('401222') ;
select f_get_pidm('2233') from  dual ;
SGAASST
   -----------------------------cancel rejection   
update wf_request_flow f
set ACTION_CODE='',
NOTES=''
where 
request_no=420235 
and ACTION_CODE like '%REJECT%' 
and SEQUENCE_NO=(select max(SEQUENCE_NO)
from wf_request_flow
where request_no=f.request_no)  ;

update request_master set REQUEST_STATUS='P'
where REQUEST_NO=420235 
and REQUEST_STATUS='R' ;

update wf_request_flow
set user_pidm =67800

where 
request_no=356530 
AND ROLE_CODE = 'RO_GRADE_CHANGE' ; 

 

 









------------------------------------------------------
--------------------------------------------------Reject request

update wf_request_flow f
set ACTION_CODE='FR_REJECT_REQUEST',
NOTES='����� �� ���� ����� ���� ���� ���� ��������' ,USER_PIDM=0 ,USER_ID='BU_APPS' ,ACTIVITY_DATE=sysdate
where 
request_no in ( select request_no from request_master where  REQUEST_STATUS='P'
and OBJECT_CODE='WF_TRANSFER' )
and ACTION_CODE is null  ;



update request_master set REQUEST_STATUS='R' ,USER_ID='BU_APPS' ,ACTIVITY_DATE=sysdate
where REQUEST_STATUS='P'
and OBJECT_CODE='WF_TRANSFER'    ;


