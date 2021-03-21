/* Formatted on 5/17/2020 12:34:53 AM (QP5 v5.360) */
  SELECT 
  ssbsect_crn , SSBSECT_PTRM_CODE ,
  SSBSECT_SEQ_NUMB , F_GET_DESC_FNC ('STVSSTS', SSBSECT_SSTS_CODE, 60) , F_GET_DESC_FNC ('STVSCHD', SSBSECT_SCHD_CODE, 60) , F_GET_DESC_FNC ('STVCAMP', SSBSECT_CAMP_CODE, 60) ,
  scbcrse_coll_code,
         scbcrse_dept_code,
         F_GET_DESC_FNC ('STVCOLL', scbcrse_coll_code, 60)    COLL_DESC,
         F_GET_DESC_FNC ('STVDEPT', scbcrse_dept_code, 60)    DEPT_DESC,
         a.SCBCRSE_TITLE  ,
     SCBCRSE_SUBJ_CODE , SCBCRSE_CRSE_NUMB  ,SSBSECT_CREDIT_HRS  , F_GET_DESC_FNC ('STVGMOD', SSBSECT_GMOD_CODE, 60) ,SSBSECT_LINK_IDENT ,SSBSECT_GRADABLE_IND ,SSBSECT_MAX_ENRL
    FROM scbcrse a, ssbsect 
   WHERE     A.SCBCRSE_EFF_TERM =
             (SELECT MAX (SCBCRSE_EFF_TERM)
                FROM SCBCRSE
               WHERE     SCBCRSE_SUBJ_CODE = A.SCBCRSE_SUBJ_CODE
                     AND SCBCRSE_CRSE_NUMB = A.SCBCRSE_CRSE_NUMB
                     AND SCBCRSE_EFF_TERM <= '144030')
         AND A.SCBCRSE_SUBJ_CODE = ssbsect_subj_code
         AND A.SCBCRSE_CRSE_NUMB = ssbsect_crse_numb
         AND ssbsect_term_code = '144030'
 
ORDER BY 1,2