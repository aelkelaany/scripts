
update bu_dev.tmp_tbl03 set COL02=f_get_pidm(trim(COL01)) ;

select distinct COL01 from bu_dev.tmp_tbl03
WHERE  COL02 IS   NULL ;

DECLARE
   CURSOR get_std
   IS
/* Formatted on 10/30/2019 10:09:55 AM (QP5 v5.227.12220.39754) */
SELECT DISTINCT COL02
  FROM bu_dev.tmp_tbl03
 WHERE   EXISTS
              (SELECT 'x'
                 FROM sgbstdn a
                WHERE     A.SGBSTDN_TERM_CODE_EFF =
                             (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN
                               WHERE     SGBSTDN_PIDM = A.SGBSTDN_PIDM
                                     AND SGBSTDN_TERM_CODE_EFF <= '144010')
                      AND SGBSTDN_STST_CODE = 'AS')
        ;



BEGIN
   FOR rec IN get_std
   LOOP
      p_update_std_status (rec.COL02,
                           '144010',
                           'гд',
                           'Banner');

       
   END LOOP;
END;

 