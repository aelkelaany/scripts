/* Formatted on 6/25/2020 2:22:49 PM (QP5 v5.360) */
  SELECT SSBSECT_CRN,
         SSBSECT_SUBJ_CODE,
         SSBSECT_CRSE_NUMB,
         GREATEST (NVL (a.SCBCRSE_CREDIT_HR_LOW, 0),
                   NVL (a.SCBCRSE_CREDIT_HR_high, 0))           hours,
         a.SCBCRSE_TITLE,
         f_get_desc_fnc ('STVCOLL', a.SCBCRSE_COLL_CODE, 60)    college,
         f_get_desc_fnc ('STVDEPT', a.SCBCRSE_DEPT_CODE, 60)    department
    FROM SATURN.SSBSECT, scbcrse a
   WHERE     SSBSECT_TERM_CODE = '144030'
         AND scbcrse_subj_code = SSBSECT_SUBJ_CODE
         AND scbcrse_crse_numb = SSBSECT_CRSE_NUMB
         AND SSBSECT_CREDIT_HRS IS NULL
         AND SSBSECT_GRADABLE_IND = 'Y'
         AND a.SCBCRSE_EFF_TERM =
             (SELECT MAX (SCBCRSE_EFF_TERM)
                FROM scbcrse
               WHERE     SCBCRSE_SUBJ_CODE = a.SCBCRSE_SUBJ_CODE
                     AND SCBCRSE_CRSE_NUMB = a.SCBCRSE_CRSE_NUMB)
         AND EXISTS
                 (SELECT '1'
                    FROM SFRSTCR
                   WHERE     sfrstcr_term_code = ssbsect_term_code
                         AND sfrstcr_crn = ssbsect_crn
                         AND sfrstcr_rsts_code IN ('RE', 'RW'))
ORDER BY 2