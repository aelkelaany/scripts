/* Formatted on 6/30/2022 11:40:45 AM (QP5 v5.371) */
  SELECT f_get_std_id (SPBPERS_PIDM)
             AS "«·—ﬁ„ «·Ã«„⁄Ì",
         f_get_std_name (SPBPERS_PIDM)
             StudentName,
         f_get_desc_fnc ('stvlevl', SHRDGMR_LEVL_CODE, 30)
             LEVL_CODE ,
         f_get_desc_fnc ('stvmajr', SHRDGMR_majr_CODE_1, 30)
             major_CODE ,
         DECODE (SPBPERS_SEX, 'M', '–ﬂ—', '«‰ÀÏ')
             SPBPERS_SEX,
         to_char(SHRDGMR_GRAD_DATE,'dd-mm-yyyy','nls_calendar=''arabic hijrah''') GRAD_DATE
              ,
         ROUND (SHRLGPA_GPA, 2)
             GpA
    FROM shrdgmr,
         spbpers,
         shrlgpa,
         spriden
   WHERE     SPBPERS_PIDM = SHRDGMR_PIDM
         AND SHRLGPA_PIDM = SPBPERS_PIDM
         AND SPRIDEN_PIDM = SHRLGPA_PIDM
         AND SPRIDEN_PIDM = SHRDGMR_PIDM
         -- AND SHRDGMR_TERM_CODE_GRAD = '144320'
         AND SHRDGMR_DEGS_CODE = 'ŒÃ'
         AND SHRDGMR_coll_CODE_1 = '35'
         AND SPRIDEN_CHANGE_IND IS NULL
         AND SHRLGPA_LEVL_CODE = SHRDGMR_LEVL_CODE
         AND SHRLGPA_GPA_TYPE_IND = 'O'
ORDER BY   
         SHRDGMR_DEPT_CODE,
         SPBPERS_SEX,
         SHRDGMR_GRAD_DATE;