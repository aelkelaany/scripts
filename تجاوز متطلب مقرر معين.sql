/* Formatted on 3/22/2023 9:04:02 AM (QP5 v5.371) */
  SELECT A.SMRDORQ_PIDM,
         SHRTTRM_TERM_CODE,
         f_get_desc_fnc ('stvstst', sgbstdn_stst_code, 30)
             stst,
         f_get_desc_fnc ('stvcamp', sgbstdn_camp_code, 30)
             campus,
         f_get_desc_fnc ('stvdept', sgbstdn_dept_code, 30)
             dept,
         F_GET_STD_ID (A.SMRDORQ_PIDM)
             STD_ID,
         F_GET_STD_NAME (A.SMRDORQ_PIDM)
             STD_NAME,
         A.SMRDORQ_PROGRAM,
         A.SMRDORQ_SUBJ_CODE || A.SMRDORQ_CRSE_NUMB_LOW,
         ROUND (SHRLGPA_GPA, 2)
             cgpa,
         f_get_desc_fnc ('stvastd', SHRTTRM_ASTD_CODE_END_OF_TERM, 30)
             astd,
         (SELECT sprtele_intl_access
            FROM sprtele
           WHERE     sprtele_pidm = sgbstdn_pidm
                 AND sprtele_tele_code = 'MO'
                 AND ROWNUM < 2)
             "Mobile NO",
         (SELECT spbpers_ssn
            FROM spbpers
           WHERE spbpers_pidm = sgbstdn_pidm)
             "SSN",
         (SELECT spbpers_sex
            FROM spbpers
           WHERE spbpers_pidm = sgbstdn_pidm)
             "Gender",
         ssbsect_crn ,ssbsect_subj_code || ssbsect_crse_numb ,SFRSTCR_RSTS_CODE
    FROM smrdorq a,
         SGBSTDN sg,
         shrlgpa,
         shrttrm,
         sfrstcr,
         ssbsect
   WHERE     A.smrdorq_request_no = (SELECT MAX (smrdorq_request_no)
                                       FROM smrdorq
                                      WHERE smrdorq_pidm = a.smrdorq_pidm)
         AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                        FROM sgbstdn
                                       WHERE sgbstdn_pidm = sg.sgbstdn_pidm)
         AND sg.sgbstdn_pidm = a.smrdorq_pidm
         AND sgbstdn_coll_code_1 IN ('12')
         AND A.SMRDORQ_SUBJ_CODE || A.SMRDORQ_CRSE_NUMB_LOW IN ('ACCO4251')
         AND SMRDORQ_MET_IND = 'N'
         AND SHRLGPA_PIDM = sg.sgbstdn_pidm
         AND sg.sgbstdn_pidm = SHRTTRM_PIDM
         AND SHRTTRM_TERM_CODE = (SELECT MAX (SHRTTRM_TERM_CODE)
                                    FROM SHRTTRM
                                   WHERE SHRTTRM_PIDM = sg.sgbstdn_pidm)
         AND SHRLGPA_GPA_TYPE_IND = 'O'
         AND SHRLGPA_LEVL_CODE = sgbstdn_levl_code
         AND sfrstcr_pidm = sg.sgbstdn_pidm
         AND sfrstcr_term_code = '144430'
         AND sfrstcr_term_code = ssbsect_term_code
         AND sfrstcr_crn = ssbsect_crn
         AND ssbsect_subj_code || ssbsect_crse_numb IN ('ACCO4253',
                                                                'ACCO4254',
                                                                'ACCO4255',
                                                                'ACCO4256') 
         AND SFRSTCR_RSTS_CODE IN ('RE','RW')
ORDER BY std_id, SMRDORQ_PROGRAM