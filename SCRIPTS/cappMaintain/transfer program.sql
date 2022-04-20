 
declare 
l_process_id number(9):=6800;
l_reply_code VARCHAR2(50);
l_reply_message VARCHAR2(200);
begin
--START REPLACING TO NEW PROGRAM
delete TRANSFER_STUDENT_PROGRAM ;
        CAPP_MANIPULATION_FUNCTIONAL.REPLACE_PROGRAM (l_process_id,
                                                     l_reply_code,
                                                     l_reply_message);
       DBMS_OUTPUT.PUT_LINE (
              'parameters 8: REPLACE_PROGRAM CIVE33'
           || l_reply_code
           || '-----'
           || l_reply_message
            );


end ;
 
Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'CAPP_STD_CIVE33', 'SAISUSR', 'ÿ·»… CIVE 38', 'N', 
    SYSDATE, NULL);
 
 
Insert into GLBEXTR
   SELECT 'STUDENT', 'CAPP_STD_CIVE33', 'SAISUSR', 'SAISUSR', PIDM, 
    SYSDATE, 'S', NULL  FROM 
( SELECT 
     PIDM_CD PIDM 
FROM BU_APPS.TRANSFER_STUDENT_PROGRAM
WHERE NOTES='Y' 
 )

 ;



select f_get_std_id(GLBEXTR_KEY) id ,f_get_std_name(GLBEXTR_KEY) name ,GLBEXTR_KEY ,F_GET_STATUS(GLBEXTR_KEY) ST_STATUS from GLBEXTR
where 
GLBEXTR_SELECTION='CAPP_STD_MIS38'
and F_GET_STATUS(GLBEXTR_KEY)='AS'
;
--select f_get_pidm('2238') from dual;

--ELC10105

--update smrssub set SMRSSUB_CREDITS=4
--  
--where SMRSSUB_SUBJ_CODE_req||SMRSSUB_CRSE_NUMB_req='IT10001'
--and SMRSSUB_CREDITS=3


/* Formatted on 09/02/2021 11:19:46 (QP5 v5.227.12220.39754) */
/* Formatted on 09/02/2021 11:20:00 (QP5 v5.227.12220.39754) */
UPDATE SGBSTDN sg
   SET sg.SGBSTDN_TERM_CODE_CTLG_1 = '143810'
 WHERE sg.sgbstdn_pidm IN
          ( SELECT 
     PIDM_CD PIDM 
FROM BU_APPS.TRANSFER_STUDENT_PROGRAM
WHERE NOTES='Y' 
 );
                           
                           
                           
                         /* Formatted on 09/02/2021 11:38:12 (QP5 v5.227.12220.39754) */
UPDATE SMRRQCM s
   SET SMRRQCM_TERM_CODE_CTLG_1 = '143810'
 WHERE     SMRRQCM_PIDM IN ( SELECT 
     PIDM_CD PIDM 
FROM BU_APPS.TRANSFER_STUDENT_PROGRAM
WHERE NOTES='Y' 
 );
                                  
   update  SORLFOS s 
   set S.SORLFOS_TERM_CODE_CTLG='143810' 
   where SORLFOS_TERM_CODE='143310'
   and SORLFOS_CACT_CODE='ACTIVE'
   and SORLFOS_PIDM IN ( SELECT 
     PIDM_CD PIDM 
FROM BU_APPS.TRANSFER_STUDENT_PROGRAM
WHERE NOTES='Y' 
 ) ;
                             
                             
            update SORLCUR
            set SORLCUR_TERM_CODE_CTLG= '143810'
            where 
           -- SORLCUR_TERM_CODE='144220'
              SORLCUR_PIDM IN ( SELECT 
     PIDM_CD PIDM 
FROM BU_APPS.TRANSFER_STUDENT_PROGRAM
WHERE NOTES='Y' 
 )
                          --   and SORLCUR_CACT_CODE='ACTIVE'
                              ;
                              
                              
                              
                              