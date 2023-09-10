/* Formatted on 7/27/2022 9:03:24 AM (QP5 v5.371) */
/* check admission application*/

SELECT SYBSSNL_SSN,
       sabnstu_pin,
       sabnstu_aidm,
       SARHEAD_APPL_COMP_IND,
       SYBSSNL_ADMISSION_TYPE,
       SYBSSNL_ADMISSION_TYPE,
       SYBSSNL_TERM_CODE
  FROM SYBSSNL, sabnstu, sarhead
 WHERE sabnstu_aidm = SYBSSNL_aidm AND sarhead_aidm = SYBSSNL_aidm -- AND SYBSSNL_TERM_CODE = '144310'
                                           --AND SYBSSNL_ADMISSION_TYPE = 'UG'
                                               --   AND SYBSSNL_EMAIL = :email
        AND SYBSSNL_SSN = :ssn;


SELECT STUDENT_SSN,
        
       ADMIT_TERM,
       ADMISSION_TYPE,
       APPLICATION_COMPLETE_IND,
       APPLICATION_PUSH_IND,
       FIRST_NAME_AR,
       MIDDLE_NAME_AR,
       LAST_NAME_AR,
       FIRST_NAME_EN,
       MIDDLE_NAME_EN,
       LAST_NAME_EN,
       GENDER,
       CITZ_CODE,
       MARITAL_STATUS,
       BIRTH_DATE_FRMT,
       BIRTH_DATE,
       EMAIL,
       MOBILE,
       ADDRESS_TYPE,
       ADDRESS_NATN,
       ADDRESS_CITY,
       ADDRESS_STREET,
       PHONE_AREA,
       PHONE_NUMBER,
       DPLM_TYPE,
       GRADUATION_DATE,
       GPA
  FROM BU_APPS.adm_MAIN_DATA_VW
 WHERE STUDENT_SSN = '1132198860';

SELECT STUDENT_SSN,
       STUDENT_PIDM,
       F_GET_STD_ID (STUDENT_PIDM)     STID,
       ADMIT_TERM,
       ADMISSION_TYPE,
       APPLICATION_COMPLETE_IND,
       APPLICATION_PUSH_IND,
       FIRST_NAME_AR,
       MIDDLE_NAME_AR,
       LAST_NAME_AR,
       FIRST_NAME_EN,
       MIDDLE_NAME_EN,
       LAST_NAME_EN,
       GENDER,
       CITZ_CODE,
       MARITAL_STATUS,
       BIRTH_DATE_FRMT,
       BIRTH_DATE,
       EMAIL,
       MOBILE,
       ADDRESS_TYPE,
       ADDRESS_NATN,
       ADDRESS_CITY,
       ADDRESS_STREET,
       PHONE_AREA,
       PHONE_NUMBER,
       DPLM_TYPE,
       GRADUATION_DATE,
       GPA
  FROM BU_APPS.STU_MAIN_DATA_VW
 WHERE STUDENT_SSN = '1132198860';

 -- student

SELECT f_get_std_id (sgbstdn_pidm)       stid,
       f_get_std_name (sgbstdn_pidm)     std_name,
       sg.*
  FROM sgbstdn sg, spbpers
 WHERE sgbstdn_pidm = spbpers_pidm AND spbpers_ssn = '1120560543';

     --  admissionCountSummary

  SELECT DECODE (sybssnl_gender,
                 'M', 'ÐßÑ',
                 'F', 'ÃäËí',
                 'ÛíÑ ãÍÏÏ')      AS "Gender",
         DECODE (sarhead_appl_comp_ind,
                 'Y', 'ãßÊãá',
                 'N', 'ÛíÑ ãßÊãá',
                 'ÛíÑ ãßÊãá')    AS "Application Status",
         COUNT (sybssnl_ssn)             AS "Count"
    FROM sybssnl s, sarhead h
   WHERE     s.sybssnl_aidm = h.sarhead_aidm
         AND h.sarhead_appl_seqno = 1
         AND sybssnl_gender IS NOT NULL
         AND s.sybssnl_term_code = '144410'
         AND s.sybssnl_admission_type = 'UG'
GROUP BY sybssnl_gender, sarhead_appl_comp_ind
ORDER BY 2 ASC, 2 DESC;



      --withdraw greater than 2 years

SELECT 1
  FROM DUAL
 WHERE F_VALIDATE_OLD_STUDENT_2021 ('1110756622') = 'Y';

SELECT COUNT (1)
  FROM stvterm, sgbstdn x, stvstst
 WHERE     sgbstdn_term_code_eff = (SELECT MAX (sgbstdn_term_code_eff)
                                      FROM sgbstdn d
                                     WHERE d.sgbstdn_pidm = x.sgbstdn_pidm)
       AND sgbstdn_stst_code = stvstst_code
       AND stvterm_code != '999999'
       AND stvterm_code > sgbstdn_term_code_eff
       AND SUBSTR (stvterm_code, 5) != '30'
       AND sgbstdn_pidm = 182019;

;

  SELECT student_ssn,
         student_pidm,
         FIRST_NAME_AR || ' ' || MIDDLE_NAME_AR || ' ' || LAST_NAME_AR
             stName,
         (SELECT f_get_program_full_desc ('144310', APPLICANT_CHOICE)
            FROM VW_APPLICANT_CHOICES
           WHERE APPLICANT_DECISION = 'CA' AND applicant_pidm = student_pidm)
             description
    FROM BU_APPS.STU_MAIN_DATA_VW v
   WHERE EXISTS
             (SELECT '1'
                FROM ADM_RECONFIRM_ADM_REQUEST
               WHERE STUDENT_PIDM = v.STUDENT_PIDM)
ORDER BY 4;


  SELECT student_ssn,
         FIRST_NAME_AR || ' ' || MIDDLE_NAME_AR || ' ' || LAST_NAME_AR
             stName,
         c.APPLICANT_CHOICE
             accepted_prog,
         NEW_PROGRAM,
         priority
    FROM STU_MAIN_DATA_VW         v,
         ADM_CHANGE_CAMP_REQUEST  m,
         ADM_CHNG_CAMP_REQ_DETAILS d,
         VW_APPLICANT_CHOICES     c
   WHERE     REQUEST_STATUS = 'P'
         AND v.STUDENT_PIDM = m.STUDENT_PIDM
         AND v.STUDENT_PIDM = d.STUDENT_PIDM
         AND v.STUDENT_PIDM = c.APPLICANT_PIDM
         AND m.REQUEST_NO = d.REQUEST_NO
         AND APPLICANT_DECISION = 'QA'
--and v.STUDENT_PIDM = 241839 ;
ORDER BY accepted_prog, student_ssn, priority;

SELECT f_get_std_name (f_get_pidm ('3898')) FROM DUAL;


---- is BU student ?

SELECT f_get_std_id (sgbstdn_pidm)       stid,
       f_get_std_name (sgbstdn_pidm)     std_name,
       sg.*
  FROM sgbstdn sg, spbpers
 WHERE sgbstdn_pidm = spbpers_pidm AND spbpers_ssn LIKE '%1127365864%';

------ is valid ssn

DECLARE
    v_ssn   VARCHAR2 (10) := '1127365854';
BEGIN
    IF F_VALIDATE_SSN (v_ssn)
    THEN
        DBMS_OUTPUT.put_line (' SSN is true');
    ELSE
        DBMS_OUTPUT.put_line ('SSN is false');
    END IF;
END;


-- delete application exec BU_APPS.P_DELETE_ADM_APPLICATION (407824 ) ;
