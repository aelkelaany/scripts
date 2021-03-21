--delete bu_dev.tmp_tbl03  where COL01 is null ;
-- update bu_dev.tmp_tbl03 set COL02=f_get_pidm(trim(COL01));
DECLARE
   CURSOR get_std
   IS
      SELECT DISTINCT COL02
        FROM bu_dev.tmp_tbl03 ;
        

BEGIN 
   FOR rec IN get_std
   LOOP
      p_update_std_status (rec.COL02,
                           '144030',
                           'AS',
                           'Banner');

     /* UPDATE SHRDGMR
         SET SHRDGMR_DEGS_CODE = 'SO',
             SHRDGMR_GRAD_DATE = NULL,
             SHRDGMR_TERM_CODE_GRAD = NULL,
             SHRDGMR_ACYR_CODE = NULL,
             SHRDGMR_GRST_CODE = NULL,
             SHRDGMR_AUTHORIZED = NULL
       WHERE SHRDGMR_pidm = rec.COL02 AND SHRDGMR_DEGS_CODE = 'ÎÌ';  /*return the student to be not-graduated    */
   END LOOP;
END;


--exec p_update_std_status (f_get_pidm('438000906'),'143810','AS','Banner');

/*update sgbstdn set SGBSTDN_STYP_CODE='ã'
WHERE SGBSTDN_PIDM IN(SELECT DISTINCT COL02
        FROM bu_dev.tmp_tbl03)
        AND SGBSTDN_TERM_CODE_EFF='144030'*/
 
