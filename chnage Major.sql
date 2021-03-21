/* Formatted on 5/9/2019 2:06:10 PM (QP5 v5.227.12220.39754) */
DECLARE
   CURSOR GET_STD
   IS
      SELECT SGBSTDN_PIDM
        FROM mjr_tmp
       WHERE old_major = '1716';

BEGIN
   FOR rec IN GET_STD
   LOOP
     -- UPDATE sgbstdn a
         SET a.SGBSTDN_MAJR_CODE_1 = '1706',
             a.SGBSTDN_DATA_ORIGIN = 'BannerIT',
             SGBSTDN_ACTIVITY_DATE = SYSDATE
       WHERE     sgbstdn_pidm = rec.sgbstdn_pidm
             AND a.SGBSTDN_TERM_CODE_EFF =
                    (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                       FROM SGBSTDN
                      WHERE     SGBSTDN_pidm = a.SGBSTDN_pidm
                            AND SGBSTDN_TERM_CODE_EFF <= '143920')
             AND SGBSTDN_MAJR_CODE_1 = '1716';


     -- UPDATE sorlfos a
         SET a.SORLFOS_MAJR_CODE = '1706',
             a.SORLFOS_DATA_ORIGIN = 'BannerIT',
             SORLFOS_ACTIVITY_DATE = SYSDATE,
             a.SORLFOS_DEPT_CODE = '1706',
             a.SORLFOS_LFOS_RULE = '172'
       WHERE     sorlfos_pidm = rec.sgbstdn_pidm
            
             AND SORLFOS_LCUR_SEQNO IN
                    (SELECT SORLCUR_SEQNO
                       FROM SORLCUR
                      WHERE     SORLCUR_pidm = a.sorlfos_pidm
                            AND SORLCUR_LMOD_CODE IN ('LEARNER', 'OUTCOME'))
             AND SORLFOS_MAJR_CODE = '1716';
   END LOOP;
END;