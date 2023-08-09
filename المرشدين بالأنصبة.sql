/* Formatted on 3/22/2023 10:58:59 AM (QP5 v5.371) */
  SELECT  SIRDPCL_coll_CODE , f_get_desc_fnc ('stvcoll', SIRDPCL_coll_CODE, 30) coll_desc , SIRDPCL_DEPT_CODE,
         f_get_desc_fnc ('stvdept', SIRDPCL_DEPT_CODE, 30)
             dept_CODE,SIRDPCL_HOME_IND ,
         f_get_std_id (SIRDPCL_PIDM),
         f_get_std_name (SIRDPCL_PIDM),
         spbpers_sex,
         spbpers_ssn,
         (SELECT COUNT (sgradvr_pidm)
            FROM sgradvr c
           WHERE     SGRADVR_TERM_CODE_EFF =
                     (SELECT MAX (SGRADVR_TERM_CODE_EFF)
                        FROM SGRADVR
                       WHERE SGRADVR_PIDM = c.SGRADVR_PIDM)
                 AND SGRADVR_ADVR_pidm = SIRDPCL_PIDM and f_get_level(c.SGRADVR_PIDM)='œ»') count_of_std_dplm,
                 (SELECT COUNT (sgradvr_pidm)
            FROM sgradvr c
           WHERE     SGRADVR_TERM_CODE_EFF =
                     (SELECT MAX (SGRADVR_TERM_CODE_EFF)
                        FROM SGRADVR
                       WHERE SGRADVR_PIDM = c.SGRADVR_PIDM)
                 AND SGRADVR_ADVR_pidm = SIRDPCL_PIDM and f_get_level(c.SGRADVR_PIDM)='Ã„') count_of_std_ba ,(SELECT COUNT (sgradvr_pidm)
            FROM sgradvr c
           WHERE     SGRADVR_TERM_CODE_EFF =
                     (SELECT MAX (SGRADVR_TERM_CODE_EFF)
                        FROM SGRADVR
                       WHERE SGRADVR_PIDM = c.SGRADVR_PIDM)
                 AND SGRADVR_ADVR_pidm = SIRDPCL_PIDM and f_get_level(c.SGRADVR_PIDM)='MA') count_of_std_ma
    FROM SIRDPCL a, sibinst, spbpers
   WHERE     SIRDPCL_PIDM = SIBINST_PIDM
         AND spbpers_pidm = SIRDPCL_PIDM
         AND SIRDPCL_TERM_CODE_EFF = (SELECT MAX (SIRDPCL_TERM_CODE_EFF)
                                        FROM SIRDPCL
                                       WHERE SIRDPCL_PIDM = a.SIRDPCL_pidm)
          
         AND SIBINST_FCST_CODE = '‰'
         AND SIBINST_TERM_CODE_EFF = (SELECT MAX (SIBINST_TERM_CODE_EFF)
                                        FROM SIBINST
                                       WHERE SIRDPCL_PIDM = SIBINST_PIDM)
ORDER BY 1,3

