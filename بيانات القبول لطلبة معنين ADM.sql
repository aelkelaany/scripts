--ssn>>col02
--update BU_DEV.TMP_TBL_KILANY3 set COL02=col01 ;
SELECT count(distinct (COL02))
  FROM BU_DEV.TMP_TBL_KILANY3
  where col02 is not null
  ;
  
  
  declare 
cursor get_data is SELECT  COL02  ssn
  FROM BU_DEV.TMP_TBL_KILANY3
  where col02 is not null ;
 BEGIN
 for rec in get_data loop 
  IF F_VALIDATE_SSN (rec.ssn) THEN
    dbms_output.put_line(' SSN is true');
  else
    dbms_output.put_line('SSN is false');
  END IF;
 end loop ;
END;
  
  SELECT             *   FROM         ADM_MAIN_DATA_VW
 WHERE STUDENT_SSN IN (SELECT COL02 FROM BU_DEV.TMP_TBL_KILANY3);

SELECT COL02
  FROM BU_DEV.TMP_TBL_KILANY3
 WHERE NOT EXISTS
           (SELECT '1'
              FROM ADM_MAIN_DATA_VW
             WHERE STUDENT_SSN = COL02);

update BU_DEV.TMP_TBL_KILANY3 set col03='NA'
where 
NOT EXISTS
           (SELECT '1'
              FROM moe_cd
             WHERE STUDENT_SSN = COL02) ;
             
             
SELECT STUDENT_SSN,
       STUDENT_GENDER,
          STUDENT_FIRST_NAME_AR
       || ' '
       || STUDENT_MI_NAME_AR
       || ' '
       || STUDENT_LAST_NAME_AR
           ARA_NAME,
          STUDENT_FIRST_NAME_EN
       || ' '
       || STUDENT_MI_NAME_EN
       || ' '
       || STUDENT_LAST_NAME_EN
           ENG_NAME,
       EDUCATION_CENTER,
       STUDENT_BIRTH_DATE_G,
       STUDENT_BIRTH_DATE_H,
       STUDENT_CITIZEN,
       STUDENT_MAJOR,
       STUDENT_GPA
           HIGH_SCHOOL,
       STUDENT_GRADUATION_YEAR,
       STUDENT_QUDORAT_SCORE
           QUDORAT,
       STUDENT_TAHSEELY_SCORE
           TAHSEELY,
       TEST_SCORE_2
           THIRD_RATIO,
       TEST_SCORE_3
           SECOND_RATIO,
       SCHOOL_NAME,
       (SELECT MAX (APPLICATION_COMPLETE_IND)
          FROM ADM_MAIN_DATA_VW
         WHERE STUDENT_SSN = M.STUDENT_SSN)
           COMPLETE_APP,
       (SELECT 'Y'
          FROM BU_APPS.ADM_STUDENT_CONFIRMATION, SPBPERS
         WHERE     ADMIT_TERM = '144510'
               AND SPBPERS_PIDM = APPLICANT_PIDM
               AND SPBPERS_SSN = M.STUDENT_SSN) IsConfirmed ,
       (SELECT f_get_program_full_desc ('144510', APPLICANT_CHOICE)    description
          FROM VW_APPLICANT_CHOICES, SPBPERS
         WHERE     ADMIT_TERM = '144510'
               AND APPLICANT_DECISION = 'FA'
               AND SPBPERS_PIDM = APPLICANT_PIDM
               AND SPBPERS_SSN = M.STUDENT_SSN)
           ACCEPTED_PROGRAM ,( select f_get_program_full_desc ('144510', sgbstdn_program_1)
from sgbstdn,spbpers
where           
spbpers_ssn=STUDENT_SSN
and spbpers_pidm=sgbstdn_pidm
and SGBSTDN_TERM_CODE_EFF='144510'
 ) program_in_sgbstdn
  FROM MOE_CD M
 WHERE STUDENT_SSN IN (SELECT COL02 FROM BU_DEV.TMP_TBL_KILANY3 /*where col03!='NA'*/);
 
 SELECT COL02 FROM BU_DEV.TMP_TBL_KILANY3  where col03='NA' ;