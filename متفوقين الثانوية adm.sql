 -- «‰”«‰Ì «œ»Ì «œ«—Ì  Õ›ÌŸ ﬁ—¬‰
SELECT STUDENT_SSN,   STUDENT_FIRST_NAME_AR || ' '|| 
   STUDENT_MI_NAME_AR ||' '||  STUDENT_LAST_NAME_AR ar_st_name, STUDENT_FIRST_NAME_EN || ' '|| 
   STUDENT_MI_NAME_EN ||' '||  STUDENT_LAST_NAME_EN en_st_name, EDUCATION_CENTER, 
   
   STUDENT_MAJOR , STUDENT_GPA, 
   STUDENT_GRADUATION_YEAR,   STUDENT_QUDORAT_SCORE, 
     STUDENT_TAHSEELY_SCORE,    TEST_SCORE_2, 
     TEST_SCORE_3, SCHOOL_NAME ,(select SPRTELE_INTL_ACCESS from sprtele,spbpers where SPRTELE_TELE_CODE = 'MO'
     and spbpers_pidm=sprtele_pidm
     and spbpers_ssn=STUDENT_SSN
     ) st_phone
  FROM (  SELECT *
            FROM moe_cd a, BU_APPS.ADM_QUOTA_BATCH_EDU_CENTER
           WHERE     STUDENT_DIPLOMA_TYPE in ('—'  ,'œ')           --'«·„”«— «·⁄·„Ì'
                 AND STUDENT_GRADUATION_YEAR = '2022' -- '”‰… «·À«‰ÊÌ…'
                 AND STUDENT_GENDER = 'M'                          -- 'female'
                 AND STUDENT_CITIZEN = '”'
                 AND QUOTA_EDUCATION_CENTER !=
                     '≈œ«—… «· ⁄·Ì„ »„Õ«›Ÿ… «·⁄—÷Ì« '
                 AND QUOTA_EDUCATION_CENTER = EDUCATION_CENTER
                 and QUOTA_BATCH_NO = 1
                 and STUDENT_MAJOR not in ('«·„⁄Âœ «·⁄·„Ì- ﬁ”„ À«‰ÊÌ')
        ORDER BY a.TEST_SCORE_3 DESC)
 WHERE ROWNUM < 7;
 
 ---------- „⁄«Âœ ⁄·„Ì… 
  
SELECT STUDENT_SSN,   STUDENT_FIRST_NAME_AR || ' '|| 
   STUDENT_MI_NAME_AR ||' '||  STUDENT_LAST_NAME_AR ar_st_name, STUDENT_FIRST_NAME_EN || ' '|| 
   STUDENT_MI_NAME_EN ||' '||  STUDENT_LAST_NAME_EN en_st_name, EDUCATION_CENTER, 
   
   STUDENT_MAJOR , STUDENT_GPA, 
   STUDENT_GRADUATION_YEAR,   STUDENT_QUDORAT_SCORE, 
     STUDENT_TAHSEELY_SCORE,    TEST_SCORE_2, 
     TEST_SCORE_3, SCHOOL_NAME ,(select SPRTELE_INTL_ACCESS from sprtele,spbpers where SPRTELE_TELE_CODE = 'MO'
     and spbpers_pidm=sprtele_pidm
     and spbpers_ssn=STUDENT_SSN
     ) st_phone
  FROM (  SELECT *
            FROM moe_cd a, BU_APPS.ADM_QUOTA_BATCH_EDU_CENTER
           WHERE     STUDENT_DIPLOMA_TYPE in ('—'  ,'œ')           --'«·„”«— «·⁄·„Ì'
                 AND STUDENT_GRADUATION_YEAR = '2022' -- '”‰… «·À«‰ÊÌ…'
                 AND STUDENT_GENDER = 'M'                          -- 'female'
                 AND STUDENT_CITIZEN = '”'
                 AND QUOTA_EDUCATION_CENTER !=
                     '≈œ«—… «· ⁄·Ì„ »„Õ«›Ÿ… «·⁄—÷Ì« '
                 AND QUOTA_EDUCATION_CENTER = EDUCATION_CENTER
                 and QUOTA_BATCH_NO = 1
                 and  STUDENT_MAJOR LIKE '%⁄·„%'
        ORDER BY a.TEST_SCORE_3 DESC)
 WHERE ROWNUM < 5;
 -- ⁄·Ê„ ÿ»Ì⁄»… 
  
SELECT STUDENT_SSN,   STUDENT_FIRST_NAME_AR || ' '|| 
   STUDENT_MI_NAME_AR ||' '||  STUDENT_LAST_NAME_AR ar_st_name, STUDENT_FIRST_NAME_EN || ' '|| 
   STUDENT_MI_NAME_EN ||' '||  STUDENT_LAST_NAME_EN en_st_name, EDUCATION_CENTER, 
   
   STUDENT_MAJOR , STUDENT_GPA, 
   STUDENT_GRADUATION_YEAR,   STUDENT_QUDORAT_SCORE, 
     STUDENT_TAHSEELY_SCORE,    TEST_SCORE_2, 
     TEST_SCORE_3, SCHOOL_NAME ,(select SPRTELE_INTL_ACCESS from sprtele,spbpers where SPRTELE_TELE_CODE = 'MO'
     and spbpers_pidm=sprtele_pidm
     and spbpers_ssn=STUDENT_SSN
     ) st_phone
  FROM (  SELECT *
            FROM moe_cd a, BU_APPS.ADM_QUOTA_BATCH_EDU_CENTER
           WHERE     STUDENT_DIPLOMA_TYPE = '⁄'             --'«·„”«— «·⁄·„Ì'
                 AND STUDENT_GRADUATION_YEAR = '2022' -- '”‰… «·À«‰ÊÌ…'
                 AND STUDENT_GENDER = 'F'                          -- 'female'
                 AND STUDENT_CITIZEN = '”'
                 AND QUOTA_EDUCATION_CENTER !=
                     '≈œ«—… «· ⁄·Ì„ »„Õ«›Ÿ… «·⁄—÷Ì« '
                 AND QUOTA_EDUCATION_CENTER = EDUCATION_CENTER
                 and QUOTA_BATCH_NO = 1
        ORDER BY a.TEST_SCORE_2 DESC)
 WHERE ROWNUM < 13 ;
 
 