/* Formatted on 5/13/2020 5:15:38 AM (QP5 v5.227.12220.39754) */
  SELECT SMBPOGN_PIDM PIDM,                                      ------PROGRAM
         SMBPOGN_REQUEST_NO REQUEST_NO,
         SPRIDEN_ID STUDENT_ID,
         SPRIDEN_FIRST_NAME || ' ' || SPRIDEN_MI || ' ' || SPRIDEN_LAST_NAME
            STUDENT_NAME,
         SMBPOGN_PROGRAM PROGRAM_CODE,
         F_GET_DESC_FNC ('STVLEVL', SGBSTDN_LEVL_CODE, 60) LEVL_DESC,
         SMBPOGN_CAMP_CODE CAMP_CODE,
         F_GET_DESC_FNC ('STVCOLL', SGBSTDN_COLL_CODE_1, 60) COLL_DESC,
         F_GET_DESC_FNC ('STVDEPT', SGBSTDN_DEPT_CODE, 60) DEPT_DESC,
         F_GET_DESC_FNC ('STVMAJR', SGBSTDN_MAJR_CODE_1, 60) MAJR_DESC,
         SMBPOGN_MET_IND PROG_MET_IND,
         SMBPOGN_TERM_CODE_CATLG TERM_CATAG,
         SMBPOGN_TERM_CODE_EFF TERM_CODE_EFF_PROG,
         SMBPOGN_TERM_CODE_EFF_AREA TERM_CODE_EFF_AREA,
         SMBPOGN_REQ_CREDITS_OVERALL PROG_REQ_CREDITS_OVERALL,
         SMBPOGN_REQ_COURSES_OVERALL PROG_REQ_COURSES_OVERALL,
         SMBPOGN_ACT_CREDITS_OVERALL PROG_ACT_CREDITS_OVERALL,
         SMBPOGN_ACT_COURSES_OVERALL PROG_ACT_COURSES_OVERALL,
         ------------------------------AREA
         AREA_PRIORITY,
         SMBAOGN_AREA AREA_CODE,
         capp.AREA_DESC AREA_DESC,
         SMBAOGN_MET_IND AREA_MET_IND,
         SMBAOGN_REQ_CREDITS_OVERALL AREA_REQ_CREDITS_OVERALL,
         SMBAOGN_REQ_COURSES_OVERALL AREA_REQ_COURSES_OVERALL,
         SMBAOGN_ACT_CREDITS_OVERALL AREA_ACT_CREDITS_OVERALL,
         SMBAOGN_ACT_COURSES_OVERALL AREA_ACT_COURSES_OVERALL,
         ------------------ COURSES
         REQUIRED_FLAG,
         SUBJECT_CODE,
         COURSE_NUMBER,
         SCBCRSE_TITLE TITLE,
         GREATEST (NVL (SCBCRSE_CREDIT_HR_LOW, 0),
                   NVL (SCBCRSE_CREDIT_HR_HIGH, 0))
            CREDIT_HR
    FROM SMBPOGN,
         sgbstdn,
         SPRIDEN,
         SMBAOGN,
         VW_ACADEMIC_PLANS capp,
         scbcrse
   WHERE     SGBSTDN_PIDM = SMBPOGN_PIDM
         AND SMBPOGN_REQUEST_NO = (SELECT MAX (SMBPOGN_REQUEST_NO)
                                     FROM SMBPOGN
                                    WHERE SMBPOGN_PIDM = SGBSTDN_PIDM)
         AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                        FROM SGBSTDN
                                       WHERE SGBSTDN_PIDM = SMBPOGN_PIDM)
         AND SMBPOGN_PROGRAM = SGBSTDN_PROGRAM_1
         AND SMBPOGN_TERM_CODE_CATLG = SGBSTDN_TERM_CODE_CTLG_1
         AND SMBAOGN_PIDM = SMBPOGN_PIDM
         AND SPRIDEN_PIDM = SGBSTDN_PIDM
         AND SPRIDEN_CHANGE_IND IS NULL
         AND SMBAOGN_REQUEST_NO = SMBPOGN_REQUEST_NO
         AND SMBPOGN_PROGRAM = capp.program_code
         AND SMBPOGN_TERM_CODE_EFF = capp.EFFECTIVE_TERM
         AND SMBAOGN_AREA = capp.area_code
         AND SCBCRSE_SUBJ_CODE = SUBJECT_CODE
         AND SCBCRSE_CRSE_NUMB = COURSE_NUMBER
         AND SCBCRSE_EFF_TERM =
                (SELECT MAX (SCBCRSE_EFF_TERM)
                   FROM SCBCRSE
                  WHERE     SCBCRSE_SUBJ_CODE = SUBJECT_CODE
                        AND SCBCRSE_CRSE_NUMB = COURSE_NUMBER
                        and SCBCRSE_EFF_TERM<= SMBPOGN_TERM_CODE_EFF)
                         
         AND spriden_id BETWEEN :P_id_FROM AND :P_ID_TO
         AND NVL (sgbstdn_styp_code, '%') LIKE :P_styp
         AND NVL (SGBSTDN_COLL_CODE_1, '%') LIKE :p_cOLL
         AND NVL (SGBSTDN_LEVL_CODE, '%') LIKE :P_LEVL
         AND NVL (SMBPOGN_PROGRAM, '%') LIKE :P_PROG
         AND NVL (SGBSTDN_DEPT_CODE, '%') LIKE :P_DEPT
         AND SMBPOGN_ACT_CREDITS_OVERALL BETWEEN NVL (:P_HRS_MIN, 0)
                                             AND NVL (:P_HRS_MAX, 999)
