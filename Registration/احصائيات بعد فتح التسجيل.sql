select substr(f_get_std_id(sfrstcr_pidm),1,3) , decode(f_get_gender (sfrstcr_pidm),'M','ÿ«·»','ÿ«·»…') sex ,count( distinct sfrstcr_pidm) all_reg_students
from sfrstcr
where sfrstcr_term_code='144030'
and sfrstcr_rsts_code in ('RW','RE') 
group by substr(f_get_std_id(sfrstcr_pidm),1,3)  ,decode(f_get_gender (sfrstcr_pidm),'M','ÿ«·»','ÿ«·»…')
order by 1;

select count(distinct sfrstcr_pidm) all_reg_students
from sfrstcr
where sfrstcr_term_code='144220'
and sfrstcr_rsts_code in ('RW','RE') 
and not exists ( SELECT '1'
                      FROM bu_dev.summer_reg_list
                     WHERE      
                            pidm= sfrstcr_pidm) ;

SELECT SSBSECT_CRN,
       ssbsect_subj_code,
       ssbsect_crse_numb,
       scbcrse_title,
       SSBSECT_MAX_ENRL,
       SSBSECT_ENRL,
       SSBSECT_SEATS_AVAIL
  FROM ssbsect, scbcrse c1
 WHERE     ssbsect_subj_code = scbcrse_subj_code
       AND ssbsect_crse_numb = scbcrse_crse_numb
       AND scbcrse_eff_term =
              (SELECT MAX (c2.scbcrse_eff_term)
                 FROM scbcrse c2
                WHERE     c2.scbcrse_subj_code = c1.scbcrse_subj_code
                      AND c2.scbcrse_crse_numb = c1.scbcrse_crse_numb
                      AND c2.scbcrse_eff_term <= '144220')
       AND ssbsect_term_code = '144220'
       AND SSBSECT_MAX_ENRL > 0
       AND SSBSECT_SEATS_AVAIL = SSBSECT_MAX_ENRL
       AND SSBSECT_SSTS_CODE='‰'
       order by 1 ;

select count( distinct  sfrstcr_crn) all_records
from sfrstcr
where sfrstcr_term_code='144220' 
and sfrstcr_rsts_code in ('RW','RE') ;

select count(  distinct sfrstcr_crn)
from sfrstcr
where sfrstcr_term_code='144020' 
and sfrstcr_rsts_code in ('RW','RE') ;

select count(distinct sfrstcr_pidm) males_41
from sfrstcr ,spbpers
where sfrstcr_term_code='144020' 
and sfrstcr_pidm=spbpers_pidm
and f_get_std_id(sfrstcr_pidm) like '441%'
and SPBPERS_SEX='M' 
and sfrstcr_rsts_code in ('RW','RE') ;
 
select count(distinct sfrstcr_pidm) females_41
from sfrstcr ,spbpers
where sfrstcr_term_code='144020' 
and sfrstcr_pidm=spbpers_pidm
and f_get_std_id(sfrstcr_pidm) like '441%'
--and SPBPERS_SEX='F'
and sfrstcr_rsts_code in ('RW','RE') ;

 SELECT count(DISTINCT  SGBSTDN_PIDM)  total_taregt
                      FROM SGBSTDN SG 
                     WHERE     SGBSTDN_TERM_CODE_EFF =
                                  (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                     FROM SGBSTDN
                                    WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                           AND SGBSTDN_STST_CODE IN ('AS')
                           AND SGBSTDN_DEGC_CODE_1 IN
                                  ('»ﬂ' )
                           AND SGBSTDN_STYP_CODE IN ('„', ' ')
                         
                          ;
        

 SELECT count(DISTINCT  SGBSTDN_PIDM) cohort_41
                      FROM SGBSTDN SG 
                     WHERE     SGBSTDN_TERM_CODE_EFF  =
                                 (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                     FROM SGBSTDN
                                    WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM) 
                           AND SGBSTDN_STST_CODE IN ('AS')
                           AND SGBSTDN_DEGC_CODE_1 IN
                                  ('»ﬂ', '»ﬂ  ', '000000', '„Ã', 'MA')
                           AND SGBSTDN_STYP_CODE IN ('„', ' ')
                        and  SG.SGBSTDN_TERM_CODE_ADMIT='144010' 
                        ;
                        
                       /*  update sfbetrm
                         set  SFBETRM_ADD_DATE=to_date('12-01-2020','dd-mm-yyyy')
                          where SFBETRM_TERM_CODE='144020'
                          and to_char(SFBETRM_ADD_DATE,'dd-mm-yyyy')='09-01-2020'*/
                          
                          
                          
 SELECT  distinct SSBSECT_CRN 
  FROM ssbsect 
 WHERE      
         ssbsect_term_code = '144030'
        
       AND SSBSECT_SSTS_CODE='‰'
       order by 1 ;
       
       
       SELECT distinct
       ssbsect_subj_code,
       ssbsect_crse_numb,
       scbcrse_title 
        
  FROM ssbsect, scbcrse c1
 WHERE     ssbsect_subj_code = scbcrse_subj_code
       AND ssbsect_crse_numb = scbcrse_crse_numb
       AND scbcrse_eff_term =
              (SELECT MAX (c2.scbcrse_eff_term)
                 FROM scbcrse c2
                WHERE     c2.scbcrse_subj_code = c1.scbcrse_subj_code
                      AND c2.scbcrse_crse_numb = c1.scbcrse_crse_numb
                      AND c2.scbcrse_eff_term <= '144030')
       AND ssbsect_term_code = '144030'
    
       AND SSBSECT_SSTS_CODE='‰'
       order by 1 ;