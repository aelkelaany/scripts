/* Formatted on 6/30/2022 8:22:35 AM (QP5 v5.371) */
  SELECT f_get_desc_fnc ('stvlevl', SHRDGMR_LEVL_CODE, 30)       LEVL_CODE,
         f_get_desc_fnc ('stvcoll', SHRDGMR_coll_CODE_1, 30)     coll_CODE,
         f_get_desc_fnc ('stvdept', SHRDGMR_DEPT_CODE, 30)       DEPT_CODE,
         
         DECODE (SPBPERS_SEX, 'M', '–ﬂ—', '«‰ÀÏ')         SPBPERS_SEX,
         COUNT (SHRDGMR_PIDM)
    FROM shrdgmr, spbpers
   WHERE     SPBPERS_PIDM = SHRDGMR_PIDM
         AND SHRDGMR_TERM_CODE_GRAD = '144320'
         AND SHRDGMR_DEGS_CODE = 'ŒÃ'
GROUP BY SHRDGMR_LEVL_CODE,
         SHRDGMR_coll_CODE_1,
         SHRDGMR_DEPT_CODE,
         
         SPBPERS_SEX
UNION  all
  SELECT f_get_desc_fnc ('stvlevl', sgbstdn_LEVL_CODE, 30)       LEVL_CODE,
         f_get_desc_fnc ('stvcoll', sgbstdn_coll_CODE_1, 30)     coll_CODE,
         f_get_desc_fnc ('stvdept', sgbstdn_DEPT_CODE, 30)       DEPT_CODE,
        
         DECODE (SPBPERS_SEX, 'M', '–ﬂ—', '«‰ÀÏ')         SPBPERS_SEX,
         COUNT (sgbstdn_PIDM)
    FROM sgbstdn sg, spbpers
   WHERE     SGBSTDN_TERM_CODE_EFF =
             (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                FROM sgbstdn
               WHERE     sgbstdn_pidm = sg.sgbstdn_pidm
                     AND SGBSTDN_TERM_CODE_EFF <= '144320')
         AND SPBPERS_pidm = sg.sgbstdn_pidm
         AND sgbstdn_stst_code IN ('AS',
                                   '„Ê',
                                   '„⁄',
                                   'ÿ„',
                                   '≈ﬁ',
                                   '›ﬂ')
GROUP BY sgbstdn_LEVL_CODE,
         sgbstdn_coll_CODE_1,
         sgbstdn_DEPT_CODE,
        
         SPBPERS_SEX