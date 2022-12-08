/* Formatted on 11/14/2022 9:45:03 AM (QP5 v5.371) */
SELECT STUDENT_SSN,
          STUDENT_FIRST_NAME_AR
       || ' '
       || STUDENT_MI_NAME_AR
       || ' '
       || STUDENT_LAST_NAME_AR                   ar_st_name,
          STUDENT_FIRST_NAME_EN
       || ' '
       || STUDENT_MI_NAME_EN
       || ' '
       || STUDENT_LAST_NAME_EN                   en_st_name,
       EDUCATION_CENTER,
       STUDENT_MAJOR,
       STUDENT_GPA,
       STUDENT_GRADUATION_YEAR,
       STUDENT_QUDORAT_SCORE,
       STUDENT_TAHSEELY_SCORE,
       TEST_SCORE_2,
       TEST_SCORE_3,
       SCHOOL_NAME,
       (SELECT MAX (SPRTELE_INTL_ACCESS)
          FROM sprtele, spbpers
         WHERE     SPRTELE_TELE_CODE = 'MO'
               AND spbpers_pidm = sprtele_pidm
               AND spbpers_ssn = STUDENT_SSN)    st_phone
  FROM (  SELECT DISTINCT STUDENT_SSN,
                          STUDENT_FIRST_NAME_AR,
                          STUDENT_MI_NAME_AR,
                          STUDENT_LAST_NAME_AR,
                          STUDENT_FIRST_NAME_EN,
                          STUDENT_MI_NAME_EN,
                          STUDENT_LAST_NAME_EN,
                          EDUCATION_CENTER,
                          STUDENT_MAJOR,
                          STUDENT_GPA,
                          STUDENT_GRADUATION_YEAR,
                          STUDENT_QUDORAT_SCORE,
                          STUDENT_TAHSEELY_SCORE,
                          TEST_SCORE_2,
                          TEST_SCORE_3,
                          SCHOOL_NAME
            FROM moe_cd a, BU_APPS.ADM_QUOTA_BATCH_EDU_CENTER
           WHERE     STUDENT_DIPLOMA_TYPE IN ('œ')
                 --  AND STUDENT_GRADUATION_YEAR = '2022'        -- '”‰… «·À«‰ÊÌ…'
                 AND STUDENT_GENDER = 'F'                          -- 'female'
                 AND STUDENT_CITIZEN = '”'
                 --                 AND QUOTA_EDUCATION_CENTER !=
                 --                     '≈œ«—… «· ⁄·Ì„ »„Õ«›Ÿ… «·⁄—÷Ì« '
                 AND QUOTA_EDUCATION_CENTER = EDUCATION_CENTER
                 AND QUOTA_BATCH_NO = 1
                 AND a.TEST_SCORE_3 >= 70
                 AND EXISTS
                         (SELECT '1'
                            FROM STU_MAIN_DATA_VW
                           WHERE STUDENT_SSN = A.STUDENT_SSN
                           AND ADMIT_TERM='144410'
                           AND ADMISSION_TYPE LIKE 'U%')
                 AND NOT EXISTS
                         (SELECT '1'
                            FROM sarappd, spbpers
                           WHERE     spbpers_pidm = sarappd_pidm
                                 AND spbpers_ssn = A.STUDENT_SSN
                                 AND SARAPPD_TERM_CODE_ENTRY = '144410'
                                 AND SARAPPD_APDC_CODE IN ('WM',
                                                           'CA',
                                                           'WA',
                                                           'CM'))
                 AND NOT EXISTS
                         (SELECT '1'
                            FROM spbpers, SGBSTDN
                           WHERE     spbpers_ssn = A.STUDENT_SSN
                                 AND SGBSTDN_PIDM = spbpers_pidm
                                 AND SGBSTDN_TERM_CODE_EFF =
                           (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                              FROM SGBSTDN
                             WHERE SGBSTDN_PIDM = spbpers_pidm)
                       AND SGBSTDN_STST_CODE  IN ('AS','„Ê','„⁄','ÿÌ','ÿ”','„”','„Œ','„‰'))
        ORDER BY a.TEST_SCORE_3 DESC)
 WHERE ROWNUM < 501
 ;