/* Formatted on 5/3/2023 8:47:54 AM (QP5 v5.371) */
  SELECT req.ssbsect_term_code,
         COLL_CODE,
         f_get_desc_fnc ('stvcoll', coll_code, 30)
             coll_desc,
         COUNT (DISTINCT req.ssbsect_subj_code || req.ssbsect_crse_numb)
             req_subjs,
         COUNT (DISTINCT elc.ssbsect_subj_code || elc.ssbsect_crse_numb)
             elc_subjs
    FROM ssbsect req, ssbsect elc, SCHD_COLL_CAMP
   WHERE     req.ssbsect_term_code = elc.ssbsect_term_code
         AND req.ssbsect_camp_code = elc.ssbsect_camp_code
         AND req.ssbsect_term_code LIKE '144410%'
         --
         AND CAMP_CODE = req.ssbsect_camp_code
         --
         AND EXISTS
                 (SELECT '1'
                    FROM sfrstcr
                   WHERE     sfrstcr_term_code = req.ssbsect_term_code
                         AND sfrstcr_crn = req.ssbsect_crn
                         AND sfrstcr_rsts_code IN ('RE', 'RW')
                         AND SFRSTCR_LEVL_CODE = 'Ã„')
         --
         AND EXISTS
                 (SELECT '1'
                    FROM sfrstcr
                   WHERE     sfrstcr_term_code = elc.ssbsect_term_code
                         AND sfrstcr_crn = elc.ssbsect_crn
                         AND sfrstcr_rsts_code IN ('RE', 'RW')
                         AND SFRSTCR_LEVL_CODE = 'Ã„')
         --
         AND EXISTS
                 (SELECT '1'
                    FROM smracaa
                   WHERE SMRACAA_SUBJ_CODE || SMRACAA_CRSE_NUMB_LOW =
                         req.ssbsect_subj_code || req.ssbsect_crse_numb)
         AND NOT EXISTS
                 (SELECT '1'
                    FROM SMRARUL
                   WHERE SMRARUL_SUBJ_CODE || SMRARUL_CRSE_NUMB_LOW =
                         req.ssbsect_subj_code || req.ssbsect_crse_numb)
         --
         AND EXISTS
                 (SELECT '1'
                    FROM SMRARUL
                   WHERE SMRARUL_SUBJ_CODE || SMRARUL_CRSE_NUMB_LOW =
                         elc.ssbsect_subj_code || elc.ssbsect_crse_numb)
         AND NOT EXISTS
                 (SELECT '1'
                    FROM smracaa
                   WHERE SMRACAA_SUBJ_CODE || SMRACAA_CRSE_NUMB_LOW =
                         elc.ssbsect_subj_code || elc.ssbsect_crse_numb)
         AND elc.SSBSECT_PTRM_CODE = 1
         AND req.SSBSECT_PTRM_CODE = 1
GROUP BY req.ssbsect_term_code, COLL_CODE
----------------
UNION
  -------------
  SELECT req.ssbsect_term_code,
         COLL_CODE,
         f_get_desc_fnc ('stvcoll', coll_code, 30)
             coll_desc,
         COUNT (DISTINCT req.ssbsect_subj_code || req.ssbsect_crse_numb)
             req_subjs,
         0
             elc_subjs
    FROM ssbsect req, SCHD_COLL_CAMP
   WHERE     req.ssbsect_term_code LIKE '144410%'
         --
         AND CAMP_CODE = req.ssbsect_camp_code
         --
         AND EXISTS
                 (SELECT '1'
                    FROM sfrstcr
                   WHERE     sfrstcr_term_code = req.ssbsect_term_code
                         AND sfrstcr_crn = req.ssbsect_crn
                         AND sfrstcr_rsts_code IN ('RE', 'RW')
                         AND SFRSTCR_LEVL_CODE = 'Ã„')
         --
         AND EXISTS
                 (SELECT '1'
                    FROM smracaa
                   WHERE SMRACAA_SUBJ_CODE || SMRACAA_CRSE_NUMB_LOW =
                         req.ssbsect_subj_code || req.ssbsect_crse_numb)
         AND NOT EXISTS
                 (SELECT '1'
                    FROM SMRARUL
                   WHERE SMRARUL_SUBJ_CODE || SMRARUL_CRSE_NUMB_LOW =
                         req.ssbsect_subj_code || req.ssbsect_crse_numb)
         --


         AND req.SSBSECT_PTRM_CODE = 1
GROUP BY req.ssbsect_term_code, COLL_CODE
ORDER BY 1, 2