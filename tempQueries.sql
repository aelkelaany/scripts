/* Formatted on 2/5/2020 11:50:15 AM (QP5 v5.227.12220.39754) */
SELECT F_GET_STD_NAME (USER_PIDM),
       ATTRIBUTE_CODE,
       ATTRIBUTE_VALUE,
       ACTIVITY_DATE,
       USER_ID
  FROM BU_APPS.USERS_ATTRIBUTES A
 WHERE     ATTRIBUTE_CODE = 'DEPARTMENT'
       AND ATTRIBUTE_VALUE LIKE '13%'
       AND EXISTS
              (SELECT 1
                 FROM USERS_ATTRIBUTES
                WHERE     USER_PIDM = A.USER_PIDM
                      AND ATTRIBUTE_CODE = 'COLLEGE'
                      AND ATTRIBUTE_VALUE LIKE '13')
-----------------------------
SELECT  SMRACAA_SUBJ_CODE, SMRACAA_CRSE_NUMB_LOW
  FROM SATURN.SMRACAA
 WHERE     SMRACAA_AREA IN
              (SELECT SMRPAAP_AREA
                 FROM SATURN.SMRPAAP
                WHERE     SMRPAAP_PROGRAM = '1-1708-1433'
                      AND SMRPAAP_TERM_CODE_EFF = '143310')
       AND SMRACAA_TERM_CODE_EFF = '143310'
MINUS
SELECT SMRDORQ_SUBJ_CODE, SMRDORQ_CRSE_NUMB_LOW
  FROM SATURN.SMRDORQ
 WHERE (SMRDORQ_PIDM = f_get_pidm ('436010071')) AND SMRDORQ_REQUEST_NO = 15

 -----------------------------------------------------------------------------
 SELECT F_GET_STD_ID(SGBSTDN_PIDM) ,SGBSTDN_COLL_CODE_1 FROM SGBSTDN A
WHERE
        A.sgbstdn_stst_code in ('AS','Øí','ãÚ','ãæ')
        AND SGBSTDN_STYP_CODE='ã'
   AND   A.sgbstdn_TERM_CODE_EFF     =    (SELECT MAX(sgbstdn_TERM_CODE_EFF )
                                             FROM    sgbstdn
                                             WHERE sgbstdn_pidm = A.sgbstdn_pidm
                                            )
                                           AND    A.sgbstdn_dept_code IS NULL
                                           AND A.SGBSTDN_LEVL_CODE='Ìã'



                                           select gac_test('27266') from dual
p_delete_grade_roll;

------------------------------------------


SELECT f_getspridenid (sgbstdn_pidm) student_id,
       f_format_name (sgbstdn_pidm, 'FML') student_name,
       (SELECT spbpers_ssn
          FROM spbpers
         WHERE spbpers_pidm = sgbstdn_pidm)
          student_ssn,
       f_get_desc_fnc ('STVSTST', sgbstdn_stst_code, 60) status,
       f_get_desc_fnc ('STVCOLL', sgbstdn_coll_code_1, 60) college,
       f_get_desc_fnc ('STVDEPT', sgbstdn_dept_code, 60) department,
       f_get_desc_fnc ('STVCAMP', sgbstdn_camp_code, 60) campus,
       f_get_desc_fnc ('STVMAJR', sgbstdn_majr_code_1, 60) major,
       f_get_desc_fnc ('STVSTYP', SGBSTDN_STYP_CODE, 60) studyType,
       f_disconnect_term_count (sgbstdn_pidm) - 1 DICONNECTION_PERIOD,
       f_disconnection_count (sgbstdn_pidm) times,
       (SELECT shrlgpa_hours_earned
          FROM shrlgpa
         WHERE     shrlgpa_pidm = a.sgbstdn_pidm
               AND shrlgpa_levl_code = sgbstdn_levl_code
               AND shrlgpa_gpa_type_ind = 'O')
          Earned_Hours
  FROM sgbstdn a
 WHERE     f_get_std_id (sgbstdn_pidm) IN
              ('433005783',
               '434007371',
               '434017176',
               '435013811',
               '436011268',
               '436011018',
               '436011239',
               '436011131',
               '434017316',
               '437010149',
               '436011277',
               '433016451',
               '434016496',
               '434016360',
               '433016452',
               '433016158',
               '430003001',
               '431014687',
               '435011923',
               '438000906',
               '436012180',
               '432011645',
               '431014876',
               '431014878',
               '437009887',
               '432020676',
               '432020771',
               '430010337',
               '434016390',
               '432025044',
               '434015982',
               '432005470',
               '435013318',
               '434004276',
               '437008399',
               '432023509',
               '433016274',
               '434015976',
               '432000481',
               '433005847')
       AND sgbstdn_term_code_eff =
              (SELECT MAX (b.sgbstdn_term_code_eff)
                 FROM sgbstdn b
                WHERE     b.sgbstdn_pidm = a.sgbstdn_pidm
                      AND b.sgbstdn_term_code_eff <=
                             f_get_param ('WORKFLOW', 'CURRENT_TERM', 1));



