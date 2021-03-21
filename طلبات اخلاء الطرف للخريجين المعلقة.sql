/* Formatted on 5/7/2020 4:07:20 PM (QP5 v5.360) */
SELECT REQUEST_NO, to_char(REQUEST_DATE,'DD-MM-YYYY','nls_calendar=''Arabic Hijrah''') REQUEST_DATE ,
       F_GET_STD_ID (REQUESTER_PIDM),
       F_GET_STD_NAME (REQUESTER_PIDM),
       f_get_desc_fnc ('STVSTYP', SGBSTDN_STYP_CODE, 60)
           AS "‰Ê⁄ «·œ—«”…",
       f_get_desc_fnc ('STVCOLL', sgbstdn_coll_code_1, 60)
           AS "«·ﬂ·Ì…",
       f_get_desc_fnc ('STVDEPT', sgbstdn_dept_code, 60)
           AS "«·ﬁ”„",
       f_get_desc_fnc ('STVCAMP', sgbstdn_camp_code, 60)
           AS "«·›—⁄",
       f_get_desc_fnc ('STVMAJR', sgbstdn_majr_code_1, 60)
           AS "«· Œ’’"
  FROM BU_APPS.REQUEST_MASTER, sgbstdn
 WHERE     OBJECT_CODE = 'WF_CLEARANCE'
       AND REQUEST_STATUS = 'P'
       AND sgbstdn_pidm = REQUESTER_PIDM
       AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                      FROM sgbstdn
                                     WHERE sgbstdn_pidm = REQUESTER_PIDM)
                                     ORDER BY 7 , 8