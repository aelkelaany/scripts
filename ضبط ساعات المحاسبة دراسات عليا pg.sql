select ssbsect_crn ,SSBSECT_SCHD_CODE from 
ssbsect where
ssbsect_term_code='144510'
 
and ssbsect_bill_hrs is null
and exists ( select '1' from scrlevl where SCRLEVL_SUBJ_CODE|| SCRLEVL_CRSE_NUMB=ssbsect_SUBJ_CODE||ssbsect_CRSE_NUMB
and SCRLEVL_LEVL_CODE='MA')
and SSBSECT_SCHD_CODE='ä'
;

update ssbsect
set ssbsect_bill_hrs=SSBSECT_CREDIT_HRS
where 
ssbsect_term_code='144510'
 
and ssbsect_bill_hrs is null
and exists ( select '1' from scrlevl where SCRLEVL_SUBJ_CODE|| SCRLEVL_CRSE_NUMB=ssbsect_SUBJ_CODE||ssbsect_CRSE_NUMB
and SCRLEVL_LEVL_CODE='MA')
and SSBSECT_SCHD_CODE='ä' ;