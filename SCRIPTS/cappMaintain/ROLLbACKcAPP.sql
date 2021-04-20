/* Formatted on 15/04/2021 13:52:01 (QP5 v5.362) */
DELETE FROM
    SATURN.SMRSSUB
      WHERE EXISTS
                (SELECT '1'
                   FROM CAPP_MNPL_LOG_DETAIL
                  WHERE     PROCESS_ID = '1900'
                        AND STD_PIDM = SMRSSUB_PIDM
                        AND LHS_SUBJ_CODE = SMRSSUB_SUBJ_CODE_REQ
                        AND LHS_CRSE_NUMB = SMRSSUB_CRSE_NUMB_REQ
                        AND MAPPING_SUCCESS_IND = 'Y'
                        AND DATA_TARGET = 'SMRSSUB'
                        AND RHS_SUBJ_CODE = SMRSSUB_SUBJ_CODE_SUB
                        AND RHS_CRSE_NUMB = SMRSSUB_CRSE_NUMB_SUB)
-- AND SMRSSUB_PIDM = 157590
;

DELETE FROM
    SATURN.SHRTRCE
      WHERE     EXISTS
                    (SELECT '1'
                       FROM CAPP_MNPL_LOG_DETAIL
                      WHERE     PROCESS_ID = '1900'
                            AND STD_PIDM = SHRTRCE_PIDM
                            AND LHS_SUBJ_CODE = SHRTRCE_SUBJ_CODE
                            AND LHS_CRSE_NUMB = SHRTRCE_CRSE_NUMB
                            AND MAPPING_SUCCESS_IND = 'Y'
                            AND DATA_TARGET LIKE 'SHRTRCE%'
                            AND GRDE_CODE_FINAL = 'ук')
            AND SHRTRCE_TRIT_SEQ_NO > 1;

DELETE FROM
    SHRTRCR
      WHERE     EXISTS
                    (SELECT '1'
                       FROM CAPP_MNPL_LOG_DETAIL
                      WHERE PROCESS_ID = '1900' AND STD_PIDM = SHRTRCR_PIDM)
            AND (SHRTRCR_PIDM, SHRTRCR_TRIT_SEQ_NO, SHRTRCR_TRAM_SEQ_NO) NOT IN
                    (SELECT SHRTRCE_PIDM,
                            SHRTRCE_TRIT_SEQ_NO,
                            SHRTRCE_TRAM_SEQ_NO
                       FROM SHRTRCE
                      WHERE     EXISTS
                                    (SELECT '1'
                                       FROM CAPP_MNPL_LOG_DETAIL
                                      WHERE     PROCESS_ID = '1900'
                                            AND STD_PIDM = SHRTRCE_PIDM)
                            AND SHRTRCE_TRIT_SEQ_NO > 1)
            AND SHRTRCR_TRIT_SEQ_NO > 1;

DELETE FROM
    SHRTRAM
      WHERE     EXISTS
                    (SELECT '1'
                       FROM CAPP_MNPL_LOG_DETAIL
                      WHERE PROCESS_ID = '1900' AND STD_PIDM = SHRTRAM_PIDM)
            AND (SHRTRAM_PIDM, SHRTRAM_TRIT_SEQ_NO, SHRTRAM_SEQ_NO) NOT IN
                    (SELECT SHRTRCE_PIDM,
                            SHRTRCE_TRIT_SEQ_NO,
                            SHRTRCE_TRAM_SEQ_NO
                       FROM SHRTRCE
                      WHERE     EXISTS
                                    (SELECT '1'
                                       FROM CAPP_MNPL_LOG_DETAIL
                                      WHERE     PROCESS_ID = '1900'
                                            AND STD_PIDM = SHRTRCE_PIDM)
                            AND SHRTRCE_TRIT_SEQ_NO > 1)
            AND SHRTRAM_TRIT_SEQ_NO > 1;


DELETE FROM
    SHRTRIT
      WHERE     (SHRTRIT_PIDM, SHRTRIT_SEQ_NO) NOT IN
                    (SELECT SHRTRAM_PIDM, SHRTRAM_TRIT_SEQ_NO FROM SHRTRAM)
            AND EXISTS
                    (SELECT '1'
                       FROM CAPP_MNPL_LOG_DETAIL
                      WHERE PROCESS_ID = '1900' AND STD_PIDM = SHRTRIT_PIDM)