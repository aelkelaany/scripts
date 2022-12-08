/* Formatted on 8/8/2022 10:06:43 AM (QP5 v5.371) */
SELECT M.REQUEST_NO,
       F_GET_STD_ID (m.REQUESTER_PIDM)                        STUDENT_ID,
       F_GET_STD_NAME (m.REQUESTER_PIDM)                      STUDENT_NAME,
       f_get_desc_fnc ('STVCOLL', sgbstdn_coll_code_1, 60)    coll_desc,
       f_get_desc_fnc ('STVMAJR', sgbstdn_majr_code_1, 60)    majr_desc,
       f_get_desc_fnc ('STVSTST', b.SGBSTDN_STST_CODE, 60)    STST,
       (SELECT ROUND (shrlgpa_gpa, 2)
          FROM shrlgpa
         WHERE     shrlgpa_pidm = m.REQUESTER_PIDM
               AND shrlgpa_levl_code = 'Ã„'
               AND shrlgpa_gpa_type_ind = 'O')                CGPA,
       (SELECT shrlgpa_hours_earned
          FROM shrlgpa
         WHERE     shrlgpa_pidm = m.requester_pidm
               AND shrlgpa_levl_code = 'Ã„'
               AND shrlgpa_gpa_type_ind = 'O')                Earned_Hours,
       f_disconnect_term_count (m.REQUESTER_PIDM)             TERMS,
       f_disconnection_count (m.REQUESTER_PIDM)               TIMES,
       '«·„⁄«·Ì'                                       PRIVILAGE
  FROM request_master m, sgbstdn b
 WHERE     sgbstdn_pidm = requester_pidm
       AND sgbstdn_term_code_eff = (SELECT MAX (x.sgbstdn_term_code_eff)
                                      FROM sgbstdn x
                                     WHERE x.sgbstdn_pidm = b.sgbstdn_pidm)
       AND OBJECT_CODE = 'WF_REACTIVATE'
       AND request_status IN ('P')
       --
       AND (   f_disconnect_term_count (m.REQUESTER_PIDM) > 4
            OR f_disconnection_count (m.REQUESTER_PIDM) >= 2)
UNION
SELECT M.REQUEST_NO,
       F_GET_STD_ID (m.REQUESTER_PIDM)                        STUDENT_ID,
       F_GET_STD_NAME (m.REQUESTER_PIDM)                      STUDENT_NAME,
       f_get_desc_fnc ('STVCOLL', sgbstdn_coll_code_1, 60)    coll_desc,
       f_get_desc_fnc ('STVMAJR', sgbstdn_majr_code_1, 60)    majr_desc,
       f_get_desc_fnc ('STVSTST', b.SGBSTDN_STST_CODE, 60)    STST,
       (SELECT ROUND (shrlgpa_gpa, 2)
          FROM shrlgpa
         WHERE     shrlgpa_pidm = m.REQUESTER_PIDM
               AND shrlgpa_levl_code = 'Ã„'
               AND shrlgpa_gpa_type_ind = 'O')                CGPA,
       (SELECT shrlgpa_hours_earned
          FROM shrlgpa
         WHERE     shrlgpa_pidm = m.requester_pidm
               AND shrlgpa_levl_code = 'Ã„'
               AND shrlgpa_gpa_type_ind = 'O')                Earned_Hours,
       f_disconnect_term_count (m.REQUESTER_PIDM)             TERMS,
       f_disconnection_count (m.REQUESTER_PIDM)               TIMES,
       '«·⁄„«œ…'
  FROM request_master m, sgbstdn b
 WHERE     sgbstdn_pidm = requester_pidm
       AND sgbstdn_term_code_eff = (SELECT MAX (x.sgbstdn_term_code_eff)
                                      FROM sgbstdn x
                                     WHERE x.sgbstdn_pidm = b.sgbstdn_pidm)
       AND OBJECT_CODE = 'WF_REACTIVATE'
       AND request_status IN ('P')
       --
       AND (    f_disconnect_term_count (m.REQUESTER_PIDM) <= 4
            AND f_disconnection_count (m.REQUESTER_PIDM) <= 1);