ORDER BY AREA_PRIORITY

--++++++++++++++++++++
/* Formatted on 5/13/2020 5:15:38 AM (QP5 v5.227.12220.39754) */
  SELECT SMBPOGN_PIDM PIDM,                                      ------PROGRAM
         SMBPOGN_REQUEST_NO REQUEST_NO,
         SPRIDEN_ID STUDENT_ID,
         SPRIDEN_FIRST_NAME || ' ' || SPRIDEN_MI || ' ' || SPRIDEN_LAST_NAME
            STUDENT_NAME,
         SMBPOGN_PROGRAM PROGRAM_CODE,
         F_GET_DESC_FNC ('STVLEVL', SGBSTDN_LEVL_CODE, 60) LEVL_DESC,
         SMBPOGN_CAMP_CODE CAMP_CODE,
         F_GET_DESC_FNC ('STVCOLL', SGBSTDN_COLL_CODE_1, 60) COLL_DESC,
         F_GET_DESC_FNC ('STVDEPT', SGBSTDN_DEPT_CODE, 60) DEPT_DESC,
         F_GET_DESC_FNC ('STVMAJR', SGBSTDN_MAJR_CODE_1, 60) MAJR_DESC,
         SMBPOGN_MET_IND PROG_MET_IND,
         SMBPOGN_TERM_CODE_CATLG TERM_CATAG,
         SMBPOGN_TERM_CODE_EFF TERM_CODE_EFF_PROG,
         SMBPOGN_TERM_CODE_EFF_AREA TERM_CODE_EFF_AREA,
         SMBPOGN_REQ_CREDITS_OVERALL PROG_REQ_CREDITS_OVERALL,
         SMBPOGN_REQ_COURSES_OVERALL PROG_REQ_COURSES_OVERALL,
         SMBPOGN_ACT_CREDITS_OVERALL PROG_ACT_CREDITS_OVERALL,
         SMBPOGN_ACT_COURSES_OVERALL PROG_ACT_COURSES_OVERALL,
         ------------------------------AREA
         AREA_PRIORITY,
         SMBAOGN_AREA AREA_CODE,
         capp.AREA_DESC AREA_DESC,
         SMBAOGN_MET_IND AREA_MET_IND,
         SMBAOGN_REQ_CREDITS_OVERALL AREA_REQ_CREDITS_OVERALL,
         SMBAOGN_REQ_COURSES_OVERALL AREA_REQ_COURSES_OVERALL,
         SMBAOGN_ACT_CREDITS_OVERALL AREA_ACT_CREDITS_OVERALL,
         SMBAOGN_ACT_COURSES_OVERALL AREA_ACT_COURSES_OVERALL,
         ------------------ COURSES
         REQUIRED_FLAG,
         SUBJECT_CODE,
         COURSE_NUMBER 
    FROM SMBPOGN,
         sgbstdn,
         SPRIDEN,
         SMBAOGN,
         VW_ACADEMIC_PLANS capp 
        
   WHERE     SGBSTDN_PIDM = SMBPOGN_PIDM
         AND SMBPOGN_REQUEST_NO = (SELECT MAX (SMBPOGN_REQUEST_NO)
                                     FROM SMBPOGN
                                    WHERE SMBPOGN_PIDM = SGBSTDN_PIDM)
         AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                        FROM SGBSTDN
                                       WHERE SGBSTDN_PIDM = SMBPOGN_PIDM)
         AND SMBPOGN_PROGRAM = SGBSTDN_PROGRAM_1
         AND SMBPOGN_TERM_CODE_CATLG = SGBSTDN_TERM_CODE_CTLG_1
         AND SMBAOGN_PIDM = SMBPOGN_PIDM
         AND SPRIDEN_PIDM = SGBSTDN_PIDM
         AND SPRIDEN_CHANGE_IND IS NULL
         AND SMBAOGN_REQUEST_NO = SMBPOGN_REQUEST_NO
         AND SMBPOGN_PROGRAM = capp.program_code
         AND SMBPOGN_TERM_CODE_EFF = capp.EFFECTIVE_TERM
         AND SMBAOGN_AREA = capp.area_code
 
       and SGBSTDN_PIDM=135424
       --++++++++++++++++++++++++++++++++++++++++++++++++++++
       /* Formatted on 5/13/2020 5:15:38 AM (QP5 v5.227.12220.39754) */
  SELECT SMBPOGN_PIDM PIDM,                                      ------PROGRAM
         SMBPOGN_REQUEST_NO REQUEST_NO,
         SPRIDEN_ID STUDENT_ID,
         SPRIDEN_FIRST_NAME || ' ' || SPRIDEN_MI || ' ' || SPRIDEN_LAST_NAME
            STUDENT_NAME,
         SMBPOGN_PROGRAM PROGRAM_CODE,
         F_GET_DESC_FNC ('STVLEVL', SGBSTDN_LEVL_CODE, 60) LEVL_DESC,
         SMBPOGN_CAMP_CODE CAMP_CODE,
         F_GET_DESC_FNC ('STVCOLL', SGBSTDN_COLL_CODE_1, 60) COLL_DESC,
         F_GET_DESC_FNC ('STVDEPT', SGBSTDN_DEPT_CODE, 60) DEPT_DESC,
         F_GET_DESC_FNC ('STVMAJR', SGBSTDN_MAJR_CODE_1, 60) MAJR_DESC,
         DECODE(SMBPOGN_MET_IND,'Y','?E???','U?? ?E???') PROG_MET_IND,
         SMBPOGN_TERM_CODE_CATLG TERM_CATAG,
         SMBPOGN_TERM_CODE_EFF TERM_CODE_EFF_PROG,
         SMBPOGN_TERM_CODE_EFF_AREA TERM_CODE_EFF_AREA,
         SMBPOGN_REQ_CREDITS_OVERALL PROG_REQ_CREDITS_OVERALL,
         SMBPOGN_REQ_COURSES_OVERALL PROG_REQ_COURSES_OVERALL,
         SMBPOGN_ACT_CREDITS_OVERALL PROG_ACT_CREDITS_OVERALL,
         SMBPOGN_ACT_COURSES_OVERALL PROG_ACT_COURSES_OVERALL,
         ------------------------------AREA
         AREA_PRIORITY,
         SMBAOGN_AREA AREA_CODE,
         capp.AREA_DESC AREA_DESC,
         SMBAOGN_MET_IND AREA_MET_IND,
         SMBAOGN_REQ_CREDITS_OVERALL AREA_REQ_CREDITS_OVERALL,
         SMBAOGN_REQ_COURSES_OVERALL AREA_REQ_COURSES_OVERALL,
         SMBAOGN_ACT_CREDITS_OVERALL AREA_ACT_CREDITS_OVERALL,
         SMBAOGN_ACT_COURSES_OVERALL AREA_ACT_COURSES_OVERALL,
         ------------------ COURSES
         REQUIRED_FLAG,
         SUBJECT_CODE
         ||COURSE_NUMBER SUBJECT,
         SCBCRSE_TITLE TITLE,
         GREATEST (NVL (SCBCRSE_CREDIT_HR_LOW, 0),
                   NVL (SCBCRSE_CREDIT_HR_HIGH, 0))
            CREDIT_HR
    FROM SMBPOGN,
         sgbstdn,
         SPRIDEN,
         SMBAOGN,
         VW_ACADEMIC_PLANS capp,
         scbcrse
   WHERE     SGBSTDN_PIDM = SMBPOGN_PIDM
         AND SMBPOGN_REQUEST_NO = (SELECT MAX (SMBPOGN_REQUEST_NO)
                                     FROM SMBPOGN
                                    WHERE SMBPOGN_PIDM = SGBSTDN_PIDM)
         AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                        FROM SGBSTDN
                                       WHERE SGBSTDN_PIDM = SMBPOGN_PIDM)
         AND SMBPOGN_PROGRAM = SGBSTDN_PROGRAM_1
         AND SMBPOGN_TERM_CODE_CATLG = SGBSTDN_TERM_CODE_CTLG_1
         AND SMBAOGN_PIDM = SMBPOGN_PIDM
         AND SPRIDEN_PIDM = SGBSTDN_PIDM
         AND SPRIDEN_CHANGE_IND IS NULL
         AND SMBAOGN_REQUEST_NO = SMBPOGN_REQUEST_NO
         AND SMBPOGN_PROGRAM = capp.program_code
         AND SMBPOGN_TERM_CODE_EFF = capp.EFFECTIVE_TERM
         AND SMBAOGN_AREA = capp.area_code
         AND SCBCRSE_SUBJ_CODE = SUBJECT_CODE
         AND SCBCRSE_CRSE_NUMB = COURSE_NUMBER
         AND SCBCRSE_EFF_TERM =
                (SELECT MAX (SCBCRSE_EFF_TERM)
                   FROM SCBCRSE
                  WHERE     SCBCRSE_SUBJ_CODE = SUBJECT_CODE
                        AND SCBCRSE_CRSE_NUMB = COURSE_NUMBER)
         AND spriden_id BETWEEN :P_id_FROM AND :P_ID_TO
       /*  AND NVL (sgbstdn_styp_code, '%') LIKE :P_styp
         AND NVL (SGBSTDN_COLL_CODE_1, '%') LIKE :p_cOLL
         AND NVL (SGBSTDN_LEVL_CODE, '%') LIKE :P_LEVL
         AND NVL (SMBPOGN_PROGRAM, '%') LIKE :P_PROG
         AND NVL (SGBSTDN_DEPT_CODE, '%') LIKE :P_DEPT
         AND SMBPOGN_ACT_CREDITS_OVERALL BETWEEN NVL (:P_HRS_MIN, 0)
                                             AND NVL (:P_HRS_MAX, 999)*/
