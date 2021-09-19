/* Formatted on 25/05/2021 12:03:16 (QP5 v5.227.12220.39754) */
  SELECT DISTINCT
         f_get_std_id (sirasgn_pidm) faculty_id,
         f_get_std_name (sirasgn_pidm) faculty_name,
         (SELECT F_GET_DESC_FNC ('STVCOLL', SIRDPCL_COLL_CODE, 60)
            FROM SIRDPCL
           WHERE     SIRDPCL_PIDM = sirasgn_pidm
                 AND SIRDPCL_TERM_CODE_EFF =
                        (SELECT MAX (SIRDPCL_TERM_CODE_EFF)
                           FROM SIRDPCL
                          WHERE SIRDPCL_PIDM = sirasgn_pidm)
                 AND ROWNUM < 2)
            COLL_DESC,
         (SELECT F_GET_DESC_FNC ('STVDEPT', SIRDPCL_DEPT_CODE, 60)
            FROM SIRDPCL
           WHERE     SIRDPCL_PIDM = sirasgn_pidm
                 AND SIRDPCL_TERM_CODE_EFF =
                        (SELECT MAX (SIRDPCL_TERM_CODE_EFF)
                           FROM SIRDPCL
                          WHERE SIRDPCL_PIDM = sirasgn_pidm)
                 AND ROWNUM < 2)
            DEPT_DESC,
         ssbsect_crn crn,
         GREATEST (NVL (a.SCBCRSE_CREDIT_HR_LOW, 0),
                   NVL (a.SCBCRSE_CREDIT_HR_HIGH, 0))
            credit,
         GREATEST (NVL (a.SCBCRSE_LEC_HR_LOW, 0),
                   NVL (a.SCBCRSE_LEC_HR_HIGH, 0))
            lec,
         GREATEST (NVL (a.SCBCRSE_LAB_HR_LOW, 0),
                   NVL (a.SCBCRSE_LAB_HR_HIGH, 0))
            lab,
         GREATEST ( (NVL (a.SCBCRSE_CONT_HR_LOW, 0)),
                   NVL (a.SCBCRSE_CONT_HR_HIGH, 0))
            contact,
         SCBCRSE_TITLE TITLE,
         A.SCBCRSE_SUBJ_CODE SUBJECT,
         A.SCBCRSE_CRSE_NUMB COURSE
    FROM scbcrse a, ssbsect, sirasgn
   WHERE     A.SCBCRSE_EFF_TERM =
                (SELECT MAX (SCBCRSE_EFF_TERM)
                   FROM SCBCRSE
                  WHERE     SCBCRSE_SUBJ_CODE = A.SCBCRSE_SUBJ_CODE
                        AND SCBCRSE_CRSE_NUMB = A.SCBCRSE_CRSE_NUMB
                        AND SCBCRSE_EFF_TERM <= '144230')
         AND A.SCBCRSE_SUBJ_CODE = ssbsect_subj_code
         AND A.SCBCRSE_CRSE_NUMB = ssbsect_crse_numb
         AND ssbsect_term_code = '144230'
        
         AND sirasgn_term_code = ssbsect_term_code
         AND ssbsect_enrl > 0
         AND sirasgn_crn = ssbsect_crn
         AND  sirasgn_pidm IN (SELECT  sirasgn_pidm
    FROM (SELECT DISTINCT
                 f_get_std_name (sirasgn_pidm) faculty_name,
                 f_get_std_id (sirasgn_pidm) faculty_id,
                 ssbsect_crn crn,
                 GREATEST (NVL (a.SCBCRSE_CREDIT_HR_LOW, 0),
                           NVL (a.SCBCRSE_CREDIT_HR_HIGH, 0))
                    credit,
                 GREATEST (NVL (a.SCBCRSE_LEC_HR_LOW, 0),
                           NVL (a.SCBCRSE_LEC_HR_HIGH, 0))
                    lec,
                 GREATEST (NVL (a.SCBCRSE_LAB_HR_LOW, 0),
                           NVL (a.SCBCRSE_LAB_HR_HIGH, 0))
                    lab,
                 GREATEST ( (NVL (a.SCBCRSE_CONT_HR_LOW, 0)),
                           NVL (a.SCBCRSE_CONT_HR_HIGH, 0))
                    contact,
                 sirasgn_pidm
            FROM scbcrse a, ssbsect, sirasgn
           WHERE     A.SCBCRSE_EFF_TERM =
                        (SELECT MAX (SCBCRSE_EFF_TERM)
                           FROM SCBCRSE
                          WHERE     SCBCRSE_SUBJ_CODE = A.SCBCRSE_SUBJ_CODE
                                AND SCBCRSE_CRSE_NUMB = A.SCBCRSE_CRSE_NUMB
                                AND SCBCRSE_EFF_TERM <= '144230')
                 AND A.SCBCRSE_SUBJ_CODE = ssbsect_subj_code
                 AND A.SCBCRSE_CRSE_NUMB = ssbsect_crse_numb
                 AND ssbsect_term_code = '144230'
                 
                 AND sirasgn_term_code = ssbsect_term_code
                 and ssbsect_enrl>0
                 AND sirasgn_crn = ssbsect_crn
              
 