/* Formatted on 4/17/2019 3:15:07 PM (QP5 v5.227.12220.39754) */
SELECT DISTINCT sfrstcr_pidm STDDNAL_PIDM,
                f_get_std_id (sfrstcr_pidm) ID,
                f_get_std_NAME (sfrstcr_pidm) NAME,
                SMRPRLE_program_DESC 
                ,f_get_desc_fnc('STVCOLL', SGBSTDN_COLL_CODE_1, 30) , f_get_desc_fnc('STVDEPT', SGBSTDN_DEPT_CODE, 30) ,SGBSTDN_COLL_CODE_1 ,SGBSTDN_DEPT_CODE
                
  FROM shrtckn,
       shrtckg a,
       ssbsect,
       shrgrde,
       sfrstcr,
       SGBSTDN,
       SCBCRSE,
       SMRPRLE
 WHERE     shrtckn_pidm = shrtckg_pidm
       AND shrtckn_pidm = SGBSTDN_pidm
       AND shrtckn_term_code = shrtckg_term_code
       AND shrtckn_seq_no = shrtckg_tckn_seq_no
       AND ssbsect_crn = sfrstcr_crn
       AND ssbsect_subj_code || ssbsect_crse_numb =
              sCBCRSE_subj_code || sCBCRSE_crse_numb
       AND sgbstdn_program_1 = SMRPRLE_program
       AND SGBSTDN_STST_CODE = 'AS'
       AND SFRSTCR_RSTS_CODE IN ('RW', 'RE')
       AND SFRSTCR_levl_code = SGBSTDN_LEVL_CODE
       AND ssbsect_term_code = sfrstcr_term_code
       AND ssbsect_subj_code = shrtckn_subj_code
       AND ssbsect_crse_numb = shrtckn_crse_numb
       AND sfrstcr_pidm = shrtckn_pidm
       AND shrtckg_seq_no =
              (SELECT MAX (b.shrtckg_seq_no)
                 FROM shrtckg b
                WHERE     a.shrtckg_term_code = b.shrtckg_term_code
                      AND a.shrtckg_pidm = b.shrtckg_pidm
                      AND a.shrtckg_tckn_seq_no = b.shrtckg_tckn_seq_no)
       AND SFRSTCR_levl_code = SHRGRDE_LEVL_CODE
       AND shrtckg_grde_code_final = shrgrde_code
       -- AND shrgrde_code IN('α')
       AND SHRGRDE_PASSED_IND = 'N'
       AND SHRGRDE_CODE  IN ('εά','Ν')
       AND sfrstcr_term_code = '143910'
       AND sgbstdn_term_code_eff =
              (SELECT MAX (a.sgbstdn_term_code_eff)
                 FROM sgbstdn a
                WHERE     a.sgbstdn_pidm = SFRSTCR_pidm
                      AND a.sgbstdn_term_code_eff <= '143910')
                      order by SGBSTDN_COLL_CODE_1 ,SGBSTDN_DEPT_CODE ,SMRPRLE_program_DESC