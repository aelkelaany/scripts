 
INSERT INTO SPRHOLD
   SELECT SGBSTDN_PIDM,
          'RH',
          USER,
          SYSDATE,
          SYSDATE + 180,
          'N',
          NULL,
          NULL,
          NULL,
          SYSDATE,
          'Banner'
     FROM (SELECT A.SGBSTDN_PIDM
             FROM SGBSTDN A
            WHERE     A.SGBSTDN_TERM_CODE_EFF =
                         (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                            FROM SGBSTDN
                           WHERE     SGBSTDN_PIDM = A.SGBSTDN_PIDM
                                 AND SGBSTDN_TERM_CODE_EFF <= '143920')
                  AND SGBSTDN_STST_CODE = 'AS'
                  AND SGBSTDN_STYP_CODE = 'ä'
                  AND NOT EXISTS
                             (SELECT '1'
                                FROM SPRHOLD
                               WHERE     SPRHOLD_pidm = a.SGBSTDN_PIDM
                                     AND SPRHOLD_HLDD_CODE = 'RH')
           UNION
           SELECT A.SGBSTDN_PIDM
             FROM SGBSTDN A
            WHERE     A.SGBSTDN_TERM_CODE_EFF =
                         (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                            FROM SGBSTDN
                           WHERE     SGBSTDN_PIDM = A.SGBSTDN_PIDM
                                 AND SGBSTDN_TERM_CODE_EFF <= '143920')
                  AND SGBSTDN_STST_CODE = 'AS'
                  --AND SGBSTDN_STYP_CODE='ã'
                  AND SGBSTDN_DEGC_CODE_1 = 'ÏÈ'
                  AND NOT EXISTS
                             (SELECT '1'
                                FROM SPRHOLD
                               WHERE     SPRHOLD_pidm = a.SGBSTDN_PIDM
                                     AND SPRHOLD_HLDD_CODE = 'RH')
           UNION
           SELECT A.SGBSTDN_PIDM
             FROM SGBSTDN A
            WHERE     A.SGBSTDN_TERM_CODE_EFF =
                         (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                            FROM SGBSTDN
                           WHERE     SGBSTDN_PIDM = A.SGBSTDN_PIDM
                                 AND SGBSTDN_TERM_CODE_EFF <= '143920')
                  AND SGBSTDN_STST_CODE = 'AS'
                  AND SGBSTDN_DEGC_CODE_1 IN ('MA', 'ãÌ')
                  AND NOT EXISTS
                             (SELECT '1'
                                FROM SPRHOLD
                               WHERE     SPRHOLD_pidm = a.SGBSTDN_PIDM
                                     AND SPRHOLD_HLDD_CODE = 'RH'))