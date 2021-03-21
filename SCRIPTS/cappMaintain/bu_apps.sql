DROP PACKAGE BU_APPS.CAPP_MANIPULATION_FUNCTIONAL;

--
-- CAPP_MANIPULATION_FUNCTIONAL  (Package) 
--
CREATE OR REPLACE PACKAGE BU_APPS.CAPP_MANIPULATION_FUNCTIONAL
IS
    --To get programs definition to start process
    CURSOR PROGRAMS_DEF_CUR (P_PROGRAM_CODE    VARCHAR2,
                             P_TERM_CODE_EFF   VARCHAR2)
    IS
        SELECT PROGRAM_CODE, TERM_CODE_EFF, RULE_CODE
          FROM PROGRAM_DEFINITION
         WHERE     ACTIVE_IND = 'Y'
               AND PROGRAM_CODE =P_PROGRAM_CODE
               AND TERM_CODE_EFF =P_TERM_CODE_EFF;

    -- TO GET_CAPP COURSES
    CURSOR CAPP_COURSES_CUR (P_PROGRAM_CODE    VARCHAR2,
                             P_TERM_CODE_EFF   VARCHAR2)
    IS
        SELECT PROGRAM_CODE,
               TERM_CODE_EFF,
               AREA_CODE,
               SUBJ_CODE,
               CRSE_NUMB,
               REQUIRED_IND
          FROM PROGRAM_COURSES
         WHERE     PROGRAM_COURSES.PROGRAM_CODE = P_PROGRAM_CODE
               AND PROGRAM_COURSES.TERM_CODE_EFF = P_TERM_CODE_EFF;

    -- TO_GET_EQUIVALENT COURSE
    CURSOR CAPP_EQVLNT_CUR (P_PROGRAM_CODE    VARCHAR2,
                            P_TERM_CODE_EFF   VARCHAR2,
                            P_AREA_CODE       VARCHAR2,
                            P_SUBJ_CODE       VARCHAR2,
                            P_CRSE_NUMB       VARCHAR2)
    IS
        SELECT *
          FROM PROGRAM_EQUV_COURSES
         WHERE     PROGRAM_CODE = P_PROGRAM_CODE
               AND TERM_CODE_EFF = P_TERM_CODE_EFF
               AND AREA_CODE = P_AREA_CODE
               AND COURSE_SUBJ_CODE = P_SUBJ_CODE
               AND COURSE_CRSE_NUMB = P_CRSE_NUMB;

    -- TO_GET_STUDENT_PASSED_COURSES
    CURSOR STDNT_PASSED_CRSE_CUR (
        P_PIDM        SHRTCKN.SHRTCKN_PIDM%TYPE,
        P_SUB_CODE    SHRTCKN.SHRTCKN_SUBJ_CODE%TYPE,
        P_CRSE_NUMB   SHRTCKN.SHRTCKN_CRSE_NUMB%TYPE)
    IS
        SELECT SHRTCKN_TERM_CODE,
               SHRTCKN_SUBJ_CODE           SUBJ,
               SHRTCKN_CRSE_NUMB           CRSE,
               SCBCRSE_TITLE               TITLE,
               SHRTCKG_GRDE_CODE_FINAL     GRADE,
               SHRTCKG_CREDIT_HOURS        HOURS
          FROM SHRTCKN,
               SGBSTDN  A,
               SHRTCKG  G1,
               SCBCRSE  C1
         WHERE     A.SGBSTDN_PIDM = SHRTCKN_PIDM
               AND SHRTCKN_SUBJ_CODE  LIKE NVL(P_SUB_CODE,'%')
               AND SHRTCKN_CRSE_NUMB  LIKE NVL(P_CRSE_NUMB,'%')
               AND A.SGBSTDN_TERM_CODE_EFF =
                   (SELECT MAX (B.SGBSTDN_TERM_CODE_EFF)
                      FROM SGBSTDN B
                     WHERE B.SGBSTDN_PIDM = A.SGBSTDN_PIDM)
               AND SHRTCKN_PIDM = G1.SHRTCKG_PIDM
               AND G1.SHRTCKG_TERM_CODE = SHRTCKN_TERM_CODE
               AND G1.SHRTCKG_TCKN_SEQ_NO = SHRTCKN_SEQ_NO
               AND G1.SHRTCKG_SEQ_NO =
                   (SELECT MAX (G2.SHRTCKG_SEQ_NO)
                      FROM SHRTCKG G2
                     WHERE     G2.SHRTCKG_PIDM = SHRTCKN_PIDM
                           AND G2.SHRTCKG_TERM_CODE = SHRTCKN_TERM_CODE
                           AND G2.SHRTCKG_TCKN_SEQ_NO = SHRTCKN_SEQ_NO)
               AND C1.SCBCRSE_SUBJ_CODE = SHRTCKN_SUBJ_CODE
               AND C1.SCBCRSE_CRSE_NUMB = SHRTCKN_CRSE_NUMB
               AND C1.SCBCRSE_EFF_TERM =
                   (SELECT MAX (C2.SCBCRSE_EFF_TERM)
                      FROM SCBCRSE C2
                     WHERE     C2.SCBCRSE_SUBJ_CODE = C1.SCBCRSE_SUBJ_CODE
                           AND C2.SCBCRSE_CRSE_NUMB = C1.SCBCRSE_CRSE_NUMB
                           AND C2.SCBCRSE_EFF_TERM <= SHRTCKN_TERM_CODE)
               AND SHRTCKN_PIDM = P_PIDM
               AND COURSE_PASSED (SHRTCKN_PIDM,
                                  SHRTCKN_SUBJ_CODE,
                                  SHRTCKN_CRSE_NUMB) =
                   'P'
               AND EXISTS
                       (SELECT 1
                          FROM SHRGRDE R1
                         WHERE     SHRGRDE_CODE = G1.SHRTCKG_GRDE_CODE_FINAL
                               AND SHRGRDE_LEVL_CODE = SGBSTDN_LEVL_CODE
                               AND SHRGRDE_TERM_CODE_EFFECTIVE =
                                   (SELECT MAX (
                                               R2.SHRGRDE_TERM_CODE_EFFECTIVE)
                                      FROM SHRGRDE R2
                                     WHERE     R1.SHRGRDE_CODE =
                                               R2.SHRGRDE_CODE
                                           AND R1.SHRGRDE_LEVL_CODE =
                                               R2.SHRGRDE_LEVL_CODE)
                               AND SHRGRDE_PASSED_IND = 'Y');

    -- TO GET ALREADY FETCHED AND LOGGED PIDMS TO BE PROCESSED
    CURSOR GET_LOGGED_PIDMS (P_PROCESS_ID NUMBER)
    IS
        SELECT PROGRAM_CODE, PROGRAM_TERM_CODE_EFF, STD_PIDM
          FROM CAPP_MNPL_LOG_HEADER
         WHERE PROCESS_ID = P_PROCESS_ID;

    -- Collect data from detail log to be processed IN SMRSSUB TABLE
    CURSOR GET_IEQ_FIT_DATA_CUR (P_PROCESS_ID NUMBER)
    IS
        SELECT *
          FROM CAPP_MNPL_LOG_DETAIL
         WHERE     PROCESS_ID = P_PROCESS_ID
               AND MAPPING_SUCCESS_IND = 'Y'
               AND GRDE_CODE_FINAL != 'ãÚ';

    PROCEDURE LOG_MAIN_INSERT (
        LOG_MAIN_REC    IN     CAPP_MNPL_LOG_MAIN%ROWTYPE,
        REPLY_CODE         OUT VARCHAR2,
        REPLY_MESSAGE      OUT VARCHAR2);

    PROCEDURE LOG_HEADER_INSERT (
        LOG_HEADER_REC   IN     CAPP_MNPL_LOG_HEADER%ROWTYPE,
        REPLY_CODE          OUT VARCHAR2,
        REPLY_MESSAGE       OUT VARCHAR2);

    PROCEDURE LOG_HEADER_CRSE_INCREMNT (
        P_PROCESS_ID   IN CAPP_MNPL_LOG_HEADER.PROCESS_ID%TYPE,
        P_STD_PIDM     IN CAPP_MNPL_LOG_HEADER.STD_PIDM%TYPE,
        P_CRSE_HR      IN CAPP_MNPL_LOG_HEADER.TOTAL_PROCESSED_HRS%TYPE);

    PROCEDURE LOG_DETAIL_INSERT (
        LOG_DETAIL_REC   IN     CAPP_MNPL_LOG_DETAIL%ROWTYPE,
        REPLY_CODE          OUT VARCHAR2,
        REPLY_MESSAGE       OUT VARCHAR2);

    PROCEDURE LOG_NOT_USED_INSERT (P_PROCESS_ID    IN     NUMBER,
                                   REPLY_CODE         OUT VARCHAR2,
                                   REPLY_MESSAGE      OUT VARCHAR2);

    PROCEDURE set_table_target (p_PROCESS_ID   IN NUMBER,
                                p_STD_PIDM     IN NUMBER,
                                p_SEQNO        IN NUMBER,
                                p_target          VARCHAR2);

    PROCEDURE LOG_DELETE (P_PROCESS_ID IN CAPP_MNPL_LOG_MAIN.PROCESS_ID%TYPE);

    PROCEDURE FETCH_PROGRAMS_DATA (P_PROCESS_ID              IN     NUMBER,
                                   P_PROGRAM_CODE                   VARCHAR2,
                                   P_PROGRAM_TERM_CODE_EFF          VARCHAR2, P_PPIDM NUMBER DEFAULT NULL ,
                                   REPLY_CODE                   OUT VARCHAR2,
                                   REPLY_MESSAGE                OUT VARCHAR2);

    PROCEDURE FETCH_RULE_DATA (P_PROCESS_ID              IN     NUMBER,
                               P_PROGRAM_CODE                   VARCHAR2,
                               P_PROGRAM_TERM_CODE_EFF          VARCHAR2,  P_PPIDM NUMBER DEFAULT NULL ,
                               REPLY_CODE                   OUT VARCHAR2,
                               REPLY_MESSAGE                OUT VARCHAR2);


    PROCEDURE FILL_LOG_FETCHED_DATA (
        P_PROCESS_ID              IN     NUMBER,
        P_PIDM                           NUMBER,
        P_PROGRAM_CODE                   VARCHAR2,
        P_PROGRAM_TERM_CODE_EFF          VARCHAR2,
        reply_code                   OUT VARCHAR2,
        reply_message                OUT VARCHAR2);

    PROCEDURE VALIDATE_INSERT_SMRSSUB (
        CAPP_MNPL_LOG_DET_REC   IN     CAPP_MNPL_LOG_DETAIL%ROWTYPE,
        reply_code                 OUT VARCHAR2,
        reply_message              OUT VARCHAR2);

    PROCEDURE VALIDATE_INSERT_SHRTRCE (P_PROCESS_ID        NUMBER,
                                       reply_code      OUT VARCHAR2,
                                       reply_message   OUT VARCHAR2);

    PROCEDURE REPLACE_PROGRAM (P_PROCESS_ID        NUMBER,
                               reply_code      OUT VARCHAR2,
                               reply_message   OUT VARCHAR2);

    FUNCTION CHECK_COURSE_FIT (P_PIDM        SHRTCKN.SHRTCKN_PIDM%TYPE,
                               P_SUB_CODE    SHRTCKN.SHRTCKN_SUBJ_CODE%TYPE,
                               P_CRSE_NUMB   SHRTCKN.SHRTCKN_CRSE_NUMB%TYPE)
        RETURN CHAR;

    FUNCTION check_previous_fit (
        P_PROCESS_ID   NUMBER,
        P_PIDM         SHRTCKN.SHRTCKN_PIDM%TYPE,
        P_SUB_CODE     SHRTCKN.SHRTCKN_SUBJ_CODE%TYPE,
        P_CRSE_NUMB    SHRTCKN.SHRTCKN_CRSE_NUMB%TYPE)
        RETURN VARCHAR2;

    FUNCTION GET_NEW_PROCESS_ID
        RETURN NUMBER;

    FUNCTION F_GET_CRSE_CREDIT_HR (P_SUBJ_CODE   VARCHAR2,
                                   P_CRSE_NUMB   VARCHAR2)
        RETURN NUMBER;

    FUNCTION F_GET_CRSE_TITLE (P_SUBJ_CODE VARCHAR2, P_CRSE_NUMB VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION F_GET_FINAL_GRADE (P_STD_PIDM    NUMBER,
                                P_SUBJ_CODE   VARCHAR2,
                                P_CRSE_NUMB   VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION F_CHECK_CRSE_SUB_INT (P_PROGRAM                 VARCHAR2,
                                   P_PROGRAM_TERM_CODE_EFF   VARCHAR2,
                                   P_STD_PIDM                NUMBER,
                                   P_SUBJ_CODE               VARCHAR2,
                                   P_CRSE_NUMB               VARCHAR2)
        RETURN VARCHAR2;

    FUNCTION F_CHECK_CRSE_SUB_EXT (P_STD_PIDM    NUMBER,
                                   P_SUBJ_CODE   VARCHAR2,
                                   P_CRSE_NUMB   VARCHAR2)
        RETURN VARCHAR2;
END;
/
DROP PACKAGE BODY BU_APPS.CAPP_MANIPULATION_FUNCTIONAL;

--
-- CAPP_MANIPULATION_FUNCTIONAL  (Package Body) 
--
CREATE OR REPLACE PACKAGE BODY BU_APPS.CAPP_MANIPULATION_FUNCTIONAL
IS
    PROCEDURE LOG_MAIN_INSERT (
        LOG_MAIN_REC    IN     CAPP_MNPL_LOG_MAIN%ROWTYPE,
        REPLY_CODE         OUT VARCHAR2,
        REPLY_MESSAGE      OUT VARCHAR2)
    IS
    BEGIN
        INSERT INTO CAPP_MNPL_LOG_MAIN (PROCESS_ID,
                                        PROCESS_PURPOSE_IND,
                                        RUNNING_DATE,
                                        USER_ID,
                                        PROCESS_TERMINATION_STATUS,
                                        PROCESS_TERMINATION_MESSAGE,
                                        PROGRAM_CODE,
                                        PROGRAM_TERM_CODE_EFF)
             VALUES (LOG_MAIN_REC.PROCESS_ID,
                     LOG_MAIN_REC.PROCESS_PURPOSE_IND,
                     LOG_MAIN_REC.RUNNING_DATE,
                     LOG_MAIN_REC.USER_ID,
                     LOG_MAIN_REC.PROCESS_TERMINATION_STATUS,
                     '',
                     LOG_MAIN_REC.PROGRAM_CODE,
                     LOG_MAIN_REC.PROGRAM_TERM_CODE_EFF);

        REPLY_CODE := '0';
        REPLY_MESSAGE := 'PROCESS MAIN DATA HAS BEEN LOGGED';
    EXCEPTION
        WHEN OTHERS
        THEN
            REPLY_CODE := 90;
            REPLY_MESSAGE := SQLERRM;
    END LOG_MAIN_INSERT;

    PROCEDURE LOG_HEADER_INSERT (
        LOG_HEADER_REC   IN     CAPP_MNPL_LOG_HEADER%ROWTYPE,
        REPLY_CODE          OUT VARCHAR2,
        REPLY_MESSAGE       OUT VARCHAR2)
    IS
    BEGIN
        INSERT INTO CAPP_MNPL_LOG_HEADER (PROCESS_ID,
                                          PROGRAM_CODE,
                                          PROGRAM_TERM_CODE_EFF,
                                          STD_PIDM,
                                          TOTAL_PROCESSED_CRSE,
                                          TOTAL_PROCESSED_HRS)
             VALUES (LOG_HEADER_REC.PROCESS_ID,
                     LOG_HEADER_REC.PROGRAM_CODE,
                     LOG_HEADER_REC.PROGRAM_TERM_CODE_EFF,
                     LOG_HEADER_REC.STD_PIDM,
                     LOG_HEADER_REC.TOTAL_PROCESSED_CRSE,
                     LOG_HEADER_REC.TOTAL_PROCESSED_HRS);

        REPLY_CODE := 0;
        REPLY_MESSAGE := '';
    EXCEPTION
        WHEN OTHERS
        THEN
            REPLY_CODE := 90;

            REPLY_MESSAGE := SQLERRM;
    END LOG_HEADER_INSERT;

    PROCEDURE LOG_HEADER_CRSE_INCREMNT (
        P_PROCESS_ID   IN CAPP_MNPL_LOG_HEADER.PROCESS_ID%TYPE,
        P_STD_PIDM     IN CAPP_MNPL_LOG_HEADER.STD_PIDM%TYPE,
        P_CRSE_HR      IN CAPP_MNPL_LOG_HEADER.TOTAL_PROCESSED_HRS%TYPE)
    IS
    BEGIN
        UPDATE CAPP_MNPL_LOG_HEADER
           SET TOTAL_PROCESSED_CRSE = TOTAL_PROCESSED_CRSE + 1,
               TOTAL_PROCESSED_HRS = TOTAL_PROCESSED_HRS + P_CRSE_HR
         WHERE PROCESS_ID = P_PROCESS_ID AND STD_PIDM = P_STD_PIDM;
    END LOG_HEADER_CRSE_INCREMNT;

    PROCEDURE LOG_DETAIL_INSERT (
        LOG_DETAIL_REC   IN     CAPP_MNPL_LOG_DETAIL%ROWTYPE,
        REPLY_CODE          OUT VARCHAR2,
        REPLY_MESSAGE       OUT VARCHAR2)
    IS
    BEGIN
        INSERT INTO CAPP_MNPL_LOG_DETAIL (PROCESS_ID,
                                          STD_PIDM,
                                          SEQNO,
                                          LHS_SUBJ_CODE,
                                          LHS_CRSE_NUMB,
                                          LHS_CREDIT_HR,
                                          REQUIRED_IND,
                                          RHS_SUBJ_CODE,
                                          RHS_CRSE_NUMB,
                                          RHS_SEQNO,
                                          RHS_EQVLNT_HR,
                                          MAPPING_SUCCESS_IND,
                                          DATA_TARGET,
                                          GRDE_CODE_FINAL,
                                          FAILURE_MESSAGE)
             VALUES (LOG_DETAIL_REC.PROCESS_ID,
                     LOG_DETAIL_REC.STD_PIDM,
                     LOG_DETAIL_REC.SEQNO,
                     LOG_DETAIL_REC.LHS_SUBJ_CODE,
                     LOG_DETAIL_REC.LHS_CRSE_NUMB,
                     LOG_DETAIL_REC.LHS_CREDIT_HR,
                     LOG_DETAIL_REC.REQUIRED_IND,
                     LOG_DETAIL_REC.RHS_SUBJ_CODE,
                     LOG_DETAIL_REC.RHS_CRSE_NUMB,
                     LOG_DETAIL_REC.RHS_SEQNO,
                     LOG_DETAIL_REC.RHS_EQVLNT_HR,
                     LOG_DETAIL_REC.MAPPING_SUCCESS_IND,
                     LOG_DETAIL_REC.DATA_TARGET,
                     LOG_DETAIL_REC.GRDE_CODE_FINAL,
                     LOG_DETAIL_REC.FAILURE_MESSAGE);

        REPLY_CODE := 0;
        REPLY_MESSAGE := 'Ok';
    EXCEPTION
        WHEN OTHERS
        THEN
            REPLY_CODE := 90;

            REPLY_MESSAGE := SQLERRM;
    END LOG_DETAIL_INSERT;

    PROCEDURE LOG_NOT_USED_INSERT (P_PROCESS_ID    IN     NUMBER,
                                   REPLY_CODE         OUT VARCHAR2,
                                   REPLY_MESSAGE      OUT VARCHAR2)
    IS
        CURSOR CHECK_USED_CUR (P_STD_PIDM   NUMBER,
                               p_SUBJ       VARCHAR2,
                               P_CRSE       VARCHAR2)
        IS
            SELECT 'Y'
              FROM CAPP_MNPL_LOG_DETAIL
             WHERE     PROCESS_ID = P_PROCESS_ID
                   AND STD_PIDM = P_STD_PIDM
                   AND RHS_SUBJ_CODE = p_SUBJ
                   AND RHS_CRSE_NUMB = P_CRSE
                   AND ROWNUM < 2;

        L_SEQNO        NUMBER (3);
        L_CHECK_USED   CHAR;
    BEGIN
        FOR H_REC IN GET_LOGGED_PIDMS (P_PROCESS_ID)
        LOOP
           <<FETCH_DATA>>
            L_SEQNO := 1;

            FOR D_REC IN STDNT_PASSED_CRSE_CUR (H_REC.STD_PIDM, '', '')
            LOOP
               <<INSERT_DATA>>
                L_CHECK_USED := 'N';

                OPEN CHECK_USED_CUR (H_REC.STD_PIDM, D_REC.SUBJ, D_REC.CRSE);

                FETCH CHECK_USED_CUR INTO L_CHECK_USED;

                CLOSE CHECK_USED_CUR;

                IF L_CHECK_USED = 'N'
                THEN
                    INSERT INTO CAPP_MNPL_LOG_NOT_USED (PROCESS_ID,
                                                        STD_PIDM,
                                                        SEQNO,
                                                        SUBJ_CODE,
                                                        CRSE_NUMB,
                                                        credit_hours,
                                                        TITLE,
                                                        GRDE_CODE_FINAL)
                         VALUES (P_PROCESS_ID,
                                 H_REC.STD_PIDM,
                                 L_SEQNO,
                                 D_REC.SUBJ,
                                 D_REC.CRSE,
                                 d_rec.HOURS,
                                 D_REC.TITLE,
                                 D_REC.GRADE);

                    L_SEQNO := L_SEQNO + 1;
                END IF;
            END LOOP;
        END LOOP;

        REPLY_CODE := '0';
        REPLY_MESSAGE := '';
    EXCEPTION
        WHEN OTHERS
        THEN
            REPLY_CODE := 90;

            REPLY_MESSAGE := SQLERRM;
    END LOG_NOT_USED_INSERT;

    PROCEDURE set_table_target (p_PROCESS_ID   IN NUMBER,
                                p_STD_PIDM     IN NUMBER,
                                p_SEQNO        IN NUMBER,
                                p_target          VARCHAR2)
    IS
    BEGIN
        UPDATE CAPP_MNPL_LOG_detail
           SET DATA_TARGET = p_target
         WHERE     PROCESS_ID = p_PROCESS_ID
               AND STD_PIDM = p_STD_PIDM
               AND SEQNO = p_SEQNO;
    END set_table_target;

    PROCEDURE LOG_DELETE (P_PROCESS_ID IN CAPP_MNPL_LOG_MAIN.PROCESS_ID%TYPE)
    IS
    BEGIN
        DELETE CAPP_MNPL_LOG_NOT_USED
         WHERE PROCESS_ID = P_PROCESS_ID;

        DELETE CAPP_MNPL_LOG_DETAIL
         WHERE PROCESS_ID = P_PROCESS_ID;

        DELETE CAPP_MNPL_LOG_HEADER
         WHERE PROCESS_ID = P_PROCESS_ID;

        DELETE CAPP_MNPL_LOG_MAIN
         WHERE PROCESS_ID = P_PROCESS_ID;
    END LOG_DELETE;

    PROCEDURE FETCH_PROGRAMS_DATA (
        P_PROCESS_ID              IN     NUMBER,
        P_PROGRAM_CODE                   VARCHAR2,
        P_PROGRAM_TERM_CODE_EFF          VARCHAR2,
        P_PPIDM                          NUMBER DEFAULT NULL,
        REPLY_CODE                   OUT VARCHAR2,
        REPLY_MESSAGE                OUT VARCHAR2)
    IS
        L_REPLY_CODE      VARCHAR2 (20);
        L_REPLY_MESSAGE   VARCHAR2 (400);
    BEGIN
        FOR PROGRAMS_DEF_REC
            IN PROGRAMS_DEF_CUR (P_PROGRAM_CODE, P_PROGRAM_TERM_CODE_EFF)
        LOOP
            FETCH_RULE_DATA (P_PROCESS_ID,
                             PROGRAMS_DEF_REC.PROGRAM_CODE,
                             PROGRAMS_DEF_REC.TERM_CODE_EFF,
                             P_PPIDM,
                             l_REPLY_CODE,
                             l_REPLY_MESSAGE);

            IF l_REPLY_CODE <> 0
            THEN
                REPLY_CODE := L_REPLY_CODE;
                REPLY_MESSAGE := L_REPLY_MESSAGE;
                RETURN;
            END IF;
        END LOOP;

        REPLY_CODE := '0';
        REPLY_MESSAGE := '';
    END FETCH_PROGRAMS_DATA;

    PROCEDURE FETCH_RULE_DATA (
        P_PROCESS_ID              IN     NUMBER,
        P_PROGRAM_CODE                   VARCHAR2,
        P_PROGRAM_TERM_CODE_EFF          VARCHAR2,
        P_PPIDM                          NUMBER DEFAULT NULL,
        REPLY_CODE                   OUT VARCHAR2,
        REPLY_MESSAGE                OUT VARCHAR2)
    IS
        CURSOR GET_PROGRAM_DATA IS
            SELECT PROGRAM_DEFINITION.RULE_CODE, SMRPRLE_LEVL_CODE
              FROM PROGRAM_DEFINITION, SMRPRLE
             WHERE     PROGRAM_DEFINITION.PROGRAM_CODE = SMRPRLE_PROGRAM
                   AND PROGRAM_DEFINITION.ACTIVE_IND = 'Y'
                   AND PROGRAM_DEFINITION.PROGRAM_CODE = P_PROGRAM_CODE
                   AND PROGRAM_DEFINITION.TERM_CODE_EFF =
                       P_PROGRAM_TERM_CODE_EFF;

        L_RULE_CODE       PROGRAM_DEFINITION.RULE_CODE%TYPE;
        L_LEVL_CODE       SMRPRLE.SMRPRLE_LEVL_CODE%TYPE;

        CURSOR GET_STUDENTS_CUR IS
            SELECT SGBSTDN_PIDM     PIDM
              FROM (SELECT F_CHECK_RULE (SGBSTDN_PIDM, L_RULE_CODE)     FUNC,
                           SGBSTDN_PIDM
                      FROM SGBSTDN X
                     WHERE     SGBSTDN_TERM_CODE_EFF =
                               (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                  FROM SGBSTDN D
                                 WHERE D.SGBSTDN_PIDM = X.SGBSTDN_PIDM)
                           AND SGBSTDN_LEVL_CODE = L_LEVL_CODE
                           AND (SGBSTDN_PIDM = P_PPIDM OR P_PPIDM = 0))
             WHERE FUNC = 'Y';

        CURSOR GET_ONE_STUDENT IS
            SELECT F_CHECK_RULE (P_PPIDM, L_RULE_CODE) FUNC FROM DUAL;

        L_ITERATOR        NUMBER (6) := 1;
        L_ONE_RESULT      CHAR := 'N';
        L_REPLY_CODE      VARCHAR2 (20);
        L_REPLY_MESSAGE   VARCHAR2 (400);
    BEGIN
        OPEN GET_PROGRAM_DATA;

        FETCH GET_PROGRAM_DATA INTO L_RULE_CODE, L_LEVL_CODE;

        IF GET_PROGRAM_DATA%NOTFOUND
        THEN
            REPLY_CODE := 50;
            REPLY_MESSAGE :=
                   'ÈíÇäÇÊ ÇáÈÑäÇãÌ ÇáãÏÎá ÛíÑ ÕÍíÍÉ'
                || '---'
                || P_PROGRAM_CODE;

            CLOSE GET_PROGRAM_DATA;

            RETURN;
        END IF;

        CLOSE GET_PROGRAM_DATA;

        IF P_PPIDM = 0
        THEN
            FOR REC IN GET_STUDENTS_CUR
            LOOP
                FILL_LOG_FETCHED_DATA (P_PROCESS_ID,
                                       REC.PIDM,
                                       P_PROGRAM_CODE,
                                       P_PROGRAM_TERM_CODE_EFF,
                                       l_REPLY_CODE,
                                       l_REPLY_MESSAGE);
                L_ITERATOR := L_ITERATOR + 1;
            END LOOP;
        ELSE
            OPEN GET_ONE_STUDENT;

            FETCH GET_ONE_STUDENT INTO L_ONE_RESULT;

            CLOSE GET_ONE_STUDENT;

            IF L_ONE_RESULT = 'Y'
            THEN
                FILL_LOG_FETCHED_DATA (P_PROCESS_ID,
                                       P_PPIDM,
                                       P_PROGRAM_CODE,
                                       P_PROGRAM_TERM_CODE_EFF,
                                       l_REPLY_CODE,
                                       l_REPLY_MESSAGE);
            ELSE
                REPLY_CODE := '99';
                REPLY_MESSAGE :=
                    'The Entered Student Doesn''t Match The Program Rule ...';
                RETURN;
            END IF;
        END IF;

        IF l_REPLY_CODE = 0
        THEN
            REPLY_CODE := 0;
            REPLY_MESSAGE := L_ITERATOR || ' Student Have Been Filled';
        ELSE
            REPLY_CODE := L_REPLY_CODE;
            REPLY_MESSAGE := L_REPLY_MESSAGE;
        END IF;

        DBMS_OUTPUT.PUT_LINE (
            'RULE_DATA' || REPLY_CODE || '-----' || REPLY_MESSAGE);
    END FETCH_RULE_DATA;

    PROCEDURE FILL_LOG_FETCHED_DATA (
        P_PROCESS_ID              IN     NUMBER,
        P_PIDM                           NUMBER,
        P_PROGRAM_CODE                   VARCHAR2,
        P_PROGRAM_TERM_CODE_EFF          VARCHAR2,
        REPLY_CODE                   OUT VARCHAR2,
        REPLY_MESSAGE                OUT VARCHAR2)
    IS
        LOG_HEADER_REC    CAPP_MNPL_LOG_HEADER%ROWTYPE;
        L_REPLY_CODE      VARCHAR2 (20);
        L_REPLY_MESSAGE   VARCHAR2 (400);
    BEGIN
        LOG_HEADER_REC.PROCESS_ID := P_PROCESS_ID;
        LOG_HEADER_REC.PROGRAM_CODE := P_PROGRAM_CODE;
        LOG_HEADER_REC.PROGRAM_TERM_CODE_EFF := P_PROGRAM_TERM_CODE_EFF;
        LOG_HEADER_REC.STD_PIDM := P_PIDM;
        LOG_HEADER_REC.TOTAL_PROCESSED_CRSE := 0;
        LOG_HEADER_REC.TOTAL_PROCESSED_HRS := 0;

        LOG_HEADER_INSERT (LOG_HEADER_REC, L_REPLY_CODE, L_REPLY_MESSAGE);
        REPLY_CODE := L_REPLY_CODE;
        REPLY_MESSAGE := L_REPLY_MESSAGE;
    END FILL_LOG_FETCHED_DATA;

    PROCEDURE VALIDATE_INSERT_SMRSSUB (
        CAPP_MNPL_LOG_DET_REC   IN     CAPP_MNPL_LOG_DETAIL%ROWTYPE,
        REPLY_CODE                 OUT VARCHAR2,
        REPLY_MESSAGE              OUT VARCHAR2)
    IS
        CURSOR CHECK_PREVIOUS_EQUATION (P_PIDM            NUMBER,
                                        P_SUBJ_CODE_REQ   VARCHAR2,
                                        P_CRSE_NUMB_REQ   VARCHAR2)
        IS
            SELECT 'Y'
              FROM SMRSSUB
             WHERE     SMRSSUB_PIDM = P_PIDM
                   AND SMRSSUB_SUBJ_CODE_REQ = P_SUBJ_CODE_REQ
                   AND SMRSSUB_CRSE_NUMB_REQ = P_CRSE_NUMB_REQ;

        L_REPLY_CODE      VARCHAR2 (20);
        L_REPLY_MESSAGE   VARCHAR2 (400);
        L_PREV_CHEK       CHAR := 'N';
        L_EQV_HRS         CAPP_MNPL_LOG_DET_REC.RHS_EQVLNT_HR%TYPE;
    BEGIN
        OPEN CHECK_PREVIOUS_EQUATION (CAPP_MNPL_LOG_DET_REC.STD_PIDM,
                                      CAPP_MNPL_LOG_DET_REC.LHS_SUBJ_CODE,
                                      CAPP_MNPL_LOG_DET_REC.LHS_CRSE_NUMB);

        FETCH CHECK_PREVIOUS_EQUATION INTO L_PREV_CHEK;

        CLOSE CHECK_PREVIOUS_EQUATION;

        IF L_PREV_CHEK = 'N'
        THEN
            -- to maintain Volunteer service subject
            IF CAPP_MNPL_LOG_DET_REC.RHS_EQVLNT_HR = 0
            THEN
                L_EQV_HRS := '';
            ELSE
                L_EQV_HRS := CAPP_MNPL_LOG_DET_REC.RHS_EQVLNT_HR;
            END IF;

            P_SMRSSUB_INSRT (
                P_PIDM          => CAPP_MNPL_LOG_DET_REC.STD_PIDM,
                P_TERM          => '',
                P_SUBJ          => CAPP_MNPL_LOG_DET_REC.RHS_SUBJ_CODE,
                P_CRSE          => CAPP_MNPL_LOG_DET_REC.RHS_CRSE_NUMB,
                P_EQ_SUBJ       => CAPP_MNPL_LOG_DET_REC.LHS_SUBJ_CODE,
                P_EQ_CRSE       => CAPP_MNPL_LOG_DET_REC.LHS_CRSE_NUMB,
                P_CREDIT_HRS    => L_EQV_HRS,
                REPLY_CODE      => L_REPLY_CODE,
                REPLY_MESSAGE   => L_REPLY_MESSAGE);
        END IF;

        IF L_REPLY_CODE = '00'
        THEN
            LOG_HEADER_CRSE_INCREMNT (CAPP_MNPL_LOG_DET_REC.PROCESS_ID,
                                      CAPP_MNPL_LOG_DET_REC.STD_PIDM,
                                      CAPP_MNPL_LOG_DET_REC.RHS_EQVLNT_HR);
            set_table_target (
                p_PROCESS_ID   => CAPP_MNPL_LOG_DET_REC.PROCESS_ID,
                p_STD_PIDM     => CAPP_MNPL_LOG_DET_REC.STD_PIDM,
                p_SEQNO        => CAPP_MNPL_LOG_DET_REC.SEQNO,
                p_target       => 'SMRSSUB');
        END IF;

        REPLY_CODE := L_REPLY_CODE;
        REPLY_MESSAGE := L_REPLY_MESSAGE;
    END VALIDATE_INSERT_SMRSSUB;

    PROCEDURE VALIDATE_INSERT_SHRTRCE (P_PROCESS_ID        NUMBER,
                                       REPLY_CODE      OUT VARCHAR2,
                                       REPLY_MESSAGE   OUT VARCHAR2)
    IS
        CURSOR GET_TRNS_HEADER IS
            SELECT DISTINCT D.STD_PIDM
              FROM CAPP_MNPL_LOG_DETAIL D
             WHERE     D.PROCESS_ID = P_PROCESS_ID
                   AND D.MAPPING_SUCCESS_IND = 'Y'
                   AND D.GRDE_CODE_FINAL = 'ãÚ'
                   AND NOT EXISTS
                           (SELECT 'Y'
                              FROM SHRTRCE
                             WHERE     SHRTRCE_PIDM = D.STD_PIDM
                                   AND SHRTRCE_SUBJ_CODE = D.LHS_SUBJ_CODE
                                   AND SHRTRCE_CRSE_NUMB = D.LHS_CRSE_NUMB);

        CURSOR GET_TRNS_RECORD_CUR (P_STD_PIDM NUMBER)
        IS
            SELECT *
              FROM CAPP_MNPL_LOG_DETAIL D
             WHERE     D.PROCESS_ID = P_PROCESS_ID
                   AND D.MAPPING_SUCCESS_IND = 'Y'
                   AND D.GRDE_CODE_FINAL = 'ãÚ'
                   AND STD_PIDM = P_STD_PIDM
                   AND NOT EXISTS
                           (SELECT 'Y'
                              FROM SHRTRCE
                             WHERE     SHRTRCE_PIDM = D.STD_PIDM
                                   AND SHRTRCE_SUBJ_CODE = D.LHS_SUBJ_CODE
                                   AND SHRTRCE_CRSE_NUMB = D.LHS_CRSE_NUMB);



        L_TRIT_SEQ_NO        SHRTRIT.SHRTRIT_SEQ_NO%TYPE;
        L_TRAM_SEQ_NO        SHRTRAM.SHRTRAM_SEQ_NO%TYPE;
        L_TRCR_SEQ_NO        SHRTRCR.SHRTRCR_SEQ_NO%TYPE;
        L_TRCE_SEQ_NO        SHRTRCR.SHRTRCR_SEQ_NO%TYPE;

        CURSOR CHECK_CURRENT_UNI (P_STD_PIDM NUMBER)
        IS
            SELECT SHRTRIT_SEQ_NO
              FROM SHRTRIT
             WHERE     SHRTRIT_SBGI_CODE =
                       F_GET_PARAM ('GENERAL', 'SBGI_CODE', 1)
                   AND SHRTRIT_PIDM = P_STD_PIDM;

        L_CHECK_UNI          SHRTRIT.SHRTRIT_SEQ_NO%TYPE;
        L_EARNED_HRS         NUMBER (3);
        l_level              VARCHAR2 (20);
        l_term               VARCHAR2 (20);
        L_STD_PIDM           NUMBER (9);

        CURSOR GET_CRD_HR_SUM IS
            SELECT SUM (SHRTRCE_CREDIT_HOURS)     EARNED_HRS
              FROM SHRTRCE
             WHERE     SHRTRCE_PIDM = L_STD_PIDM
                   AND SHRTRCE_TRIT_SEQ_NO = L_TRIT_SEQ_NO
                   AND SHRTRCE_TRAM_SEQ_NO = L_TRAM_SEQ_NO
                   AND SHRTRCE_TERM_CODE_EFF = l_term;


        L_TGPA_TRAM_SEQ_NO   SHRTGPA.SHRTGPA_TRAM_SEQ_NO%TYPE := '';

        CURSOR CHECK_CURRENT_TRNS_REC IS
            SELECT SHRTGPA_TRAM_SEQ_NO
              FROM SHRTGPA
             WHERE     SHRTGPA_PIDM = L_STD_PIDM
                   AND SHRTGPA_TERM_CODE = L_TERM
                   AND SHRTGPA_GPA_TYPE_IND = 'T'
                   AND SHRTGPA_LEVL_CODE = l_level
                   AND SHRTGPA_TRIT_SEQ_NO = L_TRIT_SEQ_NO;
    BEGIN
        FOR H_REC IN GET_TRNS_HEADER
        LOOP
            OPEN CHECK_CURRENT_UNI (H_REC.STD_PIDM);

            FETCH CHECK_CURRENT_UNI INTO L_CHECK_UNI;

            CLOSE CHECK_CURRENT_UNI;

            IF L_CHECK_UNI IS NOT NULL
            THEN
                L_TRIT_SEQ_NO := L_CHECK_UNI;
            ELSE
                SELECT NVL (MAX (SHRTRIT_SEQ_NO), 0) + 1
                  INTO L_TRIT_SEQ_NO
                  FROM SHRTRIT
                 WHERE SHRTRIT_PIDM = H_REC.STD_PIDM;

                INSERT INTO SATURN.SHRTRIT (SHRTRIT_PIDM,
                                            SHRTRIT_SEQ_NO,
                                            SHRTRIT_SBGI_CODE,
                                            SHRTRIT_SBGI_DESC,
                                            SHRTRIT_OFFICIAL_TRANS_IND,
                                            SHRTRIT_TRANS_DATE_RCVD,
                                            SHRTRIT_ACTIVITY_DATE)
                     VALUES (H_REC.STD_PIDM,
                             L_TRIT_SEQ_NO,
                             F_GET_PARAM ('GENERAL', 'SBGI_CODE', 1),
                             '',
                             'Y',
                             SYSDATE,
                             SYSDATE);
            END IF;

            ------
            SELECT NVL (MAX (SHRTRAM_SEQ_NO), 0) + 1
              INTO L_TRAM_SEQ_NO
              FROM SHRTRAM A, SHRTRIT B
             WHERE     SHRTRAM_PIDM = H_REC.STD_PIDM
                   AND A.SHRTRAM_PIDM = B.SHRTRIT_PIDM
                   AND A.SHRTRAM_TRIT_SEQ_NO = L_TRIT_SEQ_NO -- b.shrtrit_seq_no
                                                            ;

            DBMS_OUTPUT.PUT_LINE (
                   'SHRTRNS SEQ: '
                || 'l_trit_seq_no '
                || L_TRIT_SEQ_NO
                || '* l_tram_seq_no ');

            INSERT INTO SHRTRAM (SHRTRAM_PIDM,
                                 SHRTRAM_TRIT_SEQ_NO,
                                 SHRTRAM_SEQ_NO,
                                 SHRTRAM_LEVL_CODE,
                                 SHRTRAM_ATTN_PERIOD,
                                 SHRTRAM_TERM_CODE_ENTERED,
                                 SHRTRAM_DEGC_CODE,
                                 SHRTRAM_TERM_TYPE,
                                 SHRTRAM_ACCEPTANCE_DATE,
                                 SHRTRAM_ACTIVITY_DATE,
                                 SHRTRAM_ATTN_BEGIN_DATE,
                                 SHRTRAM_ATTN_END_DATE)
                 VALUES (H_REC.STD_PIDM,
                         L_TRIT_SEQ_NO,
                         L_TRAM_SEQ_NO,
                         F_GET_LEVEL (H_REC.STD_PIDM),
                         1,
                         F_GET_PARAM ('GENERAL', 'CURRENT_TERM', 1),
                         F_GET_DEGREE (H_REC.STD_PIDM),
                         '',
                         SYSDATE,
                         SYSDATE,
                         '',
                         '');

            FOR REC IN GET_TRNS_RECORD_CUR (H_REC.STD_PIDM)
            LOOP
                SELECT NVL (MAX (SHRTRCR_SEQ_NO), 0) + 1
                  INTO L_TRCR_SEQ_NO
                  FROM SHRTRCR A, SHRTRIT B, SHRTRAM C
                 WHERE     SHRTRCR_PIDM = H_REC.STD_PIDM
                       AND A.SHRTRCR_PIDM = B.SHRTRIT_PIDM
                       AND A.SHRTRCR_PIDM = C.SHRTRAM_PIDM
                       AND A.SHRTRCR_TRIT_SEQ_NO = L_TRIT_SEQ_NO -- B.SHRTRIT_SEQ_NO
                       AND A.SHRTRCR_TRAM_SEQ_NO = L_TRAM_SEQ_NO --C.SHRTRAM_SEQ_NO
                                                                ;



                INSERT INTO SHRTRCR (SHRTRCR_PIDM,
                                     SHRTRCR_TRIT_SEQ_NO,
                                     SHRTRCR_TRAM_SEQ_NO,
                                     SHRTRCR_SEQ_NO,
                                     SHRTRCR_TRANS_COURSE_NAME,
                                     SHRTRCR_TRANS_COURSE_NUMBERS,
                                     SHRTRCR_TRANS_CREDIT_HOURS,
                                     SHRTRCR_TRANS_GRADE,
                                     SHRTRCR_TRANS_GRADE_MODE,
                                     SHRTRCR_ACTIVITY_DATE,
                                     SHRTRCR_LEVL_CODE,
                                     SHRTRCR_TERM_CODE,
                                     SHRTRCR_GROUP,
                                     SHRTRCR_ART_IND,
                                     SHRTRCR_PROGRAM,
                                     SHRTRCR_GROUP_PRIMARY_IND,
                                     SHRTRCR_DUPLICATE,
                                     SHRTRCR_TCRSE_TITLE)
                         VALUES (
                                    H_REC.STD_PIDM,
                                    L_TRIT_SEQ_NO,
                                    L_TRAM_SEQ_NO,
                                    L_TRCR_SEQ_NO,
                                    F_GET_CRSE_TITLE (REC.RHS_SUBJ_CODE,
                                                      REC.RHS_CRSE_NUMB),
                                    '',
                                    REC.RHS_EQVLNT_HR,
                                    '60',
                                    '',
                                    SYSDATE,
                                    F_GET_LEVEL (H_REC.STD_PIDM),
                                    F_GET_PARAM ('GENERAL',
                                                 'CURRENT_TERM',
                                                 1),
                                    '',
                                    'O',
                                    '......',
                                    '',
                                    '',
                                    '');

                /*  SELECT NVL (MAX (SHRTRCR_SEQ_NO), 0) + 1
                    INTO l_trce_seq_no
                    FROM SHRTRCE  a,
                         SHRTRIT  b,
                         SHRTRAM  c,
                         SHRTRCR  D
                   WHERE     SHRTRCE_PIDM = H_REC.std_pidm
                         AND A.SHRTRCE_PIDM = B.SHRTRIT_PIDM
                         AND A.SHRTRCE_PIDM = C.SHRTRAM_PIDM
                         AND A.SHRTRCE_PIDM = D.SHRTRCR_PIDM
                         AND A.SHRTRCE_TRIT_SEQ_NO = l_trit_seq_no --B.SHRTRIT_SEQ_NO
                         AND A.SHRTRCE_TRAM_SEQ_NO = l_tram_seq_no --C.SHRTRAM_SEQ_NO
                         AND A.SHRTRCE_TRCR_SEQ_NO = l_trcr_seq_no --D.SHRTRCR_SEQ_NO
                                                                  ;*/

                DBMS_OUTPUT.PUT_LINE (
                       'SHRTRNS SEQ: '
                    || 'l_trit_seq_no '
                    || L_TRIT_SEQ_NO
                    || '* l_tram_seq_no '
                    || L_TRAM_SEQ_NO
                    || '* l_trcr_seq_no '
                    || L_TRCR_SEQ_NO
                    || '*l_trce_seq_no'
                    || L_TRCE_SEQ_NO
                    || '-----'
                    || 'PIDM'
                    || H_REC.STD_PIDM);

                INSERT INTO SATURN.SHRTRCE (SHRTRCE_PIDM,
                                            SHRTRCE_TRIT_SEQ_NO,
                                            SHRTRCE_TRAM_SEQ_NO,
                                            SHRTRCE_SEQ_NO,
                                            SHRTRCE_TRCR_SEQ_NO,
                                            SHRTRCE_TERM_CODE_EFF,
                                            SHRTRCE_LEVL_CODE,
                                            SHRTRCE_SUBJ_CODE,
                                            SHRTRCE_CRSE_NUMB,
                                            SHRTRCE_CRSE_TITLE,
                                            SHRTRCE_CREDIT_HOURS,
                                            SHRTRCE_GRDE_CODE,
                                            SHRTRCE_GMOD_CODE,
                                            SHRTRCE_COUNT_IN_GPA_IND,
                                            SHRTRCE_ACTIVITY_DATE,
                                            SHRTRCE_REPEAT_COURSE,
                                            SHRTRCE_REPEAT_SYS)
                         VALUES (
                                    H_REC.STD_PIDM,
                                    L_TRIT_SEQ_NO,
                                    L_TRAM_SEQ_NO,
                                    L_TRCR_SEQ_NO,
                                    L_TRCR_SEQ_NO,
                                    F_GET_PARAM ('GENERAL',
                                                 'CURRENT_TERM',
                                                 1),
                                    F_GET_LEVEL (H_REC.STD_PIDM),
                                    REC.LHS_SUBJ_CODE,
                                    REC.LHS_CRSE_NUMB,
                                    F_GET_CRSE_TITLE (REC.LHS_SUBJ_CODE,
                                                      REC.LHS_CRSE_NUMB),
                                    REC.RHS_EQVLNT_HR,
                                    'ãÚ',
                                    'Í',
                                    'Y',
                                    SYSDATE,
                                    NULL,
                                    NULL);

                REPLY_CODE := '0';
                REPLY_MESSAGE := 'OK';

                IF REPLY_CODE = '0'
                THEN
                    LOG_HEADER_CRSE_INCREMNT (REC.PROCESS_ID,
                                              H_REC.STD_PIDM,
                                              REC.RHS_EQVLNT_HR);
                    set_table_target (
                        p_PROCESS_ID   => REC.PROCESS_ID,
                        p_STD_PIDM     => H_REC.STD_PIDM,
                        p_SEQNO        => REC.SEQNO,
                        p_target       =>
                               'SHRTRCE , Transfer Courses'
                            || L_TRIT_SEQ_NO
                            || '-'
                            || L_TRAM_SEQ_NO
                            || '-'
                            || L_TRCR_SEQ_NO
                            || '-'
                            || L_TRCR_SEQ_NO
                            || ';');
                END IF;
            END LOOP;



            BEGIN
                l_level := F_GET_LEVEL (H_REC.STD_PIDM);
                l_term := F_GET_PARAM ('GENERAL', 'CURRENT_TERM', 1);
                L_STD_PIDM := H_REC.STD_PIDM;

                OPEN CHECK_CURRENT_TRNS_REC;

                FETCH CHECK_CURRENT_TRNS_REC INTO L_TGPA_TRAM_SEQ_NO;

                CLOSE CHECK_CURRENT_TRNS_REC;

                IF L_TGPA_TRAM_SEQ_NO IS NULL
                THEN
                    INSERT INTO SATURN.SHRTGPA (SHRTGPA_PIDM,
                                                SHRTGPA_TERM_CODE,
                                                SHRTGPA_LEVL_CODE,
                                                SHRTGPA_GPA_TYPE_IND,
                                                SHRTGPA_TRIT_SEQ_NO,
                                                SHRTGPA_TRAM_SEQ_NO,
                                                SHRTGPA_HOURS_ATTEMPTED,
                                                SHRTGPA_HOURS_EARNED,
                                                SHRTGPA_GPA_HOURS,
                                                SHRTGPA_QUALITY_POINTS,
                                                SHRTGPA_GPA,
                                                SHRTGPA_ACTIVITY_DATE,
                                                SHRTGPA_HOURS_PASSED)
                         VALUES (L_STD_PIDM,
                                 L_TERM,
                                 l_level,
                                 'T',
                                 L_TRIT_SEQ_NO,
                                 L_TRAM_SEQ_NO,
                                 0,
                                 L_EARNED_HRS,
                                 0,
                                 0,
                                 0,
                                 SYSDATE,
                                 L_EARNED_HRS);
                ELSE
                    UPDATE SHRTGPA
                       SET SHRTGPA_HOURS_EARNED =
                               SHRTGPA_HOURS_EARNED + L_EARNED_HRS,
                           SHRTGPA_HOURS_PASSED =
                               SHRTGPA_HOURS_PASSED + L_EARNED_HRS
                     WHERE     SHRTGPA_PIDM = L_STD_PIDM
                           AND SHRTGPA_TERM_CODE = L_TERM
                           AND SHRTGPA_GPA_TYPE_IND = 'T'
                           AND SHRTGPA_LEVL_CODE = l_level
                           AND SHRTGPA_TRIT_SEQ_NO = L_TRIT_SEQ_NO
                           AND SHRTGPA_TRAM_SEQ_NO = L_TGPA_TRAM_SEQ_NO;
                END IF;
            EXCEPTION
                WHEN OTHERS
                THEN
                    REPLY_CODE := 99;
                    REPLY_MESSAGE := SQLERRM;
            END;

            -- INSERT LGPA
            BEGIN
                UPDATE SATURN.SHRLGPA
                   SET SHRLGPA_HOURS_EARNED =
                           SHRLGPA_HOURS_EARNED + L_EARNED_HRS,
                       SHRLGPA_HOURS_PASSED =
                           SHRLGPA_HOURS_PASSED + L_EARNED_HRS
                 WHERE     SHRLGPA_PIDM = L_STD_PIDM
                       AND SHRLGPA_LEVL_CODE = l_level
                       AND SHRLGPA_GPA_TYPE_IND = 'O';

                INSERT INTO SATURN.SHRLGPA (SHRLGPA_PIDM,
                                            SHRLGPA_LEVL_CODE,
                                            SHRLGPA_GPA_TYPE_IND,
                                            SHRLGPA_HOURS_ATTEMPTED,
                                            SHRLGPA_HOURS_EARNED,
                                            SHRLGPA_GPA_HOURS,
                                            SHRLGPA_QUALITY_POINTS,
                                            SHRLGPA_GPA,
                                            SHRLGPA_ACTIVITY_DATE,
                                            SHRLGPA_HOURS_PASSED,
                                            SHRLGPA_GPA_CALC)
                     VALUES (L_STD_PIDM,
                             l_level,
                             'T',
                             0,
                             L_EARNED_HRS,
                             0,
                             0,
                             0,
                             SYSDATE,
                             L_EARNED_HRS,
                             'Y');
            EXCEPTION
                WHEN DUP_VAL_ON_INDEX
                THEN
                    UPDATE SATURN.SHRLGPA
                       SET SHRLGPA_HOURS_EARNED =
                               SHRLGPA_HOURS_EARNED + L_EARNED_HRS,
                           SHRLGPA_HOURS_PASSED =
                               SHRLGPA_HOURS_PASSED + L_EARNED_HRS
                     WHERE     SHRLGPA_PIDM = L_STD_PIDM
                           AND SHRLGPA_LEVL_CODE = l_level
                           AND SHRLGPA_GPA_TYPE_IND = 'T';
                WHEN OTHERS
                THEN
                    REPLY_CODE := 99;
                    REPLY_MESSAGE := SQLERRM;
            END;
        END LOOP;
    EXCEPTION
        WHEN OTHERS
        THEN
            REPLY_CODE := 90;
            REPLY_MESSAGE := SQLERRM || '--'; --|| REC.STD_PIDM || '***' || REC.SEQNO;
    END VALIDATE_INSERT_SHRTRCE;

    PROCEDURE REPLACE_PROGRAM (P_PROCESS_ID        NUMBER,
                               REPLY_CODE      OUT VARCHAR2,
                               REPLY_MESSAGE   OUT VARCHAR2)
    IS
        CURSOR GET_PROGRAMS_DATA_CUR IS
            SELECT DISTINCT SOBCURR_PROGRAM,
                            SORCMJR_MAJR_CODE,
                            SORCMJR_DEPT_CODE,
                            STD_PIDM
              FROM SORCMJR, SOBCURR, CAPP_MNPL_LOG_HEADER
             WHERE     SORCMJR_CURR_RULE = SOBCURR_CURR_RULE
                   AND PROCESS_ID = P_PROCESS_ID
                   AND PROGRAM_CODE = SOBCURR_PROGRAM
                   AND PROGRAM_TERM_CODE_EFF = SOBCURR_TERM_CODE_INIT
                   AND TOTAL_PROCESSED_CRSE > 0;

        L_STD_PIDM   NUMBER (10);
    BEGIN
        FOR PROGRAM_REC IN GET_PROGRAMS_DATA_CUR
        LOOP
            L_STD_PIDM := PROGRAM_REC.STD_PIDM;

            INSERT INTO BU_APPS.TRANSFER_STUDENT_PROGRAM (PIDM_CD,
                                                          PROGRAM_CD,
                                                          DEPT_CODE,
                                                          MAJOR_CODE)
                 VALUES (PROGRAM_REC.STD_PIDM,
                         PROGRAM_REC.SOBCURR_PROGRAM,
                         PROGRAM_REC.SORCMJR_DEPT_CODE,
                         PROGRAM_REC.SORCMJR_MAJR_CODE);
        END LOOP;

        --TRNSFER ALL VALID STUDENTS
        ITRANSFER_PROC (F_GET_PARAM ('GENERAL', 'CURRENT_TERM', 1));
        REPLY_MESSAGE := '';
    EXCEPTION
        WHEN OTHERS
        THEN
            REPLY_CODE := '90';
            REPLY_MESSAGE := SQLCODE || ' ' || SQLERRM || ' @' || L_STD_PIDM;
    END REPLACE_PROGRAM;

    FUNCTION CHECK_COURSE_FIT (P_PIDM        SHRTCKN.SHRTCKN_PIDM%TYPE,
                               P_SUB_CODE    SHRTCKN.SHRTCKN_SUBJ_CODE%TYPE,
                               P_CRSE_NUMB   SHRTCKN.SHRTCKN_CRSE_NUMB%TYPE)
        RETURN CHAR
    IS
        R_VALUE                 CHAR;
        STDNT_PASSED_CRSE_REC   STDNT_PASSED_CRSE_CUR%ROWTYPE;
    BEGIN
        OPEN STDNT_PASSED_CRSE_CUR (P_PIDM, P_SUB_CODE, P_CRSE_NUMB);

        FETCH STDNT_PASSED_CRSE_CUR INTO STDNT_PASSED_CRSE_REC;

        IF STDNT_PASSED_CRSE_CUR%NOTFOUND
        THEN
            CLOSE STDNT_PASSED_CRSE_CUR;

            IF COURSE_PASSED (P_PIDM, P_SUB_CODE, P_CRSE_NUMB) = 'F'
            THEN
                R_VALUE := 'F';
                RETURN R_VALUE;
            ELSE
                R_VALUE := 'N';
                RETURN R_VALUE;
            END IF;
        ELSE
            CLOSE STDNT_PASSED_CRSE_CUR;

            R_VALUE := 'P';
            RETURN R_VALUE;
        END IF;
    END CHECK_COURSE_FIT;

    FUNCTION CHECK_PREVIOUS_FIT (
        P_PROCESS_ID   NUMBER,
        P_PIDM         SHRTCKN.SHRTCKN_PIDM%TYPE,
        P_SUB_CODE     SHRTCKN.SHRTCKN_SUBJ_CODE%TYPE,
        P_CRSE_NUMB    SHRTCKN.SHRTCKN_CRSE_NUMB%TYPE)
        RETURN VARCHAR2
    IS
        CURSOR CHECK_PREV_FIT_CUR IS
            SELECT LHS_SUBJ_CODE || '-' || LHS_CRSE_NUMB
              FROM CAPP_MNPL_LOG_DETAIL
             WHERE     PROCESS_ID = P_PROCESS_ID
                   AND STD_PIDM = P_PIDM
                   AND RHS_SUBJ_CODE = P_SUB_CODE
                   AND RHS_CRSE_NUMB = P_CRSE_NUMB
                   AND MAPPING_SUCCESS_IND = 'Y'
                   AND ROWNUM < 2;

        R_VALUE   VARCHAR2 (20) := 'N';
    BEGIN
        OPEN CHECK_PREV_FIT_CUR;

        FETCH CHECK_PREV_FIT_CUR INTO R_VALUE;

        CLOSE CHECK_PREV_FIT_CUR;

        RETURN R_VALUE;
    END CHECK_PREVIOUS_FIT;

    FUNCTION GET_NEW_PROCESS_ID
        RETURN NUMBER
    IS
        R_VALUE   CAPP_MNPL_LOG_MAIN.PROCESS_ID%TYPE;

        CURSOR GET_SESSION_ID IS
            SELECT NVL (MAX (PROCESS_ID), 0) + 100 FROM CAPP_MNPL_LOG_MAIN;
    BEGIN
        OPEN GET_SESSION_ID;

        FETCH GET_SESSION_ID INTO R_VALUE;

        CLOSE GET_SESSION_ID;

        RETURN R_VALUE;
    END GET_NEW_PROCESS_ID;

    FUNCTION F_GET_CRSE_CREDIT_HR (P_SUBJ_CODE   VARCHAR2,
                                   P_CRSE_NUMB   VARCHAR2)
        RETURN NUMBER
    IS
        CURSOR GET_CREDIT_HR IS
            SELECT GREATEST (NVL (A.SCBCRSE_CREDIT_HR_LOW, 0),
                             NVL (A.SCBCRSE_CREDIT_HR_HIGH, 0))    CREDIT_HR
              FROM SCBCRSE A
             WHERE     A.SCBCRSE_SUBJ_CODE = P_SUBJ_CODE
                   AND A.SCBCRSE_CRSE_NUMB = P_CRSE_NUMB
                   AND A.SCBCRSE_EFF_TERM =
                       (SELECT MAX (SCBCRSE_EFF_TERM)
                          FROM SCBCRSE
                         WHERE     SCBCRSE_SUBJ_CODE = P_SUBJ_CODE
                               AND SCBCRSE_CRSE_NUMB = P_CRSE_NUMB);

        L_CREDIT_HR   NUMBER;
    BEGIN
        OPEN GET_CREDIT_HR;

        FETCH GET_CREDIT_HR INTO L_CREDIT_HR;

        CLOSE GET_CREDIT_HR;

        RETURN NVL (L_CREDIT_HR, 0);
    END F_GET_CRSE_CREDIT_HR;

    FUNCTION F_GET_CRSE_TITLE (P_SUBJ_CODE VARCHAR2, P_CRSE_NUMB VARCHAR2)
        RETURN VARCHAR2
    IS
        R_VALUE   SCBCRSE.SCBCRSE_TITLE%TYPE;

        CURSOR GET_TITLE_CUR IS
            SELECT A.SCBCRSE_TITLE     TITLE
              FROM SCBCRSE A
             WHERE     A.SCBCRSE_SUBJ_CODE = P_SUBJ_CODE
                   AND A.SCBCRSE_CRSE_NUMB = P_CRSE_NUMB
                   AND A.SCBCRSE_EFF_TERM =
                       (SELECT MAX (SCBCRSE_EFF_TERM)
                          FROM SCBCRSE
                         WHERE     SCBCRSE_SUBJ_CODE = P_SUBJ_CODE
                               AND SCBCRSE_CRSE_NUMB = P_CRSE_NUMB);
    BEGIN
        OPEN GET_TITLE_CUR;

        FETCH GET_TITLE_CUR INTO R_VALUE;

        CLOSE GET_TITLE_CUR;

        RETURN NVL (R_VALUE, '---');
    END F_GET_CRSE_TITLE;

    FUNCTION F_GET_FINAL_GRADE (P_STD_PIDM    NUMBER,
                                P_SUBJ_CODE   VARCHAR2,
                                P_CRSE_NUMB   VARCHAR2)
        RETURN VARCHAR2
    IS
        STDNT_PASSED_CRSE_REC   STDNT_PASSED_CRSE_CUR%ROWTYPE;
    BEGIN
        OPEN STDNT_PASSED_CRSE_CUR (P_STD_PIDM, P_SUBJ_CODE, P_CRSE_NUMB);

        FETCH STDNT_PASSED_CRSE_CUR INTO STDNT_PASSED_CRSE_REC;

        CLOSE STDNT_PASSED_CRSE_CUR;

        RETURN STDNT_PASSED_CRSE_REC.GRADE;
    END F_GET_FINAL_GRADE;

    FUNCTION F_CHECK_CRSE_SUB_INT (P_PROGRAM                 VARCHAR2,
                                   P_PROGRAM_TERM_CODE_EFF   VARCHAR2,
                                   P_STD_PIDM                NUMBER,
                                   P_SUBJ_CODE               VARCHAR2,
                                   P_CRSE_NUMB               VARCHAR2)
        RETURN VARCHAR2
    IS
        CURSOR GET_SUB_CRSE IS
            SELECT SMRSSUB_SUBJ_CODE_SUB || '-' || SMRSSUB_CRSE_NUMB_SUB
              FROM SMRSSUB
             WHERE     SMRSSUB_PIDM = P_STD_PIDM
                   AND SMRSSUB_SUBJ_CODE_REQ = P_SUBJ_CODE
                   AND SMRSSUB_CRSE_NUMB_REQ = P_CRSE_NUMB
                   AND SMRSSUB_ACTN_CODE = 'ãÏ'
                   AND NOT EXISTS
                           (SELECT 'Y'
                              FROM PROGRAM_EQUV_COURSES
                             WHERE     PROGRAM_CODE = P_PROGRAM
                                   AND TERM_CODE_EFF =
                                       P_PROGRAM_TERM_CODE_EFF
                                   AND EQUV_SUBJ_CODE = P_SUBJ_CODE
                                   AND EQUV_CRSE_NUMB = P_CRSE_NUMB);

        R_RESULT   VARCHAR2 (11) := 'N';
    BEGIN
        OPEN GET_SUB_CRSE;

        FETCH GET_SUB_CRSE INTO R_RESULT;

        CLOSE GET_SUB_CRSE;

        RETURN R_RESULT;
    END F_CHECK_CRSE_SUB_INT;

    FUNCTION F_CHECK_CRSE_SUB_EXT (P_STD_PIDM    NUMBER,
                                   P_SUBJ_CODE   VARCHAR2,
                                   P_CRSE_NUMB   VARCHAR2)
        RETURN VARCHAR2
    IS
        CURSOR GET_SUB_CRSE IS
            SELECT 'Y'
              FROM SHRTRCE
             WHERE     SHRTRCE_PIDM = P_STD_PIDM
                   AND SHRTRCE_SUBJ_CODE = P_SUBJ_CODE
                   AND SHRTRCE_CRSE_NUMB = P_CRSE_NUMB
                   AND SHRTRCE_GRDE_CODE = 'ãÚ';

        R_RESULT   VARCHAR2 (11) := 'N';
    BEGIN
        OPEN GET_SUB_CRSE;

        FETCH GET_SUB_CRSE INTO R_RESULT;

        CLOSE GET_SUB_CRSE;

        RETURN R_RESULT;
    END F_CHECK_CRSE_SUB_EXT;
END;
/
