/* Formatted on 6/24/2020 2:13:08 PM (QP5 v5.360) */
  SELECT PROGRAM_CODE,
         EFFECTIVE_TERM,
         PROGRAM_DESC,
         AREA_CODE,
         AREA_DESC,
         AREA_REQUIRED_CREDITS_HRS,
         SUM (
             GREATEST (NVL (SCBCRSE_CREDIT_HR_LOW, 0),
                       NVL (SCBCRSE_CREDIT_HR_high, 0)))    fact_sum
    FROM BU_APPS.VW_ACADEMIC_PLANS c, scbcrse a
   WHERE     EXISTS
                 (SELECT '0'
                    FROM VW_ACADEMIC_PLANS
                   WHERE     program_code = c.program_code
                         AND EFFECTIVE_TERM = c.EFFECTIVE_TERM
                         AND area_code = c.area_code
                         AND (   UPPER (COURSE_TITLE) LIKE '% ›ﬂÌ—%'
                              OR UPPER (COURSE_TITLE) LIKE '% ⁄·„%'))
         AND EXISTS
                 (SELECT '1'
                    FROM SATURN.SMBPGEN
                   WHERE     SMBPGEN_ACTIVE_IND = 'Y'
                         AND SMBPGEN_PROGRAM = program_code)
         AND EXISTS
                 (SELECT '2'
                    FROM smrprle
                   WHERE     smrprle_program = program_code
                         AND smrprle_levl_code = 'Ã„')
         AND (program_desc NOT LIKE '% Õ÷%')
         AND scbcrse_subj_code = subject_code
         AND scbcrse_crse_numb = course_number
         AND scbcrse_eff_term =
             (SELECT MAX (scbcrse_eff_term)
                FROM scbcrse
               WHERE     scbcrse_subj_code = subject_code
                     AND scbcrse_crse_numb = course_number
                     AND scbcrse_eff_term <= EFFECTIVE_TERM)
         AND (program_code NOT LIKE '%00%' OR program_code NOT LIKE '% Õ%')
GROUP BY PROGRAM_CODE,
         EFFECTIVE_TERM,
         PROGRAM_DESC,
         AREA_CODE,
         AREA_DESC,
         AREA_REQUIRED_CREDITS_HRS
ORDER BY 1, 4