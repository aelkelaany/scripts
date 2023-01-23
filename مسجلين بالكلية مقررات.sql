/* Formatted on 1/3/2023 12:22:10 PM (QP5 v5.371) */
  SELECT DISTINCT spriden_id ,
       
            ' '
         || spriden_first_name
         || ' '
         || spriden_mi
         || ' '
         || spriden_last_name
             student_name,
         scbcrse_coll_code,
         scbcrse_dept_code,
         stvcoll_desc,
         stvdept_desc,
           ssbsect_crn,
         NVL (ssbsect_credit_hrs, scbcrse_credit_hr_low)
             credits,
         ssbsect_subj_code || '-' || ssbsect_crse_numb
             course_code,
         ssbsect_seq_numb,
         scbcrse_title,
         ssbsect_enrl,
         f_get_std_id (sirasgn_pidm)
             teacher_id,
         f_get_std_name (sirasgn_pidm)
             teacher_name,
         
         spriden_pidm,
         ssbsect_camp_code,
         f_get_desc_fnc ('stvmajr', a.sgbstdn_majr_code_1, 30),
         f_get_desc_fnc ('stvcoll', a.sgbstdn_coll_code_1, 30)
             student_college,
         (SELECT SPRTELE_INTL_ACCESS
            FROM sprtele
           WHERE     SPRTELE_TELE_CODE = 'MO'
                 AND spbpers_pidm = sprtele_pidm
                 AND ROWNUM < 2)
             st_phone,
         spbpers_ssn ,sgbstdn_majr_code_1
    FROM scbcrse,
         ssbsect,
         sfrstcr,
         sirasgn,
         stvcoll,
         stvdept,
         spriden,
         sgbstdn a,
         spbpers
   WHERE     ssbsect_term_code = :p_term_code
         AND a.sgbstdn_coll_code_1 = :college
         --   AND ssbsect_camp_code IN ('01', '02')
         AND scbcrse_subj_code = ssbsect_subj_code
         AND scbcrse_crse_numb = ssbsect_crse_numb
         AND scbcrse_eff_term =
             (SELECT MAX (scbcrse_eff_term)
                FROM scbcrse
               WHERE     scbcrse_subj_code = ssbsect_subj_code
                     AND scbcrse_crse_numb = ssbsect_crse_numb
                     AND scbcrse_eff_term <= :p_term_code)
         AND ssbsect_term_code = sfrstcr_term_code
         AND ssbsect_crn = sfrstcr_crn
         AND ssbsect_term_code = sirasgn_term_code(+)
         AND ssbsect_crn = sirasgn_crn(+)
         AND DECODE (sirasgn_pidm, NULL, 'Y', sirasgn_primary_ind) = 'Y'
         AND scbcrse_coll_code = stvcoll_code(+)
         AND scbcrse_dept_code = stvdept_code(+)
         AND sfrstcr_pidm = spriden_pidm
         AND spbpers_pidm = spriden_pidm
         AND spbpers_sex = :sex
         AND spriden_change_ind IS NULL
         AND spriden_pidm = sgbstdn_pidm
         AND sgbstdn_term_code_eff = (SELECT MAX (sgbstdn_term_code_eff)
                                        FROM sgbstdn b
                                       WHERE b.sgbstdn_pidm = a.sgbstdn_pidm)
         AND sfrstcr_rsts_code IN ('RE', 'RW')
ORDER BY  sgbstdn_majr_code_1 ,spriden_id
/*,
         ssbsect_camp_code,
         scbcrse_coll_code,
         scbcrse_dept_code,
         course_code,
         ssbsect_crn,
         rsts_code DESC,
         student_name*/