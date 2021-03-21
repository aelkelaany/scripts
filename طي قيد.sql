SELECT f_get_std_id(SGBSTDN_PIDM),f_get_std_name(SGBSTDN_PIDM)
  FROM sgbstdn b
 WHERE     b.sgbstdn_term_code_eff =
              (SELECT MAX (a.sgbstdn_term_code_eff)
                 FROM sgbstdn a
                WHERE     a.sgbstdn_pidm = b.sgbstdn_pidm
                      AND a.sgbstdn_term_code_eff <= '144010')
       AND NOT EXISTS
              (SELECT 'y'
                 FROM sfrstcr where sfrstcr_term_code='144010' and sfrstcr_pidm=B.SGBSTDN_PIDM)
                 and SGBSTDN_STST_CODE='AS'
                 and SGBSTDN_LEVL_CODE   in ('Ìã') ; 
 


DECLARE
   CURSOR get_std
   IS
      SELECT DISTINCT COL02
        FROM bu_dev.tmp_tbl04
        ;

BEGIN
   FOR rec IN get_std
   LOOP
      p_update_std_status (rec.COL02,
                           '143920',
                           'Øí',
                           'Banner');

       
       
   END LOOP;
END;