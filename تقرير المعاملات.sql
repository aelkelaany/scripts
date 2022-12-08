/* Formatted on 10/27/2022 10:25:38 AM (QP5 v5.371) */
-- requester

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
               'P', 'E?E C????C?',
               'C', 'E?E C???C??E',
               'R', 'E? C????')
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
       r1.notes
  FROM wf_request_flow r1, request_master m1
 WHERE     r1.request_no = m1.request_no
       AND REQUESTER_PIDM = f_get_pidm ( :p_rqstr_id)
       AND (m1.REQUEST_NO = :p_request_no OR :p_request_no IS NULL)
       AND r1.flow_seq = (SELECT MAX (flow_seq)
                            FROM wf_request_flow
                           WHERE request_no = m1.request_no)
       AND (object_code = :P_OBJECT_CODE OR :P_OBJECT_CODE = '%')
-- benif id
UNION
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
               'P', 'E?E C????C?',
               'C', 'E?E C???C??E',
               'R', 'E? C????')
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
       r1.notes
  FROM wf_request_flow r1, request_master m1, request_details pidm_tbl
 WHERE     r1.request_no = m1.request_no
       AND r1.flow_seq = (SELECT MAX (flow_seq)
                            FROM wf_request_flow
                           WHERE request_no = m1.request_no)
       AND pidm_tbl.REQUEST_NO = m1.REQUEST_NO
       AND (m1.REQUEST_NO = :p_request_no OR :p_request_no IS NULL)
       AND pidm_tbl.SEQUENCE_NO = 1
       AND pidm_tbl.ITEM_CODE LIKE '%PIDM%'
       AND pidm_tbl.ITEM_VALUE = TO_CHAR (f_get_pidm ( :BENIF_id))
       AND (object_code = :P_OBJECT_CODE OR :P_OBJECT_CODE = '%')
--request_no
UNION
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
               'P', 'E?E C????C?',
               'C', 'E?E C???C??E',
               'R', 'E? C????')
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
       r1.notes
  FROM wf_request_flow r1, request_master m1
 WHERE     r1.request_no = m1.request_no
       AND m1.REQUEST_NO = :p_request_no
       AND r1.flow_seq = (SELECT MAX (flow_seq)
                            FROM wf_request_flow
                           WHERE request_no = m1.request_no)
--college
UNION
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
               'P', 'E?E C????C?',
               'C', 'E?E C???C??E',
               'R', 'E? C????')
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
       r1.notes
  FROM wf_request_flow r1, request_master m1, request_details pidm_tbl
 WHERE     r1.request_no = m1.request_no
       AND r1.flow_seq = (SELECT MAX (flow_seq)
                            FROM wf_request_flow
                           WHERE request_no = m1.request_no)
       AND pidm_tbl.REQUEST_NO = m1.REQUEST_NO
       AND (m1.REQUEST_NO = :p_request_no OR :p_request_no IS NULL)
       AND pidm_tbl.SEQUENCE_NO = 1
       AND pidm_tbl.ITEM_CODE LIKE '%COLLEGE%'
       AND pidm_tbl.ITEM_VALUE = :P_COLLEGE
       AND (object_code = :P_OBJECT_CODE OR :P_OBJECT_CODE = '%')
       AND :p_rqstr_id IS NULL
       AND :BENIF_id IS NULL
       AND :P_DEPARTMENT IS NULL
UNION
--DEPARTMENT

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
               'P', 'E?E C????C?',
               'C', 'E?E C???C??E',
               'R', 'E? C????')
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
       r1.notes
  FROM wf_request_flow r1, request_master m1, request_details pidm_tbl
 WHERE     r1.request_no = m1.request_no
       AND r1.flow_seq = (SELECT MAX (flow_seq)
                            FROM wf_request_flow
                           WHERE request_no = m1.request_no)
       AND pidm_tbl.REQUEST_NO = m1.REQUEST_NO
       AND (m1.REQUEST_NO = :p_request_no OR :p_request_no IS NULL)
       AND pidm_tbl.SEQUENCE_NO = 1
       AND pidm_tbl.ITEM_CODE LIKE '%DEPARTMENT%'
       AND pidm_tbl.ITEM_VALUE = :P_DEPARTMENT
       AND (object_code = :P_OBJECT_CODE OR :P_OBJECT_CODE = '%')
       AND :p_rqstr_id IS NULL
       AND :BENIF_id IS NULL
--AND :P_COLLEGE IS NULL

ORDER BY request_no DESC;