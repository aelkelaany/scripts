declare   
 p_pidm sgbstdn.sgbstdn_pidm%TYPE ;
   
 
   CURSOR get_terms_count
   IS
     SELECT COUNT (stvterm_code) ,stvterm_code  term_code
        FROM (SELECT stvterm_code,
                     (SELECT sgbstdn_stst_code
                        FROM sgbstdn x
                       WHERE     x.sgbstdn_pidm = F_GET_PIDM(:p_pidm)
                             AND x.sgbstdn_term_code_eff =
                                    (SELECT MAX (y.sgbstdn_term_code_eff)
                                       FROM sgbstdn y
                                      WHERE     y.sgbstdn_pidm =
                                                   x.sgbstdn_pidm
                                            AND y.sgbstdn_term_code_eff <=
                                                   stvterm_code))
                        status
                FROM (SELECT sgbstdn_term_code_eff
                        FROM sgbstdn
                       WHERE     sgbstdn_pidm = F_GET_PIDM(:p_pidm)
                             AND SUBSTR (sgbstdn_term_code_eff, 5) != '30') a,
                     (SELECT stvterm_code
                        FROM stvterm
                       WHERE     stvterm_code >=
                                    (SELECT MIN (sgbstdn_term_code_eff)
                                       FROM sgbstdn
                                      WHERE sgbstdn_pidm = F_GET_PIDM(:p_pidm))
                             AND SUBSTR (stvterm_code, 5) != '30') b
               WHERE     a.sgbstdn_term_code_eff(+) = b.stvterm_code
                     AND stvterm_code <
                            f_get_param ('WORKFLOW', 'CURRENT_TERM', 1))
       WHERE status = 'Øí'
       GROUP BY stvterm_code  ;

   l_disconnected_term_count   NUMBER:=0;
BEGIN
   for rec in  get_terms_count loop 

    dbms_output.put_line( rec.term_code   );  
 l_disconnected_term_count:=1+l_disconnected_term_count;
   end loop ; 

   dbms_output.put_line(  'Total of disconnected period--->>'|| l_disconnected_term_count ); 
   
   end ;