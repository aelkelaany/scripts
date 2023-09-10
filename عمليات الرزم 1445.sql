 
 --------------------- «⁄œ«œ «·ÿ·«» ›Ï ﬂ· »—‰«„Ã
 SELECT COUNT (A.SGBSTDN_PIDM)                                    std_count,
         f_get_program_full_desc ('144510', sgbstdn_program_1)     description,
         sgbstdn_program_1                                         prog_code
    FROM SGBSTDN A
   WHERE     A.SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                          FROM SGBSTDN
                                         WHERE SGBSTDN_PIDM = A.SGBSTDN_PIDM)
         AND SGBSTDN_STST_CODE = 'AS'
         --and SGBSTDN_levl_code='Ã„'
         AND A.SGBSTDN_STYP_CODE = '„'
         AND SGBSTDN_TERM_CODE_ADMIT = '144510'
       
     --    AND sgbstdn_program_1 LIKE '1F15E%'
      AND EXISTS
                         (SELECT '1'
                            FROM SARAPPD
                           WHERE     SARAPPD_PIDM = A.SGBSTDN_PIDM
                                 AND SARAPPD_APDC_CODE = 'FA'
                                 AND SARAPPD_TERM_CODE_ENTRY = '144510')
GROUP BY sgbstdn_program_1
ORDER BY 3;

-------------------------------------

update 

syrblkr set syrblkr_levl_code='Ã„'
where 
SYRBLKR_TERM_CODE = '144510'
  AND SYRBLKR_PROGRAM like  '1%' ;
update 

syrblkr set syrblkr_levl_code='œ»'
where 
SYRBLKR_TERM_CODE = '144510'
  AND SYRBLKR_PROGRAM like  '4%' ;
 

select distinct  SYRBLKR_PROGRAM ,substr(SYRBLKR_PROGRAM,3,2) college
from syrblkr
where SYRBLKR_TERM_CODE = '144510' ;

 
  update 

syrblkr set syrblkr_coll_code= substr(SOBCURR_PROGRAM,3,2)
where 
SYRBLKR_TERM_CODE = '144510'
and SYRBLKR_PROGRAM is not null ;



 update 

syrblkr set syrblkr_camp_code=(select  SOBCURR_CAMP_CODE 
from sobcurr where SOBCURR_PROGRAM=SYRBLKR_PROGRAM)
where syrblkr_camp_code is not null 
and SYRBLKR_TERM_CODE = '144510'
and SYRBLKR_PROGRAM is not null 
;


 update 

syrblkr set syrblkr_coll_code=(select  SOBCURR_coll_CODE 
from sobcurr where SOBCURR_PROGRAM=SYRBLKR_PROGRAM)
where  
  SYRBLKR_TERM_CODE = '144510'
and SYRBLKR_PROGRAM is not null 
;