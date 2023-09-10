create table bu_dev.tmp_tbl_kilany_adm2 as select * from bu_dev.tmp_tbl_kilany_adm1 where 1=2 ;


select * from bu_dev.tmp_tbl_kilany_adm2 ;


UPDATE bu_dev.tmp_tbl_kilany_adm2 SET COL16='BATCH04'
WHERE COL16 IS NULL ;

declare
cursor get_data is SELECT  COL01  ssn
  FROM bu_dev.tmp_tbl_kilany_adm2
  where col01 is not null 
  AND COL16='BATCH02';
 BEGIN
 for rec in get_data loop 
  IF F_VALIDATE_SSN (rec.ssn) THEN
    --dbms_output.put_line(' SSN is true');
    null;
  else
    dbms_output.put_line(rec.ssn||'  SSN is false');
  END IF;
 end loop ;
END;

select * from moe_cd 
where student_ssn in (select col01 from bu_dev.tmp_tbl_kilany_adm2 WHERE COL16='BATCH02' ) ;

declare 
cursor get_data is 

select col01 ssn from bu_dev.tmp_tbl_kilany_adm2 where col09 not like'N%';

begin
for rec in get_data loop 
BU_APPS.pk_qiyas.p_update_moe_cd (rec.ssn);
end loop ;
end ;



select * from bu_dev.tmp_tbl_kilany_adm2 

where col01  NOT  in (select student_ssn from moe_cd)
AND COL16='BATCH02'
;
update bu_dev.tmp_tbl_kilany_adm2  set col06='1M41IT38'
where col06='1M4IT38';


update bu_dev.tmp_tbl_kilany_adm2 set col09='N'
where col01   not in (select student_ssn from moe_cd) ;
-- dept and major 
update  bu_dev.tmp_tbl_kilany_adm2 set (col10,col11)=
 (select  SORCMJR_DEPT_CODE,SORCMJR_MAJR_CODE    FROM
  
  
     SOBCURR, SORCMJR
     WHERE 
      
  SOBCURR_CURR_RULE = SORCMJR_CURR_RULE
AND SOBCURR_PROGRAM=COL06 )
WHERE COL16='BATCH04' ;

 -- master pidm,blck_code 
 
 update  bu_dev.tmp_tbl_kilany_adm2 set (col12,col13)=
 (select  sgbstdn_blck_code,sgbstdn_pidm
 from sgbstdn
 where SGBSTDN_TERM_CODE_EFF='144510'
 and sgbstdn_program_1=col06
 and sgbstdn_blck_code is not null
 and f_get_std_id(sgbstdn_pidm) like '4450%'
 AND sgbstdn_STST_CODE='AS'
 and rownum<2
 )
 WHERE COL16='BATCH04'
 ;


/*
 SELECT col01     ssn,
               col02     FIRST_NAME,
               col03     SECOND_NAME,
               col04     THIRD_NAME,
               col06     GENDER,
               col07     PHONE,
               col08     program_cd,
               col09     dept,
               col10     major,
               col11     BLCK_CODE,
               col12     master_pidm
*/
 
delete bu_dev.tmp_tbl_kilany_qadm ;
 ;   
          insert into  bu_dev.tmp_tbl_kilany_qadm(col01      ,
               col02      ,
               col03      ,
               col04      ,
               col06      ,
               col07      ,
               col08      ,
               col09      ,
               col10      ,
               col11      ,
               col12    )


select student_ssn,STUDENT_FIRST_NAME_AR ,STUDENT_MI_NAME_AR ,STUDENT_LAST_NAME_AR,COL08,COL05,COL06,COL10,COL11,COL12,COL13 

from moe_cd,bu_dev.tmp_tbl_kilany_adm2 
where student_ssn=col01
AND COL16='BATCH02'
;




  
 update  bu_dev.tmp_tbl_kilany_adm2 m set (col14,col15)=
