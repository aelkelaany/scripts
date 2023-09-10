select * from bu_dev.tmp_tbl_kilany 
where not  exists (select '1' from sfrstcr where sfrstcr_term_code='144510' and sfrstcr_crn=col01 and sfrstcr_rsts_code in ('RE','RW')) ;

select '1'  and sfrstcr_crn=col01 and sfrstcr_rsts_code in ('RE','RW')
;
delete from sfrstcr  where sfrstcr_term_code='144510' and  sfrstcr_crn in (select col01 from bu_dev.tmp_tbl_kilany  ) ;




 update ssbsect set SSBSECT_MAX_ENRL=0 , SSBSECT_ENRL=0 ,SSBSECT_SEATS_AVAIL=0,SSBSECT_TOT_CREDIT_HRS=0
where ssbsect_term_code='144510' and ssbsect_crn in (select col01 from bu_dev.tmp_tbl_kilany  ) ;

