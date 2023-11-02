/* Formatted on 15/09/2021 13:33:02 (QP5 v5.371) 
col01 student id 
col02 pidm
col03 crn

*/

---- ”ÃÌ· Ã„«⁄Ì „‰ „·›
select * from bu_dev.tmp_tbl_kilany ;
update bu_dev.tmp_tbl_kilany set col01 =col02   ;
update bu_dev.tmp_tbl_kilany set col02 =f_get_pidm(col01) where col01 is not null ;

SELECT   col03     crn ,count(col02) students
          FROM bu_dev.tmp_tbl_kilany where col03 is not null  group by col03 order by col03 ;  


DECLARE
    CURSOR get_data IS
        SELECT DISTINCT col03     crn
          FROM bu_dev.tmp_tbl_kilany where col03 is not null  order by col03  ;
          
          l_desc   GLBSLCT.GLBSLCT_DESC%type:='ELC exclude crn' ;
          l_prefix varchar2(8):='REG_ELC_' ;
BEGIN
    FOR rec IN get_data
    LOOP
        INSERT INTO GLBSLCT (GLBSLCT_APPLICATION,
                             GLBSLCT_SELECTION,
                             GLBSLCT_CREATOR_ID,
                             GLBSLCT_DESC,
                             GLBSLCT_LOCK_IND,
                             GLBSLCT_ACTIVITY_DATE,
                             GLBSLCT_TYPE_IND)
             VALUES ('STUDENT',
                     l_prefix || rec.crn,
                     'SAISUSR',
                     l_desc,
                     'N',
                     SYSDATE,
                     NULL);

        INSERT INTO GLBEXTR
            SELECT DISTINCT 'STUDENT',
                   l_prefix || rec.crn,
                   'SAISUSR',
                   'SAISUSR', col02  PIDM , SYSDATE,
                   'S',
                   NULL
                      FROM bu_dev.tmp_tbl_kilany
                     WHERE col03 = rec.crn
                     and col02 is not null  ;

        DBMS_OUTPUT.put_line (l_prefix || rec.crn||','||rec.crn);
    END LOOP;
END;

update ssbsect set SSBSECT_BILL_HRS=nvl(SSBSECT_CREDIT_HRS,0)
where ssbsect_term_code='144510'
and SSBSECT_BILL_HRS is null ;


  SELECT * FROM   bu_dev.tmp_tbl_kilany
  WHERE col03 NOT IN (SELECT SFRSTCR_CRN FROM SFRSTCR WHERE SFRSTCR_PIDM=COL02 AND SFRSTCR_term_code='144510' )
  ;
    SELECT * FROM   bu_dev.tmp_tbl_kilany
  WHERE   exists (SELECT '2' FROM SFRSTCR WHERE sfrstcr_crn=col03 and SFRSTCR_PIDM=COL02 AND SFRSTCR_term_code='144510' ) ;
  update bu_dev.tmp_tbl_kilany set col06='REG'
  where exists (SELECT '2' FROM SFRSTCR WHERE sfrstcr_crn=col03 and SFRSTCR_PIDM=COL02 AND SFRSTCR_term_code='144510' ) ; 
    update bu_dev.tmp_tbl_kilany set col07=f_get_level(col02);
  
--- —’œ 
 update sfrstcr set SFRSTCR_GRDE_CODE='⁄›'
  ,SFRSTCR_GRDE_CODE_MID=0,SFRSTCR_GRDE_DATE=null
where sfrstcr_term_code='144510'
 
and sfrstcr_rsts_code in ('RE','RW')
and (sfrstcr_pidm,sfrstcr_crn) in (select col02,col03 from bu_dev.tmp_tbl_kilany ) ;


------  —ÕÌ·

DECLARE
   CURSOR crs_get_crn
   IS
SELECT DISTINCT sfrstcr_term_code term_code, sfrstcr_crn crn
  FROM sfrstcr x 
 WHERE     
         sfrstcr_term_code = '144510'
       AND sfrstcr_grde_code IS NOT NULL
       AND sfrstcr_grde_date IS NULL
       and sfrstcr_crn IN (SELECT DISTINCT COL03 FROM bu_dev.tmp_tbl_kilany  )
       AND sfrstcr_rsts_code IN ('RE', 'RW');

BEGIN
   FOR r IN crs_get_crn
   LOOP
      shkrols.p_do_graderoll (r.term_code,
                              r.crn,
                              'WORKFLOW_ELC',
                              '1',
                              '1',
                              'O',
                              '',
                              '',
                              '',
                              '');
   END LOOP;
END;

---- COMPLIANCE 

        INSERT INTO GLBSLCT (GLBSLCT_APPLICATION,
                             GLBSLCT_SELECTION,
                             GLBSLCT_CREATOR_ID,
                             GLBSLCT_DESC,
                             GLBSLCT_LOCK_IND,
                             GLBSLCT_ACTIVITY_DATE,
                             GLBSLCT_TYPE_IND)
             VALUES ('STUDENT',
                     'ELC_STUDENTS001',
                     'SAISUSR',
                     'ELC COMP',
                     'N',
                     SYSDATE,
                     NULL);

        INSERT INTO GLBEXTR
            SELECT DISTINCT 'STUDENT',
                   'ELC_STUDENTS001',
                   'SAISUSR',
                   'SAISUSR', col02  PIDM , SYSDATE,
                   'S',
                   NULL
                      FROM bu_dev.tmp_tbl_kilany
                     WHERE  
                       col02 is not null AND COL06 IS NOT NULL  ;