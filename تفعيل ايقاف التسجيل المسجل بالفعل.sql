/* Formatted on 12/5/2019 10:27:25 AM (QP5 v5.227.12220.39754) */
DECLARE
   CURSOR get_std
   IS
      SELECT SGBSTDN_PIDM pidm,
             f_get_std_id (SGBSTDN_PIDM),
             f_get_std_name (SGBSTDN_PIDM)
        FROM sgbstdn b
       WHERE     b.sgbstdn_term_code_eff =
                    (SELECT MAX (a.sgbstdn_term_code_eff)
                       FROM sgbstdn a
                      WHERE     a.sgbstdn_pidm = b.sgbstdn_pidm
                            AND a.sgbstdn_term_code_eff <= '144010')
             AND EXISTS
                    (SELECT 'y'
                       FROM sfrstcr
                      WHERE     sfrstcr_term_code = '144010'
                            AND sfrstcr_pidm = B.SGBSTDN_PIDM)
             AND SGBSTDN_STST_CODE = 'ÅÊ'
             AND SGBSTDN_LEVL_CODE IN ('Ìã');

BEGIN
   FOR rec IN get_std
   LOOP
      p_update_std_status (rec.pidm,
                           '144010',
                           'AS',
                           'Banner');
   END LOOP;
END;