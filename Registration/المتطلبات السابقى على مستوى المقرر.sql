/* Formatted on 10/01/2021 17:34:22 (QP5 v5.227.12220.39754) */
  SELECT scbcrse_subj_code, scbcrse_crse_numb, scbcrse_title ,f_get_desc_fnc('STVCOLL',scbcrse_coll_code,30) college ,f_get_desc_fnc('STVDEPT',scbcrse_DEPT_code,30) DEPT
    FROM scbcrse c1
   WHERE     scbcrse_eff_term =
                (SELECT MAX (c2.scbcrse_eff_term)
                   FROM scbcrse c2
                  WHERE     c2.scbcrse_subj_code = c1.scbcrse_subj_code
                        AND c2.scbcrse_crse_numb = c1.scbcrse_crse_numb
                        AND c2.scbcrse_eff_term <= '144220')
         AND EXISTS
                (SELECT '1'
                   FROM ssbsect
                  WHERE     ssbsect_term_code = '144220'
                        AND ssbsect_subj_code = scbcrse_subj_code
                        AND ssbsect_crse_numb = scbcrse_crse_numb
                         AND SSBSECT_SSTS_CODE='ä')
         AND EXISTS
                (SELECT '1'
                   FROM SCRRTST
                  WHERE     SCRRTST_subj_code = scbcrse_subj_code
                        AND SCRRTST_crse_numb = scbcrse_crse_numb)
ORDER BY 4;