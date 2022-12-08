/* Formatted on 11/10/2022 11:05:19 AM (QP5 v5.371) */
SELECT DISTINCT
       F_GET_STD_ID (STD_PIDM) STD_ID, F_GET_STD_NAME (STD_PIDM) STD_NAME
  FROM BU_APPS.CAPP_MNPL_LOG_DETAIL A
 WHERE     PROCESS_ID BETWEEN 7400 AND 7900
       AND MAPPING_SUCCESS_IND = 'Y'
       AND LHS_SUBJ_CODE || LHS_CRSE_NUMB = 'ENGL1001'
       AND EXISTS
               (SELECT '1'
                  FROM BU_APPS.CAPP_MNPL_LOG_DETAIL
                 WHERE     STD_PIDM = A.STD_PIDM
                       AND PROCESS_ID BETWEEN 7400 AND 7900
                       AND MAPPING_SUCCESS_IND = 'Y'
                       AND LHS_SUBJ_CODE || LHS_CRSE_NUMB = 'ENGL1002');



  SELECT A.STD_PIDM,
         F_GET_STD_ID (A.STD_PIDM)       STD_ID,
         F_GET_STD_NAME (A.STD_PIDM)     STD_NAME,
         A.LHS_SUBJ_CODE || A.LHS_CRSE_NUMB,
         A.RHS_SUBJ_CODE || A.RHS_CRSE_NUMB,
         B.LHS_SUBJ_CODE || B.LHS_CRSE_NUMB,
         B.RHS_SUBJ_CODE || B.RHS_CRSE_NUMB
    FROM BU_APPS.CAPP_MNPL_LOG_DETAIL A,
         BU_APPS.CAPP_MNPL_LOG_DETAIL B,
         SGBSTDN                     SG
   WHERE     A.PROCESS_ID = B.PROCESS_ID
         AND A.STD_PIDM = B.STD_PIDM
         AND A.PROCESS_ID BETWEEN 7400 AND 7900
         AND A.MAPPING_SUCCESS_IND = B.MAPPING_SUCCESS_IND
         AND A.MAPPING_SUCCESS_IND = 'Y'
         AND A.LHS_SUBJ_CODE || A.LHS_CRSE_NUMB = 'ENGL1001'
         AND B.LHS_SUBJ_CODE || B.LHS_CRSE_NUMB = 'ENGL1002'
         AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                        FROM sgbstdn
                                       WHERE sgbstdn_pidm = sg.sgbstdn_pidm)
         AND A.STD_pidm = sg.sgbstdn_pidm
         AND B.STD_pidm = sg.sgbstdn_pidm
         AND sgbstdn_stst_code IN ('AS', 'ãæ', 'ãÚ')
         AND A.DATA_TARGET IS NOT NULL
         AND B.DATA_TARGET IS NOT NULL
         AND NOT EXISTS (SELECT '1'
                  FROM BU_APPS.CAPP_MNPL_LOG_DETAIL
                 WHERE     STD_PIDM = A.STD_PIDM
                       AND PROCESS_ID BETWEEN 7400 AND 7900
                       AND MAPPING_SUCCESS_IND = 'Y'
                       AND LHS_SUBJ_CODE || LHS_CRSE_NUMB = 'ENGL1003')
ORDER BY 1


