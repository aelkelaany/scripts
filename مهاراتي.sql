xwskskil


;
SELECT DISTINCT term_code, stvterm_desc term_desc
        FROM skills_enhancement_prog a, stvterm
       WHERE     term_code = stvterm_code(+)
             AND web_disp_ind = 'Y'
             AND (   TRUNC (reg_date_from) <= TRUNC (SYSDATE)
                  OR reg_date_from IS NULL)
             AND (   TRUNC (reg_date_to) >= TRUNC (SYSDATE)
                  OR reg_date_to IS NULL)
             AND (term_code = cp_term OR cp_term IS NULL)
--             AND f_check_rule (pidm, a.rule) = 'Y';