update ssbsect 

set ssbsect_max_enrl =ssbsect_enrl ,SSBSECT_SEATS_AVAIL=0
where ssbsect_term_code = '144310'
  and ssbsect_ptrm_code=3 ;
  
  
  update ssbsect 

set ssbsect_ptrm_code=1 
where ssbsect_term_code = '144510'
  and ssbsect_ptrm_code=3 ;
  
  
  
  ---
  update ssbsect set SSBSECT_MAX_ENRL  =SSBSECT_MAX_ENRL+10
where 
SSBSECT_TERM_CODE='144510'
and exists (select '1' from ssrblck where SSRBLCK_TERM_CODE=ssbsect_term_code and SSRBLCK_CRN=SSbsect_CRN );


update ssbsect set SSBSECT_SEATS_AVAIL=SSBSECT_MAX_ENRL-SSBSECT_ENRL
where 
SSBSECT_TERM_CODE='144510'
and exists (select '1' from ssrblck where SSRBLCK_TERM_CODE=ssbsect_term_code and SSRBLCK_CRN=SSbsect_CRN );;
  
  
  