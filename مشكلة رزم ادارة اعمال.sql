/* Formatted on 9/9/2019 8:17:41 AM (QP5 v5.227.12220.39754) */
-- CREATE TABLE BU_DEV.SFRSTCR08092019 AS SELECT * FROM SFRSTCR WHERE SFRSTCR_TERM_CODE='144010' ;

DELETE FROM                                       --SELECT   SFRSTCR_PIDM FROM
           SFRSTCR
      WHERE     SFRSTCR_TERM_CODE = '144010'
            AND SFRSTCR_PIDM IN
                   (SELECT A.SGBSTDN_PIDM
                      FROM SGBSTDN A
                     WHERE     A.SGBSTDN_TERM_CODE_EFF =
                                  (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                     FROM SGBSTDN
                                    WHERE     SGBSTDN_PIDM = A.SGBSTDN_PIDM
                                          AND SGBSTDN_TERM_CODE_EFF <=
                                                 '144010')
                           AND SGBSTDN_STST_CODE = 'AS'
                           AND A.SGBSTDN_STYP_CODE = 'ã'
                           AND SGBSTDN_COLL_CODE_1 = '16'
                           AND A.sgbstdn_blck_code LIKE 'L%'
                           AND SUBSTR (F_GET_STD_ID (A.SGBSTDN_PIDM), 1, 3) =
                                  '441'
                           AND EXISTS
                                  (SELECT '1'
                                     FROM SARAPPD
                                    WHERE     SARAPPD_PIDM = A.SGBSTDN_PIDM
                                          AND SARAPPD_APDC_CODE = 'FA'
                                          AND SARAPPD_TERM_CODE_ENTRY =
                                                 '144010'));



INSERT INTO GLBSLCT (GLBSLCT_APPLICATION,
                     GLBSLCT_SELECTION,
                     GLBSLCT_CREATOR_ID,
                     GLBSLCT_DESC,
                     GLBSLCT_LOCK_IND,
                     GLBSLCT_ACTIVITY_DATE,
                     GLBSLCT_TYPE_IND)
     VALUES ('STUDENT',
             'BLOCKS_REGS_BA_144010',
             'SAISUSR',
             'ÊÓÌíá ÑÒã 144010 ÇÏÇÑÉ ÇÚãÇá ',
             'N',
             SYSDATE,
             NULL);

INSERT INTO GLBEXTR
   SELECT 'STUDENT',
          'BLOCKS_REGS_BA_144010',
          'SAISUSR',
          'SAISUSR',
          SGBSTDN_PIDM,
          SYSDATE,
          'S',
          NULL
     FROM (SELECT A.SGBSTDN_PIDM
             FROM SGBSTDN A
            WHERE     A.SGBSTDN_TERM_CODE_EFF =
                         (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                            FROM SGBSTDN
                           WHERE     SGBSTDN_PIDM = A.SGBSTDN_PIDM
                                 AND SGBSTDN_TERM_CODE_EFF <= '144010')
                  AND SGBSTDN_STST_CODE = 'AS'
                  AND A.SGBSTDN_STYP_CODE = 'ã'
                  AND SGBSTDN_COLL_CODE_1 = '16'
                  AND A.sgbstdn_blck_code LIKE 'L%'
                  AND SUBSTR (F_GET_STD_ID (A.SGBSTDN_PIDM), 1, 3) = '441'
                  AND EXISTS
                         (SELECT '1'
                            FROM SARAPPD
                           WHERE     SARAPPD_PIDM = A.SGBSTDN_PIDM
                                 AND SARAPPD_APDC_CODE = 'FA'
                                 AND SARAPPD_TERM_CODE_ENTRY = '144010')
                  AND NOT EXISTS
                             (SELECT 'C'
                                FROM SFRSTCR
                               WHERE     SFRSTCR_PIDM = A.SGBSTDN_PIDM
                                     AND SFRSTCR_TERM_CODE = '144010'
                                     AND SFRSTCR_RSTS_CODE IN ('RE', 'RW')));



UPDATE SGBSTDN A
   SET A.sgbstdn_blck_code = NULL
 WHERE SGBSTDN_PIDM IN
          (SELECT A.SGBSTDN_PIDM
             FROM SGBSTDN A
            WHERE     A.SGBSTDN_TERM_CODE_EFF =
                         (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                            FROM SGBSTDN
                           WHERE     SGBSTDN_PIDM = A.SGBSTDN_PIDM
                                 AND SGBSTDN_TERM_CODE_EFF <= '144010')
                  AND SGBSTDN_STST_CODE = 'AS'
                  AND A.SGBSTDN_STYP_CODE = 'ã'
                  AND SGBSTDN_COLL_CODE_1 = '16'
                  AND A.sgbstdn_blck_code LIKE 'L%'
                  AND SUBSTR (F_GET_STD_ID (A.SGBSTDN_PIDM), 1, 3) = '441' /*  AND   EXISTS
                                                                                  (SELECT '1'
                                                                                     FROM GLBEXTR
                                                                                    WHERE     SARAPPD_PIDM = A.SGBSTDN_PIDM
                                                                                          AND SARAPPD_APDC_CODE = 'FA'
                                                                                          AND SARAPPD_TERM_CODE_ENTRY = '144010') */
                                                                          );



                 -- SGRASSI



UPDATE ssbsect
   SET SSBSECT_ENRL =
          (SELECT COUNT (*)
             FROM sfrstcr
            WHERE     sfrstcr_term_code = '144010'
                  AND sfrstcr_crn = ssbsect_crn
                  AND SFRSTCR_RSTS_CODE IN ('RE', 'RW'))
 WHERE     ssbsect_term_code = '144010'
       AND ssbsect_crn IN
              (SELECT SSRBLCK_CRN
                 FROM ssrblck
                WHERE     ssrblck_term_code = '144010'
                      AND SSRBLCK_BLCK_CODE LIKE 'L%');

UPDATE ssbsect
   SET SSBSECT_MAX_ENRL = SSBSECT_ENRL
 WHERE     ssbsect_term_code = '144010'
       AND ssbsect_crn IN
              (SELECT SSRBLCK_CRN
                 FROM ssrblck
                WHERE     ssrblck_term_code = '144010'
                      AND SSRBLCK_BLCK_CODE LIKE 'L%');

UPDATE ssbsect
   SET SSBSECT_SEATS_AVAIL = SSBSECT_MAX_ENRL - SSBSECT_ENRL
 WHERE     ssbsect_term_code = '144010'
       AND ssbsect_crn IN
              (SELECT SSRBLCK_CRN
                 FROM ssrblck
                WHERE     ssrblck_term_code = '144010'
                      AND SSRBLCK_BLCK_CODE LIKE 'L%');