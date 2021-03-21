delete from bu_dev.tmp_tbl03 where col02 is null ;
select *   from bu_dev.tmp_tbl03 ;
 

update ssbsect set SSBSECT_MAX_ENRL =(select max( col02) from bu_dev.tmp_tbl03 where col01=SSBSECT_CRN )
where 
SSBSECT_TERM_CODE='144030'
and exists (select '1' from bu_dev.tmp_tbl03 where col01=SSBSECT_CRN );


update ssbsect set SSBSECT_SEATS_AVAIL=SSBSECT_MAX_ENRL-SSBSECT_ENRL
where 
SSBSECT_TERM_CODE='144030'
and exists (select '1' from bu_dev.tmp_tbl03 where col01=SSBSECT_CRN );