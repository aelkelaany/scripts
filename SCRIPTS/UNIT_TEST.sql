 
DECLARE 
   
    reply_code              VARCHAR2 (20);
    reply_message           VARCHAR2 (500);
BEGIN
   
      --   CAPP_MANIPULATION_FUNCTIONAL.LOG_DELETE(100);
        -- commit ;
       SYKCMPG.SYPCMPG;    
                  commit ;
                    
                     
                     -- 172751
                     --438003968 JASEM 
                     END;
                  -- select F_GET_STD_ID(197134) FROM DUAL ;  
--                     CAPP_MNPL_LOG_MAIN
--                     CAPP_MNPL_LOG_HEADER


SELECT CAPP_MANIPULATION_FUNCTIONAL.check_previous_fit (
                    100,
                    172751,
                    '1709',
                    '1207')
                    
                    FROM DUAL 
                    
                   DELETE FROM SATURN.SMRSSUB
WHERE
SMRSSUB_PIDM = 172751

 SELECT SHRTCKN_TERM_CODE,
               SHRTCKN_SUBJ_CODE           SUBJ,
               SHRTCKN_CRSE_NUMB           CRSE,
               SCBCRSE_TITLE               TITLE,
               SHRTCKG_GRDE_CODE_FINAL     GRADE,
               SHRTCKG_CREDIT_HOURS        HOURS
          FROM SHRTCKN,
               SGBSTDN  A,
               SHRTCKG  G1,
               SCBCRSE  C1
         WHERE     A.SGBSTDN_PIDM = SHRTCKN_PIDM
               AND SHRTCKN_SUBJ_CODE  LIKE NVL(:P_SUB_CODE,'%')
               AND SHRTCKN_CRSE_NUMB  LIKE NVL(:P_CRSE_NUMB,'%')
               AND A.SGBSTDN_TERM_CODE_EFF =
                   (SELECT MAX (B.SGBSTDN_TERM_CODE_EFF)
                      FROM SGBSTDN B
                     WHERE B.SGBSTDN_PIDM = A.SGBSTDN_PIDM)
               AND SHRTCKN_PIDM = G1.SHRTCKG_PIDM
               AND G1.SHRTCKG_TERM_CODE = SHRTCKN_TERM_CODE
               AND G1.SHRTCKG_TCKN_SEQ_NO = SHRTCKN_SEQ_NO
               AND G1.SHRTCKG_SEQ_NO =
                   (SELECT MAX (G2.SHRTCKG_SEQ_NO)
                      FROM SHRTCKG G2
                     WHERE     G2.SHRTCKG_PIDM = SHRTCKN_PIDM
                           AND G2.SHRTCKG_TERM_CODE = SHRTCKN_TERM_CODE
                           AND G2.SHRTCKG_TCKN_SEQ_NO = SHRTCKN_SEQ_NO)
               AND C1.SCBCRSE_SUBJ_CODE = SHRTCKN_SUBJ_CODE
               AND C1.SCBCRSE_CRSE_NUMB = SHRTCKN_CRSE_NUMB
               AND C1.SCBCRSE_EFF_TERM =
                   (SELECT MAX (C2.SCBCRSE_EFF_TERM)
                      FROM SCBCRSE C2
                     WHERE     C2.SCBCRSE_SUBJ_CODE = C1.SCBCRSE_SUBJ_CODE
                           AND C2.SCBCRSE_CRSE_NUMB = C1.SCBCRSE_CRSE_NUMB
                           AND C2.SCBCRSE_EFF_TERM <= SHRTCKN_TERM_CODE)
               AND SHRTCKN_PIDM = :P_PIDM
               AND COURSE_PASSED (SHRTCKN_PIDM,
                                  SHRTCKN_SUBJ_CODE,
                                  SHRTCKN_CRSE_NUMB) =
                   'P'
               AND EXISTS
                       (SELECT 1
                          FROM SHRGRDE R1
                         WHERE     SHRGRDE_CODE = G1.SHRTCKG_GRDE_CODE_FINAL
                               AND SHRGRDE_LEVL_CODE = SGBSTDN_LEVL_CODE
                               AND SHRGRDE_TERM_CODE_EFFECTIVE =
                                   (SELECT MAX (
                                               R2.SHRGRDE_TERM_CODE_EFFECTIVE)
                                      FROM SHRGRDE R2
                                     WHERE     R1.SHRGRDE_CODE =
                                               R2.SHRGRDE_CODE
                                           AND R1.SHRGRDE_LEVL_CODE =
                                               R2.SHRGRDE_LEVL_CODE)
                               AND SHRGRDE_PASSED_IND = 'Y');
                               
                               
                               SELECT 'Y'
              FROM CAPP_MNPL_LOG_DETAIL
             WHERE     PROCESS_ID = 100
                   AND STD_PIDM = 172751
                   AND RHS_SUBJ_CODE = 1101
                   AND RHS_CRSE_NUMB = 0133
                   AND ROWNUM < 2 ;
                   
                   
                   ------------------
                   select * from (
SELECT STD_PIDM,
       TOTAL_PROCESSED_CRSE,(SELECT SMBPOGN_ACT_COURSES_OVERALL
          FROM smbpogn
         WHERE     SMBPOGN_PIDM = STD_PIDM
               AND SMBPOGN_REQUEST_NO = (SELECT MAX (SMBPOGN_REQUEST_NO)
                                           FROM SMBPOGN
                                          WHERE SMBPOGN_PIDM = STD_PIDM))
           act_courses ,
       TOTAL_PROCESSED_HRS,
        
       (SELECT SMBPOGN_ACT_CREDITS_OVERALL
          FROM smbpogn
         WHERE     SMBPOGN_PIDM = STD_PIDM
               AND SMBPOGN_REQUEST_NO = (SELECT MAX (SMBPOGN_REQUEST_NO)
                                           FROM SMBPOGN
                                          WHERE SMBPOGN_PIDM = STD_PIDM))
           act_credits
  FROM CAPP_MNPL_LOG_HEADER )
  where TOTAL_PROCESSED_CRSE<>act_courses
  or  TOTAL_PROCESSED_HRS<>act_credits ;
  
  
  select SEQNO , RHS_SUBJ_CODE ,rHS_CRSE_NUMB ,RHS_EQVLNT_HR ,SMRDOUS_SUBJ_CODE ,SMRDOUS_CRSE_NUMB ,SMRDOUS_CREDIT_HOURS ,SMRDOUS_CREDIT_HOURS_USED

