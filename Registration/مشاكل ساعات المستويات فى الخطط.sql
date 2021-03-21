/* Formatted on 6/24/2020 2:29:59 PM (QP5 v5.360) */
SELECT *
  FROM (  SELECT PROGRAM_CODE,
                 EFFECTIVE_TERM,
                 PROGRAM_DESC,
                 AREA_CODE,
                 AREA_DESC,
                 SMRPRLE_COLL_CODE,
                 F_GET_DESC_FNC ('STVCOLL', SMRPRLE_COLL_CODE, 30)    COLLEGE,
                 AREA_REQUIRED_CREDITS_HRS                            ACT_SUM,
                 SUM (
                     GREATEST (NVL (SCBCRSE_CREDIT_HR_LOW, 0),
                               NVL (SCBCRSE_CREDIT_HR_high, 0)))      TRUTH_SUM
            FROM BU_APPS.VW_ACADEMIC_PLANS c, scbcrse a, SMRPRLE
           WHERE     EXISTS
                         (SELECT '1'
                            FROM SATURN.SMBPGEN
                           WHERE     SMBPGEN_ACTIVE_IND = 'Y'
                                 AND SMBPGEN_PROGRAM = program_code)
                 AND smrprle_program = program_code
                 AND smrprle_levl_code = 'Ã„'                 --Œÿÿ »ﬂ«·—ÌÊ”
                 AND (program_desc NOT LIKE '% Õ÷%')
                 AND scbcrse_subj_code = subject_code
                 AND scbcrse_crse_numb = course_number
                 AND scbcrse_eff_term =
                     (SELECT MAX (scbcrse_eff_term)
                        FROM scbcrse
                       WHERE     scbcrse_subj_code = subject_code
                             AND scbcrse_crse_numb = course_number
                             AND scbcrse_eff_term <= EFFECTIVE_TERM)
                 AND (    program_code NOT LIKE '%00%'
                      AND program_code NOT LIKE '% Õ%')
                 AND EXISTS
                         (SELECT '3'
                            FROM SHRDGMR
                           WHERE     SHRDGMR_DEGS_CODE = 'ŒÃ'
                                 AND SHRDGMR_PROGRAM = PROGRAM_CODE)
                                 AND NOT EXISTS(SELECT '5' FROM VW_ACADEMIC_PLANS A
                                 WHERE A.PROGRAM_CODE = c.PROGRAM_CODE
                                 AND A.EFFECTIVE_TERM=c.EFFECTIVE_TERM
                                 AND A.AREA_CODE=c.AREA_CODE
                                 AND c.REQUIRED_FLAG='N') --«” À‰«¡ „” ÊÌ«  «·«Œ Ì«—Ì
                                 
        GROUP BY PROGRAM_CODE,
                 EFFECTIVE_TERM,
                 PROGRAM_DESC,
                 AREA_CODE,
                 AREA_DESC,
                 AREA_REQUIRED_CREDITS_HRS,
                 SMRPRLE_COLL_CODE
        ORDER BY 1, 2, 4) A
 WHERE ACT_SUM <> TRUTH_SUM