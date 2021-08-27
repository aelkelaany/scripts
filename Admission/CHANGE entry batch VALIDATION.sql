update  BU_DEV.TMP_TBL04 
set col03=f_get_pidm(col02) --,col06='All'
WHERE col07 IS NULL ;

select * from 
BU_DEV.TMP_TBL04 
where col03= 0 
;

select * from 
BU_DEV.TMP_TBL04 
where col04 not in (select smrprle_program from smrprle) ;


SELECT DISTINCT
               col03 pidm, col04 new_program, APPLICANT_CHOICE_NO old_choice
          FROM BU_DEV.TMP_TBL04 , VW_APPLICANT_CHOICES
         WHERE     ADMIT_TERM = '144210'
               AND APPLICANT_PIDM = col03
               AND APPLICANT_DECISION = 'QA'
               and col01='1119626826';
               
               SELECT APPLICANT_CHOICE_NO
              FROM VW_APPLICANT_CHOICES
             WHERE     ADMIT_TERM = '1442010'
                   AND APPLICANT_PIDM = 227992
                   AND APPLICANT_CHOICE = '1-1605-1433' ;
                   
                   
                   SELECT DISTINCT
               col03 pidm, col04 new_program, APPLICANT_CHOICE_NO old_choice
          FROM BU_DEV.TMP_TBL04 , VW_APPLICANT_CHOICES
         WHERE     ADMIT_TERM = '144210'
               AND APPLICANT_PIDM = col03
               AND APPLICANT_DECISION = 'QA'
               and col04 not in (select APPLICANT_CHOICE from VW_APPLICANT_CHOICES  WHERE     ADMIT_TERM = '144210'
               AND APPLICANT_PIDM = col03 );
               
               ---------------------------report
               SELECT 
    COL01, COL02, COL05 ,
   COL04   ,/* Formatted on 8/21/2020 5:57:29 PM (QP5 v5.360) */
(SELECT SORCMJR_DESC
   FROM SORCMJR, SOBCURR
  WHERE     SOBCURR_CURR_RULE = SORCMJR_CURR_RULE
        AND SORCMJR_ADM_IND = 'Y'
        AND SOBCURR_PROGRAM = COL04/* and SOBCURR_TERM_CODE_INIT=(select max(SOBCURR_TERM_CODE_INIT) from SOBCURR where SOBCURR_PROGRAM =COL04 )*/
                                   ) AS "oldPROGCODE" ,(SELECT  SORCMJR_DESC FROM SORCMJR,SOBCURR 
         WHERE SOBCURR_CURR_RULE=SORCMJR_CURR_RULE
          and SORCMJR_ADM_IND='Y'
         AND SOBCURR_PROGRAM =(select APPLICANT_CHOICE from VW_APPLICANT_CHOICES where APPLICANT_DECISION = 'QA' and ADMIT_TERM = '144210' and APPLICANT_PIDM = col03 )
       /* and SOBCURR_TERM_CODE_INIT=(select max(SOBCURR_TERM_CODE_INIT) from SOBCURR where SOBCURR_PROGRAM =COL04 )*/
          ) AS "newPROGCODE"
    
FROM BU_DEV.TMP_TBL04  
WHERE
COL07 = 'DONE' ;