FROM SATURN.SMRDOUS ,CAPP_MNPL_LOG_DETAIL
 
where STD_PIDM = 176656
            AND MAPPING_SUCCESS_IND = 'Y'
and 
SMRDOUS_PIDM = 176656
aND SMRDOUS_REQUEST_NO = 19
and SMRDOUS_SUBJ_CODE||SMRDOUS_CRSE_NUMB=RHS_SUBJ_CODE||rHS_CRSE_NUMB 
 ;
 select SMRDOUS_SUBJ_CODE ,SMRDOUS_CRSE_NUMB ,SMRDOUS_CREDIT_HOURS ,SMRDOUS_CREDIT_HOURS_USED

FROM SATURN.SMRDOUS  
where
SMRDOUS_PIDM = 176656
aND SMRDOUS_REQUEST_NO = 19
and SMRDOUS_SUBJ_CODE||SMRDOUS_CRSE_NUMB not in (select RHS_SUBJ_CODE||rHS_CRSE_NUMB 
from CAPP_MNPL_LOG_DETAIL
where STD_PIDM = 176656
            AND MAPPING_SUCCESS_IND = 'Y')
 ;
 select SEQNO , RHS_SUBJ_CODE ,rHS_CRSE_NUMB ,RHS_EQVLNT_HR 

FROM  CAPP_MNPL_LOG_DETAIL
where STD_PIDM = 176656
            AND MAPPING_SUCCESS_IND = 'Y'
            and RHS_SUBJ_CODE||rHS_CRSE_NUMB  not in (select SMRDOUS_SUBJ_CODE||SMRDOUS_CRSE_NUMB
            FROM SATURN.SMRDOUS  
where
SMRDOUS_PIDM = 176656
aND SMRDOUS_REQUEST_NO = 19) ;