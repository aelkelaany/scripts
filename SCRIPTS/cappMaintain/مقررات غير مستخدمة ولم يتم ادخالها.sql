/* Formatted on 3/7/2022 1:03:34 PM (QP5 v5.371) */
SELECT f_get_std_id (STD_PIDM)      student_id,
       f_get_std_name (STD_PIDM)    student_name,
       SUBJ_CODE,
       CRSE_NUMB,
       CREDIT_HOURS,
       TITLE,
       GRDE_CODE_FINAL,
       (SELECT f_get_desc_fnc ('stvcoll', scbcrse_coll_code, 30)
          FROM scbcrse
         WHERE     scbcrse_subj_code || scbcrse_crse_numb =
                   SUBJ_CODE || CRSE_NUMB
               AND ROWNUM < 2)      college
  FROM BU_APPS.CAPP_MNPL_LOG_NOT_USED u
 WHERE     PROCESS_ID = 4800
       AND NOT EXISTS
               (SELECT '1'
                  FROM CAPP_MNPL_LOG_DETAIL
                 WHERE     u.std_pidm = STD_PIDM
                       AND LHS_SUBJ_CODE || LHS_CRSE_NUMB =
                           SUBJ_CODE || CRSE_NUMB)
       AND CREDIT_HOURS > 0