select sgbstdn_camp_code ,sgbstdn_program_1
from sgbstdn
where sgbstdn_camp_code='23'
and SGBSTDN_TERM_CODE_EFF='144210'
and SGBSTDN_PROGRAM_1 like '2%'
and sgbstdn_pidm in (select pidm_cd from BU_APPS.TRANSFER_STUDENT_PROGRAM)

;
update  sgbstdn set sgbstdn_camp_code ='24'
  
where sgbstdn_camp_code='23'
and SGBSTDN_TERM_CODE_EFF='144210'
and SGBSTDN_PROGRAM_1 like '2%'
and sgbstdn_pidm in (select pidm_cd from BU_APPS.TRANSFER_STUDENT_PROGRAM)

;
update 

SOVLCUR

set  SOVLCUR_CAMP_CODE='24' 
where SOVLCUR_camp_code='23'
 
and SOVLCUR_PROGRAM like '2%'
and SOVLCUR_pidm in (select pidm_cd from BU_APPS.TRANSFER_STUDENT_PROGRAM)
 ;
 update shrdgmr
 set shrdgmr_camp_code=24
 where  
 shrdgmr_camp_code=23
 and shrdgmr_program like '2%'
 and Shrdgmr_pidm in (select pidm_cd from BU_APPS.TRANSFER_STUDENT_PROGRAM) ; 
 
 SELECT SOBCURR_CURR_RULE,
               SORCMJR_CMJR_RULE,
               SOBCURR_CAMP_CODE,
               SOBCURR_COLL_CODE
          FROM SOBCURR, SORCMJR
         WHERE     SOBCURR_CURR_RULE = SORCMJR_CURR_RULE
               AND SOBCURR_PROGRAM = '2-1909-1433'
             
               AND SOBCURR_LEVL_CODE = 'Ã„';
               
               
               -----------------------------
               
               
               
               Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'TRNS_STD_1442', 'SAISUSR', '„ÕÊ·Ì‰ 1442', 'N', 
    SYSDATE, NULL);
 

Insert into GLBEXTR
   SELECT 'STUDENT', 'TRNS_STD_1442', 'SAISUSR', 'SAISUSR', PIDM, 
    SYSDATE, 'S', NULL  FROM 
    (  SELECT DISTINCT PIDM_CD PIDM
FROM BU_APPS.TRANSFER_STUDENT_PROGRAM 
 )
 
 ssrblkr