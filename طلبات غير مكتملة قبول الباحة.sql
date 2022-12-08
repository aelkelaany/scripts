/* Formatted on 8/4/2022 1:43:18 PM (QP5 v5.371) */
SELECT sybssnl_ssn,
          cd.STUDENT_FIRST_NAME_AR
       || ' '
       || cd.STUDENT_MI_NAME_AR
       || ''
       || cd.STUDENT_LAST_NAME_AR    student_name,
       cd.EDUCATION_CENTER,
       STUDENT_DIPLOMA_TYPE,
       STUDENT_GPA,
       STUDENT_GRADUATION_YEAR,
       QUDRAT_TEST_CODE,
       STUDENT_QUDORAT_SCORE,
       TAHSEELY_TEST_CODE,
       STUDENT_TAHSEELY_SCORE,
       TEST_CODE_1,
       TEST_SCORE_1,
       TEST_CODE_2,
       TEST_SCORE_2,
       TEST_CODE_3,
       TEST_SCORE_3,
       SCHOOL_NAME
  FROM sybssnl  s,
       sarhead  h,
       moe_cd   cd,
       BU_APPS.ADM_QUOTA_BATCH_EDU_CENTER
 WHERE     s.sybssnl_aidm = h.sarhead_aidm
       AND h.sarhead_appl_seqno = 1
       AND s.sybssnl_term_code = '144410'
       AND s.sybssnl_admission_type = 'UG'
       AND s.SYBSSNL_SSN = cd.STUDENT_SSN
       AND QUOTA_BATCH_NO = 1
       AND cd.EDUCATION_CENTER = QUOTA_EDUCATION_CENTER
       AND h.SARHEAD_APPL_COMP_IND = 'N'
       order by 3