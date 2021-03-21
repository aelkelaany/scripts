DECLARE 
CURSOR GET_REQUESTS IS 
SELECT DISTINCT m.request_no REQ_NO
        FROM request_master m, wf_request_flow f
       WHERE     m.request_no = f.request_no
             AND object_code = 'WF_REG_MAINTAIN'
             AND m.request_status = 'P'
             AND F.FLOW_SEQ =4
             AND USER_PIDM =f_get_pidm('6603')
             AND ACTION_CODE IS NULL 
             and rownum<=5
             ORDER BY 1 ASC
           ;
           BEGIN
           
           FOR REC IN GET_REQUESTS
           LOOP
           UPDATE wf_request_flow
           SET USER_PIDM=f_get_pidm('2521')
           WHERE 
           REQUEST_NO=REC.REQ_NO 
           AND FLOW_SEQ = 4
           --AND  USER_PIDM IS NULL
             AND ACTION_CODE IS NULL ;
             
           END LOOP ; 
           END ; 
           
             UPDATE wf_request_flow
           SET USER_PIDM=NULL
           WHERE 
            ACTION_CODE IS NULL 
            AND  USER_PIDM IN(235905,
235906,
235907,
235908,
235909
) 

and rownum<21
              ; 
           
           
            
              
               SELECT COUNT (DISTINCT B.REQUEST_NO) ,f_get_STD_ID(b.user_pidm) EMPLOYEE_ID ,f_get_STD_NAME(b.user_pidm) EMPLOYEE_NAME ,b.user_pidm PIDM 
          FROM request_master a, wf_request_flow b
         WHERE     a.request_no = b.request_no
               AND a.object_code = 'WF_REG_MAINTAIN'
                AND A.REQUEST_STATUS = 'P'
                 
               AND B.FLOW_SEQ = (SELECT MAX (FLOW_SEQ)
                                      FROM wf_request_flow
                                     WHERE request_no = B.REQUEST_NO)
               AND  B.FLOW_SEQ = 4 
              GROUP BY b.user_pidm ;
              
              
              SELECT COUNT (DISTINCT B.REQUEST_NO) ,f_get_STD_ID(b.user_pidm) EMPLOYEE_ID ,f_get_STD_NAME(b.user_pidm) EMPLOYEE_NAME ,b.user_pidm PIDM 
          FROM request_master a, wf_request_flow b
         WHERE     a.request_no = b.request_no
               AND a.object_code = 'WF_REG_MAINTAIN'
                AND A.REQUEST_STATUS <> 'P'
                 
               AND B.FLOW_SEQ = (SELECT MAX (FLOW_SEQ)
                                      FROM wf_request_flow
                                     WHERE request_no = B.REQUEST_NO)
               AND  B.FLOW_SEQ = 4 
              GROUP BY b.user_pidm ;