/* Formatted on 3/22/2023 10:58:59 AM (QP5 v5.371) */
  SELECT SIRDPCL_PIDM , SIRDPCL_DEPT_CODE,
         f_get_desc_fnc ('stvdept', SIRDPCL_DEPT_CODE, 30)
             dept_CODE,
         f_get_std_id (SIRDPCL_PIDM),
         f_get_std_name (SIRDPCL_PIDM),
         spbpers_sex,
         spbpers_ssn,  SIRDPCL_TERM_CODE_EFF ,
         (SELECT COUNT (sgradvr_pidm)
            FROM sgradvr c
           WHERE     SGRADVR_TERM_CODE_EFF =
                     (SELECT MAX (SGRADVR_TERM_CODE_EFF)
                        FROM SGRADVR
                       WHERE SGRADVR_PIDM = c.SGRADVR_PIDM)
                 AND SGRADVR_ADVR_pidm = SIRDPCL_PIDM and f_get_level(c.SGRADVR_PIDM)='Ã„') count_of_std
    FROM SIRDPCL a, sibinst, spbpers
   WHERE     SIRDPCL_PIDM = SIBINST_PIDM
         AND spbpers_pidm = SIRDPCL_PIDM
         AND SIRDPCL_TERM_CODE_EFF = (SELECT MAX (SIRDPCL_TERM_CODE_EFF)
                                        FROM SIRDPCL
                                       WHERE SIRDPCL_PIDM = a.SIRDPCL_pidm)
         -- and (SIRDPCL_DEPT_CODE like '41__' or SIRDPCL_DEPT_CODE='1705')
         -- and f_get_desc_fnc('stvdept',SIRDPCL_DEPT_CODE,30) like '%Õ«”»%'
         -- and  SIRDPCL_coll_CODE   in ('41','17','18','42','19')
         AND SIRDPCL_DEPT_CODE LIKE '42%'
         AND SIBINST_FCST_CODE = '‰'
         AND SIBINST_TERM_CODE_EFF = (SELECT MAX (SIBINST_TERM_CODE_EFF)
                                        FROM SIBINST
                                       WHERE SIRDPCL_PIDM = SIBINST_PIDM)
                                       
                                        and  exists (select '1' from sirasgn 
                                        where sirasgn_pidm=SIBINST_PIDM
                                        and sirasgn_term_code='144510' )
ORDER BY 1