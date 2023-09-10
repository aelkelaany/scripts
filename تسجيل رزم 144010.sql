/* Formatted on 08/09/2021 12:26:21 (QP5 v5.227.12220.39754) */
INSERT INTO GLBSLCT (GLBSLCT_APPLICATION,
                     GLBSLCT_SELECTION,
                     GLBSLCT_CREATOR_ID,
                     GLBSLCT_DESC,
                     GLBSLCT_LOCK_IND,
                     GLBSLCT_ACTIVITY_DATE,
                     GLBSLCT_TYPE_IND)
     VALUES ('STUDENT',
             'BLOCKS_REGS_144510',
             'SAISUSR',
             ' ”ÃÌ· —“„ 144510',
             'N',
             SYSDATE,
             NULL);

INSERT INTO GLBEXTR
   SELECT 'STUDENT',
          'BLOCKS_REGS_144510',
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
                  AND SGBSTDN_TERM_CODE_ADMIT = '144510'
                  AND EXISTS
                         (SELECT '1'
                            FROM SARAPPD
                           WHERE     SARAPPD_PIDM = A.SGBSTDN_PIDM
                                 AND SARAPPD_APDC_CODE = 'FA'
                                 AND SARAPPD_TERM_CODE_ENTRY = '144510'));


 --delete from GLBEXTR where  GLBEXTR_SELECTION='BLOCKS_REGS_144010' ;

 ------

UPDATE SYRBLKR
   SET SYRBLKR_CAPACITY_USED = 0
 WHERE SYRBLKR_TERM_CODE = '144510';






UPDATE SGBSTDN A
   SET A.sgbstdn_blck_code = NULL
 WHERE     A.SGBSTDN_TERM_CODE_EFF =
              (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                 FROM SGBSTDN
                WHERE     SGBSTDN_PIDM = A.SGBSTDN_PIDM
                      AND SGBSTDN_TERM_CODE_EFF <= '144510')
       AND SGBSTDN_TERM_CODE_ADMIT = '144510'
       and A.sgbstdn_coll_code_1='16'
          AND EXISTS
                         (SELECT '1'
                            FROM SARAPPD
                           WHERE     SARAPPD_PIDM = A.SGBSTDN_PIDM
                                 AND SARAPPD_APDC_CODE = 'FA'
                                 AND SARAPPD_TERM_CODE_ENTRY = '144510')
                                 
                                 and sgbstdn_blck_code is not null 
                                 
       
       ;
       
     UPDATE SYRBLKR
   SET SYRBLKR_CAPACITY_USED = 0
 WHERE SYRBLKR_TERM_CODE = '144510';  
       
       
       

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
                  AND sgbstdn_pidm = GLBEXTR_KEY);                                                                                                                                                                            --------

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

-- reset'
;
UPDATE SYRBLKR
   SET SYRBLKR_CAPACITY_NO = 0
 WHERE SYRBLKR_TERM_CODE = '144510';
 
 
 
 


 ---  ”ÃÌ· «·„«ÃÌ” Ì— „” ÊÏ 2 „”œœÌ‰ ›ﬁÿ

INSERT INTO GLBSLCT (GLBSLCT_APPLICATION,
                     GLBSLCT_SELECTION,
                     GLBSLCT_CREATOR_ID,
                     GLBSLCT_DESC,
                     GLBSLCT_LOCK_IND,
                     GLBSLCT_ACTIVITY_DATE,
                     GLBSLCT_TYPE_IND)
     VALUES ('STUDENT',
             'BLK_REG_431_PG2',
             'SAISUSR',
             ' ”ÃÌ· —“„ PG2  ',
             'N',
             SYSDATE,
             NULL);

INSERT INTO GLBEXTR
   SELECT 'STUDENT',
          'BLK_REG_431_PG2',
          'SAISUSR',
          'SAISUSR',
          PIDM,
          SYSDATE,
          'S',
          NULL
     FROM (SELECT DISTINCT A.SGBSTDN_PIDM PIDM
             FROM SGBSTDN A, SPRIDEN
            WHERE     A.SGBSTDN_TERM_CODE_EFF =
                         (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                            FROM SGBSTDN
                           WHERE SGBSTDN_PIDM = A.SGBSTDN_PIDM)
                  AND SGBSTDN_STST_CODE = 'AS'
                  AND SGBSTDN_LEVL_CODE = 'MA'
                  AND SPRIDEN_PIDM = SGBSTDN_PIDM
                  AND SPRIDEN_CHANGE_IND IS NULL
                  AND SPRIDEN_ID LIKE '442%'
                  AND EXISTS
                         (SELECT '1'
                            FROM BU_APPS.BNK_REG_PAYMENT
                           WHERE     TERM_CODE = '144510'
                                 AND STUDENT_PIDM = SGBSTDN_PIDM
                                 AND INVOICE_STATUS = 'PAID'));

