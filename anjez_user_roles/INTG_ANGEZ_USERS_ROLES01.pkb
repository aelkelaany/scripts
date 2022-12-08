/* Formatted on 11/14/2022 9:37:37 PM (QP5 v5.371) */
CREATE OR REPLACE PACKAGE BODY intg_angez_users_roles
IS
-- TODO 
-- PENDING OR HOLDING REQUESTS???
    PROCEDURE deactive_user_wf
    IS
        CURSOR get_exempted_users IS
            SELECT REF_NBR,
                   SSN,
                   USER_ROLE,
                   COLL,
                   DEPT,
                   DCN_NBR,
                   DCN_TYP,
                   DCN_DT,
                   RQST_DT,
                   PROCESSED_DT,
                   INB_USER,
                   RQST_STATUS
              FROM anjez_users_roles
             WHERE RQST_STATUS = 'P' AND DCN_TYP = 'E'
             order by REF_NBR asc ;

        CURSOR check_user_role (P_SSN VARCHAR2, P_ROLE VARCHAR2)
        IS
            SELECT 'Y'
              FROM spbpers, ROLE_USERS
             WHERE     spbpers_ssn = P_SSN
                   AND USER_PIDM = spbpers_pidm
                    AND ACTIVE = 'Y'
                   AND DECODE (ROLE_CODE,
                               'RO_COLLEGE_DEAN', 'CDN',
                               'RO_COLLEGE_DEAN_VICE', 'VDN',
                               'RO_DEPT_MANAGER', 'DPT') =
                       P_ROLE;

        CURSOR get_old_user_data (P_SSN VARCHAR2, P_ROLE VARCHAR2)
        IS
            SELECT ROLE_CODE r_code, USER_PIDM, GOBEACC_USERNAME
              FROM spbpers, ROLE_USERS, GOBEACC
             WHERE     spbpers_ssn = P_SSN
                   AND USER_PIDM = spbpers_pidm
                   AND GOBEACC_pidm(+) = spbpers_pidm
                   AND ACTIVE = 'Y'
                   AND DECODE (ROLE_CODE,
                               'RO_COLLEGE_DEAN', 'CDN',
                               'RO_COLLEGE_DEAN_VICE', 'VDN',
                               'RO_DEPT_MANAGER', 'DPT') =
                       P_ROLE;

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

        CURSOR CHECK_OTHER_DEPTS (P_USER_PIDM NUMBER, P_ROLE VARCHAR2)
        IS
            SELECT 'Y'
              FROM users_attributes
             WHERE user_pidm = P_USER_PIDM AND role_code = P_ROLE
             AND ATTRIBUTE_CODE IN ('COLLEGE','DEPARTMENT');

        l_check_value   CHAR;
    BEGIN
        --todo
       -- start looping requests 
        FOR req_rec IN get_exempted_users
        LOOP
         -- check if   exists otherwise log error
            l_check_value := 'N';

            OPEN check_user_role (req_rec.SSN, req_rec.USER_ROLE);

            FETCH check_user_role INTO l_check_value;

            CLOSE check_user_role;

            IF l_check_value = 'N'
            THEN
                log_angez (req_rec.REF_NBR,
                           'Error',
                           'user has not role',
                           'R');
                CONTINUE;
            END IF;



           <<user_loop>>
            FOR user_rec
                IN get_old_user_data (req_rec.SSN, req_rec.USER_ROLE)
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

                -- CHECK IT DOESN'T HAS ANOTHER ATTRIBUTES
                l_check_value := 'N';

                OPEN CHECK_OTHER_DEPTS (user_rec.USER_PIDM, user_rec.R_CODE);

                FETCH CHECK_OTHER_DEPTS INTO l_check_value;

                CLOSE CHECK_OTHER_DEPTS;

                -- DELETE COLLEGE ATTR
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
                            AND ATTRIBUTE_CODE = 'TRN_ALLOW_APPROVALS'
                             ;
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
            END LOOP;
        END LOOP;
    END;


    PROCEDURE deactive_user_inb (P_USERNAME VARCHAR2, P_ROLE VARCHAR2)
    IS
    BEGIN
        NULL;
    END;

    PROCEDURE active_user_wf
    IS
    BEGIN
        NULL;
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
    BEGIN
        INSERT INTO log_angez_process (REF_NBR,
                                       USER_PIDM,
                                       OPERATION,
                                       OPERATION_DESC,
                                       ATTR_VALUE,
                                       INB_USER,
                                       ACTIVITY_DT)
             VALUES (p_ref_nbr,
                     p_user_pidm,
                     p_operation,
                     p_operation_desc,
                     p_attr_value,
                     p_inb_user,
                     SYSDATE);
    END;
END;