exec p_Delete_wf('231890') ;

   -----------------------------cancel rejection   
update wf_request_flow f
set ACTION_CODE='',
NOTES=''
where 
request_no=233223
and ACTION_CODE like '%REJECT%' 
and SEQUENCE_NO=(select max(SEQUENCE_NO)
from wf_request_flow
where request_no=f.request_no)  ;

update request_master set REQUEST_STATUS='P'
where REQUEST_NO=233223
and REQUEST_STATUS='R' ;
------------------------------------------------------
--------------------------------------------------Reject request

update wf_request_flow f
set ACTION_CODE='FR_REJECT_REQUEST',
NOTES='‰⁄ –— ⁄‰ ﬁ»Ê· «·ÿ·» ·⁄œ„  Õﬁﬁ ‘—Êÿ «·„›«÷·…' ,USER_PIDM=0 ,USER_ID='BU_APPS' ,ACTIVITY_DATE=sysdate
where 
request_no in ( select request_no from request_master where  REQUEST_STATUS='P'
and OBJECT_CODE='WF_TRANSFER' )
and ACTION_CODE is null  ;



update request_master set REQUEST_STATUS='R' ,USER_ID='BU_APPS' ,ACTIVITY_DATE=sysdate
where REQUEST_STATUS='P'
and OBJECT_CODE='WF_TRANSFER'    ;


