/* Formatted on 3/10/2022 2:25:29 PM (QP5 v5.371) */
  SELECT COUNT (*),
         SYBSTDC_PIDM,
         f_get_std_id (SYBSTDC_PIDM)
             pidm,
         f_get_std_name (SYBSTDC_PIDM)
             st_name,
         F_GET_DESC_FNC ('STVSTYP', sgbstdn_styp_code, 30)
             AS "��� �������",
         F_GET_DESC_FNC ('STVCOLL', SGBSTDN_COLL_CODE_1, 30)
             college,
         F_GET_DESC_FNC ('STVDEPT', SGBSTDN_DEPT_CODE, 30)
             department
    FROM sybstdc,
         ssbsect,
         scbcrse,
         sgbstdn
   WHERE     SYBSTDC_TERM_CODE = :p_term
         AND SYBSTDC_DISCONNECTED = 'Y'
         -- AND SYBSTDC_SUBMIT_DATE IS NOT NULL
         AND ssbsect_term_code = sybstdc_term_code
         AND ssbsect_crn = sybstdc_crn
         AND ssbsect_subj_code = scbcrse_subj_code
         AND ssbsect_crse_numb = scbcrse_crse_numb
         AND sgbstdn_styp_code != '�'
         AND sgbstdn_stst_code = 'AS'
         AND SCBCRSE_EFF_TERM =
             (SELECT MAX (SCBCRSE_EFF_TERM)
                FROM scbcrse
               WHERE     ssbsect_subj_code = scbcrse_subj_code
                     AND ssbsect_crse_numb = scbcrse_crse_numb)
         AND sgbstdn_pidm = sybstdc_pidm
         AND SGBSTDN_TERM_CODE_EFF =
             (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                FROM sgbstdn
               WHERE     sgbstdn_pidm = sybstdc_pidm
                     AND SGBSTDN_TERM_CODE_EFF <= sybstdc_term_code)
         AND NOT EXISTS
                 (SELECT '1'
                    FROM sybstdc
                   WHERE     sybstdc_term_code = :p_term
                         AND sybstdc_pidm = sgbstdn_pidm
                         AND SYBSTDC_DISCONNECTED = 'N')
         AND (SELECT COUNT (*)
                FROM sybstdc
               WHERE     sybstdc_term_code = :p_term
                     AND SYBSTDC_DISCONNECTED = 'Y'
                     AND sybstdc_pidm = sgbstdn_pidm) =
             (SELECT COUNT (*)
                FROM sfrstcr
               WHERE     SFRSTCR_TERM_CODE = :p_term
                     AND SFRSTCR_pidm = sgbstdn_pidm
                     AND SFRSTCR_RSTS_CODE IN ('RE', 'RW')
                     AND EXISTS
                             (SELECT '1'
                                FROM ssbsect
                               WHERE     ssbsect_term_code = sfrstcr_term_code
                                     AND ssbsect_crn = sfrstcr_crn
                                     AND SSBSECT_GRADABLE_IND = 'Y'))
GROUP BY SYBSTDC_PIDM,
         sgbstdn_styp_code,
         SGBSTDN_COLL_CODE_1,
         SGBSTDN_DEPT_CODE
ORDER BY 6, 7