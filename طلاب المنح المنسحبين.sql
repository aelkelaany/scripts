/* Formatted on 5/10/2022 12:14:35 PM (QP5 v5.371) */
SELECT SGBSTDN_TERM_CODE_EFF                                          TERM,
       F_GET_STD_ID (SG.sgbstdn_pidm)                                 STD_ID,
       f_get_std_name (SG.sgbstdn_pidm)                               STD_NAME,
       DECODE (SPBPERS_SEX,  'M', 'ÿ«·»',  'F', 'ÿ«·»…')     SEX,
       F_GET_DESC_FNC ('STVCITZ', SPBPERS_CITZ_CODE, 30)              CITIZ,
       F_GET_DESC_FNC ('STVSTST', SG.SGBSTDN_STST_CODE, 30)           STST,
       F_GET_DESC_FNC ('STVCOLL', SG.SGBSTDN_COLL_CODE_1, 30)         COLL,
       F_GET_DESC_FNC ('STVDEPT', SG.SGBSTDN_DEPT_CODE, 30)           DEPT,
       F_GET_DESC_FNC ('STVMAJR', SG.SGBSTDN_MAJR_CODE_1, 30)         MAJR,
       F_GET_EMAIL_FNC (SG.sgbstdn_pidm)                              EMAIL,
       NVL (SPRTELE_PHONE_NUMBER, SPRTELE_INTL_ACCESS)                TELE
  FROM SGBSTDN SG, spbpers, SPRTELE
 WHERE     SGBSTDN_TERM_CODE_EFF =
           (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
              FROM SGBSTDN
             WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                   AND SGBSTDN_TERM_CODE_EFF >= '144310')
       AND SG.sgbstdn_pidm = SPBPERS_pidm
       AND SG.sgbstdn_pidm = SPRTELE_PIDM
       AND SPRTELE_TELE_CODE = 'MO'
       AND SPBPERS_CITZ_CODE != '”'
       AND SG.SGBSTDN_STST_CODE IN ('ÿÌ',
                                    '„‰',
                                    '„”',
                                    'ÿ”',
                                    '„Œ')
                                    
                                    ORDER BY  TERM,COLL,DEPT,STST
                                    ;