/* Formatted on 8/21/2020 6:06:18 PM (QP5 v5.360) */
  SELECT ROW_NUMBER ()
             OVER (
                 PARTITION BY request_term, requester_college, requester_major
                 ORDER BY CGPA DESC, Earned_Hours DESC)    row_num,
         a.*,
            (SELECT SOBCURR_PROGRAM
               FROM SORCMJR, SOBCURR
              WHERE     SOBCURR_CURR_RULE = SORCMJR_CURR_RULE
                    AND SORCMJR_DEPT_CODE = NVL (A.DEPT_CODE, A.MAJOR_CODE)
                    AND SOBCURR_PROGRAM LIKE '2_%1433%'
                    AND SOBCURR_DEGC_CODE = 'Èß'
                    AND SOBCURR_PRIM_ROLL_IND = 'Y'
                    AND SPBPERS_SEX = 'F'
                    AND ROWNUM < 2)
         || (SELECT SOBCURR_PROGRAM
               FROM SORCMJR, SOBCURR
              WHERE     SOBCURR_CURR_RULE = SORCMJR_CURR_RULE
                    AND SORCMJR_DEPT_CODE = NVL (A.DEPT_CODE, A.MAJOR_CODE)
                    AND SOBCURR_PROGRAM LIKE '1_%1433%'
                    AND SOBCURR_DEGC_CODE = 'Èß'
                    AND SOBCURR_PRIM_ROLL_IND = 'Y'
                    AND SPBPERS_SEX = 'M'
                    AND SORCMJR_ADM_IND = 'Y'
                    AND ROWNUM < 2)                        AS "PROGRAM_CODE",
         (SELECT SMRPRLE_PROGRAM_DESC
            FROM SMRPRLE
           WHERE SMRPRLE_PROGRAM =
                    (SELECT SOBCURR_PROGRAM
                       FROM SORCMJR, SOBCURR
                      WHERE     SOBCURR_CURR_RULE = SORCMJR_CURR_RULE
                            AND SORCMJR_DEPT_CODE =
                                NVL (A.DEPT_CODE, A.MAJOR_CODE)
                            AND SOBCURR_PROGRAM LIKE '2_%1433%'
                            AND SOBCURR_DEGC_CODE = 'Èß'
                            AND SOBCURR_PRIM_ROLL_IND = 'Y'
                            AND SPBPERS_SEX = 'F'
                            AND SORCMJR_ADM_IND = 'Y'
                            AND ROWNUM < 2)
                 || (SELECT SOBCURR_PROGRAM
                       FROM SORCMJR, SOBCURR
                      WHERE     SOBCURR_CURR_RULE = SORCMJR_CURR_RULE
                            AND SORCMJR_DEPT_CODE =
                                NVL (A.DEPT_CODE, A.MAJOR_CODE)
                            AND SOBCURR_PROGRAM LIKE '1_%1433%'
                            AND SOBCURR_DEGC_CODE = 'Èß'
                            AND SOBCURR_PRIM_ROLL_IND = 'Y'
                            AND SPBPERS_SEX = 'M'
                            AND SORCMJR_ADM_IND = 'Y'
                            AND ROWNUM < 2))               NEW_PROGRAM_DESC,
         (SELECT SORCMJR_DESC
            FROM SORCMJR, SOBCURR
           WHERE     SOBCURR_CURR_RULE = SORCMJR_CURR_RULE
                 AND SORCMJR_ADM_IND = 'Y'
                 AND SOBCURR_PROGRAM =
                        (SELECT SOBCURR_PROGRAM
                           FROM SORCMJR, SOBCURR
                          WHERE     SOBCURR_CURR_RULE = SORCMJR_CURR_RULE
                                AND SORCMJR_DEPT_CODE =
                                    NVL (A.DEPT_CODE, A.MAJOR_CODE)
                                AND SOBCURR_PROGRAM LIKE '2_%1433%'
                                AND SOBCURR_DEGC_CODE = 'Èß'
                                AND SOBCURR_PRIM_ROLL_IND = 'Y'
                                AND SPBPERS_SEX = 'F'
                                AND ROWNUM < 2)
                     || (SELECT SOBCURR_PROGRAM
                           FROM SORCMJR, SOBCURR
                          WHERE     SOBCURR_CURR_RULE = SORCMJR_CURR_RULE
                                AND SORCMJR_DEPT_CODE =
                                    NVL (A.DEPT_CODE, A.MAJOR_CODE)
                                AND SOBCURR_PROGRAM LIKE '1_%1433%'
                                AND SOBCURR_DEGC_CODE = 'Èß'
                                AND SOBCURR_PRIM_ROLL_IND = 'Y'
                                AND SPBPERS_SEX = 'M'
                                AND SORCMJR_ADM_IND = 'Y'
                                AND ROWNUM < 2) /* and SOBCURR_TERM_CODE_INIT=(select max(SOBCURR_TERM_CODE_INIT) from SOBCURR where SOBCURR_PROGRAM =COL04 )*/
                                               )           AS "Full Description"
    FROM (SELECT m.request_no,
                 (SELECT d.item_value
                    FROM request_details d
                   WHERE     d.request_no = m.request_no
                         AND d.sequence_no = 1
                         AND d.item_code = 'TERM')
                     request_term,
                 f_get_desc_fnc (
                     'STVCOLL',
                     (SELECT d.item_value
                        FROM request_details d
                       WHERE     d.request_no = m.request_no
                             AND d.sequence_no = 1
                             AND d.item_code = 'TRANSFER_COLLEGE'),
                     60)
                     requester_college,
                 (SELECT d.item_value
                    FROM request_details d
                   WHERE     d.request_no = m.request_no
                         AND d.sequence_no = 1
                         AND d.item_code = 'TRANSFER_MAJOR')
                     MAJOR_CODE,
                 f_get_desc_fnc (
                     'STVMAJR',
                     (SELECT d.item_value
                        FROM request_details d
                       WHERE     d.request_no = m.request_no
                             AND d.sequence_no = 1
                             AND d.item_code = 'TRANSFER_MAJOR'),
                     60)
                     requester_major,
                 (SELECT d.item_value
                    FROM request_details d
                   WHERE     d.request_no = m.request_no
                         AND d.sequence_no = 1
                         AND d.item_code = 'TRANSFER_DEPT')
                     dept_code,
                 f_getspridenid (requester_pidm)
                     student_id,
                 requester_pidm
                     student_pidm,
                 f_format_name (requester_pidm, 'FML')
                     student_name,
                 sgbstdn_coll_code_1
                     Coll_code,
                 f_get_desc_fnc ('STVCOLL', sgbstdn_coll_code_1, 60)
                     coll_desc,
                 f_get_desc_fnc ('STVMAJR', sgbstdn_majr_code_1, 60)
                     majr_desc,
                 (SELECT SPBPERS_SEX
                    FROM SPBPERS
                   WHERE SPBPERS_Pidm = m.requester_pidm)
                     SPBPERS_SEX,
                 (SELECT shrlgpa_hours_earned
                    FROM shrlgpa
                   WHERE     shrlgpa_pidm = m.requester_pidm
                         AND shrlgpa_levl_code = sgbstdn_levl_code
                         AND shrlgpa_gpa_type_ind = 'O')
                     Earned_Hours,
                 (SELECT ROUND (shrlgpa_gpa, 2)
                    FROM shrlgpa
                   WHERE     shrlgpa_pidm = m.requester_pidm
                         AND shrlgpa_levl_code = sgbstdn_levl_code
                         AND shrlgpa_gpa_type_ind = 'O')
                     CGPA
            FROM request_master m, sgbstdn b
           WHERE     sgbstdn_pidm = requester_pidm
                 AND sgbstdn_term_code_eff =
                     (SELECT MAX (x.sgbstdn_term_code_eff)
                        FROM sgbstdn x
                       WHERE x.sgbstdn_pidm = b.sgbstdn_pidm)
                 AND object_code = 'WF_TRANSFER'
                 AND request_status IN ( :request_status)
                 AND EXISTS
                         (SELECT 1
                            FROM WF_REQUEST_FLOW
                           WHERE     REQUEST_NO = m.request_no
                                 AND FLOW_SEQ =
                                     (SELECT MAX (FLOW_SEQ)
                                        FROM WF_REQUEST_FLOW
                                       WHERE REQUEST_NO = m.request_no)
                                 AND FLOW_SEQ >= 2)
                 AND EXISTS
                         (SELECT 1
                            FROM request_details d
                           WHERE     d.request_no = m.request_no
                                 AND d.sequence_no = 1
                                 AND d.item_code = 'TERM'
                                 AND d.item_value = :p_term)
                 AND (   EXISTS
                             (SELECT 1
                                FROM request_details d
                               WHERE     d.request_no = m.request_no
                                     AND d.sequence_no = 1
                                     AND d.item_code = 'TRANSFER_TYPE'
                                     AND d.item_value = :p_type)
                      OR :p_type = '%')
                 AND (   EXISTS
                             (SELECT 1
                                FROM request_details d
                               WHERE     d.request_no = m.request_no
                                     AND d.sequence_no = 1
                                     AND d.item_code = 'TRANSFER_COLLEGE'
                                     AND d.item_value = :p_coll)
                      OR :p_coll = '%')
                 AND (   EXISTS
                             (SELECT 1
                                FROM request_details d
                               WHERE     d.request_no = m.request_no
                                     AND d.sequence_no = 1
                                     AND d.item_code = 'TRANSFER_MAJOR'
                                     AND d.item_value = :p_major)
                      OR :p_major = '%')) a
--  WHERE A.DEPT_CODE IS NULL
ORDER BY  requester_college  ,
         major_code 
          ;