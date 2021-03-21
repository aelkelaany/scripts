
update bu_dev.tmp_tbl03 set COL02=f_get_pidm(trim(COL01)) ;

select distinct * from bu_dev.tmp_tbl03
WHERE  COL02 IS   NULL ;

select count( *) from bu_dev.tmp_tbl03
WHERE  COL02 in (select sfrstcr_pidm
from sfrstcr 
where sfrstcr_term_code='144010'
and sfrstcr_crn='11717'
and sfrstcr_rsts_code in ('RE','RW'));

update bu_dev.tmp_tbl03 set col03='До'
where col03 is null ;

 
-- update sfrstcr 

update sfrstcr set SFRSTCR_GRDE_CODE=(select col03 from bu_dev.tmp_tbl03 where col02=sfrstcr_pidm)
  
where sfrstcr_term_code='144010'
and sfrstcr_crn='11717'
and sfrstcr_rsts_code in ('RE','RW');

update sfrstcr set SFRSTCR_GRDE_CODE_MID=0
where sfrstcr_term_code='144010'
and sfrstcr_crn='11717'
and sfrstcr_rsts_code in ('RE','RW');