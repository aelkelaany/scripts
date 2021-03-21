 
SELECT DISTINCT
       SSBSECT_TERM_CODE,
       SSBSECT_CRN,
       SSBSECT_SUBJ_CODE || '' || SSBSECT_CRSE_NUMB course_no,
       SSBSECT_SCHD_CODE,
       SSBSECT_CAMP_CODE,
       SSBSECT_MAX_ENRL,
       SSBSECT_SEQ_NUMB,
       SSBSECT_SEATS_AVAIL,
       SSBSECT_ENRL,
       SCBCRSE_COLL_CODE,
       SCBCRSE_DEPT_CODE,
       ' ' || SCBCRSE_TITLE SCBCRSE_TITLE,
       NVL (SSBSECT_CREDIT_HRS, SCBCRSE_CREDIT_HR_LOW) SCBCRSE_CREDIT_HR_LOW,
       ssbsect_subj_code,
       ssbsect_crse_numb
  FROM SSBSECT,
       SCBCRSE a,
       SSRMEET,
       sfrstcr
 WHERE     SSBSECT_TERM_CODE LIKE :TERM
        AND      nvl(SCBCRSE_COLL_CODE,'%')                LIKE :COLL
       AND       nvl(SCBCRSE_DEPT_CODE,'%')               LIKE :DEPT
       AND NVL (SSBSECT_CAMP_CODE, '%') LIKE :CAMP
       AND NVL (SSBSECT_SUBJ_CODE, '%') LIKE :SUBJ
       AND ssbsect_crn BETWEEN :p_from_crn AND :p_to_crn
       AND NVL (SSBSECT_SEQ_NUMB, '%') LIKE UPPER (:p_from_seq)
       AND ssbsect_crn = sfrstcr_crn
       AND ssbsect_term_code = sfrstcr_term_code
       AND sfrstcr_pidm IN
              (SELECT b.sgbstdn_pidm
                 FROM sgbstdn b
                WHERE     b.sgbstdn_stst_code = 'AS'
                 -- and b.sgbstdn_styp_code = 'ã'
                       
                      AND b.sgbstdn_program_1 LIKE :Prog
                      AND b.sgbstdn_term_code_eff =
                             (SELECT MAX (a.sgbstdn_term_code_eff)
                                FROM sgbstdn a
                               WHERE     a.sgbstdn_pidm = b.sgbstdn_pidm
                                     AND a.sgbstdn_term_code_eff <= :TERM))
       AND SSRMEET_TERM_CODE(+) = SSBSECT_TERM_CODE
       AND SSRMEET_CRN(+) = SSBSECT_CRN
       AND SCBCRSE_SUBJ_CODE = SSBSECT_SUBJ_CODE
       AND SCBCRSE_CRSE_NUMB = SSBSECT_CRSE_NUMB
       AND SSBSECT_SSTS_CODE = 'ä'
       AND scbcrse_eff_term =
              (SELECT MAX (scbcrse_eff_term)
                 FROM scbcrse
                WHERE     scbcrse_subj_code = a.scbcrse_subj_code
                      AND scbcrse_crse_numb = a.scbcrse_crse_numb)