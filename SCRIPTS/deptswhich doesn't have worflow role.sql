 
  
 SELECT    DISTINCT  wf_rqst_items(B.REQUEST_NO,'DEPARTMENT_CODE')
          FROM request_master a, wf_request_flow b
         WHERE     a.request_no = b.request_no
               AND a.object_code = 'WF_WITHDRAW_COURSE'
               AND A.REQUEST_STATUS = 'P'
                and USER_PIDM is null 
and ROLE_CODE='RO_DEPT_MANAGER'
  AND   wf_rqst_items(B.REQUEST_NO,'DEPARTMENT_CODE') NOT IN  ( SELECT ATTRIBUTE_VALUE FROM USERS_ATTRIBUTES    WHERE ATTRIBUTE_CODE='DEPARTMENT' )                        
  
  request_details
  
  sfrstcr
  
  request_f