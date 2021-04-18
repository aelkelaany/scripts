/* Formatted on 08/04/2021 12:49:55 (QP5 v5.227.12220.39754) */
FUNCTION CF_1Formula
   RETURN NUMBER
IS
   CURSOR get_hours (
      v_term VARCHAR2)
   IS
      SELECT COUNT (*) crn_count,
             SUM (
                DECODE (
                   ssbsect_schd_code,
                   '?', NVL (NVL (ssbsect_lab_hr, scbcrse_lab_hr_low), 0),
                   '?', DECODE (
                            SIRASGN_CATEGORY,
                            '01', 0,
                            NVL (NVL (ssbsect_lab_hr, scbcrse_lab_hr_low), 0)),
                   '?', NVL (NVL (ssbsect_lab_hr, scbcrse_lab_hr_low), 0),
                   '?', NVL (NVL (ssbsect_lab_hr, scbcrse_lab_hr_low), 0),
                   'E', NVL (NVL (ssbsect_lab_hr, scbcrse_lab_hr_low), 0),
                   0))
                lab_hr,
             SUM (
                DECODE (
                   ssbsect_schd_code,
                   '?', DECODE (
                            SIRASGN_CATEGORY,
                            '01', NVL (
                                     NVL (ssbsect_lec_hr, scbcrse_lec_hr_low),
                                     0),
                            0),
                   '?', NVL (NVL (ssbsect_lec_hr, scbcrse_lec_hr_low), 0),
                   0))
                lec_hr
        FROM ssbsect, scbcrse b, sirasgn
       WHERE     ssbsect_subj_code = scbcrse_subj_code
             AND ssbsect_crse_numb = scbcrse_crse_numb
             AND SSBSECT_SSTS_CODE = '?'
             AND sirasgn_crn = ssbsect_crn
             AND sirasgn_term_code = ssbsect_term_code
             AND ssbsect_crn IN
                    (SELECT a.sirasgn_crn
                       FROM sirasgn a, ssrmeet
                      WHERE     a.sirasgn_pidm = f_get_pidm (:SPRIDEN_ID)
                            AND a.sirasgn_term_code = v_term
                            AND a.sirasgn_crn = ssbsect_crn
                            AND sirasgn_term_code = SSRMEET_term_code
                            AND ssbsect_crn = SSRMEET_crn
                            AND SSRMEET_CATAGORY = SIRASGN_CATEGORY)
             AND ssbsect.ssbsect_term_code = v_term
             AND sirasgn_pidm = f_get_pidm (:SPRIDEN_ID)
             AND SSBSECT_CRN NOT IN
                    (SELECT SFRSTCR_CRN
                       FROM sgbstdn b, SFRSTCR
                      WHERE     b.SGBSTDN_STST_CODE IN
                                   ('AS', '??', '??', 'I?')
                            AND (   b.SGBSTDN_STYP_CODE IN ('?', 'E')
                                 OR b.SGBSTDN_LEVL_CODE IN
                                       ('??', 'I?', 'MA'))
                            AND B.SGBSTDN_PROGRAM_1 NOT IN
                                   ('1-15022-1437',
                                    '2-15022-1437',
                                    '1-1503-1437',
                                    '2-1503-1437')
                            AND b.SGBSTDN_PIDM = SFRSTCR_PIDM
                            AND SFRSTCR_RSTS_CODE IN ('RW', 'RE')
                            AND SFRSTCR_term_code = v_term
                            AND b.sgbstdn_term_code_eff =
                                   (SELECT MAX (a.sgbstdn_term_code_eff)
                                      FROM sgbstdn a
                                     WHERE     a.sgbstdn_pidm =
                                                  b.sgbstdn_pidm
                                           AND a.sgbstdn_term_code_eff <=
                                                  v_term))
             AND SCBCRSE_EFF_TERM =
                    (SELECT MAX (a.SCBCRSE_EFF_TERM)
                       FROM SCBCRSE a
                      WHERE     a.SCBCRSE_SUBJ_CODE = b.SCBCRSE_SUBJ_CODE
                            AND a.SCBCRSE_CRSE_NUMB = b.SCBCRSE_CRSE_NUMB
                            AND a.SCBCRSE_EFF_TERM <= v_term);


   CURSOR Get_Hours_Lab_mix (
      v_term VARCHAR2)
   IS
      SELECT NVL (
                SUM (
                   DECODE (
                      ssbsect_schd_code,
                      '?', NVL (NVL (ssbsect_lab_hr, scbcrse_lab_hr_low), 0),
                      0)),
                0)
                lab_hr_mix
        FROM ssbsect, scbcrse b, sirasgn
       WHERE     ssbsect_subj_code = scbcrse_subj_code
             AND ssbsect_crse_numb = scbcrse_crse_numb
             AND SSBSECT_SSTS_CODE = '?'
             AND sirasgn_crn = ssbsect_crn
             AND sirasgn_term_code = ssbsect_term_code
             AND ssbsect_schd_code = '?'
             AND NOT EXISTS
                        (SELECT 0
                           FROM ssrmeet
                          WHERE     SSRMEET_CATAGORY <> '01'
                                AND ssrmeet_crn = ssbsect_crn
                                AND ssrmeet_term_code = ssbsect_term_code)
             AND ssbsect_crn IN
                    (SELECT a.sirasgn_crn
                       FROM sirasgn a, ssrmeet
                      WHERE     a.sirasgn_pidm = f_get_pidm (:SPRIDEN_ID)
                            AND a.sirasgn_term_code = v_term
                            AND a.sirasgn_crn = ssbsect_crn
                            AND sirasgn_term_code = SSRMEET_term_code
                            AND ssbsect_crn = SSRMEET_crn
                            AND SSRMEET_CATAGORY = SIRASGN_CATEGORY)
             AND ssbsect.ssbsect_term_code = v_term
             AND sirasgn_pidm = f_get_pidm (:SPRIDEN_ID)
             AND SSBSECT_CRN NOT IN
                    (SELECT SFRSTCR_CRN
                       FROM sgbstdn b, SFRSTCR
                      WHERE     b.SGBSTDN_STST_CODE IN
                                   ('AS', '??', '??', 'I?')
                            AND (   b.SGBSTDN_STYP_CODE IN ('?', 'E')
                                 OR b.SGBSTDN_LEVL_CODE IN
                                       ('??', 'I?', 'MA'))
                            AND B.SGBSTDN_PROGRAM_1 NOT IN
                                   ('1-15022-1437',
                                    '2-15022-1437',
                                    '1-1503-1437',
                                    '2-1503-1437')
                            AND b.SGBSTDN_PIDM = SFRSTCR_PIDM
                            AND SFRSTCR_RSTS_CODE IN ('RW', 'RE')
                            AND SFRSTCR_term_code = v_term
                            AND b.sgbstdn_term_code_eff =
                                   (SELECT MAX (a.sgbstdn_term_code_eff)
                                      FROM sgbstdn a
                                     WHERE     a.sgbstdn_pidm =
                                                  b.sgbstdn_pidm
                                           AND a.sgbstdn_term_code_eff <=
                                                  v_term))
             AND SCBCRSE_EFF_TERM =
                    (SELECT MAX (a.SCBCRSE_EFF_TERM)
                       FROM SCBCRSE a
                      WHERE     a.SCBCRSE_SUBJ_CODE = b.SCBCRSE_SUBJ_CODE
                            AND a.SCBCRSE_CRSE_NUMB = b.SCBCRSE_CRSE_NUMB
                            AND a.SCBCRSE_EFF_TERM <= v_term);


   Lab1   NUMBER := 0;
   Lab2   NUMBER := 0;
BEGIN
   OPEN get_hours (:P_term_code);

   FETCH get_hours
      INTO :CP_1, lab1, :CP_3;

   OPEN Get_Hours_Lab_mix (:P_term_code);

   FETCH Get_Hours_Lab_mix INTO lab2;



   :CP_2 := lab1 + lab2;

   CLOSE get_hours;

   RETURN '';
END;