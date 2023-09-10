SELECT m1.request_no,
       r1.sequence_no,
       r1.flow_seq,
       r1.role_code,
       r1.action_code,
       TO_CHAR (TO_DATE (m1.request_date),
                'dd-mm-yyyy',
                'nls_calendar=''Arabic Hijrah''')
           request_date,
       m1.object_code
           object_code,
          f_get_std_id (REQUESTER_PIDM)
       || '  '
       || f_get_std_name (REQUESTER_PIDM)
           requester_name,
       DECODE (m1.request_status,
               'P', 'Pending',
               'C', 'Completed',
               'R', 'Rejected')
           request_status,
       (SELECT object_desc
          FROM object_definition o1
         WHERE o1.object_code = m1.object_code)
           object_desc,
       (SELECT role_decription
          FROM role_definition
         WHERE role_code = r1.role_code)
           role_desc,
       f_get_std_id (r1.user_pidm) || '  ' || f_get_std_name (r1.user_pidm)
           approver,
       TO_CHAR (TO_DATE (r1.ACTIVITY_DATE),
                'dd-mm-yyyy',
                'nls_calendar=''Arabic Hijrah''')
           activity_date,
       r1.notes ,F_GET_STD_ID(USER_PIDM),F_GET_STD_NAME(USER_PIDM)
  FROM wf_request_flow r1, request_master m1
 WHERE     r1.request_no = m1.request_no


       AND r1.flow_seq = (SELECT MAX (flow_seq)
                            FROM wf_request_flow
                           WHERE request_no = m1.request_no)
       AND (object_code in ('WF_ADDITIONAL_CHANCE','WF_REACTIVATE')  )
       --COLLEGE
       AND EXISTS (SELECT '1' FROM REQUEST_DETAILS WHERE REQUEST_NO=m1.request_no
       AND SEQUENCE_NO=1
       AND ITEM_CODE LIKE'%COLLEGE%' --COLLEGE_CODE
       AND ITEM_VALUE='12'
       )
       -- TERM
       AND EXISTS (SELECT '1' FROM REQUEST_DETAILS WHERE REQUEST_NO=m1.request_no
       AND SEQUENCE_NO=1
       AND ITEM_CODE LIKE'%TERM%' --COLLEGE_CODE
       AND ITEM_VALUE>='144430'
       )
       -- REMOVE CANCELED REQUESTS 
       AND  NVL(ACTION_CODE,'--')!='CANCEL_REQUEST'
       
       AND NVL(USER_PIDM,'0')!=157409
       AND REQUEST_STATUS ='P' ;
       
       
SELECT sgbstdn_levl_code level_code,
             sgbstdn_stst_code status_code,
             sgbstdn_styp_code student_type
        FROM sgbstdn x
       WHERE     sgbstdn_pidm = f_get_pidm('442008589')
             AND sgbstdn_term_code_eff =
                    (SELECT MAX (sgbstdn_term_code_eff)
                       FROM sgbstdn d
                      WHERE     d.sgbstdn_pidm = x.sgbstdn_pidm
                            AND d.sgbstdn_term_code_eff <=
                                   f_get_param ('WORKFLOW',
                                                'CURRENT_TERM',
                                                1))
             AND nvl(SGBSTDN_TERM_CODE_ADMIT,'000000') !=
                    f_get_param ('WORKFLOW', 'CURRENT_TERM', 1)
                    
 
;