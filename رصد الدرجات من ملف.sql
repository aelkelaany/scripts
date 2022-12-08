--col01>> student id
--colo2>>crn
--col03>> pidm
--col04>> grade code='До'
delete from bu_dev.tmp_tbl_kilany where col01 is null ;
update bu_dev.tmp_tbl_kilany set COL03=f_get_pidm(trim(COL01)) ;
update bu_dev.tmp_tbl_kilany set COL02=trim(COL02)  ;
select distinct * from bu_dev.tmp_tbl_kilany
WHERE  COL03 IS   NULL ;

select count( *) from bu_dev.tmp_tbl_kilany
WHERE  COL03 in (select sfrstcr_pidm
from sfrstcr 
where sfrstcr_term_code='144340'
and sfrstcr_crn=col02
and sfrstcr_rsts_code in ('RE','RW'));

select  *  from bu_dev.tmp_tbl_kilany
WHERE  not exists (select '1'
from sfrstcr 
where sfrstcr_term_code='144340'
and sfrstcr_crn=col02
and sfrstcr_pidm=col03
and sfrstcr_rsts_code in ('RE','RW'));

update bu_dev.tmp_tbl_kilany set col04='До'
where col03 is not null ;

select  * from  sfrstcr where exists (select '1' from bu_dev.tmp_tbl_kilany where col03=sfrstcr_pidm   and  col02=sfrstcr_crn)
  
and sfrstcr_term_code='144340'
 
and sfrstcr_rsts_code in ('RE','RW')
--and SFRSTCR_GRDE_CODE is null


 ;




 update sfrstcr set SFRSTCR_GRDE_CODE='До'
  ,SFRSTCR_GRDE_CODE_MID=0,SFRSTCR_GRDE_DATE=null
where sfrstcr_term_code='144340'
 
and sfrstcr_rsts_code in ('RE','RW')
and (sfrstcr_pidm,sfrstcr_crn) in (select col03,col02 from bu_dev.tmp_tbl_kilany )

/*and SFRSTCR_GRDE_CODE is null */;
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





 
Insert into SATURN.SFRSTCR    (SFRSTCR_TERM_CODE, SFRSTCR_PIDM, SFRSTCR_CRN, SFRSTCR_REG_SEQ, SFRSTCR_PTRM_CODE, 
    SFRSTCR_RSTS_CODE, SFRSTCR_RSTS_DATE, SFRSTCR_BILL_HR, SFRSTCR_WAIV_HR, SFRSTCR_CREDIT_HR, 
    SFRSTCR_BILL_HR_HOLD, SFRSTCR_CREDIT_HR_HOLD, SFRSTCR_GMOD_CODE, SFRSTCR_GRDE_CODE, SFRSTCR_GRDE_DATE, 
    SFRSTCR_DUPL_OVER, SFRSTCR_LINK_OVER, SFRSTCR_CORQ_OVER, SFRSTCR_PREQ_OVER, SFRSTCR_TIME_OVER, 
    SFRSTCR_CAPC_OVER, SFRSTCR_LEVL_OVER, SFRSTCR_COLL_OVER, SFRSTCR_MAJR_OVER, SFRSTCR_CLAS_OVER, 
    SFRSTCR_APPR_OVER, SFRSTCR_ADD_DATE, SFRSTCR_ACTIVITY_DATE, SFRSTCR_LEVL_CODE, SFRSTCR_CAMP_CODE, 
    SFRSTCR_REPT_OVER, SFRSTCR_RPTH_OVER, SFRSTCR_CAMP_OVER, SFRSTCR_USER, SFRSTCR_ASSESS_ACTIVITY_DATE, 
    SFRSTCR_MEXC_OVER) 
    select distinct '144230', col03, col02,rownum+ 42, '1', 
    'RW', TO_DATE('22/05/2021 22:21:45', 'DD/MM/YYYY HH24:MI:SS'), 0, 0, 2, 
    0, 2, 'м', 'А', TO_DATE('27/07/2021 11:15:32', 'DD/MM/YYYY HH24:MI:SS'), 
    'N', 'N', 'N', 'N', 'N', 
    'N', 'N', 'N', 'N', 'N', 
    'N', TO_DATE('22/05/2021 22:21:47', 'DD/MM/YYYY HH24:MI:SS'), TO_DATE('22/05/2021 22:21:47', 'DD/MM/YYYY HH24:MI:SS'), 'лЦ', '03', 
    'N', 'N', 'N', 'WWW2_USER', TO_DATE('22/05/2021 22:21:47', 'DD/MM/YYYY HH24:MI:SS'), 
    'N' 
  from  bu_dev.tmp_tbl_kilany
 WHERE NOT EXISTS
           (SELECT '1'
              FROM sfrstcr
             WHERE     sfrstcr_term_code = '144230'
                   AND sfrstcr_rsts_code IN ('RE', 'RW')
                   AND  sfrstcr_pidm=col03 
                   AND  sfrstcr_crn=col02 )
                  -- and col02=30273
                   order by 2 ;
                   
                   
                   
                   
                    
                   
                   
        
 