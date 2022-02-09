/* Formatted on 22/12/2021 09:52:51 (QP5 v5.371) */
/*create table syrmgrd
(
syrmgrd_pidm number(9),
syrmgrd_name_en varchar2(200),
syrmgrd_internship_start varchar2(50),
syrmgrd_internship_end varchar2(50) 

);

grant select on bu_apps.syrmgrd to public ;

create public synonym syrmgrd for bu_apps.syrmgrd;

select substr( col06,1,instr(col06,'-')-2),
substr( col06,instr(col06,'-')+2) from dual ; */

update syrmgrd set syrmgrd_internship_end='30/01/2022'
where syrmgrd_internship_end=' 31/1/2022' ;


INSERT INTO syrmgrd
    SELECT DISTINCT f_get_pidm (col05),
                    col04,
                    SUBSTR (col06, 1, INSTR (col06, '-') - 2),
                    SUBSTR (col06, INSTR (col06, '-') + 2)
      FROM BU_DEV.TMP_TBL_KILANY1
     WHERE col05 IS NOT NULL;



  SELECT sgbstdn_pidm,
         f_getspridenid (s1.sgbstdn_pidm)           student_id,
         f_format_name (s1.sgbstdn_pidm, 'FML')     student_name,
         upper(syrmgrd_name_en),
         spbpers_ssn                                student_ssn,
         spbpers_sex,
       decode(spbpers_sex,'M','','')                              nationality,
         ''                                 college,
         ''                        major,
         ''                         srudent_LEVEL,
         syrmgrd_internship_start,
         syrmgrd_internship_end
    FROM sgbstdn s1, spbpers, syrmgrd
   WHERE     s1.sgbstdn_term_code_eff =
             (SELECT MAX (s2.sgbstdn_term_code_eff)
                FROM sgbstdn s2
               WHERE s2.sgbstdn_pidm = s1.sgbstdn_pidm)
         AND s1.sgbstdn_pidm = spbpers_pidm
         AND syrmgrd_pidm = s1.sgbstdn_pidm
ORDER BY SPBPERS_SEX DESC
;

select distinct   syrmgrd_internship_start,
         syrmgrd_internship_end
         
         from  syrmgrd ;
         
         
         select f_get_pidm('436002879') from dual ; 
         f_get_pidm('436002879')
         
         FATIMAH MOHAMMED SHARAF ALSHAKHS 