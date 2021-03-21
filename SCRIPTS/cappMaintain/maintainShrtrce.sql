/* Formatted on 10/02/2021 14:05:22 (QP5 v5.227.12220.39754) */
UPDATE SHRTRCE
   SET (SHRTRCE_SUBJ_CODE, SHRTRCE_CRSE_NUMB) =
          (SELECT LHS_SUBJ_CODE, LHS_CRSE_NUMB
             FROM BU_APPS.CAPP_MNPL_LOG_DETAIL
            WHERE     STD_PIDM = SHRTRCE_PIDM
                  AND MAPPING_SUCCESS_IND = 'Y'
                  AND GRDE_CODE_FINAL = 'ук'
                  AND RHS_SUBJ_CODE || RHS_CRSE_NUMB =
                         SHRTRCE_SUBJ_CODE || SHRTRCE_CRSE_NUMB)
 WHERE EXISTS
          (SELECT '1'
             FROM CAPP_MNPL_LOG_DETAIL
            WHERE     STD_PIDM = SHRTRCE_PIDM
                  AND process_id = 2000
                  AND MAPPING_SUCCESS_IND = 'Y'
                  AND GRDE_CODE_FINAL = 'ук'
                  AND RHS_SUBJ_CODE || RHS_CRSE_NUMB =
                         SHRTRCE_SUBJ_CODE || SHRTRCE_CRSE_NUMB)