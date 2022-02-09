 /*INSERT INTO BU_DEV.TMP_TBL_KILANY (COL01,COL02)
  SELECT SFRSTCR_PIDM ,SFRSTCR_CRN*/
  
  SELECT
   SFRSTCR_PIDM ,F_GET_STD_ID (SFRSTCR_PIDM)       STID,
         F_GET_STD_NAME (SFRSTCR_PIDM)     STNAME,
         SFRSTCR_CRN,
         SSBSECT_SUBJ_CODE || SSBSECT_CRSE_NUMB,
         SCRRTST_SUBJ_CODE_PREQ,
         SCRRTST_CRSE_NUMB_PREQ 
    FROM SCRRTST, SFRSTCR, SSBSECT
   WHERE     SFRSTCR_CRN = SSBSECT_CRN
         AND SSBSECT_TERM_CODE = SFRSTCR_TERM_CODE
         AND SSBSECT_SUBJ_CODE = SCRRTST_SUBJ_CODE
         AND SSBSECT_CRSE_NUMB = SCRRTST_CRSE_NUMB
         and sfrstcr_rsts_code in ('RE','RW')
         AND SFRSTCR_TERM_CODE = '144320'
         AND SSBSECT_CAMP_CODE = '37'
         AND SCRRTST_SUBJ_CODE_PREQ NOT IN ('BMDT',
                                            'OPER',
                                            'DNT',
                                            'MEDT',
                                            'PROS','PREV')
         AND CAPP_MANIPULATION_FUNCTIONAL.CHECK_COURSE_FIT (
                 SFRSTCR_PIDM,
                 SCRRTST_SUBJ_CODE_PREQ,
                 SCRRTST_CRSE_NUMB_PREQ) !=
             'P'
ORDER BY 3

;

-- PROCESSING
DECLARE 
CURSOR GET_DATA IS SELECT COL01 PIDM,COL02 CRN FROM BU_DEV.TMP_TBL_KILANY
WHERE COL01 IS NOT NULL ;
BEGIN 
FOR REC IN GET_DATA 
LOOP 
 UPDATE sfrstcr
           SET sfrstcr_rsts_code = 'DD',
               SFRSTCR_BILL_HR = 0,
               SFRSTCR_WAIV_HR = 0,
               SFRSTCR_CREDIT_HR = 0,
               SFRSTCR_BILL_HR_HOLD = 0,
               SFRSTCR_CREDIT_HR_HOLD = 0,
               sfrstcr_activity_date = SYSDATE,
               sfrstcr_user = USER
         WHERE     sfrstcr_pidm = REC.PIDM
               AND sfrstcr_term_code ='144320'
                  AND SFRSTCR_CRN=REC.CRN    
                  AND SFRSTCR_RSTS_CODE IN ('RE','RW') ;
                  
                    DBMS_OUTPUT.put_line (
                    REC.PIDM || '<<-ROWS>>' || SQL%ROWCOUNT);
             END LOOP ;      
                   END ; 