SELECT f_get_std_id (GLBEXTR_KEY)
  FROM GLBEXTR
 WHERE     GLBEXTR_SELECTION = 'BLK_REG_431_PG1'
       AND NOT EXISTS
              (SELECT '1'
                 FROM sfrstcr
                WHERE     sfrstcr_term_code = '144510'
                      AND sfrstcr_pidm = GLBEXTR_KEY
                     );

                -- prrograms / blocks

SELECT DISTINCT SMRPRLE_PROGRAM,
                SMRPRLE_PROGRAM_DESC,
                STVBLCK_CODE,
                STVBLCK_DESC
  FROM STVBLCK, SMRPRLE
 WHERE     (      SUBSTR (SMRPRLE_PROGRAM, 2, 1)
               || SUBSTR (SMRPRLE_PROGRAM, 5, 4)
               || '_PG' = STVBLCK_CODE
            OR    SUBSTR (SMRPRLE_PROGRAM, 2, 1)
               || SUBSTR (SMRPRLE_PROGRAM, 5, 3)
               || '_PG' = STVBLCK_CODE)
       AND SUBSTR (SMRPRLE_PROGRAM, -1) NOT IN ('P', 'T')
       AND STVBLCK_CODE LIKE '%PG'
       AND STVBLCK_CODE IN
              (SELECT DISTINCT SSRBLCK_BLCK_CODE
                 FROM SSRBLCK
                WHERE     SSRBLCK_TERM_CODE = '144510'
                      AND SSRBLCK_BLCK_CODE LIKE '%PG')
       AND EXISTS
              (SELECT '1'
                 FROM sgbstdn
                WHERE sgbstdn_program_1 = SMRPRLE_PROGRAM)
UNION
SELECT DISTINCT SMRPRLE_PROGRAM,
                SMRPRLE_PROGRAM_DESC,
                STVBLCK_CODE,
                STVBLCK_DESC
  FROM STVBLCK, SMRPRLE
 WHERE     (      SUBSTR (SMRPRLE_PROGRAM, 2, 1)
               || SUBSTR (SMRPRLE_PROGRAM, 5, 4)
               || '_PG2' = STVBLCK_CODE
            OR    SUBSTR (SMRPRLE_PROGRAM, 2, 1)
               || SUBSTR (SMRPRLE_PROGRAM, 5, 3)
               || '_PG2' = STVBLCK_CODE)
       AND STVBLCK_CODE LIKE '%PG2%'
       AND STVBLCK_CODE IN
              (SELECT DISTINCT SSRBLCK_BLCK_CODE
                 FROM SSRBLCK
                WHERE     SSRBLCK_TERM_CODE = '144510'
                      AND SSRBLCK_BLCK_CODE LIKE '%PG2%')
       AND EXISTS
              (SELECT '1'
                 FROM sgbstdn
                WHERE sgbstdn_program_1 = SMRPRLE_PROGRAM);

INSERT INTO GLBSLCT (GLBSLCT_APPLICATION,
                     GLBSLCT_SELECTION,
                     GLBSLCT_CREATOR_ID,
                     GLBSLCT_DESC,
                     GLBSLCT_LOCK_IND,
                     GLBSLCT_ACTIVITY_DATE,
                     GLBSLCT_TYPE_IND)
     VALUES ('STUDENT',
             'BLK_REG_431_PG1',
             'SAISUSR',
             ' ”ÃÌ· —“„ PG1  ',
             'N',
             SYSDATE,
             NULL);

INSERT INTO GLBEXTR
   SELECT 'STUDENT',
          'BLK_REG_431_PG1',
          'SAISUSR',
          'SAISUSR',
          PIDM,
          SYSDATE,
          'S',
          NULL
     FROM (SELECT DISTINCT A.SGBSTDN_PIDM PIDM
             FROM SGBSTDN A, SPRIDEN
            WHERE     A.SGBSTDN_TERM_CODE_EFF =
                         (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                            FROM SGBSTDN
                           WHERE SGBSTDN_PIDM = A.SGBSTDN_PIDM)
                  AND SGBSTDN_STST_CODE = 'AS'
                  AND SGBSTDN_LEVL_CODE = 'MA'
                  AND SPRIDEN_PIDM = SGBSTDN_PIDM
                  AND SPRIDEN_CHANGE_IND IS NULL
                  AND SPRIDEN_ID LIKE '443%'
                  AND EXISTS
                         (SELECT '1'
                            FROM BU_DEV.TMP_TBL_KILANY
                           WHERE col07 = SGBSTDN_PIDM));