/* Formatted on 25/03/2021 11:56:06 (QP5 v5.227.12220.39754) */
  SELECT f_get_std_id (SYBSTDC_PIDM) pidm,
         f_get_std_name (SYBSTDC_PIDM) st_name,
         F_GET_DESC_FNC ('STVSTYP', sgbstdn_styp_code, 30)
            AS "‰Ê⁄ «·œ—«”…",
         F_GET_DESC_FNC ('STVCOLL', SGBSTDN_COLL_CODE_1, 30) college,
         F_GET_DESC_FNC ('STVDEPT', SGBSTDN_DEPT_CODE, 30) department,
         SYBSTDC_CRN crn,
         scbcrse_title ttile
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
ORDER BY 4, 5, 1