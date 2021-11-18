BU_DEV.TMP_TBL04

UPDATE  BU_DEV.TMP_TBL04 SET COL03=TRIM(COL03) ,COL04=TRIM(COL04) ;

UPDATE BU_DEV.TMP_TBL04 SET COL06 = CAPP_MANIPULATION_FUNCTIONAL.F_GET_CRSE_CREDIT_HR (
                       SUBSTR(COL03,1,4),
                       SUBSTR(COL03,5))
                       ;
                       update BU_DEV.TMP_TBL04 set COL05=col09;

SMRSSUB
;
SELECT COL04 , SUBSTR(COL04,1,4) ,SUBSTR(COL04,5) , CAPP_MANIPULATION_FUNCTIONAL.F_GET_CRSE_CREDIT_HR (
                       SUBSTR(COL04,1,4),
                       SUBSTR(COL04,5)) FROM  BU_DEV.TMP_TBL04 ;
                       
                       
    
         INSERT INTO smbslib (smbslib_pidm,
                              smbslib_adj_program_ind,
                              smbslib_adj_area_ind,
                              smbslib_adj_group_ind,
                              smbslib_adj_target_ind,
                              smbslib_adj_waiver_ind,
                              smbslib_adj_subst_ind,
                              smbslib_activity_date)
             select distinct F_GET_PIDM(COL01),
                      'N',
                      'N',
                      'N',
                      'N',
                      'N',
                      'Y',
                      SYSDATE 
                      from BU_DEV.TMP_TBL04
                      where not exists (select '1' from smbslib where smbslib_pidm=F_GET_PIDM(COL01)) ;                 
                      
Insert into SATURN.SMRSSUB
   (SMRSSUB_PIDM, SMRSSUB_TERM_CODE_EFF, SMRSSUB_SUBJ_CODE_REQ, SMRSSUB_CRSE_NUMB_REQ, SMRSSUB_SUBJ_CODE_SUB, 
    SMRSSUB_CRSE_NUMB_SUB, SMRSSUB_ACTIVITY_DATE, SMRSSUB_ACTN_CODE, SMRSSUB_CREDITS)
SELECT 
   distinct F_GET_PIDM(COL01), '000000', SUBSTR(COL04,1,4), SUBSTR(COL04,5), SUBSTR(COL03,1,4), 
    SUBSTR(COL03,5), SYSDATE, '„œ', COL05 
 FROM  BU_DEV.TMP_TBL04
 where  (F_GET_PIDM(COL01),'000000',SUBSTR(COL04,1,4),SUBSTR(COL04,5)) not in ( select SMRSSUB_PIDM
,SMRSSUB_TERM_CODE_EFF
,SMRSSUB_SUBJ_CODE_REQ
,SMRSSUB_CRSE_NUMB_REQ
from SMRSSUB
where SMRSSUB_pidm=F_GET_PIDM(COL01)
) 
--and col01='437008586'
 and col03<>'11020110'
 ;
 
  
 Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'COMPDENTAL', 'SAISUSR', 'dental „ÿ«»ﬁ«  ', 'N', 
    SYSDATE, NULL);
    Insert into GLBEXTR
   SELECT 'STUDENT', 'COMPDENTAL', 'SAISUSR', 'SAISUSR',  PIDM, 
    SYSDATE, 'S', NULL  FROM 
 (
  SELECT  DISTINCT  F_GET_PIDM(COL01) PIDM
FROM  BU_DEV.TMP_TBL04
Where
  COL01 IS NOT NULL ) ;


