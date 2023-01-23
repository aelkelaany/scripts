/* Formatted on 12/29/2022 1:40:35 PM (QP5 v5.371) */
DECLARE
    P_SSN               VARCHAR2 (10) := '1107772814';
    P_ID                VARCHAR2 (10) := '439003748';
    P_STATUS            VARCHAR2 (50);
    P_ERROR_MESSAGE     VARCHAR2 (150);
    P_FULL_NAME         VARCHAR2 (150);
    P_GENDER            VARCHAR2 (50);
    P_MOBILE            VARCHAR2 (50);
    P_BIRTH_DATE        VARCHAR2 (50);
    P_COLLEGE           VARCHAR2 (50);
    P_MAJOR             VARCHAR2 (50);
    P_GPA               VARCHAR2 (50);
    P_GRADUATION_DATE   VARCHAR2 (50);
    P_EVALUATION        VARCHAR2 (50);
BEGIN
    WSO2ESB.P_GET_GRADUATE_INFO (P_SSN,
                                 P_ID,
                                 P_STATUS,
                                 P_ERROR_MESSAGE,
                                 P_FULL_NAME,
                                 P_GENDER,
                                 P_MOBILE,
                                 P_BIRTH_DATE,
                                 P_COLLEGE,
                                 P_MAJOR,
                                 P_GPA,
                                 P_GRADUATION_DATE,
                                 P_EVALUATION);

    DBMS_OUTPUT.put_line (
           ' P_STATUS  '
        || P_STATUS
        || '
   '
        || 'P_ERROR_MESSAGE '
        || P_ERROR_MESSAGE
        || '
   '
        || 'P_FULL_NAME '
        || P_FULL_NAME
        || '
   '
        || 'P_GENDER '
        || P_GENDER
        || '
        '
        || 'P_MOBILE '
        || P_MOBILE
        || '
   '
        || 'P_BIRTH_DATE '
        || P_BIRTH_DATE
        || '
   '
        || 'P_COLLEGE '
        || P_COLLEGE
        || '
   '
        || 'P_MAJOR '
        || P_MAJOR
        || '
   '
        || 'P_GPA '
        || P_GPA
        || '
   '
        || 'P_GRADUATION_DATE '
        || P_GRADUATION_DATE
        || '
   '
        || 'P_EVALUATION '
        || P_EVALUATION);
END;