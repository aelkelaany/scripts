/* Formatted on 9/4/2019 10:24:19 AM (QP5 v5.227.12220.39754) */  
--create table bu_dev.sfrstcr_04092019 as select * from sfrstcr where sfrstcr_term_code='144010';
  INSERT INTO GLBSLCT (GLBSLCT_APPLICATION,
                     GLBSLCT_SELECTION,
                     GLBSLCT_CREATOR_ID,
                     GLBSLCT_DESC,
                     GLBSLCT_LOCK_IND,
                     GLBSLCT_ACTIVITY_DATE,
                     GLBSLCT_TYPE_IND)
     VALUES ('STUDENT',
             'BLOCKS_REGSV6_144010',
             'SAISUSR',
             ' ”ÃÌ· —“„ 144010 V6 ',
             'N',
             SYSDATE,
             NULL);

INSERT INTO GLBEXTR
   SELECT 'STUDENT',
          'BLOCKS_REGSV6_144010',
          'SAISUSR',
          'SAISUSR',
          SGBSTDN_PIDM,
          SYSDATE,
          'S',
          NULL
     FROM (
     
SELECT
A.SGBSTDN_PIDM

 /* ,F_GET_STD_NAME (A.SGBSTDN_PIDM),
       F_GET_STD_ID (A.SGBSTDN_PIDM),
       A.sgbstdn_blck_code  */
  FROM SGBSTDN A
 WHERE     A.SGBSTDN_TERM_CODE_EFF =
              (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                 FROM SGBSTDN
                WHERE     SGBSTDN_PIDM = A.SGBSTDN_PIDM
                      AND SGBSTDN_TERM_CODE_EFF <= '144010')
       AND SGBSTDN_STST_CODE = 'AS'
       AND A.SGBSTDN_STYP_CODE = '„'
       AND SGBSTDN_COLL_CODE_1 = '17'
       AND A.sgbstdn_blck_code = 'V6'
       AND SUBSTR (F_GET_STD_ID (A.SGBSTDN_PIDM), 1, 3) = '441'
       AND   EXISTS
              (SELECT '1'
                 FROM SARAPPD
                WHERE     SARAPPD_PIDM = A.SGBSTDN_PIDM
                      AND SARAPPD_APDC_CODE = 'FA'
                      AND SARAPPD_TERM_CODE_ENTRY = '144010')
       AND  not   EXISTS
              (SELECT 'C'
                 FROM SFRSTCR
                WHERE SFRSTCR_PIDM = A.SGBSTDN_PIDM
                AND SFRSTCR_RSTS_CODE IN ('RE','RW')
               -- AND SFRSTCR_RSTS_CODE IN ('DD')
                )) AND SFRSTCR_TERM_CODE='144010'
                 



 

UPDATE SGBSTDN A
   SET A.sgbstdn_blck_code = NULL
WHERE     SGBSTDN_PIDM   IN (

SELECT
A.SGBSTDN_PIDM

  FROM SGBSTDN A
 WHERE     A.SGBSTDN_TERM_CODE_EFF =
              (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                 FROM SGBSTDN
                WHERE     SGBSTDN_PIDM = A.SGBSTDN_PIDM
                      AND SGBSTDN_TERM_CODE_EFF <= '144010')
       AND SGBSTDN_STST_CODE = 'AS'
       AND A.SGBSTDN_STYP_CODE = '„'
       AND SGBSTDN_COLL_CODE_1 = '17'
       AND A.sgbstdn_blck_code = 'V6'
       AND SUBSTR (F_GET_STD_ID (A.SGBSTDN_PIDM), 1, 3) = '441'
       AND   EXISTS
              (SELECT '1'
                 FROM SARAPPD
                WHERE     SARAPPD_PIDM = A.SGBSTDN_PIDM
                      AND SARAPPD_APDC_CODE = 'FA'
                      AND SARAPPD_TERM_CODE_ENTRY = '144010')
        
                ) ;


--syrblkr

--SHRDGMR