/* Formatted on 15/09/2021 12:03:09 (QP5 v5.371) */
  SELECT DISTINCT
         sirasgn_pidm,
         f_get_std_id (sirasgn_pidm)                             faculty_id,
         f_get_std_name (sirasgn_pidm)                           faculty_name,
         (SELECT F_GET_DESC_FNC ('STVCOLL', SIRDPCL_COLL_CODE, 60)
            FROM SIRDPCL
           WHERE     SIRDPCL_PIDM = sirasgn_pidm
                 AND SIRDPCL_TERM_CODE_EFF =
                     (SELECT MAX (SIRDPCL_TERM_CODE_EFF)
                        FROM SIRDPCL
                       WHERE SIRDPCL_PIDM = sirasgn_pidm)
                 AND ROWNUM < 2)                                 COLL_DESC,
         (SELECT F_GET_DESC_FNC ('STVDEPT', SIRDPCL_DEPT_CODE, 60)
            FROM SIRDPCL
           WHERE     SIRDPCL_PIDM = sirasgn_pidm
                 AND SIRDPCL_TERM_CODE_EFF =
                     (SELECT MAX (SIRDPCL_TERM_CODE_EFF)
                        FROM SIRDPCL
                       WHERE SIRDPCL_PIDM = sirasgn_pidm)
                 AND ROWNUM < 2)                                 DEPT_DESC,
         ssbsect_crn                                             crn,
         GREATEST (NVL (a.SCBCRSE_CREDIT_HR_LOW, 0),
                   NVL (a.SCBCRSE_CREDIT_HR_HIGH, 0))            credit,
         GREATEST (NVL (a.SCBCRSE_LEC_HR_LOW, 0),
                   NVL (a.SCBCRSE_LEC_HR_HIGH, 0))               lec,
         GREATEST (NVL (a.SCBCRSE_LAB_HR_LOW, 0),
                   NVL (a.SCBCRSE_LAB_HR_HIGH, 0))               lab,
         GREATEST ((NVL (a.SCBCRSE_CONT_HR_LOW, 0)),
                   NVL (a.SCBCRSE_CONT_HR_HIGH, 0))              contact,
         SCBCRSE_TITLE                                           TITLE,
         A.SCBCRSE_SUBJ_CODE                                     SUBJECT,
         A.SCBCRSE_CRSE_NUMB                                     COURSE,
         SSBSECT_SCHD_CODE                                       SCHD_CODE,SIRASGN_CATEGORY,
         DECODE (
             ssbsect_schd_code,
             'Ú', GREATEST (NVL (a.SCBCRSE_LAB_HR_LOW, 0),
                             NVL (a.SCBCRSE_LAB_HR_HIGH, 0)),
             'ã', DECODE (
                       SIRASGN_CATEGORY,
                       '01', 0,
                       GREATEST (NVL (a.SCBCRSE_LAB_HR_LOW, 0),
                                 NVL (a.SCBCRSE_LAB_HR_HIGH, 0))),
             'Ñ', GREATEST (NVL (a.SCBCRSE_LAB_HR_LOW, 0),
                             NVL (a.SCBCRSE_LAB_HR_HIGH, 0)),
             'Ó', GREATEST (NVL (a.SCBCRSE_LAB_HR_LOW, 0),
                             NVL (a.SCBCRSE_LAB_HR_HIGH, 0)),
             'Ê', GREATEST (NVL (a.SCBCRSE_LAB_HR_LOW, 0),
                             NVL (a.SCBCRSE_LAB_HR_HIGH, 0)))    lab_hr_counted,
         DECODE (
             ssbsect_schd_code,
             'ã', DECODE (
                       SIRASGN_CATEGORY,
                       '01', GREATEST (NVL (a.SCBCRSE_LEC_HR_LOW, 0),
                                       NVL (a.SCBCRSE_LEC_HR_HIGH, 0)),
                       0),
             'ä', GREATEST (NVL (a.SCBCRSE_LEC_HR_LOW, 0),
                             NVL (a.SCBCRSE_LEC_HR_HIGH, 0)))    lec_hr_counted
    FROM scbcrse a, ssbsect, sirasgn
   WHERE     A.SCBCRSE_EFF_TERM =
             (SELECT MAX (SCBCRSE_EFF_TERM)
                FROM SCBCRSE
               WHERE     SCBCRSE_SUBJ_CODE = A.SCBCRSE_SUBJ_CODE
                     AND SCBCRSE_CRSE_NUMB = A.SCBCRSE_CRSE_NUMB
                     AND SCBCRSE_EFF_TERM <=
                         f_get_param ('GENERAL', 'CURRENT_TERM', 1))
         AND A.SCBCRSE_SUBJ_CODE = ssbsect_subj_code
         AND A.SCBCRSE_CRSE_NUMB = ssbsect_crse_numb
       
         AND ssbsect_term_code = f_get_param ('GENERAL', 'CURRENT_TERM', 1)
         AND sirasgn_term_code = ssbsect_term_code
         AND ssbsect_enrl > 0
         AND SSBSECT_SSTS_CODE = 'ä'
         AND sirasgn_crn = ssbsect_crn
         AND NOT EXISTS
                 (SELECT '1'
                    FROM SGBSTDN, SFRSTCR
                   WHERE     SFRSTCR_TERM_CODE = ssbsect_term_code
                         AND sfrstcr_crn = ssbsect_crn
                         AND SGBSTDN_PIDM = SFRSTCR_PIDM
                         AND SFRSTCR_RSTS_CODE IN ('RW', 'RE')
                         AND SGBSTDN_TERM_CODE_EFF =
                             (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN
                               WHERE     SGBSTDN_PIDM = sfrstcr_PIDM
                                     AND SGBSTDN_TERM_CODE_EFF <=
                                         f_get_param ('GENERAL',
                                                      'CURRENT_TERM',
                                                      1))
                         AND (   SGBSTDN_STYP_CODE IN ('ä', 'Ê')
                              OR SGBSTDN_LEVL_CODE IN ('ãÌ', 'ÏÚ', 'MA'))
                         AND SGBSTDN_PROGRAM_1 NOT IN ('1-15022-1437',
                                                       '2-15022-1437',
                                                       '1-1503-1437',
                                                       '2-1503-1437'))
                                                       and sirasgn_pidm=33469
ORDER BY 2;



SELECT F_GET_DESC_FNC ('STVCOLL', SIRDPCL_COLL_CODE, 60)
  FROM SIRDPCL
 WHERE     SIRDPCL_PIDM = 33275
       AND SIRDPCL_TERM_CODE_EFF = (SELECT MAX (SIRDPCL_TERM_CODE_EFF)
                                      FROM SIRDPCL
                                     WHERE SIRDPCL_PIDM = 33275)
       AND ROWNUM < 2