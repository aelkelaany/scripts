  delete 
    sgbstdn s1
      
       WHERE     s1.sgbstdn_pidm in ( SELECT A.REQUESTER_PIDM   FROM REQUEST_MASTER A ,REQUEST_DETAILS TERM ,WF_REQUEST_FLOW USERID
WHERE OBJECT_CODE='WF_UN_WITHDRAW'
AND REQUEST_STATUS='K'
AND A.REQUEST_NO=TERM.REQUEST_NO
AND TERM.SEQUENCE_NO=1
AND TERM.ITEM_CODE='WITHDRAW_TYPE'
AND TERM.ITEM_VALUE='��'
 
 AND USERID.REQUEST_NO=A.REQUEST_NO
 AND ROLE_CODE='RO_DAR_FILES'
 AND USER_PIDM=F_GET_PIDM('1063')
 AND USERID.ACTIVITY_DATE BETWEEN SYSDATE-3 AND SYSDATE)
 and sgbstdn_stst_code='��' ;

  update WF_REQUEST_FLOW 
 set USER_PIDM=''
 ,ACTION_CODE='' 
 where request_no in (

SELECT A.REQUEST_NO   FROM REQUEST_MASTER A ,REQUEST_DETAILS TERM ,WF_REQUEST_FLOW USERID
WHERE OBJECT_CODE='WF_UN_WITHDRAW'
AND REQUEST_STATUS='K'
AND A.REQUEST_NO=TERM.REQUEST_NO
AND TERM.SEQUENCE_NO=1
AND TERM.ITEM_CODE='WITHDRAW_TYPE'
AND TERM.ITEM_VALUE='��'
--AND F_GET_STATUS(REQUESTER_PIDM)='��' 
 AND USERID.REQUEST_NO=A.REQUEST_NO
 AND ROLE_CODE='RO_DAR_FILES'
 AND USER_PIDM=F_GET_PIDM('1063')
 AND USERID.ACTIVITY_DATE BETWEEN SYSDATE-3 AND SYSDATE
 
 
 ) 
 and ROLE_CODE='RO_DAR_FILES';
 
 
 update request_master 
 set REQUEST_STATUS='K'
 where request_no in (

SELECT A.REQUEST_NO   FROM REQUEST_MASTER A ,REQUEST_DETAILS TERM ,WF_REQUEST_FLOW USERID
WHERE OBJECT_CODE='WF_UN_WITHDRAW'
AND REQUEST_STATUS='C'
AND A.REQUEST_NO=TERM.REQUEST_NO
AND TERM.SEQUENCE_NO=1
AND TERM.ITEM_CODE='WITHDRAW_TYPE'
AND TERM.ITEM_VALUE='��'
--AND F_GET_STATUS(REQUESTER_PIDM)='��' 
 AND USERID.REQUEST_NO=A.REQUEST_NO
 AND ROLE_CODE='RO_DAR_FILES'
 AND USER_PIDM=F_GET_PIDM('1063')
 AND USERID.ACTIVITY_DATE BETWEEN SYSDATE-3 AND SYSDATE
 
 
 ) ;
 
   update request_master 
 set REQUEST_STATUS='P'
 where     
    REQUEST_STATUS='K'