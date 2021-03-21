/*   */
DECLARE
   CURSOR get_std
   IS
      SELECT DISTINCT COL02
        FROM bu_dev.tmp_tbl03
       WHERE COL01 != '42900089';

BEGIN
   FOR rec IN get_std
   LOOP
      p_update_std_status (rec.COL02,
                           '143920',
                           'AS',
                           'Banner');

      UPDATE SHRDGMR
         SET SHRDGMR_DEGS_CODE = 'SO',
             SHRDGMR_GRAD_DATE = NULL,
             SHRDGMR_TERM_CODE_GRAD = NULL,
             SHRDGMR_ACYR_CODE = NULL,
             SHRDGMR_GRST_CODE = NULL,
             SHRDGMR_AUTHORIZED = NULL
       WHERE SHRDGMR_pidm = rec.COL02 AND SHRDGMR_DEGS_CODE = 'ÎÌ';  /*return the student to be not-graduated    */
   END LOOP;
END;