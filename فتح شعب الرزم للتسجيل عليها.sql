update ssbsect 

set ssbsect_max_enrl =ssbsect_enrl ,SSBSECT_SEATS_AVAIL=0
where ssbsect_term_code = '144310'
  and ssbsect_ptrm_code=3 ;
  
  
  update ssbsect 

set ssbsect_ptrm_code=1 
where ssbsect_term_code = '144310'
  and ssbsect_ptrm_code=3 ;