ORDER BY AREA_PRIORITY

--++++9999999999999999999999999999999999999999999999

SELECT  
decode(comp.),
CAPP.REQUIRED_FLAG ,CAPP.RULE_DESC  
AREA_PRIORITY,
         capp.AREA_CODE,
         capp.AREA_DESC AREA_DESC ,capp.subject_code || capp.course_number subject, 
 capp.COURSE_TITLE ,
 (SELECT GREATEST (NVL (SCBCRSE_CREDIT_HR_LOW, 0), NVL (SCBCRSE_CREDIT_HR_HIGH, 0))
  FROM scbcrse 
  a WHERE a.scbcrse_subj_code =capp.subject_code
   AND a.scbcrse_crse_numb =capp.course_number
    AND scbcrse_eff_term =(SELECT MAX (scbcrse_eff_term) 
    FROM scbcrse
     WHERE scbcrse_subj_code = capp.subject_code
     AND scbcrse_crse_numb =capp.course_number
     AND scbcrse_eff_term <=CAPP.EFFECTIVE_TERM)) subj_crd_hrs ,
     SPRIDEN_ID STUDENT_ID,
     SPRIDEN_FIRST_NAME || ' ' || SPRIDEN_MI || ' ' || SPRIDEN_LAST_NAME STUDENT_NAME,
      F_GET_DESC_FNC ('STVLEVL', comp.LEVL_CODE, 60) LEVL_DESC,
      F_GET_DESC_FNC ('STVCOLL', comp.COLL_CODE, 60) COLL_DESC,
      F_GET_DESC_FNC ('STVDEPT', comp.DEPT_CODE, 60) DEPT_DESC,          
      F_GET_DESC_FNC ('STVMAJR', comp.MAJR_CODE, 60) MAJR_DESC ,        
      COMP.*                  
      FROM VW_ACADEMIC_PLANS capp  left outer join                  
      (SELECT SMBPOGN_PIDM PIDM,                                                      
       SMBPOGN_REQUEST_NO REQUEST_NO,                 
       SMBPOGN_PROGRAM PROGRAM_code,                  
       SGBSTDN_LEVL_CODE LEVL_CODE,                  
       SGBSTDN_CAMP_CODE CAMP_CODE,                  
       SGBSTDN_COLL_CODE_1 COLL_CODE,                
       SGBSTDN_dept_CODE dept_CODE,                
       SGBSTDN_MAJR_CODE_1 MAJR_CODE,                  
      SMBPOGN_MET_IND MET_IND,                  
      SMBPOGN_TERM_CODE_CATLG TERM_CODE_CATLG,                  
      SMBPOGN_TERM_CODE_EFF TERM_CODE_EFF_PROG,                   
      SMBPOGN_TERM_CODE_EFF_AREA CODE_EFF_AREA,               
       SMBPOGN_REQ_CREDITS_OVERALL prog_REQ_CREDITS_OVERALL,                 
       SMBPOGN_REQ_COURSES_OVERALL prog_REQ_COURSES_OVERALL,                  
       SMBPOGN_ACT_CREDITS_OVERALL prog_ACT_CREDITS_OVERALL,                   
      SMBPOGN_ACT_COURSES_OVERALL prog_ACT_COURSES_OVERALL,                               
      SMBAOGN_AREA AREA_code,                  
      SMBAOGN_MET_IND area_MET_IND,                   
      SMBAOGN_REQ_CREDITS_OVERALL area_REQ_CREDITS_OVERALL,                
      SMBAOGN_REQ_COURSES_OVERALL area_REQ_COURSES_OVERALL,
      SMBAOGN_ACT_CREDITS_OVERALL area_ACT_CREDITS_OVERALL,                  
      SMBAOGN_ACT_COURSES_OVERALL area_ACT_COURSES_OVERALL,                                
      SMRDORQ_CAA_SEQNO SEQNO,                
      SMRDORQ_MET_IND crse_MET_IND,                 
      SMRDORQ_SUBJ_CODE SUBJ_CODE,                 
      SMRDORQ_CRSE_NUMB_LOW CRSE_NUMB,                 
      P.SMRDOUS_CRN crn,                   
      P.SMRDOUS_TERM_CODE TERM_CODE,                 
      P.SMRDOUS_GRDE_CODE GRDE_CODE,                   
      ADJ.SMRDOUS_SUBJ_CODE || ADJ.SMRDOUS_CRSE_NUMB ADJ_SUBJ                  
      FROM SMBPOGN,sgbstdn,SMBAOGN,SMRDORQ,SMRDOUS P,SMRDOUS ADJ               
       WHERE      SGBSTDN_PIDM = SMBPOGN_PIDM                 
      AND SMBPOGN_REQUEST_NO = (SELECT MAX (SMBPOGN_REQUEST_NO)                  
      FROM SMBPOGN                  WHERE SMBPOGN_PIDM = SGBSTDN_PIDM)                
      AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)                   
      FROM SGBSTDN                   
      WHERE SGBSTDN_PIDM = SMBPOGN_PIDM)                 
      AND SMBPOGN_PROGRAM = SGBSTDN_PROGRAM_1                
      AND SMBPOGN_TERM_CODE_CATLG = SGBSTDN_TERM_CODE_CTLG_1                  
      AND SMBAOGN_PIDM = SMBPOGN_PIDM                 
      AND SMBAOGN_REQUEST_NO = SMBPOGN_REQUEST_NO                
      AND SMRDORQ_PIDM = SMBPOGN_PIDM                   
      AND SMRDORQ_REQUEST_NO = SMBPOGN_REQUEST_NO                  
      AND SMRDORQ_AREA = SMBAOGN_AREA
      AND SMRDORQ_SUBJ_CODE IS NOT NULL                  
      AND P.SMRDOUS_PIDM(+) = SMBPOGN_PIDM                  
      AND P.SMRDOUS_REQUEST_NO(+) = SMBPOGN_REQUEST_NO                  
      AND P.SMRDOUS_AREA(+) = SMBAOGN_AREA                  
      AND P.SMRDOUS_CAA_SEQNO(+) = SMRDORQ_CAA_SEQNO                
      AND ADJ.SMRDOUS_PIDM(+) = SMBPOGN_PIDM                  
      AND ADJ.SMRDOUS_REQUEST_NO(+) = SMBPOGN_REQUEST_NO                
      AND ADJ.SMRDOUS_AREA(+) = SMBAOGN_AREA
                        AND ADJ.SMRDOUS_CAA_SEQNO(+) = SMRDORQ_CAA_SEQNO                  
                        AND ADJ.SMRDOUS_SUBJ_CODE(+) || ADJ.SMRDOUS_CRSE_NUMB(+) <> SMRDORQ_SUBJ_CODE || SMRDORQ_CRSE_NUMB_LOW                                   
      UNION                
      SELECT SMBPOGN_PIDM PIDM,                                                        
      SMBPOGN_REQUEST_NO REQUEST_NO,                  
      SMBPOGN_PROGRAM PROGRAM_code,                   
      SGBSTDN_LEVL_CODE LEVL_CODE,                   
      SGBSTDN_CAMP_CODE CAMP_CODE,                   
      SGBSTDN_COLL_CODE_1 COLL_CODE,                 
      SGBSTDN_dept_CODE dept_CODE,                 
      SGBSTDN_MAJR_CODE_1 MAJR_CODE,                   
      SMBPOGN_MET_IND MET_IND,                   
      SMBPOGN_TERM_CODE_CATLG TERM_CODE_CATLG,                   
      SMBPOGN_TERM_CODE_EFF TERM_CODE_EFF_PROG,                
      SMBPOGN_TERM_CODE_EFF_AREA CODE_EFF_AREA,                 
      SMBPOGN_REQ_CREDITS_OVERALL prog_REQ_CREDITS_OVERALL,
 SMBPOGN_REQ_COURSES_OVERALL prog_REQ_COURSES_OVERALL,                   
 SMBPOGN_ACT_CREDITS_OVERALL prog_ACT_CREDITS_OVERALL,                
   SMBPOGN_ACT_COURSES_OVERALL prog_ACT_COURSES_OVERALL,
   SMBAOGN_AREA AREA_code,                   
