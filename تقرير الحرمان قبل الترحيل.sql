/* Formatted on 10/23/2023 1:53:51 PM (QP5 v5.371) */
SELECT F_GET_DESC_FNC ('STVCOLL', SGBSTDN_COLL_CODE_1, 30)
           college,
       F_GET_DESC_FNC ('STVCAMP', SGBSTDN_CAMP_CODE, 30)
           CAMPUS,
       F_GET_DESC_FNC ('STVDEPT', SGBSTDN_DEPT_CODE, 30)
           department,
       SFRSTCR_CRN CRN ,
       SCBCRSE_TITLE TITLE,
       WF_WITHDRAW_COURSE.get_instructor_name (SFRSTCR_CRN,
                                               sfrstcr_TERM_CODE)
           INSTRUCTOR,
       f_get_std_id (sfrstcr_PIDM)
           ST_ID,
       f_get_std_name (sfrstcr_PIDM)
           st_name
  FROM sfrstcr,
       ssbsect,
       scbcrse,
       sgbstdn
 WHERE     sfrstcr_TERM_CODE = :p_term
       AND ssbsect_term_code = SFRSTCR_term_code
       AND ssbsect_subj_code = scbcrse_subj_code
       AND ssbsect_crse_numb = scbcrse_crse_numb
       AND sfrstcr_crn = ssbsect_crn
       AND sfrstcr_rsts_code IN ('RE', 'RW')
       AND SFRSTCR_GRDE_CODE = 'Í'
       AND sgbstdn_stst_code = 'AS'
       AND SCBCRSE_EFF_TERM =
           (SELECT MAX (SCBCRSE_EFF_TERM)
              FROM scbcrse
             WHERE     ssbsect_subj_code = scbcrse_subj_code
                   AND ssbsect_crse_numb = scbcrse_crse_numb)
       AND sgbstdn_pidm = sfrstcr_pidm
       AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                      FROM sgbstdn
                                     WHERE sgbstdn_pidm = sfrstcr_pidm)
                                     
                                     ORDER BY COLLEGE , CAMPUS , DEPARTMENT,CRN,ST_ID;