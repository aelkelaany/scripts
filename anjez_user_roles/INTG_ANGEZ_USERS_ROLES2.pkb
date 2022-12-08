/* Formatted on 11/20/2022 8:44:39 AM (QP5 v5.371) */
CREATE OR REPLACE PACKAGE BODY intg_angez_users_roles
IS
    CURSOR GET_AJNEZ_REQUESTS (P_DCN_TYP VARCHAR2)
    IS
          SELECT REF_NBR,
                 SSN,
                 --  USER_ROLE,
                 BNR_ROLE,
                 COLL,
                 DEPT,
                 DCN_NBR,
                 DCN_TYP,
                 DCN_DT,
                 RQST_DT,
                 PROCESSED_DT,
                 INB_USER,
                 RQST_STATUS
            FROM anjez_users_roles,
                 (SELECT 'DPT' ANGEZ_ROLE, 'RO_DEPT_MANAGER' BNR_ROLE FROM DUAL
                  UNION
                  SELECT 'VDN' ANGEZ_ROLE, 'RO_COLLEGE_DEAN_VICE' BNR_ROLE
                    FROM DUAL
                  UNION
                  SELECT 'VDN' ANGEZ_ROLE, 'RO_VICE_DEAN' BNR_ROLE FROM DUAL
                  UNION
                  SELECT 'CDN' ANGEZ_ROLE, 'RO_COLLEGE_DEAN' BNR_ROLE FROM DUAL
                  UNION
                  SELECT 'CDN' ANGEZ_ROLE, 'RO_COLLEGE_DEAN_VICE' BNR_ROLE
                    FROM DUAL)
           WHERE     RQST_STATUS = 'P'
                 AND DCN_TYP = P_DCN_TYP
                 AND USER_ROLE = ANGEZ_ROLE
        ORDER BY REF_NBR ASC;



    -- TODO
    -- PENDING OR HOLDING REQUESTS???
    PROCEDURE deactive_user_wf
    IS
        CURSOR check_user_role (P_SSN VARCHAR2, P_ROLE VARCHAR2)
        IS
            SELECT 'Y'
              FROM spbpers, ROLE_USERS
             WHERE     spbpers_ssn = P_SSN
                   AND USER_PIDM = spbpers_pidm
                   AND ACTIVE = 'Y'
                   AND ROLE_CODE = P_ROLE;

        CURSOR get_old_user_data (P_SSN VARCHAR2, P_ROLE VARCHAR2)
        IS
            SELECT ROLE_CODE r_code, USER_PIDM, GOBEACC_USERNAME
              FROM spbpers, ROLE_USERS, GOBEACC
             WHERE     spbpers_ssn = P_SSN
                   AND USER_PIDM = spbpers_pidm
                   AND GOBEACC_pidm(+) = spbpers_pidm
                   AND ACTIVE = 'Y'
                   AND ROLE_CODE = P_ROLE;



        CURSOR CHECK_OTHER_DEPTS (P_USER_PIDM NUMBER, P_ROLE VARCHAR2)
        IS
            SELECT 'Y'
              FROM users_attributes
             WHERE     user_pidm = P_USER_PIDM
                   AND role_code = P_ROLE
                   AND ATTRIBUTE_CODE IN ('DEPARTMENT');

        CURSOR CHECK_OTHER_attr (P_USER_PIDM NUMBER, P_ROLE VARCHAR2)
        IS
            SELECT 'Y'
              FROM users_attributes
             WHERE     user_pidm = P_USER_PIDM
                   AND role_code = P_ROLE
                   AND ATTRIBUTE_CODE IN ('COLLEGE', 'DEPARTMENT');

        CURSOR get_wf_requests (p_user_pidm NUMBER, p_role VARCHAR2)
        IS
            SELECT REQUEST_NO,
                   SEQUENCE_NO,
                   FLOW_SEQ,
                   ROLE_CODE
              FROM wf_request_flow a
             WHERE     USER_PIDM = p_user_pidm
                   AND ACTION_CODE IS NULL
                   AND ROLE_CODE = p_role
                   AND EXISTS
                           (SELECT '1'
                              FROM request_master
                             WHERE     request_no = a.request_no
                                   AND request_status = 'P');

        CURSOR GET_dept_ATTRS (P_USER_PIDM   NUMBER,
                               P_ROLE        VARCHAR2,
                               P_DEPT        VARCHAR2)
        IS
            SELECT ATTRIBUTE_VALUE
              FROM users_attributes
             WHERE     user_pidm = P_USER_PIDM
                   AND role_code = P_ROLE
                   AND ATTRIBUTE_CODE = 'DEPARTMENT'
                   AND ATTRIBUTE_VALUE IN (SELECT GENERAL_DEPT
                                             FROM SYMTRCL_DEPT_MAPPING
                                            WHERE DEPT_CODE = P_DEPT
                                           UNION
                                           SELECT P_DEPT FROM DUAL);

        l_check_value   CHAR;
        l_inb_output    VARCHAR2 (150);
    BEGIN
        --todo
        -- start looping requests
        FOR req_rec IN GET_AJNEZ_REQUESTS ('E')
        LOOP
            -- check if   exists otherwise log error
            l_check_value := 'N';

            OPEN check_user_role (req_rec.SSN, req_rec.BNR_ROLE);

            FETCH check_user_role INTO l_check_value;

            CLOSE check_user_role;

            IF l_check_value = 'N'
            THEN
                log_angez (req_rec.REF_NBR,
                           'Error',
                           'user has not role ' || req_rec.BNR_ROLE,
                           'R');
                CONTINUE;
            END IF;



           <<user_loop>>
            FOR user_rec IN get_old_user_data (req_rec.SSN, req_rec.BNR_ROLE)
            LOOP
                -- REMOVE ROLE_ATTRIBUTES
                -- DEPTS

                FOR ATTR_REC
                    IN GET_dept_ATTRS (user_rec.USER_PIDM,
                                       user_rec.R_CODE,
                                       req_rec.DEPT)
                LOOP
                    p_log_angez_process (req_rec.ref_nbr,
                                         user_rec.USER_PIDM,
                                         'REMOVE DEPTS',
                                         user_rec.R_CODE,
                                         ATTR_REC.ATTRIBUTE_VALUE,
                                         '');

                    DELETE FROM
                        USERS_ATTRIBUTES
                          WHERE     ROLE_CODE = user_rec.R_CODE
                                AND USER_PIDM = user_rec.USER_PIDM
                                AND ATTRIBUTE_CODE = 'DEPARTMENT'
                                AND ATTRIBUTE_VALUE =
                                    ATTR_REC.ATTRIBUTE_VALUE;
                END LOOP;

                -- DELETE COLLEGE ATTR
                -- in  case he has privilage on another department check
                l_check_value := 'N';

                OPEN CHECK_OTHER_DEPTS (user_rec.USER_PIDM, user_rec.R_CODE);

                FETCH CHECK_OTHER_DEPTS INTO l_check_value;

                CLOSE CHECK_OTHER_DEPTS;

                IF l_check_value = 'N'
                THEN
                    p_log_angez_process (req_rec.ref_nbr,
                                         user_rec.USER_PIDM,
                                         'REMOVE COLLEGE',
                                         user_rec.R_CODE,
                                         req_rec.COLL,
                                         '');

                    DELETE FROM
                        USERS_ATTRIBUTES
                          WHERE     ROLE_CODE = user_rec.R_CODE
                                AND USER_PIDM = user_rec.USER_PIDM
                                AND ATTRIBUTE_CODE = 'COLLEGE'
                                AND ATTRIBUTE_VALUE = req_rec.COLL;
                END IF;

                -- CHECK IT DOESN'T HAS ANOTHER ATTRIBUTES
                l_check_value := 'N';

                OPEN CHECK_OTHER_attr (user_rec.USER_PIDM, user_rec.R_CODE);

                FETCH CHECK_OTHER_attr INTO l_check_value;

                CLOSE CHECK_OTHER_attr;



                IF l_check_value = 'Y'
                THEN
                    p_log_angez_process (req_rec.ref_nbr,
                                         user_rec.USER_PIDM,
                                         'HAS ANOTHER DEPTS ATTRIBUTES',
                                         user_rec.R_CODE,
                                         '',
                                         '');
                    CONTINUE;
                END IF;



                -- DELETE TRANSFER ATTR
                p_log_angez_process (req_rec.ref_nbr,
                                     user_rec.USER_PIDM,
                                     'REMOVE TRANSFER',
                                     user_rec.R_CODE,
                                     '',
                                     '');

                DELETE FROM
                    USERS_ATTRIBUTES
                      WHERE     ROLE_CODE = user_rec.R_CODE
                            AND USER_PIDM = user_rec.USER_PIDM
                            AND ATTRIBUTE_CODE = 'TRN_ALLOW_APPROVALS';

                NULL;

                -- DEACTIVE ROLE
                UPDATE ROLE_USERS
                   SET ACTIVE = 'N',
                       SEND_EMAIL_FLAG = 'N',
                       ACTIVITY_DATE = SYSDATE
                 WHERE     ROLE_CODE = user_rec.R_CODE
                       AND USER_PIDM = user_rec.USER_PIDM;

                p_log_angez_process (req_rec.ref_nbr,
                                     user_rec.USER_PIDM,
                                     'Deactive_wf_role',
                                     user_rec.R_CODE,
                                     '',
                                     '');

                -- release assigned workflow requestst

                FOR wfreq
                    IN get_wf_requests (user_rec.USER_PIDM, user_rec.R_CODE)
                LOOP
                    p_log_angez_process (req_rec.ref_nbr,
                                         user_rec.USER_PIDM,
                                         'Release wf requests  ',
                                         user_rec.R_CODE,
                                         wfreq.request_no,
                                         '');

                    UPDATE wf_request_flow
                       SET USER_PIDM = NULL
                     WHERE     REQUEST_NO = wfreq.request_no
                           AND SEQUENCE_NO = wfreq.SEQUENCE_NO
                           AND FLOW_SEQ = wfreq.FLOW_SEQ
                           AND ROLE_CODE = wfreq.ROLE_CODE;

                    -- deactive inb account

                    deactive_user_inb (user_rec.GOBEACC_USERNAME,
                                       user_rec.R_CODE,
                                       l_inb_output);

                    IF l_inb_output = ''
                    THEN
                        log_angez (
                            req_rec.REF_NBR,
                            'Completed',
                            'user has been deactiveted ' || req_rec.BNR_ROLE,
                            'C');
                    ELSE
                        log_angez (
                            req_rec.REF_NBR,
                            'Finished',
                            'INB user still ' || user_rec.GOBEACC_USERNAME,
                            'F');
                    END IF;
                END LOOP;
            END LOOP;
        END LOOP;
    END;


    PROCEDURE deactive_user_inb (P_USERNAME       VARCHAR2,
                                 P_ROLE           VARCHAR2,
                                 p_output     OUT VARCHAR2)
    IS
    BEGIN
        NULL;
    END;

    PROCEDURE active_user_wf
    IS
        CURSOR check_user_role_attr (P_ROLE   VARCHAR2,
                                     p_coll   VARCHAR2,
                                     p_dept   VARCHAR2)
        IS
            SELECT 'Y'
              FROM users_attributes coll, users_attributes dept
             WHERE     coll.ROLE_CODE = P_ROLE
                   AND coll.USER_PIDM = dept.user_pidm
                   AND coll.ATTRIBUTE_CODE = 'COLLEGE'
                   AND coll.ATTRIBUTE_VALUE = p_coll
                   AND dept.ROLE_CODE = coll.ROLE_CODE
                   AND dept.ATTRIBUTE_CODE = 'DEPARTMENT'
                   AND dept.ATTRIBUTE_VALUE = p_dept
                   AND EXISTS
                           (SELECT '1'
                              FROM role_users
                             WHERE     active = 'Y'
                                   AND role_code = coll.ROLE_CODE
                                   AND user_pidm = dept.user_pidm);

        CURSOR check_coll_user (P_SSN    VARCHAR2,
                                P_ROLE   VARCHAR2,
                                p_coll   VARCHAR2)
        IS
            SELECT 'Y'
              FROM spbpers, ROLE_USERS r, users_attributes coll
             WHERE     spbpers_ssn = P_SSN
                   AND r.USER_PIDM = spbpers_pidm
                   AND r.ROLE_CODE = P_ROLE
                   AND coll.ROLE_CODE = r.role_code
                   AND coll.USER_PIDM = spbpers_pidm
                   AND coll.ATTRIBUTE_CODE = 'COLLEGE'
                   AND coll.ATTRIBUTE_VALUE = p_coll;


        CURSOR get_user (p_ssn VARCHAR2)
        IS
            SELECT spbpers_pidm
              FROM spbpers
             WHERE spbpers_ssn = p_ssn;

        CURSOR get_depts (P_DEPT VARCHAR2)
        IS
            SELECT GENERAL_DEPT     DEPT
              FROM SYMTRCL_DEPT_MAPPING
             WHERE DEPT_CODE = P_DEPT
            UNION
            SELECT P_DEPT FROM DUAL;

        l_check_value   CHAR;
        l_user_pidm     NUMBER (8);
        l_inb_output    VARCHAR2 (150);
    -- TODO
    -- GET REQUSTS
    -- IF SOMEONE HAS THE SAME ROLE
    --ASSIGN ROLE



    BEGIN
        FOR req_rec IN GET_AJNEZ_REQUESTS ('A')
        LOOP
            l_check_value := 'N';

            OPEN check_user_role_attr (REQ_REC.BNR_ROLE,
                                       REQ_REC.coll,
                                       REQ_REC.dept);

            FETCH check_user_role_attr INTO l_check_value;

            CLOSE check_user_role_attr;

            IF l_check_value = 'Y'
            THEN
                log_angez (
                    req_rec.REF_NBR,
                    'Error',
                    'Someone else on the same role' || req_rec.BNR_ROLE,
                    'R');

                CONTINUE;
            END IF;

            l_user_pidm := 0;

            OPEN get_user (req_rec.ssn);

            FETCH get_user INTO l_user_pidm;

            CLOSE get_user;

            BEGIN                                               -- insert role
                INSERT INTO ROLE_USERS (ROLE_CODE,
                                        USER_PIDM,
                                        ACTIVITY_DATE,
                                        USERID,
                                        ACTIVE,
                                        USER_MAIL,
                                        SEND_EMAIL_FLAG)
                     VALUES (req_rec.BNR_ROLE,
                             l_user_pidm,
                             SYSDATE,
                             USER,
                             'Y',
                             '',
                             'Y');

                p_log_angez_process (req_rec.ref_nbr,
                                     l_user_pidm,
                                     'Adding role  ',
                                     req_rec.BNR_ROLE,
                                     REQ_REC.coll,
                                     '');
            EXCEPTION
                WHEN DUP_VAL_ON_INDEX
                THEN
                    UPDATE ROLE_USERS
                       SET ACTIVE = 'Y',
                           ACTIVITY_DATE = SYSDATE,
                           USERID = USER,
                           SEND_EMAIL_FLAG = 'Y'
                     WHERE     ROLE_CODE = req_rec.BNR_ROLE
                           AND USER_PIDM = l_user_pidm;

                    p_log_angez_process (req_rec.ref_nbr,
                                         l_user_pidm,
                                         'ACTIVE role  ',
                                         req_rec.BNR_ROLE,
                                         REQ_REC.coll,
                                         '');
            END;

            -- insert college attribute
            add_attribute (req_rec.ref_nbr,
                           req_rec.BNR_ROLE,
                           l_user_pidm,
                           'COLLEGE',
                           REQ_REC.coll);

            -- insert internal_transfer attribute
            add_attribute (req_rec.ref_nbr,
                           req_rec.BNR_ROLE,
                           l_user_pidm,
                           'TRN_ALLOW_APPROVALS',
                           'N');


            FOR DEPT_REC                                       -- insert depts
                         IN get_depts (REQ_REC.DEPT)
            LOOP
                add_attribute (req_rec.ref_nbr,
                               req_rec.BNR_ROLE,
                               l_user_pidm,
                               'DEPARTMENT',
                               DEPT_REC.DEPT);
            END LOOP;
             p_log_angez_process (req_rec.ref_nbr,
                                         l_user_pidm,
                                         'ASIGNING COMPLETE ',
                                         req_rec.BNR_ROLE,
                                         REQ_REC.coll,
                                         '');
        END LOOP;
    END;

    PROCEDURE active_user_inb
    IS
    BEGIN
        NULL;
    END;

    PROCEDURE run_package
    IS
    BEGIN
        NULL;
    END;

    PROCEDURE log_angez (p_ref_nbr   NUMBER,
                         P_error     VARCHAR2,
                         p_notes     VARCHAR2,
                         p_STATUS    VARCHAR2)
    IS
    BEGIN
        UPDATE anjez_users_roles
           SET PROCESSED_DT = SYSDATE,
               RQST_STATUS = p_STATUS,
               ERROR_LOG = P_error,
               NOTES = p_notes
         WHERE REF_NBR = p_ref_nbr;
    END;

    PROCEDURE p_log_angez_process (p_ref_nbr          NUMBER,
                                   p_user_pidm        NUMBER,
                                   p_operation        VARCHAR2,
                                   p_operation_desc   VARCHAR2,
                                   p_attr_value       VARCHAR2,
                                   p_inb_user         VARCHAR2)
    IS
        L_SEQ_NBR   NUMBER (2);

        CURSOR GET_NXT_SQNC (p_ref NUMBER)
        IS
            SELECT NVL (MAX (SEQ_NBR) + 1, 1)
              FROM log_angez_process
             WHERE REF_NBR = p_ref;
    BEGIN
        OPEN GET_NXT_SQNC (p_ref_nbr);

        FETCH GET_NXT_SQNC INTO L_SEQ_NBR;

        CLOSE GET_NXT_SQNC;

        INSERT INTO log_angez_process (REF_NBR,
                                       SEQ_NBR,
                                       USER_PIDM,
                                       OPERATION,
                                       OPERATION_DESC,
                                       ATTR_VALUE,
                                       INB_USER,
                                       ACTIVITY_DT)
             VALUES (p_ref_nbr,
                     L_SEQ_NBR,
                     p_user_pidm,
                     p_operation,
                     p_operation_desc,
                     p_attr_value,
                     p_inb_user,
                     SYSDATE);
    END;

    PROCEDURE add_attribute (p_ref_no      NUMBER,
                             p_ROLE_CODE   VARCHAR2,
                             p_user_pidm   NUMBER,
                             p_code        VARCHAR2,
                             p_value       VARCHAR2)
    IS
    BEGIN
        INSERT INTO USERS_ATTRIBUTES (ROLE_CODE,
                                      USER_PIDM,
                                      ATTRIBUTE_CODE,
                                      ATTRIBUTE_VALUE,
                                      ACTIVITY_DATE,
                                      USER_ID)
             VALUES (p_ROLE_CODE,
                     p_user_pidm,
                     p_code,
                     p_value,
                     SYSDATE,
                     USER);

        p_log_angez_process (p_ref_no,
                             p_user_pidm,
                             'Adding  ' || INITCAP (p_code),
                             '',
                             p_value,
                             '');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX
        THEN
            p_log_angez_process (p_ref_no,
                                 p_user_pidm,
                                 INITCAP (p_code) || ' Exists Before  ',
                                 '',
                                 p_value,
                                 '');
    END;
END;