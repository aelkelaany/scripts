/* Formatted on 4/26/2020 2:01:07 PM (QP5 v5.354) */
DECLARE
    L_CRN            VARCHAR2 (6) := :CRN;
    L_TERM_CODE      VARCHAR2 (6) := '144020';
    L_COLLEGE       SCBCRSE.SCBCRSE_COLL_CODE%type;
    L_DEPARTMENT     SCBCRSE.SCBCRSE_DEPT_CODE%type;
    l_gradable_ind   VARCHAR2 (5);
    l_title          SCBCRSE.SCBCRSE_title%type;

    CURSOR get_coll_dept IS
        SELECT SCBCRSE_COLL_CODE,
               SCBCRSE_DEPT_CODE,
                SCBCRSE_title,
               ssbsect_gradable_ind 
          FROM SCBCRSE, ssbsect
         WHERE     SCBCRSE_EFF_TERM =
                   (SELECT MAX (SCBCRSE_EFF_TERM)
                      FROM SCBCRSE
                     WHERE     SCBCRSE_SUBJ_CODE = ssbsect_SUBJ_CODE
                           AND SCBCRSE_CRSE_NUMB = ssbsect_CRSE_NUMB)
               AND SCBCRSE_SUBJ_CODE = ssbsect_SUBJ_CODE
               AND SCBCRSE_CRSE_NUMB = ssbsect_CRSE_NUMB
               AND ssbsect_term_code = l_term_code
               AND ssbsect_crn = l_crn;

    CURSOR CHECK_EX_CRNS IS
        SELECT TERM_CODE,
               CRN,
               DEPT_MANAGER_ID,
               DEPT_MANAGER_PIDM,
               VICE_DEAN_ID,
               VICE_DEAN_PIDM,
               DEAN_ID,
               DEAN_PIDM
          FROM BU_APPS.GRADES_APPROVAL_EXECLUDED_CRN
         WHERE TERM_CODE = L_TERM_CODE AND CRN = L_CRN;

    L_EX_REC         CHECK_EX_CRNS%ROWTYPE;



    CURSOR get_header IS
        SELECT a.USER_PIDM     DMGR_PIDM
          FROM ROLE_USERS a
         WHERE     ROLE_CODE = 'RO_DEPT_MANAGER'
               AND EXISTS
                       (SELECT 'Y'
                          FROM USERS_ATTRIBUTES t1
                         WHERE     t1.USER_PIDM = a.USER_PIDM
                               AND t1.ATTRIBUTE_CODE = 'COLLEGE'
                               AND t1.ATTRIBUTE_VALUE = L_COLLEGE)
               AND EXISTS
                       (SELECT 'Y'
                          FROM USERS_ATTRIBUTES t2
                         WHERE     t2.USER_PIDM = a.USER_PIDM
                               AND t2.ATTRIBUTE_CODE = 'DEPARTMENT'
                               AND t2.ATTRIBUTE_VALUE = L_DEPARTMENT)
               AND ACTIVE = 'Y';

    l_DMGR_PIDM      NUMBER (8);

    CURSOR get_vice IS
        SELECT a.USER_PIDM     VICE_PIDM
          FROM ROLE_USERS a
         WHERE     ROLE_CODE = 'RO_VICE_DEAN'
               AND EXISTS
                       (SELECT 'Y'
                          FROM USERS_ATTRIBUTES t1
                         WHERE     t1.USER_PIDM = a.USER_PIDM
                               AND t1.ATTRIBUTE_CODE = 'COLLEGE'
                               AND t1.ATTRIBUTE_VALUE = L_COLLEGE)
               AND EXISTS
                       (SELECT 'Y'
                          FROM USERS_ATTRIBUTES t2
                         WHERE     t2.USER_PIDM = a.USER_PIDM
                               AND t2.ATTRIBUTE_CODE = 'DEPARTMENT'
                               AND t2.ATTRIBUTE_VALUE = L_DEPARTMENT)
               AND ACTIVE = 'Y';

    l_VICE_PIDM      NUMBER (8);

    CURSOR get_dean IS
        SELECT a.USER_PIDM     DEAN_PIDM
          FROM ROLE_USERS a
         WHERE     ROLE_CODE = 'RO_COLLEGE_DEAN_GA'
               AND EXISTS
                       (SELECT 'Y'
                          FROM USERS_ATTRIBUTES t1
                         WHERE     t1.USER_PIDM = a.USER_PIDM
                               AND t1.ATTRIBUTE_CODE = 'COLLEGE'
                               AND t1.ATTRIBUTE_VALUE = L_COLLEGE)
               AND EXISTS
                       (SELECT 'Y'
                          FROM USERS_ATTRIBUTES t2
                         WHERE     t2.USER_PIDM = a.USER_PIDM
                               AND t2.ATTRIBUTE_CODE = 'DEPARTMENT'
                               AND t2.ATTRIBUTE_VALUE = L_DEPARTMENT)
               AND ACTIVE = 'Y';

    l_DEAN_PIDM      NUMBER (8);
BEGIN
   

    OPEN get_coll_dept;

    FETCH get_coll_dept
        INTO l_college,
             l_department,
            
             l_title,l_gradable_ind;

    CLOSE get_coll_dept;

    DBMS_OUTPUT.PUT_LINE (
           l_title
        || '  '
        || L_CRN
        || '       '
        || 'COLLEEG  : '
        || l_college
        || '   DEPARTMENT : '
        || l_department
        || '  GRADEABLE : '
        || l_gradable_ind) ;
 OPEN CHECK_EX_CRNS;

    FETCH CHECK_EX_CRNS INTO L_EX_REC;

    IF L_EX_REC.DEPT_MANAGER_ID is  not null 
    THEN
        DBMS_OUTPUT.PUT_LINE (
        '**EXCLUDED   ***'||
               'HEAD OF DEPARTMENT :'
            || L_EX_REC.DEPT_MANAGER_ID
            || '--'
            || F_GET_STD_NAME (L_EX_REC.DEPT_MANAGER_PIDM));
        DBMS_OUTPUT.PUT_LINE (
               'VICE DEAN :'
            || L_EX_REC.VICE_DEAN_ID
            || '--'
            || F_GET_STD_NAME (L_EX_REC.VICE_DEAN_PIDM));
        DBMS_OUTPUT.PUT_LINE (
               'COLLEGE DEAN:'
            || L_EX_REC.DEAN_ID
            || '--'
            || F_GET_STD_NAME (L_EX_REC.DEAN_PIDM));
             CLOSE CHECK_EX_CRNS;
             return ;
    END IF;

    CLOSE CHECK_EX_CRNS;
OPEN get_header;

    FETCH get_header INTO l_dmgr_pidm;

    CLOSE get_header;

    DBMS_OUTPUT.PUT_LINE (
           'HEAD OF DEPARTMENT :'
        || F_GET_STD_id (l_dmgr_pidm)
        || '--'
        || F_GET_STD_NAME (l_dmgr_pidm));

    ---
    OPEN get_vice;

    FETCH get_vice INTO l_vice_pidm;

    CLOSE get_vice;

    DBMS_OUTPUT.PUT_LINE (
           'VICE DEAN :'
        || F_GET_STD_id (l_vice_pidm)
        || '--'
        || F_GET_STD_NAME (l_vice_pidm));

    -----
    OPEN get_dean;

    FETCH get_dean INTO l_dean_pidm;

    CLOSE get_dean;

    DBMS_OUTPUT.PUT_LINE (
           'COLLEGE DEAN :'
        || F_GET_STD_id (l_dean_pidm)
        || '--'
        || F_GET_STD_NAME (l_dean_pidm));
END;