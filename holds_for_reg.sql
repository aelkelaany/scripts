UPDATE bu_dev.tmp_tbl04
   SET COL02 = f_get_pidm (TRIM (COL01));

SELECT DISTINCT COL01
  FROM bu_dev.tmp_tbl04
 WHERE COL02 IS NULL;
 
 select * from sprhold
 where sprhold not in (select )
 
 
 
 
Insert into SPRHOLD
   (SPRHOLD_PIDM, SPRHOLD_HLDD_CODE, SPRHOLD_USER, SPRHOLD_FROM_DATE, SPRHOLD_TO_DATE, 
    SPRHOLD_RELEASE_IND, SPRHOLD_REASON, SPRHOLD_AMOUNT_OWED, SPRHOLD_ORIG_CODE, SPRHOLD_ACTIVITY_DATE, 
    SPRHOLD_DATA_ORIGIN)
select 
    a.sgbstdn_pidm, 'RH', 'SAISUSR', sysdate-3, sysdate+365, 
    'N', NULL, NULL, NULL, sysdate, 
    'Banner IT' 
    from sgbstdn a
    where not exists (select '1' from sprhold where sprhold_pidm=a.sgbstdn_pidm and SPRHOLD_HLDD_CODE='RH'  ) 
    and SGBSTDN_TERM_CODE_EFF=( select max(SGBSTDN_TERM_CODE_EFF) from sgbstdn where sgbstdn_pidm=a.sgbstdn_pidm)
    and SGBSTDN_STST_CODE  in ('AS')
 
update SPRHOLD set SPRHOLD_TO_DATE=sysdate+365
where SPRHOLD_HLDD_CODE='RH' 


 
 delete from sprhold where sprhold_pidm in ( select COL02 from tmp_tbl04  )
and SPRHOLD_HLDD_CODE='RH'

select * from tmp_tbl04 where col02 not in (select sprhold_pidm from sprhold where SPRHOLD_HLDD_CODE='RH' )

sfrstcr