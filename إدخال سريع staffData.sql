/* Formatted on 4/20/2022 10:37:38 AM (QP5 v5.371) */
-- check if exists before addind 

SELECT f_get_std_id (spbpers_pidm)       stid,
       f_get_std_name (spbpers_pidm)     std_name
  FROM spbpers
 WHERE     spbpers_ssn LIKE '%1078839584%'
       AND NOT EXISTS
               (SELECT '1'
                  FROM sgbstdn
                 WHERE sgbstdn_pidm = spbpers_pidm);


DECLARE
    v_STAFF_ID       VARCHAR2 (100) := TRIM ( :STAFF_ID);
    v_FIRST_NAME     VARCHAR2 (100) := TRIM ( :FIRST_NAME);
    v_SECOND_NAME    VARCHAR2 (100) := TRIM ( :SECOND_NAME);
    v_THIRD_NAME     VARCHAR2 (100) := TRIM ( :THIRD_NAME);
    v_FAMILY_NAME    VARCHAR2 (100) := TRIM ( :FAMILY_NAME);
    v_STAFF_MAIL     VARCHAR2 (100) := TRIM ( :STAFF_MAIL);
    v_userName       VARCHAR2 (100) := TRIM ( :USERNAME);
    v_STAFF_SSN      VARCHAR2 (100) := TRIM ( :STAFF_SSN);
    v_STAFF_GENDER   VARCHAR2 (100) := TRIM ( :STAFF_GENDER);
    V_STAFF_PHONE    VARCHAR2 (100) := TRIM ( :V_STAFF_PHONE);
    V_COLL           VARCHAR2 (4) := TRIM ( :V_COLLEGE);
    V_DEPT           VARCHAR2 (4) := TRIM ( :V_DEPT);
    v_pidm           NUMBER (9);

    CURSOR does_it_exist_cur IS
        SELECT '1'
          FROM spriden
         WHERE spriden_id = v_STAFF_ID;

    CURSOR does_it_exist_cur2 IS
        SELECT '1'
          FROM ERP_STAFF
         WHERE STAFF_ID = v_STAFF_ID;

    l_check1         NUMBER := 0;
    l_check2         NUMBER := 0;
