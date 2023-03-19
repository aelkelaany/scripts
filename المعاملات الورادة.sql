   SELECT m1.request_no,
                  r1.sequence_no,
                  r1.flow_seq,
                  r1.role_code,
                  r1.action_code,
                  m1.request_date,
                  m1.object_code object_code,
                  DECODE (m1.request_status,
                          'P', 'Ã«—Ì «·⁄„· ⁄·Ì «·ÿ·»',
                          'C', ' „ ≈ﬂ „«· «·ÿ·»',
                          'R', ' „ —›÷ «·ÿ·»')
                     request_status,
                  object_desc,
                  ro.role_decription role_desc ,(select F_GET_DESC_FNC('stvdept',item_value,30)||'^'||item_value from request_details where request_no= m1.request_no
                  and sequence_no=1 and item_code='DEPARTMENT'
                  ) dept
             FROM wf_request_flow r1,
                  request_master m1,
                  role_definition ro,
                  object_definition o1,
                  wf_actions ac,
                  wf_flow f 
            WHERE     r1.request_no = m1.request_no
                  AND r1.role_code = ro.role_code(+)
                  AND m1.object_code = o1.object_code(+)
                  AND r1.action_code = ac.action_code(+)
                  AND f.OBJECT_CODE = m1.OBJECT_CODE
                  AND f.FLOW_SEQ = r1.FLOW_SEQ
                  AND (r1.action_code IS NULL OR ac.action_type = 'HOLD')
                  AND (   (user_pidm = f_get_pidm(:cp_id) AND user_pidm IS NOT NULL)
                       OR (    f_get_pidm(:cp_id) IN
                                  (SELECT user_pidm
                                     FROM role_users
                                    WHERE     role_code IN
                                                 (r1.role_code,
                                                  f.ASSISTANT_ROLE_CODE)
                                          AND active = 'Y')
                           AND user_pidm IS NULL
                           AND wf_navigation.f_valid_match_pidm (
                                  m1.request_no,
                                  r1.role_code,
                                  f_get_pidm(:cp_id),
                                  f.ASSISTANT_ROLE_CODE) = 'Y'))
                  AND m1.request_status = 'P'
                  AND (m1.request_no = :cp_req_no OR :cp_req_no IS NULL)
                  AND m1.object_code NOT IN
                         (SELECT PARAMETER_VALUE
                            FROM dev_sys_parameters
                           WHERE     MODULE = 'WORKFLOW'
                                 AND PARAMETER_CODE = 'PREVENT_INBOX')
                                 --and m1.object_code='WF_CLEARANCE'
         ORDER BY m1.request_no DESC