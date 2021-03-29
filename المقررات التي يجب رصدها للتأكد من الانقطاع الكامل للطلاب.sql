/* Formatted on 25/03/2021 11:56:23 (QP5 v5.227.12220.39754) */
  SELECT DISTINCT
         ssbsect_term_code term_code,
         sirasgn_crn crn,
         scbcrse_title || ' ~ ' || ssbsect_subj_code || ssbsect_crse_numb title,
         f_get_std_id (sirasgn_pidm) instr_id,
         f_get_std_name (sirasgn_pidm) instr_name,
         DECODE (xwlkstdc.is_submitted (ssbsect_term_code, sirasgn_crn),
                 'P', 'ÊÍÊ ÇáÃÌÑÇÁ',
                 'S', 'Êã ÇáÑÕÏ',
                 'N', 'áã íÊã ÇáÑÕÏ')
            crn_status,
         F_GET_DESC_FNC ('STVcoll', scbcrse_coll_code, 30) college,
         F_GET_DESC_FNC ('STVdept', scbcrse_dept_code, 30) dept,
         sirasgn_pidm
    FROM ssbsect, sirasgn, scbcrse
   WHERE     sirasgn_term_code = :p_TERM_code
         AND ssbsect_term_code = sirasgn_term_code
         AND ssbsect_crn = sirasgn_crn
         AND ssbsect_subj_code = scbcrse_subj_code
         AND ssbsect_crse_numb = scbcrse_crse_numb
         AND SCBCRSE_EFF_TERM =
                (SELECT MAX (SCBCRSE_EFF_TERM)
                   FROM scbcrse
                  WHERE     ssbsect_subj_code = scbcrse_subj_code
                        AND ssbsect_crse_numb = scbcrse_crse_numb)
         AND ssbsect_gradable_ind = 'Y'
         AND ssbsect_enrl > 0
         AND SSBSECT_SSTS_CODE = 'ä'
         AND EXISTS
                (SELECT 'x'
                   FROM sfrstcr
                  WHERE     sfrstcr_term_code = :TERM
                        AND sfrstcr_crn = ssbsect_crn
                        AND sfrstcr_rsts_code IN ('RE', 'RW')
                        AND sfrstcr_pidm IN
                               (SELECT DISTINCT SYBSTDC_PIDM
                                  FROM sybstdc a
                                 WHERE     SYBSTDC_TERM_CODE = :p_term
                                       AND SYBSTDC_DISCONNECTED = 'Y'
                                       AND NOT EXISTS
                                                  (SELECT '1'
                                                     FROM sybstdc
                                                    WHERE     sybstdc_term_code =
                                                                 '144220'
                                                          AND sybstdc_pidm =
                                                                 a.sybstdc_pidm
                                                          AND SYBSTDC_DISCONNECTED =
                                                                 'N')))
         AND ssbsect_ptrm_code != 2
         -- AND scbcrse_dept_code like :p_dept_code
         AND scbcrse_coll_code LIKE :p_coll_code
         AND xwlkstdc.is_submitted (ssbsect_term_code, sirasgn_crn) LIKE
                :p_crn_status
ORDER BY 7, 8, instr_id;