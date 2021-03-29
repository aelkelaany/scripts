/* Formatted on 25/03/2021 11:55:57 (QP5 v5.227.12220.39754) */
UPDATE bu_dev.tmp_tbl03
   SET COL02 = f_get_pidm (TRIM (COL01));

SELECT DISTINCT COL01
  FROM bu_dev.tmp_tbl03
 WHERE COL02 IS NULL;

DECLARE
   CURSOR get_std
   IS
      SELECT DISTINCT COL02
        FROM bu_dev.tmp_tbl03
       WHERE EXISTS
                (SELECT 'x'
                   FROM sgbstdn a
                  WHERE     A.SGBSTDN_TERM_CODE_EFF =
                               (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                  FROM SGBSTDN
                                 WHERE     SGBSTDN_PIDM = A.SGBSTDN_PIDM
                                       AND SGBSTDN_TERM_CODE_EFF <= '144010')
                        AND SGBSTDN_STST_CODE = 'AS');

BEGIN
   FOR rec IN get_std
   LOOP
      p_update_std_status (rec.COL02,
                           '144010',
                           'гд',
                           'Banner');
   END LOOP;
END;