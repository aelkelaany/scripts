 DECLARE
   CURSOR get_std
   IS
      SELECT SGBSTDN_PIDM pidm
          
     FROM SGBSTDN SG
    WHERE     SGBSTDN_TERM_CODE_EFF =
                 (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                    FROM SGBSTDN
                   WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                         AND SGBSTDN_TERM_CODE_EFF <= '144010')
          AND SGBSTDN_STST_CODE   IN ('Øí')
          AND SGBSTDN_STYP_CODE = 'È' ;

BEGIN
   FOR rec IN get_std
   LOOP
      p_update_std_status (rec.pidm,
                           '144010',
                           'AS',
                           'Banner');

       
   END LOOP;
END; 