 
  SELECT SSBSECT_CRN,
         ssbsect_subj_code,
         ssbsect_crse_numb,
         scbcrse_title,
         SSBSECT_MAX_ENRL,
         SSBSECT_ENRL,
         SSBSECT_SEATS_AVAIL,
         SSBSECT_SCHD_CODE,
         f_get_desc_fnc ('stvcamp', SSBSECT_CAMP_CODE, 30) campus,   f_get_desc_fnc ('stvdept', scbcrse_dept_CODE, 30) dept
    FROM ssbsect, scbcrse c1
   WHERE     ssbsect_subj_code = scbcrse_subj_code
         AND ssbsect_crse_numb = scbcrse_crse_numb
         AND scbcrse_eff_term =
                (SELECT MAX (c2.scbcrse_eff_term)
                   FROM scbcrse c2
                  WHERE     c2.scbcrse_subj_code = c1.scbcrse_subj_code
                        AND c2.scbcrse_crse_numb = c1.scbcrse_crse_numb
                        AND c2.scbcrse_eff_term <= '144220')
         AND EXISTS
                (SELECT '1'
                   FROM SSRRCOL
                  WHERE     SSRRCOL_CRN = Ssbsect_CRN
                        AND SSRRCOL_TERM_CODE = '144220'
                        AND SSRRCOL_coll_code = '15')
                      /*   AND EXISTS
                (SELECT '1'
                   FROM SSRRdep
                  WHERE     SSRRdep_CRN = Ssbsect_CRN
                        AND SSRRdep_TERM_CODE = '144220'
                        AND SSRRdep_dept_code = '1501')*/
         AND ssbsect_term_code = '144220'
         AND SSBSECT_MAX_ENRL > 0
      --    AND SSBSECT_SEATS_AVAIL = 0--SSBSECT_MAX_ENRL
         AND SSBSECT_SSTS_CODE = 'ä'
         AND SSBSECT_PTRM_CODE = 1
ORDER BY 10 ;

dev_sys_parameters