BU_DEV.TMP_TBL04

UPDATE  BU_DEV.TMP_TBL04 SET COL03=TRIM(COL03) ,COL04=TRIM(COL04) 

UPDATE BU_DEV.TMP_TBL04 SET COL06 = CAPP_MANIPULATION_FUNCTIONAL.F_GET_CRSE_CREDIT_HR (
                       SUBSTR(COL03,1,4),
                       SUBSTR(COL03,5))

SMRSSUB
;
SELECT COL04 , SUBSTR(COL04,1,3) ,SUBSTR(COL04,4) , CAPP_MANIPULATION_FUNCTIONAL.F_GET_CRSE_CREDIT_HR (
                       SUBSTR(COL04,1,3),
                       SUBSTR(COL04,4)) FROM  BU_DEV.TMP_TBL04 ;
                       
                       
                       
                      
Insert into SATURN.SMRSSUB
   (SMRSSUB_PIDM, SMRSSUB_TERM_CODE_EFF, SMRSSUB_SUBJ_CODE_REQ, SMRSSUB_CRSE_NUMB_REQ, SMRSSUB_SUBJ_CODE_SUB, 
    SMRSSUB_CRSE_NUMB_SUB, SMRSSUB_ACTIVITY_DATE, SMRSSUB_ACTN_CODE, SMRSSUB_CREDITS)
SELECT 
    F_GET_PIDM(COL01), '000000', SUBSTR(COL04,1,3), SUBSTR(COL04,4), SUBSTR(COL03,1,4), 
    SUBSTR(COL03,5), SYSDATE, '��', COL05 
 FROM  BU_DEV.TMP_TBL04;
 
  
 Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'COMP08', 'SAISUSR', '������� ������� ', 'N', 
    SYSDATE, NULL);
    Insert into GLBEXTR
   SELECT 'STUDENT', 'COMP08', 'SAISUSR', 'SAISUSR',  PIDM, 
    SYSDATE, 'S', NULL  FROM 
 (
  SELECT  DISTINCT  F_GET_PIDM(COL01) PIDM
FROM  BU_DEV.TMP_TBL04
Where
  COL01 IS NOT NULL ) ;

