/* Formatted on 28/07/2021 11:58:29 (QP5 v5.227.12220.39754) */
  SELECT coll_code,
         f_get_desc_fnc ('stvcoll', coll_code, 30) college,
         dept_code,
         f_get_desc_fnc ('stvdept', dept_code, 30) department,
         camp_code,
         f_get_desc_fnc ('stvcamp', camp_code, 30) campus,f_get_desc_fnc ('stvSCHD', SCHD_code, 30) SCHEDULE ,
         crn,
         SCBCRSE_SUBJ_CODE || SCBCRSE_CRSE_NUMB subject,
         title,CREDIT_HR ,
         f_get_std_id (instr_pidm) instr_id,
         f_get_std_name (instr_pidm) instr_name
    FROM (SELECT DECODE (
                    scbcrse_coll_code,
                    '00', NVL((SELECT COLL_CODE
                             FROM symtrcl_dept_mapping
                            WHERE     GENERAL_DEPT = scbcrse_dept_code
                                  AND camp_code = ssbsect_camp_code
                                  AND ROWNUM < 2),'ÚÇã'),
                    scbcrse_coll_code)
                    coll_code,
                 DECODE (
                    scbcrse_coll_code,
                    '00', NVL((SELECT dept_CODE
                             FROM symtrcl_dept_mapping
                            WHERE     GENERAL_DEPT = scbcrse_dept_code
                                  AND camp_code = ssbsect_camp_code
                                  AND ROWNUM < 2),A.SCBCRSE_SUBJ_CODE),
                    scbcrse_dept_code)
                    dept_code,
                 ssbsect_camp_code camp_code,
                  SSBSECT_SCHD_CODE SCHD_CODE,
                 ssbsect_crn crn,
                 A.SCBCRSE_SUBJ_CODE,
                 A.SCBCRSE_CRSE_NUMB,
                 scbcrse_title title,GREATEST (NVL (A.SCBCRSE_CREDIT_HR_LOW, 0),
                          NVL (A.SCBCRSE_CREDIT_HR_HIGH, 0))
                   CREDIT_HR,
                 (SELECT sirasgn_pidm
                    FROM saturn.sirasgn
                   WHERE     sirasgn_term_code = '144230'
                         AND sirasgn_crn = ssbsect_crn
                         AND sirasgn_primary_ind = 'Y')
                    instr_pidm 
            FROM scbcrse a, ssbsect
           WHERE     A.SCBCRSE_EFF_TERM =
                        (SELECT MAX (SCBCRSE_EFF_TERM)
                           FROM SCBCRSE
                          WHERE     SCBCRSE_SUBJ_CODE = A.SCBCRSE_SUBJ_CODE
                                AND SCBCRSE_CRSE_NUMB = A.SCBCRSE_CRSE_NUMB
                                AND SCBCRSE_EFF_TERM <= '144230')
                 AND A.SCBCRSE_SUBJ_CODE = ssbsect_subj_code
                 AND A.SCBCRSE_CRSE_NUMB = ssbsect_crse_numb
                 AND ssbsect_term_code = '144230'
                 AND SSBSECT_SSTS_CODE='ä'
            --   AND SSBSECT_GRADABLE_IND = 'Y'
                 AND SSBSECT_ENRL > 0)
ORDER BY coll_code,
         dept_code,
         camp_code,
         subject