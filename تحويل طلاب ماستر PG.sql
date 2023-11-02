 
 INSERT INTO BU_APPS.TRANSFER_STUDENT_PROGRAM (PIDM_CD,
                                                          PROGRAM_CD,
                                                          DEPT_CODE,
                                                          MAJOR_CODE )
                select sgbstdn_pidm STD_PIDM,
                         '6F31MIC42P',
                         '3101',
                         '3151'
                         
                         
                         from sgbstdn sg
                         where 
                         SGBSTDN_TERM_CODE_EFF=(select max(SGBSTDN_TERM_CODE_EFF) from sgBStdn where 
                         sgbstdn_pidm=sg.sgbstdn_pidm
                         )
                         and sgbstdn_program_1='6F17MIC42P'
                         and sgBStdn_stst_code in ('AS','Øí','ãæ','ãÚ') ;
                         
                         
                         EXEC  ITRANSFER_PROC (F_GET_PARAM ('GENERAL', 'CURRENT_TERM', 1));
                         
                         
                         Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'CAPP_STD_17_31', 'SAISUSR', 'MASTER STUDENTS', 'N', 
    SYSDATE, NULL);
 
 
Insert into GLBEXTR
   SELECT 'STUDENT', 'CAPP_STD_17_31', 'SAISUSR', 'SAISUSR', PIDM, 
    SYSDATE, 'S', NULL  FROM 
( SELECT 
     PIDM_CD PIDM 
FROM BU_APPS.TRANSFER_STUDENT_PROGRAM
WHERE NOTES='Y' 
 )

 ;