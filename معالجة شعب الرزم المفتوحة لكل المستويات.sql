create table DEV_BACKUP.crn_blk_pt1_144210 as 
select * from ssbsect 
where ssbsect_term_code='144310'
and SSBSECT_PTRM_CODE=1
and exists (select '1' from ssrblck
where SSRBLCK_TERM_CODE=ssbsect_term_code and SSRBLCK_CRN=ssbsect_crn) ;


insert into  DEV_BACKUP.crn_blk_pt1_144210

select * from ssbsect a
where ssbsect_term_code='144310'
and SSBSECT_PTRM_CODE=1
and exists (select '1' from ssrblck
where SSRBLCK_TERM_CODE=ssbsect_term_code and SSRBLCK_CRN=ssbsect_crn)
and not exists (select '2' from DEV_BACKUP.crn_blk_pt1_144210 where ssbsect_crn=a.ssbsect_crn) ;

update ssbsect set  SSBSECT_PTRM_CODE=3
where 
ssbsect_term_code='144310'
and SSBSECT_PTRM_CODE=1
and exists (select '1' from ssrblck
where SSRBLCK_TERM_CODE=ssbsect_term_code and SSRBLCK_CRN=ssbsect_crn)   ;
 