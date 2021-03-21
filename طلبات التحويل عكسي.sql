/* Formatted on 8/16/2020 12:51:35 PM (QP5 v5.360) */
SELECT f_get_std_id (sgbstdn_pidm)
           stid,
       f_get_std_name (sgbstdn_pidm)
           std_name,
       SGBSTDN_DEPT_CODE,
       F_GET_DESC_FNC ('STVMAJR', SGBSTDN_DEPT_CODE, 30)
           STUDENT_DEPT_DESC,
       SGBSTDN_MAJR_CODE_1,
       F_GET_DESC_FNC ('STVMAJR', SGBSTDN_MAJR_CODE_1, 30)
           STUDENT_MAJOR_DESC,
       REQUEST_NO,
       DECODE (REQUEST_STATUS,
               'P', ' Õ  «·≈Ã—«¡',
               'C', '„ﬁ»Ê·Â',
               'R', '„—›Ê÷…')
           status,
       (SELECT item_value
          FROM request_details
         WHERE     request_no = m.request_no
               AND sequence_no = 1
               AND item_code = 'TRANSFER_PROGRAM')
           program,
       (SELECT item_value
          FROM request_details
         WHERE     request_no = m.request_no
               AND sequence_no = 1
               AND item_code = 'TRANSFER_MAJOR')
           major,
       F_GET_DESC_FNC (
           'STVMAJR',
           (SELECT item_value
              FROM request_details
             WHERE     request_no = m.request_no
                   AND sequence_no = 1
                   AND item_code = 'TRANSFER_MAJOR'),
           30)
           MAJOR_DESC,
       (SELECT item_value
          FROM request_details
         WHERE     request_no = m.request_no
               AND sequence_no = 1
               AND item_code = 'TRANSFER_DEPT')
           dept,
       F_GET_DESC_FNC (
           'STVDEPT',
           (SELECT item_value
              FROM request_details
             WHERE     request_no = m.request_no
                   AND sequence_no = 1
                   AND item_code = 'TRANSFER_DEPT'),
           30)
           DEPT_DESC,
       (SELECT item_value
          FROM request_details
         WHERE     request_no = m.request_no
               AND sequence_no = 1
               AND item_code = 'TRANSFER_TYPE')
           TRANSFER_TYPE
  FROM REQUEST_MASTER m, sgbstdn
 WHERE     sgbstdn_pidm = REQUESTER_PIDM
       AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                      FROM sgbstdn
                                     WHERE sgbstdn_pidm = REQUESTER_PIDM)
       AND OBJECT_CODE = 'WF_TRANSFER'
       -- AND REQUEST_STATUS='C'
       AND SGBSTDN_DEPT_CODE = '3101'
       AND EXISTS
               (SELECT '1'
                  FROM request_details
                 WHERE     request_no = m.request_no
                       AND sequence_no = 1
                       AND item_code = 'TERM'
                       AND item_value = '144030');