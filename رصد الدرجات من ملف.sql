--col01>> student id
--colo2>>crn
--col03>> pidm
--col04>> grade code='До'

update bu_dev.tmp_tbl_kilany set COL03=f_get_pidm(trim(COL01)) ;
update bu_dev.tmp_tbl_kilany set COL02=trim(COL02)  ;
select distinct * from bu_dev.tmp_tbl_kilany
WHERE  COL03 IS   NULL ;

select count( *) from bu_dev.tmp_tbl_kilany
WHERE  COL02 in (select sfrstcr_pidm
from sfrstcr 
where sfrstcr_term_code='144010'
and sfrstcr_crn='11717'
and sfrstcr_rsts_code in ('RE','RW'));

update bu_dev.tmp_tbl_kilany set col04='До'
where col03 is not null ;

select  * from  sfrstcr where exists (select '1' from bu_dev.tmp_tbl_kilany where col03=sfrstcr_pidm   and  col02=sfrstcr_crn)
  
and sfrstcr_term_code='144230'
 
and sfrstcr_rsts_code in ('RE','RW')
--and SFRSTCR_GRDE_CODE is null


 ;




 update sfrstcr set SFRSTCR_GRDE_CODE=(select col04 from bu_dev.tmp_tbl_kilany where col03=sfrstcr_pidm   and sfrstcr_crn=col03)
  ,SFRSTCR_GRDE_CODE_MID=0
where sfrstcr_term_code='144230'
 
and sfrstcr_rsts_code in ('RE','RW')
and SFRSTCR_GRDE_CODE is null ;
-- update sfrstcr 
/**
update sfrstcr set SFRSTCR_GRDE_CODE=(select col03 from bu_dev.tmp_tbl_kilany where col02=sfrstcr_pidm)
  
where sfrstcr_term_code='144010'
and sfrstcr_crn='11717'
and sfrstcr_rsts_code in ('RE','RW');

update sfrstcr set SFRSTCR_GRDE_CODE_MID=0
where sfrstcr_term_code='144010'
and sfrstcr_crn='11717'
and sfrstcr_rsts_code in ('RE','RW');*/