--------------------------------advisor

SELECT STVCOLL_CODE, STVCOLL_DESC
  FROM STVCOLL
 WHERE EXISTS
          (SELECT 'X'
             FROM GORFBPR
            WHERE     GORFBPR_FGAC_USER_ID = 'HABULKHAIR'
                  AND (   REPLACE (GORFBPR_FBPR_CODE, 'COLL_') = STVCOLL_CODE
                       OR SUBSTR (REPLACE (GORFBPR_FBPR_CODE, 'DEPT_'), 1, 2) =
                             STVCOLL_CODE))
UNION
SELECT STVCOLL_CODE, STVCOLL_DESC
  FROM STVCOLL
 WHERE NOT EXISTS
          (SELECT 'X'
             FROM GORFBPR
            WHERE GORFBPR_FGAC_USER_ID = 'HABULKHAIR');

SELECT STVDEPT_CODE, STVDEPT_DESC
  FROM STVDEPT
 WHERE     EXISTS
              (SELECT 'X'
                 FROM GORFBPR
                WHERE     GORFBPR_FGAC_USER_ID = 'HABULKHAIR'
                      AND (REPLACE (GORFBPR_FBPR_CODE, 'DEPT_') =
                              STVDEPT_CODE))
       AND SUBSTR (STVDEPT_CODE, 1, 2) = :COLL_CODE
UNION
SELECT STVDEPT_CODE, STVDEPT_DESC
  FROM STVDEPT
 WHERE     NOT EXISTS
              (SELECT 'X'
                 FROM GORFBPR
                WHERE GORFBPR_FGAC_USER_ID = 'HABULKHAIR')
       AND SUBSTR (STVDEPT_CODE, 1, 2) = :COLL_CODE;


  -----------------------postpone term

SELECT 1
  FROM DUAL
 WHERE F_WFR_POSTPONE_TERM (f_get_pidm ('441017906')) = 'Y';

SELECT sgbstdn_levl_code level_code,
       sgbstdn_stst_code status_code,
       sgbstdn_styp_code student_type
  FROM sgbstdn x
 WHERE     sgbstdn_pidm = f_get_pidm ('441017906')
       AND sgbstdn_term_code_eff =
              (SELECT MAX (sgbstdn_term_code_eff)
                 FROM sgbstdn d
                WHERE     d.sgbstdn_pidm = x.sgbstdn_pidm
                      AND d.sgbstdn_term_code_eff <=
                             f_get_param ('WORKFLOW', 'CURRENT_TERM', 1))
       AND SGBSTDN_TERM_CODE_ADMIT !=
              f_get_param ('WORKFLOW', 'CURRENT_TERM', 1);

-------------------------------

