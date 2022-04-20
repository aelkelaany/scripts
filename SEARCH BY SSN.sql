select f_get_std_id(sgbstdn_pidm) stid,f_get_std_name(sgbstdn_pidm)std_name, sg.* from sgbstdn sg,spbpers
where
sgbstdn_pidm=spbpers_pidm
and spbpers_ssn like'%1080996992%'
;

select f_get_std_id(spbpers_pidm) stid,f_get_std_name(spbpers_pidm)std_name from spbpers
where
 
  spbpers_ssn like'%1078839584%'
  and not exists (select '1' from sgbstdn
  where sgbstdn_pidm=spbpers_pidm)
;

spriden
265095
spbpers
sibinst
GOBTPAC
SIRDPCL
/*
update shrdgmr set SHRDGMR_GRAD_DATE=TO_DATE('05/05/2019', 'MM/DD/YYYY') ,SHRDGMR_TERM_CODE_GRAD='143920',SHRDGMR_ACYR_CODE='1439'
 
where 
  SHRDGMR_GRAD_DATE = TO_DATE('7/19/2020', 'MM/DD/YYYY') ;

SELECT 
    f_get_std_id(STUDENT_PIDM) stid,f_get_std_name(STUDENT_PIDM)std_name , MOBILE_NO ,sgbstdn_program_1 ,SORCMJR_DESC
    
FROM BU_APPS.LOG_SMS ,sgbstdn ,sorcmjr,sobcurr
WHERE
sgbstdn_pidm=STUDENT_PIDM
and SGBSTDN_TERM_CODE_EFF=(select max(SGBSTDN_TERM_CODE_EFF) from sgbstdn where sgbstdn_pidm=STUDENT_PIDM )
and MESSAGE_JUSTIFICATION = 'ÿ«·»«  «œ»Ì —”«·…  Â‰∆… ··„ﬁ»Ê·Ì‰ «·Ãœœ'
and SORCMJR_CURR_RULE= SOBCURR_CURR_RULE
and SOBCURR_PROGRAM= sgbstdn_program_1
  ;
  
  */
  
  
  