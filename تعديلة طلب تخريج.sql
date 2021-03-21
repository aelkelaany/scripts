 SELECT 'X'
 FROM SFRSTCR
 WHERE SFRSTCR_PIDM=:I_STUDENT_PIDM
 AND EXISTS(SELECT 'C' FROM
 SSBSECT
 WHERE
   SSBSECT_TERM_CODE=SFRSTCR_TERM_CODE
 AND  SSBSECT_CRN=SFRSTCR_CRN
 
 AND EXISTS(SELECT 'B' FROM 
 DEV_SYS_PARAMETERS
 WHERE MODULE='WORKFLOW'
 AND PARAMETER_CODE='MA_MESSAGE_CRSE'
 AND PARAMETER_VALUE=SSBSECT_SUBJ_CODE||SSBSECT_CRSE_NUMB
 AND ACTIVE='Y')
 AND SFRSTCR_GRDE_CODE IS NOT NULL 
 --AND SFRSTCR_GRDE_CODE NOT IN ('�','�','�')
 --AND SFRSTCR_GRDE_DATE IS NOT NULL 
 AND ROWNUM<2);
 
                                                
                                                
                                                
                                                
                                               
Insert into DEV_SYS_PARAMETERS
   (MODULE, PARAMETER_CODE, SEQUENCE_NO, PARAMETER_VALUE, ACTIVITY_DATE, 
    USER_ID, ACTIVE, SYSTEM_REQ_IND)
 Values
   ('WORKFLOW', 'MA_MESSAGE_CRSE', 1, '13063408', sysdate, 
    'BU_APPS', 'Y', NULL);
 
 Insert into DEV_SYS_PARAMETERS
   (MODULE, PARAMETER_CODE, SEQUENCE_NO, PARAMETER_VALUE, ACTIVITY_DATE, 
    USER_ID, ACTIVE, SYSTEM_REQ_IND)
 Values
   ('WORKFLOW', 'MA_MESSAGE_CRSE', 2, '13093208', sysdate, 
    'BU_APPS', 'Y', NULL);
    Insert into DEV_SYS_PARAMETERS
   (MODULE, PARAMETER_CODE, SEQUENCE_NO, PARAMETER_VALUE, ACTIVITY_DATE, 
    USER_ID, ACTIVE, SYSTEM_REQ_IND)
 Values
   ('WORKFLOW', 'MA_MESSAGE_CRSE', 3, '13016208', sysdate, 
    'BU_APPS', 'Y', NULL);
    Insert into DEV_SYS_PARAMETERS
   (MODULE, PARAMETER_CODE, SEQUENCE_NO, PARAMETER_VALUE, ACTIVITY_DATE, 
    USER_ID, ACTIVE, SYSTEM_REQ_IND)
 Values
   ('WORKFLOW', 'MA_MESSAGE_CRSE', 4, '13077204', sysdate, 
    'BU_APPS', 'Y', NULL);
    Insert into DEV_SYS_PARAMETERS
   (MODULE, PARAMETER_CODE, SEQUENCE_NO, PARAMETER_VALUE, ACTIVITY_DATE, 
    USER_ID, ACTIVE, SYSTEM_REQ_IND)
 Values
   ('WORKFLOW', 'MA_MESSAGE_CRSE', 5, '13103202', sysdate, 
    'BU_APPS', 'Y', NULL);
    Insert into DEV_SYS_PARAMETERS
   (MODULE, PARAMETER_CODE, SEQUENCE_NO, PARAMETER_VALUE, ACTIVITY_DATE, 
    USER_ID, ACTIVE, SYSTEM_REQ_IND)
 Values
   ('WORKFLOW', 'MA_MESSAGE_CRSE', 6, '15021610', sysdate, 
    'BU_APPS', 'Y', NULL);
    