SELECT f_getspridenid (sgbstdn_pidm) student_id,
       f_format_name (sgbstdn_pidm, 'FML') student_name,
       (SELECT spbpers_ssn
          FROM spbpers
         WHERE spbpers_pidm = sgbstdn_pidm)
          student_ssn,
       f_get_desc_fnc ('STVSTST', sgbstdn_stst_code, 60) status,
       f_get_desc_fnc ('STVCOLL', sgbstdn_coll_code_1, 60) college,
       f_get_desc_fnc ('STVDEPT', sgbstdn_dept_code, 60) department,
       f_get_desc_fnc ('STVCAMP', sgbstdn_camp_code, 60) campus,
       f_get_desc_fnc ('STVMAJR', sgbstdn_majr_code_1, 60) major,
       f_get_desc_fnc ('STVSTYP', SGBSTDN_STYP_CODE, 60) studyType,
       6 - f_chances_count (sgbstdn_pidm) REMAINIG_CHANCES ,   (SELECT shrlgpa_hours_earned
          FROM shrlgpa
         WHERE     shrlgpa_pidm = a.sgbstdn_pidm
               AND shrlgpa_levl_code = sgbstdn_levl_code
               AND shrlgpa_gpa_type_ind = 'O') earned_hours ,f_disconnect_term_count(sgbstdn_pidm) disconnected_period
  FROM sgbstdn a
 WHERE     f_get_std_id(sgbstdn_pidm) IN ('434016332')
             /* ('433005847',
               '432000481',
               '434016496',
               '432011645',
               '434017316')*/
       AND sgbstdn_term_code_eff =
              (SELECT MAX (b.sgbstdn_term_code_eff)
                 FROM sgbstdn b
                WHERE     b.sgbstdn_pidm = a.sgbstdn_pidm
                      AND b.sgbstdn_term_code_eff <=
                             f_get_param ('WORKFLOW', 'CURRENT_TERM', 1));
                             
                             
                             ----------------student info 
                             
                             /* Formatted on 2/9/2020 10:25:16 AM (QP5 v5.227.12220.39754) */
  SELECT f_getspridenid (sgbstdn_pidm) student_id,
         f_format_name (sgbstdn_pidm, 'FML') student_name,
         (SELECT spbpers_ssn
            FROM spbpers
           WHERE spbpers_pidm = sgbstdn_pidm)
            student_ssn,
         (SELECT DECODE (SPBPERS_SEX, 'M', 'ÐßÑ', 'ÃäËì')
            FROM spbpers
           WHERE spbpers_pidm = sgbstdn_pidm)
            sex,
         f_get_desc_fnc ('STVSTST', sgbstdn_stst_code, 60) status,
         f_get_desc_fnc ('STVCOLL', sgbstdn_coll_code_1, 60) college,
         sgbstdn_dept_code dept,
         f_get_desc_fnc ('STVDEPT', sgbstdn_dept_code, 60) department,
         SG.SGBSTDN_CAMP_CODE camp_code,
         f_get_desc_fnc ('STVCAMP', sgbstdn_camp_code, 60) campus,
         sgbstdn_majr_code_1 major_code,
         f_get_desc_fnc ('STVMAJR', sgbstdn_majr_code_1, 60) major,
         SG.SGBSTDN_PROGRAM_1 program_code,
         SMRPRLE_PROGRAM_DESC program_desc
    FROM SGBSTDN SG, smrprle
   WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                        FROM SGBSTDN
                                       WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
         AND SGBSTDN_STST_CODE IN ('AS')
         AND SGBSTDN_DEGC_CODE_1 IN ('ÏÈ')
         AND SGBSTDN_TERM_CODE_ADMIT != '144020'
         AND smrprle_program = SG.SGBSTDN_PROGRAM_1
         AND NOT EXISTS
                    (SELECT 'c'
                       FROM sprhold
                      WHERE     SPRHOLD_HLDD_CODE = 'RH'
                            AND sprhold_pidm = SGBSTDN_PIDM)
ORDER BY PROGRAM_CODE, sgbstdn_camp_code