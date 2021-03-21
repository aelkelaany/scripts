/* Formatted on 10/13/2019 12:39:48 PM (QP5 v5.227.12220.39754) */
SELECT F_GET_STD_NAME (A.SGBSTDN_PIDM),
       F_GET_STD_ID (A.SGBSTDN_PIDM),
       SGBSTDN_PROGRAM_1
  FROM SGBSTDN A
 WHERE     A.SGBSTDN_TERM_CODE_EFF =
              (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                 FROM SGBSTDN
                WHERE     SGBSTDN_PIDM = A.SGBSTDN_PIDM
                      AND SGBSTDN_TERM_CODE_EFF <= '144010')
       AND SGBSTDN_STST_CODE = 'AS'
       AND A.SGBSTDN_STYP_CODE = 'ã'
       AND SUBSTR (F_GET_STD_ID (A.SGBSTDN_PIDM), 1, 3) = '438'
       AND SGBSTDN_PROGRAM_1 NOT LIKE '%1433';

 ------------2nd query

  SELECT DISTINCT *
    FROM (  SELECT F_GET_STD_NAME (A.SGBSTDN_PIDM),
                   F_GET_STD_ID (A.SGBSTDN_PIDM) AS "ÇáÑÞã ÇáÌÇãÚí",
                   SGBSTDN_PROGRAM_1 "ÑãÒ ÇáÈÑäÇãÌ", SMRPRLE_PROGRAM_DESC as "æÕÝ ÇáÈÑäÇãÌ" ,SGBSTDN_COLL_CODE_1 as "ÑãÒ ÇáßáíÉ",f_get_desc_fnc('STVCOLL' ,SGBSTDN_COLL_CODE_1  , 30  ) AS "ÇáßáíÉ" ,  
                   SUM (SHRTGPA_HOURS_EARNED) AS "ÓÇÚÇÊ ÇáÓÌá",
                   SMBPOGN_ACT_CREDITS_OVERALL AS "ÓÇÚÇÊ ÇáãØÇÈÞÉ",
                   SMBPOGN_REQUEST_NO AS "ÑÞã ÇáØáÈ",
                   ABS (SUM (SHRTGPA_HOURS_EARNED) - SMBPOGN_ACT_CREDITS_OVERALL)
                      AS "ÝÑÞ ÇáÓÇÚÇÊ"
              FROM SGBSTDN A, SHRTGPA, SMBPOGN ,smrprle
             WHERE     A.SGBSTDN_TERM_CODE_EFF =
                          (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                             FROM SGBSTDN
                            WHERE     SGBSTDN_PIDM = A.SGBSTDN_PIDM
                                  AND SGBSTDN_TERM_CODE_EFF <= '144010')
                   AND SGBSTDN_STST_CODE = 'AS'
                   AND A.SGBSTDN_STYP_CODE = 'ã'
                   AND a.SGBSTDN_DEGC_CODE_1 = 'Èß'
                   AND SUBSTR (F_GET_STD_ID (A.SGBSTDN_PIDM), 1, 3) = '438'
                   AND SHRTGPA_pidm = sgbstdn_pidm
                   -- AND SGBSTDN_PROGRAM_1 NOT LIKE '%1433'
                   AND SMBPOGN_pidm = sgbstdn_pidm
                   AND SMBPOGN_REQUEST_NO = (SELECT MAX (SMBPOGN_REQUEST_NO)
                                               FROM SMBPOGN
                                              WHERE SMBPOGN_pidm = sgbstdn_pidm)
                   AND SMBPOGN_PROGRAM = SGBSTDN_PROGRAM_1
                   and SMRPRLE_PROGRAM=SGBSTDN_PROGRAM_1
          GROUP BY SGBSTDN_PROGRAM_1,
                   sgbstdn_pidm,
                   SMBPOGN_ACT_CREDITS_OVERALL,
                   SMBPOGN_REQUEST_NO ,SGBSTDN_COLL_CODE_1,SMRPRLE_PROGRAM_DESC)
   WHERE  ABS (SUM (SHRTGPA_HOURS_EARNED) - SMBPOGN_ACT_CREDITS_OVERALL) > 0
ORDER BY 3;

SELECT  F_GET_STD_NAME (A.SMRDOCN_PIDM),
                   F_GET_STD_ID (A.SMRDOCN_PIDM),A.* FROM SMRDOCN A
