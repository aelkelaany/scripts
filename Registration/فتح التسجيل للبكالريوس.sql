 
DELETE FROM sfbetrm
      WHERE SFBETRM_TERM_CODE = '144220';


UPDATE SPRHOLD
   SET SPRHOLD_FROM_DATE = SPRHOLD_FROM_DATE - 100,
       SPRHOLD_TO_DATE = SYSDATE + 100
 WHERE SPRHOLD_HLDD_CODE = 'RH';


INSERT INTO SPRHOLD (SPRHOLD_PIDM,
                     SPRHOLD_HLDD_CODE,
                     SPRHOLD_USER,
                     SPRHOLD_FROM_DATE,
                     SPRHOLD_TO_DATE,
                     SPRHOLD_RELEASE_IND,
                     SPRHOLD_REASON,
                     SPRHOLD_AMOUNT_OWED,
                     SPRHOLD_ORIG_CODE,
                     SPRHOLD_ACTIVITY_DATE,
                     SPRHOLD_DATA_ORIGIN)
   SELECT a.sgbstdn_pidm,
          'RH',
          'SAISUSR',
          SYSDATE - 3,
          SYSDATE + 1000,
          'N',
          NULL,
          NULL,
          NULL,
          SYSDATE,
          'Banner IT'
     FROM sgbstdn a
    WHERE     NOT EXISTS
                     (SELECT '1'
                        FROM sprhold
                       WHERE     sprhold_pidm = a.sgbstdn_pidm
                             AND SPRHOLD_HLDD_CODE = 'RH')
          AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                         FROM sgbstdn
                                        WHERE sgbstdn_pidm = a.sgbstdn_pidm)
          AND SGBSTDN_STST_CODE IN ('AS');



DELETE FROM sprhold
      WHERE     EXISTS
                   (SELECT DISTINCT f_get_std_id (SGBSTDN_PIDM)
                      FROM SGBSTDN SG
                     WHERE     SGBSTDN_TERM_CODE_EFF =
                                  (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                     FROM SGBSTDN
                                    WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                           AND SGBSTDN_STST_CODE IN ('AS')
                           AND SGBSTDN_DEGC_CODE_1 IN ('»ﬂ')
                           AND SGBSTDN_LEVL_CODE = 'Ã„'
                           AND SGBSTDN_STYP_CODE IN ('„', ' ')
                           AND sprhold_pidm = SG.sgbstdn_pidm)
            AND SPRHOLD_HLDD_CODE = 'RH';
            
            -------------time ticket------------
            DELETE 
 FROM sprhold
      WHERE     EXISTS
 (select '1' from SFBRGRP where SFBRGRP_pidm=sprhold_pidm and SFBRGRP_TERM_CODE='144310'  ) 
            AND SPRHOLD_HLDD_CODE = 'RH';