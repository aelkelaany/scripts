/* Formatted on 15/06/2021 10:00:36 (QP5 v5.227.12220.39754) */
  SELECT COLL_DESC,
         DEPT_DESC,
         credit,
         COUNT (crn),
         credit * COUNT (crn) total,
         SUBJECT || COURSE,
         TITLE
    FROM (SELECT DISTINCT
                 F_GET_DESC_FNC ('STVCOLL', a.SCBCRSE_COLL_CODE, 60) COLL_DESC,
                 F_GET_DESC_FNC ('STVDEPT', a.SCBCRSE_DEPT_CODE, 60) DEPT_DESC,
                 ssbsect_crn crn,
                 GREATEST (NVL (a.SCBCRSE_CREDIT_HR_LOW, 0),
                           NVL (a.SCBCRSE_CREDIT_HR_HIGH, 0))
                    credit,
                 SCBCRSE_TITLE TITLE,
                 A.SCBCRSE_SUBJ_CODE SUBJECT,
                 A.SCBCRSE_CRSE_NUMB COURSE
            FROM scbcrse a, ssbsect
           WHERE     A.SCBCRSE_EFF_TERM =
                        (SELECT MAX (SCBCRSE_EFF_TERM)
                           FROM SCBCRSE
                          WHERE     SCBCRSE_SUBJ_CODE = A.SCBCRSE_SUBJ_CODE
                                AND SCBCRSE_CRSE_NUMB = A.SCBCRSE_CRSE_NUMB
                                AND SCBCRSE_EFF_TERM <= '144310')
                 AND A.SCBCRSE_SUBJ_CODE = ssbsect_subj_code
                 AND A.SCBCRSE_CRSE_NUMB = ssbsect_crse_numb
                 AND ssbsect_term_code = '144310'
                 AND a.SCBCRSE_DEPT_CODE = '3201')
GROUP BY COLL_DESC,
         DEPT_DESC,
         credit,
         SUBJECT || COURSE,
         TITLE
ORDER BY 6;