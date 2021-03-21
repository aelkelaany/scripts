/* Formatted on 10/24/2019 12:47:54 PM (QP5 v5.227.12220.39754) */
--SELECT F_GET_STD_ID('197127') FROM DUAL

SELECT COUNT (*) crn_count,
       SUM (
          DECODE (ssbsect_schd_code,
                  'Ú', NVL (NVL (ssbsect_lab_hr, scbcrse_lab_hr_low), 0),
                  'ã', NVL (NVL (ssbsect_lab_hr, scbcrse_lab_hr_low), 0),
                  'Ó', NVL (NVL (SSBSECT_OTH_HR, SCBCRSE_OTH_HR_LOW), 0),
                  0))
          lab_hr,
       SUM (
          DECODE (
             ssbsect_schd_code,
             'ä', DECODE (
                      SIRASGN_CATEGORY,
                      '01', NVL (NVL (ssbsect_lec_hr, scbcrse_lec_hr_low), 0),
                      '02', NVL (NVL (ssbsect_lab_hr, scbcrse_lab_hr_low), 0),
                      0),
             'ã', NVL (NVL (ssbsect_lec_hr, scbcrse_lec_hr_low), 0),
             0))
          lec_hr
  FROM ssbsect, scbcrse b, sirasgn
 WHERE     ssbsect_subj_code = scbcrse_subj_code
       AND ssbsect_crse_numb = scbcrse_crse_numb
       AND ssbsect_crn IN
              (SELECT a.sirasgn_crn
                 FROM sirasgn a, ssrmeet
                WHERE     f_get_std_id (a.sirasgn_pidm) LIKE :p_id
                      AND a.sirasgn_term_code = :p_term_code
                      AND a.sirasgn_crn = ssbsect_crn
                      AND sirasgn_term_code = SSRMEET_term_code
                      AND ssbsect_crn = SSRMEET_crn
                      AND SSRMEET_CATAGORY = SIRASGN_CATEGORY)
       AND ssbsect.ssbsect_term_code = :p_term_code
       AND ssbsect_term_code = SIRASGN_term_code
       AND ssbsect_crn = SIRASGN_crn
       AND f_get_std_id (sirasgn_pidm) LIKE :p_id
       AND SSBSECT_CRN IN
              (SELECT SFRSTCR_CRN
                 FROM sgbstdn b, SFRSTCR
                WHERE     b.SGBSTDN_STST_CODE IN ('AS', 'ãÚ')
                      AND (   b.SGBSTDN_STYP_CODE IN ('ä', 'Ê')
                           OR b.SGBSTDN_LEVL_CODE IN ('ãÌ', 'ÏÚ', 'MA'))
                      AND b.SGBSTDN_PIDM = SFRSTCR_PIDM
                      AND SFRSTCR_RSTS_CODE IN ('RW', 'RE')
                      AND SFRSTCR_term_code = :p_term_code
                      AND b.sgbstdn_term_code_eff =
                             (SELECT MAX (a.sgbstdn_term_code_eff)
                                FROM sgbstdn a
                               WHERE     a.sgbstdn_pidm = b.sgbstdn_pidm
                                     AND a.sgbstdn_term_code_eff <=
                                            :P_term_CODE))
       AND SCBCRSE_subJ_code || SCBCRSE_crse_numb NOT IN
              (SELECT DISTINCT SMRACAA_subJ_code || SMRACAA_CRSE_NUMB_LOW
                 FROM SMRACAA A
                WHERE     SMRACAA_TERM_CODE_EFF =
                             (SELECT MAX (SMRACAA_TERM_CODE_EFF)
                                FROM SMRACAA
                               WHERE     SMRACAA_AREA = A.SMRACAA_AREA
                                     AND SMRACAA_TERM_CODE_EFF <=
                                            :P_term_code)
                      AND SMRACAA_AREA IN
                             (SELECT SMRPAAP_AREA
                                FROM SMRPAAP
                               WHERE SMRPAAP_PROGRAM IN
                                        ('1-15022-1437',
                                         '2-15022-1437',
                                         '1-1503-1437',
                                         '2-1503-1437')))
       AND SCBCRSE_EFF_TERM =
              (SELECT MAX (a.SCBCRSE_EFF_TERM)
                 FROM SCBCRSE a
                WHERE     a.SCBCRSE_SUBJ_CODE = b.SCBCRSE_SUBJ_CODE
                      AND a.SCBCRSE_CRSE_NUMB = b.SCBCRSE_CRSE_NUMB
                      AND a.SCBCRSE_EFF_TERM <= :P_term_code)