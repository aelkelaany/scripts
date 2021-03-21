

DECLARE
   CURSOR get_std
   IS
    SELECT SGBSTDN_PIDM pidm 
  FROM sgbstdn b
 WHERE     b.sgbstdn_term_code_eff = (SELECT MAX (a.sgbstdn_term_code_eff)
                                        FROM sgbstdn a
                                       WHERE a.sgbstdn_pidm = b.sgbstdn_pidm)
       AND SGBSTDN_STST_CODE = '��'
       and B.SGBSTDN_STYP_CODE='�'
       AND SGBSTDN_LEVL_CODE IN ('��') 
        ;

BEGIN
   FOR rec IN get_std
   LOOP
      p_update_std_status (rec.pidm,
                           '144010',
                           '��',
                           'Banner');

       
       
   END LOOP;
END;


 