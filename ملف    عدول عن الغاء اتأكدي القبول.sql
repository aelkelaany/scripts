/* Formatted on 26/08/2021 17:25:30 (QP5 v5.371) */
DECLARE
COUNTER NUMBER;
    CURSOR GET_DATA IS
          SELECT student_ssn SSN,
                 student_pidm PIDM ,
                 FIRST_NAME_AR || ' ' || MIDDLE_NAME_AR || ' ' || LAST_NAME_AR
                     stName,
                 (SELECT f_get_program_full_desc ('144310', APPLICANT_CHOICE)
                    FROM VW_APPLICANT_CHOICES
                   WHERE     APPLICANT_DECISION = 'CA'
                         AND ADMISSION_TYPE = 'UG'
                         AND applicant_pidm = student_pidm)
                     description
            FROM BU_APPS.STU_MAIN_DATA_VW v
           WHERE EXISTS
                     (SELECT '1'
                        FROM ADM_RECONFIRM_ADM_REQUEST
                       WHERE STUDENT_PIDM = v.STUDENT_PIDM)
        ORDER BY 4;
BEGIN
    FOR REC IN GET_DATA
    LOOP
        DELETE FROM SARAPPD
              WHERE     sarappd_pidm = REC.PIDM
                    AND SARAPPD_APDC_CODE IN ('CM',
                                              'CA',
                                              'WM',
                                              'WA',
                                              'CU');

        COUNTER := SQL%ROWCOUNT;
  

        DBMS_OUTPUT.put_line (COUNTER || '  ' || REC.SSN);
        COUNTER := 0;
              BEGIN
        INSERT INTO adm_student_confirmation(ADMIT_TERM, APPLICANT_PIDM, ACTIVITY_DATE, USER_ID)
VALUES ('144310',REC.PIDM,SYSDATE,USER);
EXCEPTION WHEN DUP_VAL_ON_INDEX THEN 
  DBMS_OUTPUT.put_line (  ' cONFIRMED BEFORE ' || REC.SSN);
END ;
    END LOOP;
END;