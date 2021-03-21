/* Formatted on 4/11/2019 12:56:08 PM (QP5 v5.227.12220.39754) */
DECLARE
   CURSOR coll_cur
   IS
      SELECT DISTINCT
             f_get_pidm (COLLEGE_DEAN_ID) USER_PIDM,
             'DEAN' role,
             COLLEGE_CODE
        FROM course_temp
       WHERE     COLLEGE_CODE IS NOT NULL
             AND COLLEGE_DEAN_ID IS NOT NULL
             
      UNION
      SELECT DISTINCT
             f_get_pidm (VICE_DEAN_ID) USER_PIDM, 'VDEAN' role, COLLEGE_CODE
        FROM course_temp
       WHERE     COLLEGE_CODE IS NOT NULL
             AND VICE_DEAN_ID IS NOT NULL
             
      UNION
      SELECT DISTINCT
             f_get_pidm (DEPARTMENT_MANAGER_ID) USER_PIDM,
             'DMGR' role,
             COLLEGE_CODE
        FROM course_temp
       WHERE     COLLEGE_CODE IS NOT NULL
             AND DEPARTMENT_MANAGER_ID IS NOT NULL
              
      ORDER BY 2;

   CURSOR department_cur (
      p_coll_code VARCHAR2)
   IS
      SELECT DISTINCT DEPARTMENT_CODE
        FROM course_temp
       WHERE     COLLEGE_CODE = p_coll_code
             AND DEPARTMENT_CODE IS NOT NULL
             AND DEPARTMENT_CODE <> '10'
              ;

   CURSOR DMGR
   IS
      SELECT DISTINCT
             f_get_pidm (DEPARTMENT_MANAGER_ID) USER_PIDM, DEPARTMENT_CODE
        FROM course_temp
       WHERE     DEPARTMENT_CODE IS NOT NULL
             AND DEPARTMENT_MANAGER_ID IS NOT NULL;

BEGIN
   FOR rec IN coll_cur
   LOOP
      BEGIN
         IF REC.ROLE <> 'DMGR'
         THEN
            FOR drec IN department_cur (rec.COLLEGE_CODE)
            LOOP
               BEGIN
                  INSERT INTO users_attributes (USER_PIDM,
                                                ATTRIBUTE_CODE,
                                                ATTRIBUTE_VALUE,
                                                ACTIVITY_DATE,
                                                USER_ID)
                       VALUES (rec.USER_PIDM,
                               'DEPARTMENT',
                               drec.DEPARTMENT_CODE,
                               SYSDATE,
                               USER);
               EXCEPTION
                  WHEN DUP_VAL_ON_INDEX
                  THEN
                     NULL;
               END;
            END LOOP;
         END IF;

         INSERT INTO users_attributes (USER_PIDM,
                                       ATTRIBUTE_CODE,
                                       ATTRIBUTE_VALUE,
                                       ACTIVITY_DATE,
                                       USER_ID)
              VALUES (rec.USER_PIDM,
                      'COLLEGE',
                      rec.COLLEGE_CODE,
                      SYSDATE,
                      USER);
      EXCEPTION
         WHEN DUP_VAL_ON_INDEX
         THEN
            NULL;
      END;
   END LOOP;


   ------
   FOR rec IN DMGR
   LOOP
      BEGIN
         INSERT INTO users_attributes (USER_PIDM,
                                       ATTRIBUTE_CODE,
                                       ATTRIBUTE_VALUE,
                                       ACTIVITY_DATE,
                                       USER_ID)
              VALUES (rec.USER_PIDM,
                      'DEPARTMENT',
                      rec.DEPARTMENT_CODE,
                      SYSDATE,
                      USER);
      EXCEPTION
         WHEN DUP_VAL_ON_INDEX
         THEN
            NULL;
      END;
   END LOOP;
END;