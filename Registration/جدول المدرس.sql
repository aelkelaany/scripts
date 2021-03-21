/* Formatted on 5/17/2020 12:34:53 AM (QP5 v5.360) */
  SELECT scbcrse_coll_code,
         scbcrse_dept_code,
         F_GET_DESC_FNC ('STVCOLL', scbcrse_coll_code, 60)    COLL_DESC,
         F_GET_DESC_FNC ('STVDEPT', scbcrse_dept_code, 60)    DEPT_DESC,
         f_get_std_name (sirasgn_pidm)                        faculty_name,
         f_get_std_id (sirasgn_pidm),
         a.SCBCRSE_TITLE,
         GREATEST (NVL (a.SCBCRSE_CREDIT_HR_LOW, 0),
                   NVL (a.SCBCRSE_CREDIT_HR_HIGH, 0))         credit,
         GREATEST (NVL (a.SCBCRSE_LEC_HR_LOW, 0),
                   NVL (a.SCBCRSE_LEC_HR_HIGH, 0))            lec,
         GREATEST (NVL (a.SCBCRSE_LAB_HR_LOW, 0),
                   NVL (a.SCBCRSE_LAB_HR_HIGH, 0))            lab,
                   GREATEST (NVL (a.SCBCRSE_CONT_HR_LOW, 0),
                   NVL (a.SCBCRSE_CONT_HR_HIGH, 0))            contact
    FROM scbcrse a, ssbsect, sirasgn
   WHERE     A.SCBCRSE_EFF_TERM =
             (SELECT MAX (SCBCRSE_EFF_TERM)
                FROM SCBCRSE
               WHERE     SCBCRSE_SUBJ_CODE = A.SCBCRSE_SUBJ_CODE
                     AND SCBCRSE_CRSE_NUMB = A.SCBCRSE_CRSE_NUMB
                     AND SCBCRSE_EFF_TERM <= '144030')
         AND A.SCBCRSE_SUBJ_CODE = ssbsect_subj_code
         AND A.SCBCRSE_CRSE_NUMB = ssbsect_crse_numb
         AND ssbsect_term_code = '144030'
         AND sirasgn_term_code = ssbsect_term_code
         AND sirasgn_crn = ssbsect_crn
         AND SIRASGN_PRIMARY_IND = 'Y'
ORDER BY 5

----+++++++++++++++++++++++++++++++
/* Formatted on 5/17/2020 12:34:53 AM (QP5 v5.360) */
  
  select 
   faculty_id ,faculty_name ,COLL_DESC,DEPT_DESC,SCBCRSE_TITLE ,count(crn),sum(credit) ,sum(lec),sum(lab),sum(contact)
         from 
  (SELECT   
         F_GET_DESC_FNC ('STVCOLL', SIRDPCL_COLL_CODE, 60)    COLL_DESC,
         F_GET_DESC_FNC ('STVDEPT', SIRDPCL_DEPT_CODE, 60)    DEPT_DESC,
         f_get_std_name (sirasgn_pidm)                        faculty_name,
         f_get_std_id (sirasgn_pidm) faculty_id,
         ssbsect_crn crn , a.SCBCRSE_TITLE ,
          GREATEST (NVL (a.SCBCRSE_CREDIT_HR_LOW, 0),
                   NVL (a.SCBCRSE_CREDIT_HR_HIGH, 0))          credit,
          GREATEST (NVL (a.SCBCRSE_LEC_HR_LOW, 0),
                   NVL (a.SCBCRSE_LEC_HR_HIGH, 0))             lec,
         GREATEST (NVL (a.SCBCRSE_LAB_HR_LOW, 0),
                   NVL (a.SCBCRSE_LAB_HR_HIGH, 0))             lab,
                   GREATEST ((NVL (a.SCBCRSE_CONT_HR_LOW, 0)) ,
                   NVL (a.SCBCRSE_CONT_HR_HIGH, 0))            contact
    FROM scbcrse a, ssbsect, sirasgn ,SIRDPCL
   WHERE     A.SCBCRSE_EFF_TERM =
             (SELECT MAX (SCBCRSE_EFF_TERM)
                FROM SCBCRSE
               WHERE     SCBCRSE_SUBJ_CODE = A.SCBCRSE_SUBJ_CODE
                     AND SCBCRSE_CRSE_NUMB = A.SCBCRSE_CRSE_NUMB
                     AND SCBCRSE_EFF_TERM <= '144030')
         AND A.SCBCRSE_SUBJ_CODE = ssbsect_subj_code
         AND A.SCBCRSE_CRSE_NUMB = ssbsect_crse_numb
         AND ssbsect_term_code = '144030'
         AND sirasgn_term_code = ssbsect_term_code
         AND sirasgn_crn = ssbsect_crn
         AND SIRASGN_PRIMARY_IND = 'Y'
         and SIRDPCL_PIDM=sirasgn_pidm
        -- and SIRDPCL_HOME_IND='Y'
         and SIRDPCL_TERM_CODE_EFF=(select max(SIRDPCL_TERM_CODE_EFF) from SIRDPCL where SIRDPCL_PIDM=sirasgn_pidm)
         )
         group by 
         COLL_DESC,
          DEPT_DESC,
          faculty_name       ,faculty_id    ,SCBCRSE_TITLE            
      
ORDER BY 1