/* Formatted on 31/01/2022 10:09:23 (QP5 v5.227.12220.39754) */
SELECT COUNT (SGBSTDN_PIDM),substr(f_get_std_id (SGBSTDN_PIDM),1,3) stdgroup
  FROM sgbstdn b
 WHERE     b.sgbstdn_term_code_eff =
              (SELECT MAX (a.sgbstdn_term_code_eff)
                 FROM sgbstdn a
                WHERE     a.sgbstdn_pidm = b.sgbstdn_pidm
                      AND a.sgbstdn_term_code_eff <= '144320')
       AND NOT EXISTS
                  (SELECT 'y'
                     FROM sfrstcr
                    WHERE     sfrstcr_term_code = '144320'
                          AND sfrstcr_pidm = B.SGBSTDN_PIDM
                          AND sfrstcr_rsts_code IN ('RE', 'RW'))
       AND SGBSTDN_STST_CODE = 'AS'
       AND SGBSTDN_LEVL_CODE IN ('Ìã')
       group by substr(f_get_std_id (SGBSTDN_PIDM),1,3)
       order by 2;

SELECT f_get_std_id (SGBSTDN_PIDM), f_get_std_name (SGBSTDN_PIDM)
  FROM sgbstdn b
 WHERE     b.sgbstdn_term_code_eff =
              (SELECT MAX (a.sgbstdn_term_code_eff)
                 FROM sgbstdn a
                WHERE     a.sgbstdn_pidm = b.sgbstdn_pidm
                      AND a.sgbstdn_term_code_eff <= '144320')
       AND NOT EXISTS
                  (SELECT 'y'
                     FROM sfrstcr
                    WHERE     sfrstcr_term_code = '144320'
                          AND sfrstcr_pidm = B.SGBSTDN_PIDM
                          AND sfrstcr_rsts_code IN ('RE', 'RW'))
       AND SGBSTDN_STST_CODE = 'AS'
       AND SGBSTDN_LEVL_CODE IN ('Ìã');



DECLARE
   CURSOR get_std
   IS
      SELECT DISTINCT COL02 FROM bu_dev.tmp_tbl04;

BEGIN
   FOR rec IN get_std
   LOOP
     -- p_update_std_status (rec.COL02,
                           '143920',
                           'Øí',
                           'Banner');
   END LOOP;
END;