WHERE (SMRDOCN_PIDM, SMRDOCN_REQUEST_NO) IN 
(SELECT DISTINCT SGBSTDN_PIDM ,SMBPOGN_REQUEST_NO
    FROM (  SELECT  A.SGBSTDN_PIDM ,
                     
                   SMBPOGN_REQUEST_NO    ,
                     ABS (SUM (SHRTGPA_HOURS_EARNED) - SMBPOGN_ACT_CREDITS_OVERALL) DIFF
              FROM SGBSTDN A, SHRTGPA, SMBPOGN ,smrprle
             WHERE     A.SGBSTDN_TERM_CODE_EFF =
                          (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                             FROM SGBSTDN
                            WHERE     SGBSTDN_PIDM = A.SGBSTDN_PIDM
                                  AND SGBSTDN_TERM_CODE_EFF <= '144010')
                   AND SGBSTDN_STST_CODE = 'AS'
                   AND A.SGBSTDN_STYP_CODE = 'ã'
                   AND a.SGBSTDN_DEGC_CODE_1 = 'Èß'
                   AND SUBSTR (F_GET_STD_ID (A.SGBSTDN_PIDM), 1, 3) = '438'
                   AND SHRTGPA_pidm = sgbstdn_pidm
                   -- AND SGBSTDN_PROGRAM_1 NOT LIKE '%1433'
                   AND SMBPOGN_pidm = sgbstdn_pidm
                   AND SMBPOGN_REQUEST_NO = (SELECT MAX (SMBPOGN_REQUEST_NO)
                                               FROM SMBPOGN
                                              WHERE SMBPOGN_pidm = sgbstdn_pidm)
                   AND SMBPOGN_PROGRAM = SGBSTDN_PROGRAM_1
                   and SMRPRLE_PROGRAM=SGBSTDN_PROGRAM_1
          GROUP BY   
                   sgbstdn_pidm,
                     SMBPOGN_ACT_CREDITS_OVERALL ,
                   SMBPOGN_REQUEST_NO  )
   WHERE  DIFF> 0  )
   ORDER BY 1 ;
 

----------------------3rd capp report 
  SELECT SMBPGEN_PROGRAM,
         SMRPRLE_PROGRAM_DESC,
         SMBPGEN_REQ_CREDITS_OVERALL,
         SMBPGEN_REQ_COURSES_OVERALL,
         SMRPAAP_AREA_PRIORITY,
         SMRACAA_AREA,
         SMRALIB_area_desc,
         SMBPGEN_TERM_CODE_EFF,
         SMRPAAP_AREA,
         SMBAGEN_REQ_CREDITS_OVERALL,
         SMBAGEN_REQ_COURSES_OVERALL,
         SMRACAA_RULE,
         SMRACAA_SUBJ_CODE,
         SMRACAA_CRSE_NUMB_LOW,
         (SELECT a.scbcrse_title
            FROM scbcrse a
           WHERE     a.scbcrse_subj_code = SMRACAA_SUBJ_CODE
                 AND a.scbcrse_crse_numb = SMRACAA_CRSE_NUMB_LOW
                 AND SCBCRSE_EFF_TERM =
                        (SELECT MAX (SCBCRSE_EFF_TERM)
                           FROM scbcrse
                          WHERE     scbcrse_subj_code = SMRACAA_SUBJ_CODE
                                AND scbcrse_crse_numb = SMRACAA_CRSE_NUMB_LOW
                                AND SCBCRSE_EFF_TERM <= '143810'))
            title,
         SMRACAA_RULE,
         SMRACAA_TERM_CODE_EFF
    FROM smbpgen a,
         smrpaap,
         smracaa,
         SMBAGEN,
         SMRALIB,
         SMRPRLE
   WHERE     SMBPGEN_PROGRAM || SMBPGEN_TERM_CODE_EFF =
                SMRPAAP_PROGRAM || SMRPAAP_TERM_CODE_EFF
         AND SMRPRLE.SMRPRLE_PROGRAM = SMBPGEN_PROGRAM
         AND SMBAGEN_AREA || SMBAGEN_TERM_CODE_EFF =
                SMRPAAP_AREA || SMRPAAP_TERM_CODE_EFF
         AND SMRPAAP_AREA || SMRPAAP_TERM_CODE_EFF =
                SMRACAA_AREA || SMRACAA_TERM_CODE_EFF
         AND SMRALIB_area = SMBAGEN_AREA
         AND SMBPGEN_TERM_CODE_EFF =
                (SELECT MAX (SMBPGEN_TERM_CODE_EFF)
                   FROM smbpgen
                  WHERE     SMBPGEN_TERM_CODE_EFF <= :p_term_eff
                        AND SMBPGEN_PROGRAM = a.SMBPGEN_PROGRAM)
         AND   EXISTS
                (SELECT '1'
                   FROM SGBSTDN A
                  WHERE     A.SGBSTDN_TERM_CODE_EFF =
                               (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                  FROM SGBSTDN
                                 WHERE     SGBSTDN_PIDM = A.SGBSTDN_PIDM
                                       AND SGBSTDN_TERM_CODE_EFF <= '144010')
                        AND SGBSTDN_STST_CODE = 'AS'
                        AND A.SGBSTDN_STYP_CODE = 'ã'
                        AND a.SGBSTDN_DEGC_CODE_1 = 'Èß'
                        AND SUBSTR (F_GET_STD_ID (A.SGBSTDN_PIDM), 1, 3) =
                               '438'
                        AND SGBSTDN_PROGRAM_1 = a.SMBPGEN_PROGRAM)
ORDER BY SMBPGEN_PROGRAM,
         SMRALIB_AREA_DESC,
         SMRPAAP_AREA_PRIORITY,
         SMRACAA_SUBJ_CODE,
         SMRACAA_CRSE_NUMB_LOW DESC ;