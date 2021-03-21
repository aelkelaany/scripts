SELECT f_get_std_id(SGBSTDN_PIDM) student_id ,   f_get_std_name(SGBSTDN_PIDM) student_name , SGBSTDN_STST_CODE , sgbstdn_dept_code
  FROM  SGBSTDN SG
 WHERE     
         SGBSTDN_TERM_CODE_EFF =
           (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
              FROM SGBSTDN
             WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                   AND SGBSTDN_TERM_CODE_EFF <= '144210')
                   and not exists (select '1' from sgradvr where sgradvr_pidm=SG.SGBSTDN_PIDM)
                   and sgbstdn_stst_code ='AS'
                                                  and sgbstdn_dept_code like '4101%'
        ;