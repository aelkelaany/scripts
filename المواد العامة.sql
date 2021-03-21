 
SELECT scbcrse_coll_code,
       scbcrse_dept_code,
       ssbsect_crn,
       A.SCBCRSE_SUBJ_CODE,
       A.SCBCRSE_CRSE_NUMB,
       scbcrse_title , f_get_desc_fnc ('STVCAMP', ssbsect_camp_code, 60) campus
  FROM scbcrse a, ssbsect
 WHERE     A.SCBCRSE_EFF_TERM =
              (SELECT MAX (SCBCRSE_EFF_TERM)
                 FROM SCBCRSE
                WHERE     SCBCRSE_SUBJ_CODE = A.SCBCRSE_SUBJ_CODE
                      AND SCBCRSE_CRSE_NUMB = A.SCBCRSE_CRSE_NUMB
                      AND SCBCRSE_EFF_TERM <= '144020')
       AND A.SCBCRSE_SUBJ_CODE = ssbsect_subj_code
       AND A.SCBCRSE_CRSE_NUMB = ssbsect_crse_numb
       AND ssbsect_term_code = '144020'
       AND SSBSECT_GRADABLE_IND = 'Y'
       AND SSBSECT_ENRL > 0
       AND SCBCRSE_COLL_CODE IN ('11', '00')
       order by 4,5
       
       dev_sys_parameters
       
       NALSENANI