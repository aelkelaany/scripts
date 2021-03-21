SELECT f_get_std_id(SGBSTDN_PIDM) student_id ,   f_get_std_name(SGBSTDN_PIDM) student_name , SGBSTDN_STST_CODE , sgbstdn_dept_code
  FROM  SGBSTDN SG
 WHERE     
         SGBSTDN_TERM_CODE_EFF =
           (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
              FROM SGBSTDN
             WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                   AND SGBSTDN_TERM_CODE_EFF <= '144210')
                   and SGBSTDN_TERM_CODE_ADMIT  =
                    f_get_param ('WORKFLOW', 'CURRENT_TERM', 1) 
                    and sgbstdn_dept_code='4209'
                    and sgbstdn_program_1 like '2%'


;
select min(APPLICANT_RATE) ,f_get_std_id(APPLICANT_PIDM) from VW_APPLICANT_CHOICES
where 
APPLICANT_CHOICE='2-4209-1433'
and APPLICANT_PIDM in (SELECT SGBSTDN_PIDM
  FROM  SGBSTDN SG
 WHERE     
         SGBSTDN_TERM_CODE_EFF =
           (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
              FROM SGBSTDN
             WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                   AND SGBSTDN_TERM_CODE_EFF <= '144210')
                   and SGBSTDN_TERM_CODE_ADMIT  =
                    f_get_param ('WORKFLOW', 'CURRENT_TERM', 1) 
                    and sgbstdn_dept_code='4209'
                    and sgbstdn_program_1 like '2%') 
                    group by APPLICANT_PIDM
                    order by 1 asc;
