DECLARE
   CURSOR get_std
   IS
--      SELECT DISTINCT COL02 pidm
--        FROM bu_dev.tmp_tbl03 ;
      -- WHERE COL01 != '42900089';
select f_get_pidm ('437011006') pidm from dual ;
BEGIN
   FOR rec IN get_std
   LOOP
      BU_APPS.p_update_std_status (rec.pidm,
                           '144020',
                           'AS',
                           'Banner');

       UPDATE SHRDGMR
         SET SHRDGMR_DEGS_CODE = 'SO',
             SHRDGMR_GRAD_DATE = NULL,
             SHRDGMR_TERM_CODE_GRAD = NULL,
             SHRDGMR_ACYR_CODE = NULL,
             SHRDGMR_GRST_CODE = NULL,
             SHRDGMR_AUTHORIZED = NULL
       WHERE SHRDGMR_pidm = rec.pidm AND SHRDGMR_DEGS_CODE = 'ÎÌ';  /*return the student to be not-graduated */    
   END LOOP;
END;
