 SELECT spriden_pidm "Pidm",
             spriden_id "Student Number",
             (SELECT spbpers_ssn
                FROM spbpers
               WHERE spbpers_pidm = sgbstdn_pidm)
                "SSN",
             (SELECT spbpers_sex
                FROM spbpers
               WHERE spbpers_pidm = sgbstdn_pidm)
                "Gender",
             d.spriden_first_name "Arabic First Name",
             d.spriden_mi "Arabic Middle Name",
             d.spriden_last_name "Arabic Last Name",
                d.spriden_first_name
             || ' '
             || d.spriden_mi
             || ' '
             || d.spriden_last_name
                "Arabic Full Name",
             (SELECT stvcoll_desc
                FROM stvcoll
               WHERE stvcoll_code = sgbstdn_coll_code_1)
                "College",
             (SELECT stvdept_desc
                FROM stvdept
               WHERE stvdept_code = sgbstdn_dept_code)
                "Department",
             (SELECT  sprtele_intl_access  
                FROM sprtele
               WHERE     sprtele_pidm = sgbstdn_pidm
                     AND sprtele_tele_code = 'MO'
                     AND ROWNUM = 1)
                "Mobile NO"
        FROM sgbstdn x, stvstst, spriden d
       WHERE     sgbstdn_pidm = spriden_pidm
             AND spriden_change_ind IS NULL
             AND sgbstdn_term_code_eff =
                    (SELECT MAX (sgbstdn_term_code_eff)
                       FROM sgbstdn d
                      WHERE d.sgbstdn_pidm = x.sgbstdn_pidm)
             AND sgbstdn_stst_code = stvstst_code
             AND d.spriden_id LIKE '441%'
             AND sgbstdn_levl_code IN ('Ã„')
             AND stvstst_code IN ('AS')
             AND NOT EXISTS
                    (SELECT 'X'
                       FROM GOREMAL
                      WHERE     GOREMAL_PIDM = sgbstdn_pidm
                      AND GOREMAL_EMAL_CODE='BU'
                             )
                                ;



/* Formatted on 9/16/2019 9:12:55 AM (QP5 v5.227.12220.39754) */
UPDATE bu_dev.tmp_tbl03
   SET COL02 = f_get_pidm (TRIM (COL01));

SELECT DISTINCT COL01
  FROM bu_dev.tmp_tbl03
 WHERE COL02 IS NULL;


UPDATE GOREMAL
   SET GOREMAL_PREFERRED_IND = 'N'
 WHERE     GOREMAL_PIDM IN (SELECT col02 FROM bu_dev.tmp_tbl03)
       AND GOREMAL_EMAL_CODE != 'BU';

INSERT INTO GOREMAL (GOREMAL_PIDM,
                     GOREMAL_EMAL_CODE,
                     GOREMAL_EMAIL_ADDRESS,
                     GOREMAL_STATUS_IND,
                     GOREMAL_PREFERRED_IND,
                     GOREMAL_ACTIVITY_DATE,
                     GOREMAL_USER_ID,
                     GOREMAL_COMMENT,
                     GOREMAL_DISP_WEB_IND,
                     GOREMAL_DATA_ORIGIN)
   SELECT DISTINCT COL02,
                   'BU',
                   col01 || '@stu.bu.edu.sa',
                   'A',
                   'Y',
                   SYSDATE,
                   USER,
                   NULL,
                   'Y',
                   'Banner'
     FROM bu_dev.tmp_tbl03;

INSERT INTO BU_APPS.STUDENT_EMAIL_PASSWORD (STUDENT_ID,
                                            STUDENT_PASSWORD,
                                            STUDENT_PIDM)
   SELECT col01, col03, col02 FROM bu_dev.tmp_tbl03;