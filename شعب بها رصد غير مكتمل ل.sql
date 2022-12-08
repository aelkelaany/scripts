/* Formatted on 12/6/2022 11:11:51 AM (QP5 v5.371) */
SELECT f_get_desc_fnc ('stvcoll', scbcrse_coll_code, 30)             coll,
       f_get_desc_fnc ('stvdept', scbcrse_dept_code, 30)             dept,
       ''''||ssbsect_crn||''',',
       A.SCBCRSE_SUBJ_CODE,
       A.SCBCRSE_CRSE_NUMB,
       scbcrse_title,
       ssbsect_ptrm_code,
       SSBSECT_SCHD_CODE,
       wf_withdraw_course.get_INSTRUCTOR_NAME (ssbsect_crn,
                                               ssbsect_term_code)    INSTR,
       f_get_desc_fnc ('stvcamp', ssbsect_camp_code, 30)             camp , (select count(sfrstcr_pidm) FROM sfrstcr x
                 WHERE     ssbsect_term_code = sfrstcr_term_code
                       AND ssbsect_crn = sfrstcr_crn
                       AND sfrstcr_term_code = '144410'
                       AND sfrstcr_grde_code ='á'
                       AND sfrstcr_grde_date IS not NULL
                       AND sfrstcr_rsts_code IN ('RE', 'RW') ) std_count ,SSBSECT_ENRL
  FROM scbcrse a, ssbsect 
 WHERE     A.SCBCRSE_EFF_TERM =
           (SELECT MAX (SCBCRSE_EFF_TERM)
              FROM SCBCRSE
             WHERE     SCBCRSE_SUBJ_CODE = A.SCBCRSE_SUBJ_CODE
                   AND SCBCRSE_CRSE_NUMB = A.SCBCRSE_CRSE_NUMB
                   AND SCBCRSE_EFF_TERM <= '144410')
       AND A.SCBCRSE_SUBJ_CODE = ssbsect_subj_code
       AND A.SCBCRSE_CRSE_NUMB = ssbsect_crse_numb
       AND ssbsect_term_code = '144410'
       AND SSBSECT_GRADABLE_IND = 'Y'
       AND SSBSECT_SSTS_CODE = 'ä'
       AND SSBSECT_ENRL > 0
       AND EXISTS
               (SELECT 'a'
                  FROM sfrstcr x
                 WHERE     ssbsect_term_code = sfrstcr_term_code
                       AND ssbsect_crn = sfrstcr_crn
                       AND sfrstcr_term_code = '144410'
                       AND sfrstcr_grde_code ='á'
                       AND sfrstcr_grde_date IS not NULL
                       AND sfrstcr_rsts_code IN ('RE', 'RW'))
  
 
       AND SSBSECT_SCHD_CODE IN ('ä', 'ã')
--and SCBCRSE_COLL_CODE  NOT in ('11','00')
 and  SSBSECT_PTRM_CODE!=4
 
 ;