BEGIN
    OPEN does_it_exist_cur;

    FETCH does_it_exist_cur INTO l_check1;

    CLOSE does_it_exist_cur;

    IF l_check1 = 1
    THEN
        DBMS_OUTPUT.PUT_LINE ('already exists in spriden');
        RETURN;
    END IF;

    OPEN does_it_exist_cur2;

    FETCH does_it_exist_cur2 INTO l_check2;

    CLOSE does_it_exist_cur2;

    IF l_check2 = 1
    THEN
        DBMS_OUTPUT.PUT_LINE ('already exists in ERP STAFF');
        RETURN;
    END IF;

    v_pidm := gb_common.f_generate_pidm;           -- f_get_pidm (v_STAFF_ID);


    INSERT INTO SATURN.SPRIDEN (SPRIDEN_PIDM,
                                SPRIDEN_ID,
                                SPRIDEN_LAST_NAME,
                                SPRIDEN_FIRST_NAME,
                                SPRIDEN_MI,
                                SPRIDEN_ENTITY_IND,
                                SPRIDEN_ACTIVITY_DATE,
                                SPRIDEN_USER,
                                SPRIDEN_SEARCH_LAST_NAME,
                                SPRIDEN_SEARCH_FIRST_NAME,
                                SPRIDEN_SEARCH_MI,
                                SPRIDEN_CREATE_USER,
                                SPRIDEN_CREATE_DATE,
                                SPRIDEN_DATA_ORIGIN)
         VALUES (v_pidm,
                 v_STAFF_ID,
                 v_THIRD_NAME || ' ' || v_FAMILY_NAME,
                 v_FIRST_NAME,
                 v_SECOND_NAME,
                 'P',
                 SYSDATE,
                 'BU_APPS',
                 v_THIRD_NAME || ' ' || v_FAMILY_NAME,
                 v_FIRST_NAME,
                 v_SECOND_NAME,
                 'BU_APPS',
                 SYSDATE,
                 'Banner');

    INSERT INTO BU_APPS.ERP_STAFF (STAFF_ID,
                                   FIRST_NAME,
                                   SECOND_NAME,
                                   THIRD_NAME,
                                   FAMILY_NAME,
                                   STAFF_SSN,
                                   STAFF_MAIL,
                                   STAFF_GENDER,
                                   STAFF_MOBILE,
                                   DATA_SOURCE)
         VALUES (v_STAFF_ID,
                 v_FIRST_NAME,
                 v_SECOND_NAME,
                 v_THIRD_NAME,
                 v_FAMILY_NAME,
                 v_STAFF_SSN,
                 v_STAFF_MAIL,
                 v_STAFF_GENDER,
                 V_STAFF_PHONE,
                 'Tasaheel');

    INSERT INTO SATURN.SPBPERS (SPBPERS_PIDM,
                                SPBPERS_SSN,
                                SPBPERS_MRTL_CODE,
                                SPBPERS_RELG_CODE,
                                SPBPERS_SEX,
                                SPBPERS_CONFID_IND,
                                SPBPERS_ACTIVITY_DATE,
                                SPBPERS_CITZ_CODE,
                                SPBPERS_DATA_ORIGIN,
                                SPBPERS_USER_ID,
                                SPBPERS_ARMED_SERV_MED_VET_IND)
         VALUES (v_pidm,
                 v_STAFF_SSN,
                 '',
                 '',
                 v_STAFF_GENDER,
                 'N',
                 SYSDATE,
                 '',
                 'Banner',
                 'BU_APPS',
                 'N');


    INSERT INTO GENERAL.GOREMAL (GOREMAL_PIDM,
                                 GOREMAL_EMAL_CODE,
                                 GOREMAL_EMAIL_ADDRESS,
                                 GOREMAL_STATUS_IND,
                                 GOREMAL_PREFERRED_IND,
                                 GOREMAL_ACTIVITY_DATE,
                                 GOREMAL_USER_ID,
                                 GOREMAL_DISP_WEB_IND,
                                 GOREMAL_DATA_ORIGIN)
         VALUES (v_pidm,
                 'BU',
                 v_STAFF_MAIL,
                 'A',
                 'Y',
                 SYSDATE,
                 'BU_APPS',
                 'Y',
                 'Banner');


    INSERT INTO SATURN.SPRTELE (SPRTELE_PIDM,
                                SPRTELE_SEQNO,
                                SPRTELE_TELE_CODE,
                                SPRTELE_ACTIVITY_DATE,
                                SPRTELE_ATYP_CODE,
                                SPRTELE_INTL_ACCESS,
                                SPRTELE_DATA_ORIGIN,
                                SPRTELE_USER_ID)
         VALUES (v_pidm,
                 1,
                 'MO',
                 SYSDATE,
                 'œ„',
                 '966' || v_staff_phone,
                 'Banner',
                 'BU_APPS');



    INSERT INTO SATURN.SIBINST (SIBINST_PIDM,
                                SIBINST_TERM_CODE_EFF,
                                SIBINST_FCST_CODE,
                                SIBINST_SCHD_IND,
                                SIBINST_ADVR_IND,
                                SIBINST_FCST_DATE,
                                SIBINST_ACTIVITY_DATE,
                                SIBINST_DATA_ORIGIN,
                                SIBINST_USER_ID,
                                SIBINST_OVERRIDE_PROCESS_IND)
         VALUES (v_pidm,
                 '144320',
                 '‰',
                 'Y',
                 'Y',
                 SYSDATE,
                 SYSDATE,
                 'Banner',
                 'SAISUSR',
                 'N');


    INSERT INTO SATURN.SIRDPCL (SIRDPCL_PIDM,
                                SIRDPCL_TERM_CODE_EFF,
                                SIRDPCL_COLL_CODE,
                                SIRDPCL_DEPT_CODE,
                                SIRDPCL_HOME_IND,
                                SIRDPCL_ACTIVITY_DATE)
         VALUES (v_pidm,
                 '144320',
                 v_coll,
                 v_dept,
                 'Y',
                 SYSDATE);



    UPDATE GOBTPAC
       SET GOBTPAC_LDAP_USER = UPPER (v_userName),
           GOBTPAC_PIN_EXP_DATE = GOBTPAC_PIN_EXP_DATE + 3650
     WHERE GOBTPAC_pidm = v_pidm;


    INSERT INTO GENERAL.GOBANSR (GOBANSR_PIDM,
                                 GOBANSR_NUM,
                                 GOBANSR_GOBQSTN_ID,
                                 GOBANSR_ANSR_DESC,
                                 GOBANSR_ANSR_SALT,
                                 GOBANSR_USER_ID,
                                 GOBANSR_DATA_ORIGIN,
                                 GOBANSR_ACTIVITY_DATE)
         VALUES (v_pidm,
                 1,
                 '1',
                 v_STAFF_SSN,
                 v_STAFF_SSN,
                 'SAISUSR',
                 'Banner',
                 SYSDATE);


    DBMS_OUTPUT.PUT_LINE ('Added Successfully with pidm' || v_pidm);
END;