SMBAOGN_MET_IND area_MET_IND,                
SMBAOGN_REQ_CREDITS_OVERALL area_REQ_CREDITS_OVERALL,                 
      SMBAOGN_REQ_COURSES_OVERALL area_REQ_COURSES_OVERALL,                  
      SMBAOGN_ACT_CREDITS_OVERALL area_ACT_CREDITS_OVERALL,                   
      SMBAOGN_ACT_COURSES_OVERALL area_ACT_COURSES_OVERALL,                               
      SMRDRRQ_CAA_SEQNO,                
       NVL (P.SMRDOUS_EARNED_IND, 'N') MET_IND,                 
      SMRDRRQ_SUBJ_CODE,                   
      SMRDRRQ_CRSE_NUMB_LOW,                 
      P.SMRDOUS_CRN,                   
      P.SMRDOUS_TERM_CODE,                   
      P.SMRDOUS_GRDE_CODE,                   
      ADJ.SMRDOUS_SUBJ_CODE || ADJ.SMRDOUS_CRSE_NUMB ADJ_SUBJ                 
       FROM SMBPOGN PROG,                
      SMBAOGN,                
      sgbstdn,                
      SMRDRRQ,                
      SMRDOUS P,
      SMRDOUS ADJ                 
      where SGBSTDN_PIDM = SMBPOGN_PIDM                  
      AND SMBPOGN_REQUEST_NO = (SELECT MAX (SMBPOGN_REQUEST_NO)                   
      FROM SMBPOGN                   
      WHERE SMBPOGN_PIDM = SGBSTDN_PIDM)                 
      AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)                
      FROM SGBSTDN                
      WHERE SGBSTDN_PIDM = SMBPOGN_PIDM)                  
      AND SMBPOGN_PROGRAM = SGBSTDN_PROGRAM_1                 
      AND SMBPOGN_TERM_CODE_CATLG = SGBSTDN_TERM_CODE_CTLG_1                   
      AND SMBAOGN_PIDM = SMBPOGN_PIDM                  
      AND SMBAOGN_REQUEST_NO = SMBPOGN_REQUEST_NO                 
      AND SMRDRRQ_PIDM = SMBPOGN_PIDM                
      AND SMRDRRQ_REQUEST_NO = SMBPOGN_REQUEST_NO                   
      AND SMRDRRQ_AREA = SMBAOGN_AREA                  
      AND P.SMRDOUS_PIDM(+) = SMBPOGN_PIDM                  
      AND P.SMRDOUS_REQUEST_NO(+) = SMBPOGN_REQUEST_NO                  
      AND P.SMRDOUS_AREA(+) = SMBAOGN_AREA                  
      AND P.SMRDOUS_CAA_SEQNO(+) = SMRDRRQ_CAA_SEQNO                
      AND P.SMRDOUS_KEY_RULE(+) = SMRDRRQ_KEY_RULE                
      AND P.SMRDOUS_RUL_SEQNO(+) = SMRDRRQ_RUL_SEQNO                  
      AND ADJ.SMRDOUS_PIDM(+) = SMBPOGN_PIDM                
      AND ADJ.SMRDOUS_REQUEST_NO(+) = SMBPOGN_REQUEST_NO                  
      AND ADJ.SMRDOUS_AREA(+) = SMBAOGN_AREA                
      AND ADJ.SMRDOUS_CAA_SEQNO(+) = SMRDRRQ_CAA_SEQNO                
      AND ADJ.SMRDOUS_KEY_RULE(+) = SMRDRRQ_KEY_RULE                  
      AND ADJ.SMRDOUS_RUL_SEQNO(+) = SMRDRRQ_RUL_SEQNO                  
      AND ADJ.SMRDOUS_SUBJ_CODE(+) || ADJ.SMRDOUS_CRSE_NUMB(+) <>                 
      SMRDRRQ_SUBJ_CODE || SMRDRRQ_CRSE_NUMB_LOW ) comp                  
      on CAPP.PROGRAM_CODE = COMP.PROGRAM_CODE                  
      AND CAPP.EFFECTIVE_TERM = COMP.TERM_CODE_EFF_PROG                   
      AND CAPP.AREA_CODE = COMP.AREA_CODE                  
      AND CAPP.SUBJECT_CODE = COMP.SUBJ_CODE                
      AND CAPP.COURSE_NUMBER    = COMP.CRSE_NUMB ,spriden                                                 
      where SPRIDEN_PIDM = comp.PIDM                   
      AND SPRIDEN_CHANGE_IND IS NULL         
      and PIDM = 128852