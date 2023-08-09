--  check gpa equal to excellent 
SELECT RWTPAYR_TRAN_NUMBER,
       RWTPAYR_PIDM,
       RWTPAYR_ID,
       RWTPAYR_NAME,
       RWTPAYR_CAMP_CODE,
       RWTPAYR_CAMP_DESC,
       RWTPAYR_COLL_CODE,
       RWTPAYR_COLL_DESC,
       RWTPAYR_DEPT_CODE,
       RWTPAYR_DEPT_DESC,
       RWTPAYR_LEVEL_CODE,
       RWTPAYR_LEVEL_DESC,
       RWTPAYR_TERM_CODE,
       RWTPAYR_TERM_DESC,
       RWTPAYR_EFF_YEAR,
       RWTPAYR_EFF_MONTH,
       RWTPAYR_FA_YEAR,
       RWTPAYR_CHARGE,
       RWTPAYR_PAYMENT,
       RWTPAYR_DEDUCTION,
       RWTPAYR_ACTIVITY_DATE,
       RWTPAYR_CELG_CODE,
       RWTPAYR_CELG_DESC,
       RWTPAYR_REG_EXP_FLAG,
       RWTPAYR_PROCESSED_FLAG,
       RWTPAYR_CHRG_PROCESS_FLAG,
       RWTPAYR_DEDCT_PROCESS_FLAG,
       RWTPAYR_NON_FA_DED,
       RWTPAYR_PREV_PAYMENT,
       RWTPAYR_NOTE,
       RWTPAYR_USER
  FROM SATURN.RWTPAYR
 WHERE     RWTPAYR_TRAN_NUMBER = 906
       AND    EXISTS
               (SELECT '1'
                  FROM shrtgpa, SHRASTR
                 WHERE     shrtgpa_PIDM = RWTPAYR_PIDM
                       AND shrtgpa_TERM_CODE = '144430'
                       AND shrtgpa_gpa BETWEEN SHRASTR_MIN_GPA_CUM
                                           AND SHRASTR_MAX_GPA_CUM
                       AND SHRASTR_TERM_CODE_EFFECTIVE =
                           (SELECT MAX (SHRASTR_TERM_CODE_EFFECTIVE)
                              FROM SHRASTR
                             WHERE SHRASTR_LEVL_CODE = RWTPAYR_LEVEL_CODE
                             AND SHRASTR_COLL_CODE = '99'
                       AND SHRASTR_ASTD_CODE_NEXT = 'דד')
                       AND SHRASTR_COLL_CODE = '99'
                       AND SHRASTR_ASTD_CODE_NEXT = 'דד') ;
                       
------------------------

SELECT RWTPAYR_TRAN_NUMBER,
       RWTPAYR_PIDM,
       RWTPAYR_ID,
       RWTPAYR_NAME,
       RWTPAYR_CAMP_CODE,
       RWTPAYR_CAMP_DESC,
       RWTPAYR_COLL_CODE,
       RWTPAYR_COLL_DESC,
       RWTPAYR_DEPT_CODE,
       RWTPAYR_DEPT_DESC,
       RWTPAYR_LEVEL_CODE,
       RWTPAYR_LEVEL_DESC,
       RWTPAYR_TERM_CODE,
       RWTPAYR_TERM_DESC,
       RWTPAYR_EFF_YEAR,
       RWTPAYR_EFF_MONTH,
       RWTPAYR_FA_YEAR,
       RWTPAYR_CHARGE,
       RWTPAYR_PAYMENT,
       RWTPAYR_DEDUCTION,
       RWTPAYR_ACTIVITY_DATE,
       RWTPAYR_CELG_CODE,
       RWTPAYR_CELG_DESC,
       RWTPAYR_REG_EXP_FLAG,
       RWTPAYR_PROCESSED_FLAG,
       RWTPAYR_CHRG_PROCESS_FLAG,
       RWTPAYR_DEDCT_PROCESS_FLAG,
       RWTPAYR_NON_FA_DED,
       RWTPAYR_PREV_PAYMENT,
       RWTPAYR_NOTE,
       RWTPAYR_USER
  FROM SATURN.RWTPAYR
 WHERE     RWTPAYR_TRAN_NUMBER = 906 
 and exists (select '1' from shrdgmr where shrdgmr_pidm=RWTPAYR_PIDM and  SHRDGMR_DEGS_CODE='־ּ' /*and SHRDGMR_TERM_CODE_GRAD like'1444%'*/)
 ;
 
 its_met_fa