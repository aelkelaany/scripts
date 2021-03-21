/* Formatted on 2/25/2020 1:51:11 PM (QP5 v5.227.12220.39754) */

drop function get_sgbstdn_eff_term ;
CREATE FUNCTION get_sgbstdn_eff_term (pidm NUMBER)
   RETURN VARCHAR2
IS
   CURSOR get_eff_term
   IS
      SELECT MAX (SGBSTDN_TERM_CODE_EFF)
        FROM SGBSTDN
       WHERE     SGBSTDN_PIDM = PIDM
             AND SGBSTDN_TERM_CODE_EFF <=
                    f_get_param ('WORKFLOW', 'CURRENT_TERM', 1);

   l_eff_term   SGBSTDN.SGBSTDN_TERM_CODE_EFF%TYPE;
BEGIN
   OPEN get_eff_term;

   FETCH get_eff_term INTO l_eff_term;

   CLOSE get_eff_term;

   RETURN l_eff_term;
END;

create public synonym get_sgbstdn_eff_term for bu_apps.get_sgbstdn_eff_term ;

grant execute  on bu_apps.get_sgbstdn_eff_term to public  ;

AND SGBSTDN_TERM_CODE_EFF =GET_SGBSTDN_EFF_TERM(SGBSTDN_PIDM)