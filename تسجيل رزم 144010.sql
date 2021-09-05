/* Formatted on 9/1/2019 10:14:30 AM (QP5 v5.227.12220.39754) */
INSERT INTO GLBSLCT (GLBSLCT_APPLICATION,
                     GLBSLCT_SELECTION,
                     GLBSLCT_CREATOR_ID,
                     GLBSLCT_DESC,
                     GLBSLCT_LOCK_IND,
                     GLBSLCT_ACTIVITY_DATE,
                     GLBSLCT_TYPE_IND)
     VALUES ('STUDENT',
             'BLOCKS_REGS_144310',
             'SAISUSR',
             ' ”ÃÌ· —“„ 144310  ',
             'N',
             SYSDATE,
             NULL);

INSERT INTO GLBEXTR
   SELECT 'STUDENT',
          'BLOCKS_REGS_144310',
          'SAISUSR',
          'SAISUSR',
          SGBSTDN_PIDM,
          SYSDATE,
          'S',
          NULL
     FROM (SELECT DISTINCT A.SGBSTDN_PIDM
             FROM SGBSTDN A
            WHERE     A.SGBSTDN_TERM_CODE_EFF =
                         (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                            FROM SGBSTDN
                           WHERE SGBSTDN_PIDM = A.SGBSTDN_PIDM)
                  AND SGBSTDN_STST_CODE = 'AS'
                  AND A.SGBSTDN_STYP_CODE = '„'
                  AND SGBSTDN_TERM_CODE_ADMIT = '144310'
                  AND EXISTS
                         (SELECT '1'
                            FROM SARAPPD
                           WHERE     SARAPPD_PIDM = A.SGBSTDN_PIDM
                                 AND SARAPPD_APDC_CODE = 'FA'
                                 AND SARAPPD_TERM_CODE_ENTRY = '144310'));


 --delete from GLBEXTR where  GLBEXTR_SELECTION='BLOCKS_REGS_144010' ;

 ------

UPDATE SYRBLKR
   SET SYRBLKR_CAPACITY_USED = 0
 WHERE SYRBLKR_TERM_CODE = '144310';

UPDATE SGBSTDN A
   SET A.sgbstdn_blck_code = NULL
 WHERE     A.SGBSTDN_TERM_CODE_EFF =
              (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                 FROM SGBSTDN
                WHERE     SGBSTDN_PIDM = A.SGBSTDN_PIDM
                      AND SGBSTDN_TERM_CODE_EFF <= '144310')
       AND SGBSTDN_TERM_CODE_ADMIT = '144310';

INSERT INTO GLBSLCT (GLBSLCT_APPLICATION,
                     GLBSLCT_SELECTION,
                     GLBSLCT_CREATOR_ID,
                     GLBSLCT_DESC,
                     GLBSLCT_LOCK_IND,
                     GLBSLCT_ACTIVITY_DATE,
                     GLBSLCT_TYPE_IND)
     VALUES ('STUDENT',
             'BLOCKS2_REGS_144010',
             'SAISUSR',
             ' ”ÃÌ· —“„ 144010  ',
             'N',
             SYSDATE,
             NULL);

INSERT INTO GLBEXTR
   SELECT 'STUDENT',
          'BLOCKS2_REGS_144010',
          'SAISUSR',
          'SAISUSR',
          PIDM,
          SYSDATE,
          'S',
          NULL
     FROM (SELECT GLBEXTR_KEY PIDM,
                  f_get_std_id (GLBEXTR_KEY),
                  f_get_std_name (GLBEXTR_KEY),
                  sgbstdn_blck_code
             FROM GLBEXTR, sgbstdn
            WHERE     GLBEXTR_SELECTION = 'BLOCKS_REGS_144010'
                  AND NOT EXISTS
                             (SELECT '1'
                                FROM sfrstcr
                               WHERE     sfrstcr_term_code = '144010'
                                     AND sfrstcr_pidm = GLBEXTR_KEY)
                  AND sgbstdn_pidm = GLBEXTR_KEY);                                                                                                                          --------

SELECT DISTINCT f_get_std_id (sfrstcr_pidm), f_get_std_name (sfrstcr_pidm)
  FROM sfrstcr
 WHERE     SFRSTCR_TERM_CODE = '144010'
       AND EXISTS
              (SELECT '1'
                 FROM GLBEXTR
                WHERE     GLBEXTR_SELECTION = 'BLOCKS_REGS_144010'
                      AND GLBEXTR_KEY = sfrstcr_pidm)
--SSBSECT
--report SWRBLSC

/* select distinct f_get_std_id(sfrstcr_pidm),f_get_std_name(sfrstcr_pidm)from sfrstcr where
SFRSTCR_TERM_CODE='144010'
and sfrstcr_crn='14438'

delete from sfrstcr where SFRSTCR_TERM_CODE='144010'
and sfrstcr_crn='14438' */