UPDATE sgbstdn a
         SET a.SGBSTDN_MAJR_CODE_1 = '1315',
             a.SGBSTDN_DATA_ORIGIN = 'BannerIT',
             SGBSTDN_ACTIVITY_DATE = SYSDATE
       WHERE     sgbstdn_pidm = f_get_pidm('435008122')
             AND a.SGBSTDN_TERM_CODE_EFF =
                    (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                       FROM SGBSTDN
                      WHERE     SGBSTDN_pidm = a.SGBSTDN_pidm
                            AND SGBSTDN_TERM_CODE_EFF <= '143920')
             AND SGBSTDN_MAJR_CODE_1 = '1301';


      UPDATE sorlfos a
         SET a.SORLFOS_MAJR_CODE = '1315',
             a.SORLFOS_DATA_ORIGIN = 'BannerIT',
             SORLFOS_ACTIVITY_DATE = SYSDATE,
             a.SORLFOS_DEPT_CODE = '1315',
             a.SORLFOS_LFOS_RULE = '319'
       WHERE     sorlfos_pidm = f_get_pidm('435008122')
            
             AND SORLFOS_LCUR_SEQNO IN
                    (SELECT SORLCUR_SEQNO
                       FROM SORLCUR
                      WHERE     SORLCUR_pidm = f_get_pidm('435008122')
                            AND SORLCUR_LMOD_CODE IN ('LEARNER', 'OUTCOME'))
             AND SORLFOS_MAJR_CODE = '1301';
             
             shrdgmr