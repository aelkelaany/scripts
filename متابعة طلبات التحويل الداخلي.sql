SELECT ROW_NUMBER ()
         OVER (PARTITION BY request_term, requester_college, requester_major,GENDER
               ORDER BY CGPA DESC, Earned_Hours DESC)
            row_num,
         a.*,
         (SELECT    f_get_std_name (user_pidm) ||'----'||
                    f_get_std_id (user_pidm) ||'***'||user_pidm
            FROM role_users
           WHERE     ROLE_CODE = 'RO_DEPT_MANAGER'
           and ACTIVE='Y'
                 AND user_pidm IN
                        (SELECT user_pidm
                           FROM users_attributes
                          WHERE     ATTRIBUTE_CODE = 'DEPARTMENT'
                                AND ATTRIBUTE_VALUE = a.dept_code)
                                AND user_pidm IN
                        (SELECT user_pidm
                           FROM users_attributes
                          WHERE     ATTRIBUTE_CODE = 'TRN_ALLOW_APPROVALS'
                                AND ATTRIBUTE_VALUE = 'Y')
                                )
            HOD_approver
        /*, (SELECT    f_get_std_name (user_pidm)
                 || '---'
                 || f_get_std_id (user_pidm)
            FROM role_users
           WHERE     ROLE_CODE = 'RO_COLLEGE_DEAN'
                 AND ACTIVE = 'Y'
                 AND user_pidm IN
                        (SELECT user_pidm
                           FROM users_attributes
                          WHERE     ATTRIBUTE_CODE = 'DEPARTMENT'
                                AND ATTRIBUTE_VALUE = a.DEPT_code))
            HOD_approver*/
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
                 f_getspridenid (requester_pidm) student_id,
                 requester_pidm student_pidm,
                 f_format_name (requester_pidm, 'FML') student_name,
                 sgbstdn_coll_code_1 Coll_code,
                 f_get_desc_fnc ('STVCOLL', sgbstdn_coll_code_1, 60) coll_desc,
                 f_get_desc_fnc ('STVMAJR', sgbstdn_majr_code_1, 60) majr_desc,
                 (SELECT DECODE (SPBPERS_SEX,  'M', 'ÐßÑ',  'F', 'ÇäËì')
                    FROM SPBPERS
                   WHERE SPBPERS_Pidm = m.requester_pidm)
                    gender,
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
                    CGPA ,(select SORTEST_TEST_SCORE from SORTEST where SORTEST_TESC_CODE='äÓÈ2' and SORTEST_PIDM=b.sgbstdn_pidm)as "ËáÇËíÉ" ,(select SORHSCH_GPA from SORHSCH where SORHSCH_pidm=b.sgbstdn_pidm) as  "ËÇäæíÉ"
                    ,(SELECT action_code
                           FROM WF_REQUEST_FLOW
                          WHERE     REQUEST_NO = m.request_no
                          and FLOW_SEQ  = 2
                            ) DepartmentAction ,(SELECT action_code
                           FROM WF_REQUEST_FLOW
                          WHERE     REQUEST_NO = m.request_no
                          and FLOW_SEQ  = 3
                            ) DeanAction ,(SELECT action_code
                           FROM WF_REQUEST_FLOW
                          WHERE     REQUEST_NO = m.request_no
                          and FLOW_SEQ  = 4
                            ) DARAction
            FROM request_master m, sgbstdn b
           WHERE     sgbstdn_pidm = requester_pidm
                 AND sgbstdn_term_code_eff =
                        (SELECT MAX (x.sgbstdn_term_code_eff)
                           FROM sgbstdn x
                          WHERE x.sgbstdn_pidm = b.sgbstdn_pidm)
                 AND object_code = 'WF_TRANSFER'
                 AND request_status IN ('C','R')
                 AND EXISTS
                        (SELECT 1
                           FROM WF_REQUEST_FLOW
                          WHERE     REQUEST_NO = m.request_no
                                AND FLOW_SEQ =
                                       (SELECT MAX (FLOW_SEQ)
                                          FROM WF_REQUEST_FLOW
                                         WHERE REQUEST_NO = m.request_no)
                                AND FLOW_SEQ  >= 4
                                  )
                                   
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
--where deanaction is null --deanaction='APPROVE' and departmentaction='APPROVE_07'
ORDER BY requester_college,
         requester_major,
         CGPA DESC,
         Earned_Hours DESC;