SELECT SSBSECT_CRN,
       ssbsect_subj_code,
       ssbsect_crse_numb,
       scbcrse_title 
,f_get_desc_fnc('STVCOLL',scbcrse_coll_code,30) college ,f_get_desc_fnc('STVDEPT',scbcrse_DEPT_code,30) DEPT
  FROM ssbsect, scbcrse c1
 WHERE     ssbsect_subj_code = scbcrse_subj_code
       AND ssbsect_crse_numb = scbcrse_crse_numb
       AND scbcrse_eff_term =
              (SELECT MAX (c2.scbcrse_eff_term)
                 FROM scbcrse c2
                WHERE     c2.scbcrse_subj_code = c1.scbcrse_subj_code
                      AND c2.scbcrse_crse_numb = c1.scbcrse_crse_numb
                      AND c2.scbcrse_eff_term <= '144220')
       AND ssbsect_term_code = '144220'
      /* AND SSBSECT_MAX_ENRL > 0
       AND SSBSECT_SEATS_AVAIL = SSBSECT_MAX_ENRL*/
       AND SSBSECT_SSTS_CODE='ä'
       and exists (select '1' from SSRRTST where SSRRTST_TERM_CODE=ssbsect_term_code and SSRRTST_CRN=SSBSECT_CRN )
       order by 5 ;
       
       