/* Formatted on 8/24/2020 3:20:55 PM (QP5 v5.360) */
DECLARE
    CURSOR get_std IS SELECT col01 FROM bu_dev.tmp_tbl03
    ;

    i_initiator_pidm   NUMBER;
    l_reply_code       VARCHAR2 (150);
    l_reply_message    VARCHAR2 (400);
BEGIN
    FOR rec IN get_std
    LOOP
        i_initiator_pidm := rec.col01;
        DBMS_OUTPUT.put_line (
                '  student'
            || f_get_std_id (i_initiator_pidm));
        p_update_student_status (i_initiator_pidm,
                                 '144210',
                                 'AS',
                                 'WORKFLOW',
                                 l_reply_code,
                                 l_reply_message);
        DBMS_OUTPUT.put_line (
               l_reply_message
            || l_reply_code
            || 'for student'
            || f_get_std_id (i_initiator_pidm));

        UPDATE sgbstdn
           SET SGBSTDN_ASTD_CODE = 'Ý1', SGBSTDN_TERM_CODE_ASTD = '144210'
         WHERE     sgbstdn_pidm = i_initiator_pidm
               AND sgbstdn_term_code_eff = '144210';

        UPDATE sfbetrm
           SET SFBETRM_MHRS_OVER = '14'
         WHERE     sfbetrm_pidm = i_initiator_pidm
               AND sfbetrm_term_code = '144210';

        IF SQL%NOTFOUND
        THEN
            INSERT INTO SATURN.SFBETRM (SFBETRM_TERM_CODE,
                                        SFBETRM_PIDM,
                                        SFBETRM_ESTS_CODE,
                                        SFBETRM_ESTS_DATE,
                                        SFBETRM_MHRS_OVER,
                                        SFBETRM_AR_IND,
                                        SFBETRM_ADD_DATE,
                                        SFBETRM_ACTIVITY_DATE,
                                        SFBETRM_USER,
                                        SFBETRM_DATA_ORIGIN,
                                        SFBETRM_MIN_HRS,
                                        SFBETRM_MINH_SRCE_CDE,
                                        SFBETRM_MAXH_SRCE_CDE)
                 VALUES ('144210',
                         i_initiator_pidm,
                         'EL',
                         SYSDATE,
                         '14',
                         'N',
                         SYSDATE,
                         SYSDATE,
                         USER,
                         'WORKFLOW:',
                         0,
                         '',
                         '');
        END IF;
    END LOOP;
END;