 

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
           requester_name,F_GET_DESC_FNC('STVDEPT',pidm_tbl.ITEM_VALUE,30) DEPT ,
       DECODE (m1.request_status,
               'P', ' Õ  «·≈Ã—«¡',
               'C', ' „ «· ‰›Ì–',
               'R', ' „ «·—›÷')
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
       r1.notes ,F_GET_STD_ID(STD_TBL.ITEM_VALUE)STID ,F_GET_STD_NAME(STD_TBL.ITEM_VALUE)STNAME 
  FROM wf_request_flow r1, request_master m1, request_details pidm_tbl ,request_details TERM_TBL ,request_details STD_TBL
 WHERE     r1.request_no = m1.request_no
       AND r1.flow_seq = (SELECT MAX (flow_seq)
                            FROM wf_request_flow
                           WHERE request_no = m1.request_no)
       AND pidm_tbl.REQUEST_NO = m1.REQUEST_NO
       AND (m1.REQUEST_NO = :p_request_no OR :p_request_no IS NULL)
       AND pidm_tbl.SEQUENCE_NO = 1
       AND pidm_tbl.ITEM_CODE LIKE '%DEPARTMENT%'
       AND pidm_tbl.ITEM_VALUE LIKE :P_DEPARTMENT
       AND pidm_tbl.REQUEST_NO=TERM_TBL.REQUEST_NO
       AND TERM_TBL.SEQUENCE_NO = 1
       AND TERM_TBL.ITEM_CODE LIKE '%TERM%'
       AND TERM_TBL.ITEM_VALUE='144430'
       --
       AND pidm_tbl.REQUEST_NO=STD_TBL.REQUEST_NO
       AND STD_TBL.SEQUENCE_NO = 1
       AND STD_TBL.ITEM_CODE LIKE '%STUDENT_PIDM%'
       
       AND (object_code = :P_OBJECT_CODE  )
       AND :p_rqstr_id IS NULL
       AND :BENIF_id IS NULL
 

ORDER BY DEPT ,request_no DESC