/* Formatted on 6/22/2022 8:56:54 AM (QP5 v5.371) */
SELECT SGBSTDN_TERM_CODE_EFF,
       F_GET_STD_ID (SGBSTDN_PIDM)       ST_ID,
       F_GET_STD_name (SGBSTDN_PIDM)     ST_name,
       SGBSTDN_STST_CODE,
       SGBSTDN_PIDM,
       SGBSTDN_MAJR_CODE_1,
       SGBSTDN_COLL_CODE_1,
       SGBSTDN_DEPT_CODE,
       SGBSTDN_PROGRAM_1
  FROM sgbstdn
 WHERE     --SGBSTDN_TERM_CODE_EFF='144330'
           SGBSTDN_STYP_CODE = 'ã'
       AND EXISTS
               (SELECT '1'
                  FROM request_master
                 WHERE     object_code = 'WF_INTERNAL_VISITOR'
                       AND REQUESTER_PIDM = SGBSTDN_PIDM
                       AND REQUEST_STATUS = 'C')
       AND sgbstdn_program_1 LIKE '1%38'
       AND SUBSTR (sgbstdn_program_1, 3, 2) != SGBSTDN_COLL_CODE_1

--AND SGBSTDN_STST_CODE ='ÎÌ'