Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'CRN_SWAP_143920_G1', 'SAISUSR', 'ÿ«·»«  «·‘⁄» 15', 'N', 
    SYSDATE, NULL);
 
 
Insert into GLBEXTR
   SELECT 'STUDENT', 'CRN_SWAP_143920_G1', 'SAISUSR', 'SAISUSR', SFRSTCR_PIDM, 
    SYSDATE, 'S', NULL  FROM 
(  SELECT SFRSTCR_PIDM
            FROM SFRSTCR
           WHERE     SFRSTCR_TERM_CODE = '143920'
                 AND SFRSTCR_RSTS_CODE IN ('RW', 'RE')
                 AND SFRSTCR_CRN = '28415'
                 AND SUBSTR(F_GET_STD_ID(SFRSTCR_PIDM),1,3) IN ('438','439')
        ORDER BY SFRSTCR_PIDM DESC) ;
 
--------------------------------------------------------------------------------------------------
Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'CRN_SWAP_143920_G2', 'SAISUSR', 'ÿ«·»«  «·‘⁄» 15', 'N', 
    SYSDATE, NULL);
 
 
Insert into GLBEXTR
   SELECT 'STUDENT', 'CRN_SWAP_143920_G2', 'SAISUSR', 'SAISUSR', SFRSTCR_PIDM, 
    SYSDATE, 'S', NULL  FROM 
(  SELECT SFRSTCR_PIDM
            FROM SFRSTCR
           WHERE     SFRSTCR_TERM_CODE = '143920'
                 AND SFRSTCR_RSTS_CODE IN ('RW', 'RE')
                 AND SFRSTCR_CRN = '28362'
                 AND SUBSTR(F_GET_STD_ID(SFRSTCR_PIDM),1,3) IN ('438','439')
        ORDER BY SFRSTCR_PIDM DESC) ;
--------------------------------------------------------------------------------------------------
Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'CRN_SWAP_143920_G3', 'SAISUSR', 'ÿ«·»«  «·‘⁄» 15', 'N', 
    SYSDATE, NULL);
 
 
Insert into GLBEXTR
   SELECT 'STUDENT', 'CRN_SWAP_143920_G3', 'SAISUSR', 'SAISUSR', SFRSTCR_PIDM, 
    SYSDATE, 'S', NULL  FROM 
(  SELECT SFRSTCR_PIDM
            FROM SFRSTCR
           WHERE     SFRSTCR_TERM_CODE = '143920'
                 AND SFRSTCR_RSTS_CODE IN ('RW', 'RE')
                 AND SFRSTCR_CRN = '28421'
                 AND SUBSTR(F_GET_STD_ID(SFRSTCR_PIDM),1,3) IN ('438','439')
        ORDER BY SFRSTCR_PIDM DESC) ;
--------------------------------------------------------------------------------------------------
Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'CRN_SWAP_143920_G4', 'SAISUSR', 'ÿ«·»«  «·‘⁄» 15', 'N', 
    SYSDATE, NULL);
 
 
Insert into GLBEXTR
   SELECT 'STUDENT', 'CRN_SWAP_143920_G4', 'SAISUSR', 'SAISUSR', SFRSTCR_PIDM, 
    SYSDATE, 'S', NULL  FROM 
(  SELECT SFRSTCR_PIDM
            FROM SFRSTCR
           WHERE     SFRSTCR_TERM_CODE = '143920'
                 AND SFRSTCR_RSTS_CODE IN ('RW', 'RE')
                 AND SFRSTCR_CRN = '28428'
                -- AND SUBSTR(F_GET_STD_ID(SFRSTCR_PIDM),1,3) IN ('438','439')
        ORDER BY SFRSTCR_PIDM DESC) ;
--------------------------------------------------------------------------------------------------
Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'CRN_SWAP_143920_G5', 'SAISUSR', 'ÿ«·»«  «·‘⁄» 15', 'N', 
    SYSDATE, NULL);
 
 
Insert into GLBEXTR
   SELECT 'STUDENT', 'CRN_SWAP_143920_G5', 'SAISUSR', 'SAISUSR', SFRSTCR_PIDM, 
    SYSDATE, 'S', NULL  FROM 
(  SELECT SFRSTCR_PIDM
            FROM SFRSTCR
           WHERE     SFRSTCR_TERM_CODE = '143920'
                 AND SFRSTCR_RSTS_CODE IN ('RW', 'RE')
                 AND SFRSTCR_CRN = '28363'
                 AND SUBSTR(F_GET_STD_ID(SFRSTCR_PIDM),1,3) IN ('438','439')
        ORDER BY SFRSTCR_PIDM DESC) ;
--------------------------------------------------------------------------------------------------
