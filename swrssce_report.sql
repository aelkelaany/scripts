
SELECT  distinct spriden_id from  (
SELECT spriden_id,
       spriden_pidm,
          ' '
       || spriden_first_name
       || ' '
       || spriden_mi
       || ' '
       || spriden_last_name
          student_name,
       stvschd_desc,
       ssbsect_schd_code,
       ssbsect_crn,
       ssbsect_seq_numb,
       ssbsect_subj_code,
       ssbsect_crse_numb,
       sfrstcr_credit_hr,
       sfrstcr_term_code,
       scbcrse_subj_code || '-' || scbcrse_crse_numb course_no,
       ' ' || NVL (SSBSECT_CRSE_TITLE, SCBCRSE_TITLE) SCBCRSE_TITLE,
       sgbstdn_camp_code,
       sgbstdn_coll_code_1,
       sgbstdn_levl_code,
       sgbstdn_majr_code_1,
       sgbstdn_dept_code,
          DECODE (SSRMEET.SSRMEET_SUN_DAY,
                  'U', '?',
                  SSRMEET.SSRMEET_SUN_DAY)
       || ' '
       || DECODE (SSRMEET.SSRMEET_MON_DAY,
                  'M', '?',
                  SSRMEET.SSRMEET_MON_DAY)
       || ' '
       || DECODE (SSRMEET.SSRMEET_TUE_DAY,
                  'T', 'E',
                  SSRMEET.SSRMEET_TUE_DAY)
       || ' '
       || DECODE (SSRMEET.SSRMEET_WED_DAY,
                  'W', '?',
                  SSRMEET.SSRMEET_WED_DAY)
       || ' '
       || DECODE (SSRMEET.SSRMEET_THU_DAY,
                  'R', 'I',
                  SSRMEET.SSRMEET_THU_DAY)
       || ' '
       || DECODE (SSRMEET.SSRMEET_FRI_DAY,
                  'F', '?',
                  SSRMEET.SSRMEET_FRI_DAY)
       || ' '
       || DECODE (SSRMEET.SSRMEET_SAT_DAY,
                  'S', '?',
                  SSRMEET.SSRMEET_SAT_DAY)
          DAYES,
       SSRMEET.SSRMEET_BEGIN_TIME || ' - ' || SSRMEET.SSRMEET_END_TIME TIME,
       ssrmeet_bldg_code,
       stvbldg.stvbldg_desc,
       ssrmeet_room_code,
       ssrmeet_catagory,
       SHRLGPA_HOURS_EARNED,
       ROUND (SHRLGPA_GPA, 3)
  FROM spriden,
       sgbstdn,
       sfrstcr,
       scbcrse,
       shrlgpa,
       ssbsect,
       ssrmeet,
       stvschd,
       stvbldg
 WHERE     spriden_id BETWEEN :p_id_from AND :P_ID_TO
       AND sfrstcr_term_code = :p_term_code
       AND NVL (sgbstdn_coll_code_1, '%') LIKE :p_coll_code
       AND NVL (sgbstdn_majr_code_1, '%') LIKE :p_majr_code
       AND NVL (sgbstdn_dept_code, '%') LIKE :p_dept_code
       AND NVL (sgbstdn_camp_code, '%') LIKE :p_camp_code
       AND NVL (sgbstdn_levl_code, '%') LIKE :p_levl_code
       AND NVL (sgbstdn_styp_code, '%') LIKE :p_styp
       AND ssrmeet_term_code(+) = ssbsect_term_code
       AND ssrmeet_crn(+) = ssbsect_crn
       AND NVL (ssrmeet_bldg_code, '00') = stvbldg.stvbldg_code
       AND spriden_pidm = sgbstdn_pidm
       AND spriden_pidm = sfrstcr_pidm
       AND sfrstcr_term_code = ssbsect_term_code
       AND sfrstcr_crn = ssbsect_crn
       AND sgbstdn_pidm = shrlgpa_pidm(+)
       AND sgbstdn_levl_code = shrlgpa_levl_code(+)
       AND scbcrse_subj_code = ssbsect_subj_code
       AND scbcrse_crse_numb = ssbsect_crse_numb
       AND scbcrse_eff_term =
              (SELECT MAX (scbcrse_eff_term)
                 FROM scbcrse
                WHERE     scbcrse_subj_code = ssbsect_subj_code
                      AND scbcrse_crse_numb = ssbsect_crse_numb)
       AND ssbsect_schd_code = stvschd_code
       AND spriden_change_ind IS NULL
       
       AND  
           sgbstdn_term_code_eff = (SELECT MAX (sgbstdn_term_code_eff)
                                      FROM sgbstdn
                                     WHERE sgbstdn_pidm = spriden_pidm)
                                           
       AND NVL (sfrstcr_error_flag, 'N') <> 'F'
       AND sfrstcr_rsts_code IN
              (SELECT DISTINCT stvrsts_code
                 FROM stvrsts
                WHERE     stvrsts_incl_sect_enrl = 'Y'
                      AND stvrsts_gradable_ind = 'Y')
       AND NVL (shrlgpa_gpa_type_ind, 'O') = 'O' )
       where   spriden_id='435006937'
       
       
       
       GORFBPR