(SELECT   col13  PIDM ,f_get_std_id(col13)
            from bu_dev.tmp_tbl_kilany_qadm  
            where col01=m.col01 )
            WHERE COL16='BATCH02'
            ;
            
            select * from bu_dev.tmp_tbl_kilany_adm2 WHERE COL16='BATCH02' ; 
            
            update SGBSTDN set SGBSTDN_RESD_CODE='Ó'
            where exists (select '1' from bu_dev.tmp_tbl_kilany_adm2 where sgbstdn_pidm=col14 AND   COL16='BATCH02' )
            
            ;
            
            select STUDENT_BIRTH_DATE_G FROM MOE_CD ;
            
            UPDATE SPBPERS SET SPBPERS_BIRTH_DATE=(
            SELECT TO_DATE(STUDENT_BIRTH_DATE_G,'DD/MM/YYYY') FROM MOE_CD
            WHERE STUDENT_SSN=SPBPERS_SSN)
            WHERE  EXISTS (SELECT '1' FROM bu_dev.tmp_tbl_kilany_adm2 where SPBPERS_pidm=col14 AND   COL16='BATCH02') ;
            
            
            
            select * from bu_dev.tmp_tbl_kilany_adm2 WHERE COL16='BATCH03' ; 
            
            -- STUDENT WENT THROUGH SAADCRV 
            
            UPDATE bu_dev.tmp_tbl_kilany_adm2 set (col14,col15)=(
            
            select sgbstdn_pidm , f_get_std_id(sgbstdn_pidm) stid  from sgbstdn sg,spbpers
where
sgbstdn_pidm=spbpers_pidm
and spbpers_ssn =COL01
            )
            WHERE COL16='BATCH04' ;  
            
            
            
          update SGBSTDN set SGBSTDN_BLCK_CODE= (SELECT COL12 from bu_dev.tmp_tbl_kilany_adm2 WHERE sgbstdn_pidm=col14 AND   COL16='BATCH04' )
            where exists (select '1' from bu_dev.tmp_tbl_kilany_adm2 where sgbstdn_pidm=col14 AND   COL16='BATCH04' ) ;
   



SELECT * FROM BU_DEV.tmp_tbl_kilany_adm2
     WHERE 
      NOT  exists  (select '5' from sgbstdn where sgbstdn_pidm=col14 and sgbstdn_program_1=col06)
      and COL09 is null ; 
            
      
      ----
      
      Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'ADM_MANUAL_451' , 'SAISUSR', 'ÑÒã ÞÈæá íÏæí', 'N', 
    SYSDATE, NULL);
    
    
  
    
    Insert into GLBEXTR
   SELECT 'STUDENT', 'ADM_MANUAL_451', 'SAISUSR', 'SAISUSR',  PIDM, 
    SYSDATE, 'S', NULL  FROM 
(  SELECT   col14  PIDM
            from BU_DEV.tmp_tbl_kilany_adm2
           WHERE      col14 IS NOT NULL
           AND COL16 IN ('BATCH02','BATCH03')
           
           ) ;
           
           
           
           -------- ÊÍæíá ÈÑäÇãÌ 
  update   BU_DEV.tmp_tbl_kilany_adm2 set col06=col08 where col16='BATCH04' ;    
SELECT * FROM BU_DEV.tmp_tbl_kilany_adm2
     WHERE 
     col16='BATCH04' ;
     
   
           
           DELETE TRANSFER_STUDENT_PROGRAM;

INSERT INTO TRANSFER_STUDENT_PROGRAM (PIDM_CD,
                                      PROGRAM_CD,
                                      DEPT_CODE,
                                      MAJOR_CODE,
                                      NOTES)
                                      
  select distinct COL14 ,COL06 ,col10,col11 ,''  FROM
  BU_DEV.tmp_tbl_kilany_adm2
  
where col16='BATCH04' ;
  
  
    update SGBSTDN set SGBSTDN_BLCK_CODE= (SELECT distinct COL12 from bu_dev.tmp_tbl_kilany_adm2 WHERE sgbstdn_pidm=col14 AND   COL16='BATCH04' )
            where exists (select '1' from bu_dev.tmp_tbl_kilany_adm2 where sgbstdn_pidm=col14 AND   COL16='BATCH04' ) ;
            
            
      DELETE FROM sfrstcr WHERE 
 sfrstcr_term_code='144510'
AND  EXISTS (SELECT '1' FROM BU_DEV.tmp_tbl_kilany_adm2
  
where col16='BATCH04' and  sfrstcr_pidm=col14 ) ;       


select * from 
 
  BU_DEV.tmp_tbl_kilany_adm2
  
where col16='BATCH04' 
and exists (select '1' from sgbstdn where sgbstdn_pidm=col14 and sgbstdn_stst_code!='AS') ;