
SELECT sgbstdn_pidm std_pidm,
                   f_getspridenid (sgbstdn_pidm)
                || ' - '
                || f_format_name (sgbstdn_pidm, 'FML')
                   std_name   
           FROM   sgbstdn a 
          WHERE    
          exists (SELECT '1'
        FROM request_master m 
       WHERE    
               object_code = 'WF_ADDITIONAL_CHANCE'
             AND m.request_status = 'C'
             
             AND M.REQUESTER_PIDM =a.sgbstdn_pidm) 
                and sgbstdn_stst_code='ей'
                AND a.sgbstdn_term_code_eff =
                       (SELECT MAX (b.sgbstdn_term_code_eff)
                          FROM sgbstdn b
                         WHERE     b.sgbstdn_pidm = a.sgbstdn_pidm
                               AND b.sgbstdn_term_code_eff <=
                                      f_get_param ('GENERAL',
                                                   'CURRENT_TERM',
                                                   1))


                      