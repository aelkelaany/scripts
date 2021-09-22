update   BU_APPS.WF_REQUEST_FLOW f 
 set    USER_PIDM =(SELECT  a.USER_PIDM 
       
  FROM users_attributes a, ROLE_USERS r
 WHERE     a.USER_PIDM = r.USER_PIDM
       AND ATTRIBUTE_CODE = 'DEPARTMENT'
       AND ACTIVE = 'Y'
       AND a.ROLE_CODE = r.ROLE_CODE
       AND r.ROLE_CODE = 'RO_DEPT_MANAGER'
       AND ATTRIBUTE_VALUE =(select item_value from request_details where request_no =f.request_no and SEQUENCE_NO=1 and item_code='DEPARTMENT' )  )
 
WHERE
 ACTION_CODE = 'HOLD'
   AND USER_PIDM = 167084
   and  ROLE_CODE='RO_DEPT_MANAGER'
 -- and f.request_no=309552 ;
  --and exists ( select '1' from request_details where request_no =f.request_no and SEQUENCE_NO=1 and item_code='DEPARTMENT' and item_value='1401')   
   
    
  
  
  ß
  
  
  
  select * from BU_APPS.WF_REQUEST_FLOW f 
WHERE
 ACTION_CODE = 'HOLD'
   AND USER_PIDM = 167084
  -- and  ROLE_CODE='RO_COLLEGE_DEAN'
    and f.request_no=173271 ;
  --and exists  (select '1' from request_details where request_no =f.request_no and SEQUENCE_NO=1 and item_code='DEPARTMENT' and item_value='1401')  
   
     and exists ( select '1' from request_details where request_no =f.request_no and SEQUENCE_NO=1 and item_code='COLLEGE_CODE'  ) 
     
     
     ;
     
     
     
     


update   BU_APPS.WF_REQUEST_FLOW f 
 set    USER_PIDM =( SELECT sirasgn_pidm
           FROM saturn.sirasgn
          WHERE     sirasgn_term_code =
                       (select item_value from request_details where request_no =f.request_no and SEQUENCE_NO=1 and item_code='TERM' )
                AND sirasgn_crn =(select item_value from request_details where request_no =f.request_no and SEQUENCE_NO=1 and item_code='CRN' ) 
                       
                AND sirasgn_primary_ind = 'Y'
        )
 
WHERE
 ACTION_CODE = 'HOLD'
 --  AND USER_PIDM = 167084
   and  ROLE_CODE='RO_INSTRUCTOR'
-- and f.request_no=149698 ;
  --and exists ( select '1' from request_details where request_no =f.request_no and SEQUENCE_NO=1 and item_code='DEPARTMENT' and item_value='1401')   
   
    ;;
    
    
    update   BU_APPS.WF_REQUEST_FLOW f 
 set    USER_PIDM =(SELECT  a.USER_PIDM 
       
  FROM users_attributes a, ROLE_USERS r
 WHERE     a.USER_PIDM = r.USER_PIDM
       AND ATTRIBUTE_CODE = 'COLLEGE'
       AND ACTIVE = 'Y'
       AND a.ROLE_CODE = r.ROLE_CODE
       AND r.ROLE_CODE = 'RO_COLLEGE_DEAN'
       AND ATTRIBUTE_VALUE =(select item_value from request_details where request_no =f.request_no and SEQUENCE_NO=1 and item_code='COLLEGE_CODE' )  )
 
WHERE
 ACTION_CODE = 'HOLD'
  AND USER_PIDM = 167084
   and  ROLE_CODE='RO_COLLEGE_DEAN'
 --  and f.request_no=306419  
   and exists ( select '1' from request_details where request_no =f.request_no and SEQUENCE_NO=1 and item_code='COLLEGE_CODE'  )   
   
    