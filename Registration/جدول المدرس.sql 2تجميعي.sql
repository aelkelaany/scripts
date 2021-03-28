/* Formatted on 25/03/2021 10:10:27 (QP5 v5.227.12220.39754) */
  SELECT faculty_id,
         faculty_name,
         COLL_DESC,
         DEPT_DESC,
         COUNT (crn),
         SUM (credit),
         SUM (lec),
         SUM (lab),
         SUM (contact)
    FROM (SELECT DISTINCT
                 F_GET_DESC_FNC ('STVCOLL', SIRDPCL_COLL_CODE, 60) COLL_DESC,
                 F_GET_DESC_FNC ('STVDEPT', SIRDPCL_DEPT_CODE, 60) DEPT_DESC,
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
                    contact
            FROM scbcrse a,
                 ssbsect,
                 sirasgn,
                 SIRDPCL
           WHERE     A.SCBCRSE_EFF_TERM =
                        (SELECT MAX (SCBCRSE_EFF_TERM)
                           FROM SCBCRSE
                          WHERE     SCBCRSE_SUBJ_CODE = A.SCBCRSE_SUBJ_CODE
                                AND SCBCRSE_CRSE_NUMB = A.SCBCRSE_CRSE_NUMB
                                AND SCBCRSE_EFF_TERM <= '144220')
                 AND A.SCBCRSE_SUBJ_CODE = ssbsect_subj_code
                 AND A.SCBCRSE_CRSE_NUMB = ssbsect_crse_numb
                 AND ssbsect_term_code = '144220'
                 AND ssbsect_ptrm_code = '4'      --------------------->>level
                 AND sirasgn_term_code = ssbsect_term_code
                 AND sirasgn_crn = ssbsect_crn
                 --  AND SIRASGN_PRIMARY_IND = 'Y'
                 AND SIRDPCL_PIDM = sirasgn_pidm
                 -- and SIRDPCL_HOME_IND='Y'
                 AND SIRDPCL_TERM_CODE_EFF =
                        (SELECT MAX (SIRDPCL_TERM_CODE_EFF)
                           FROM SIRDPCL
                          WHERE SIRDPCL_PIDM = sirasgn_pidm))
GROUP BY COLL_DESC,
         DEPT_DESC,
         faculty_name,
         faculty_id
ORDER BY 1