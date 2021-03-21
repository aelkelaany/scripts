/* Formatted on 4/9/2019 12:51:25 PM (QP5 v5.227.12220.39754) */
/*delete course_temp ;
create table ssbcrse_tmp090419 as select * from scbcrse ;
CREATE TABLE ROLE_USERS_TMP090419 AS SELECT * FROM ROLE_USERS;
 CREATE TABLE USERS_ATTRIBUTES_TMP090419 AS SELECT * FROM USERS_ATTRIBUTES;
create table execluded_crn ( crn varchar2(8) primary key ,dept_manager_pidm number(8),vice_dean_pidm number(8),dean_pidm number(8)) ;*/

--COLLEGE CODE

UPDATE scbcrse A
   SET A.SCBCRSE_COLL_CODE =
          (SELECT COLLEGE_CODE
             FROM course_temp
            WHERE     COURSE_NUMBER =
                         A.SCBCRSE_SUBJ_CODE || A.SCBCRSE_CRSE_NUMB
                   and rownum<2
                  and COLLEGE_CODE is not null )
 WHERE A.SCBCRSE_EFF_TERM =
          (SELECT MAX (SCBCRSE_EFF_TERM)
             FROM SCBCRSE
            WHERE     SCBCRSE_SUBJ_CODE = A.SCBCRSE_SUBJ_CODE
                  AND SCBCRSE_CRSE_NUMB = A.SCBCRSE_CRSE_NUMB
                  AND SCBCRSE_EFF_TERM <= '143920') 
and A.SCBCRSE_SUBJ_CODE || A.SCBCRSE_CRSE_NUMB   in ( select course_number from course_temp   )
-- DEPARTMENTS

UPDATE scbcrse A
   SET A.SCBCRSE_DEPT_CODE =
          (SELECT DEPARTMENT_CODE
             FROM course_temp
            WHERE     COURSE_NUMBER =
                         A.SCBCRSE_SUBJ_CODE || A.SCBCRSE_CRSE_NUMB
                  AND ROWNUM < 2 and DEPARTMENT_CODE is not null )
 WHERE     
        A.SCBCRSE_EFF_TERM =
              (SELECT MAX (SCBCRSE_EFF_TERM)
                 FROM SCBCRSE
                WHERE     SCBCRSE_SUBJ_CODE = A.SCBCRSE_SUBJ_CODE
                      AND SCBCRSE_CRSE_NUMB = A.SCBCRSE_CRSE_NUMB
                      AND SCBCRSE_EFF_TERM <= '143920')
                      and A.SCBCRSE_SUBJ_CODE || A.SCBCRSE_CRSE_NUMB   in ( select course_number from course_temp   );

                      --INSERT DEPT_MANAGERS

INSERT INTO ROLE_USERS
   SELECT  distinct 'RO_DEPT_MANAGER',
          f_get_pidm(DEPARTMENT_MANAGER_ID),
          SYSDATE,
          USER,
          'Y',
          '',
          'Y'
     FROM course_temp
    WHERE NOT EXISTS
                 (SELECT '1'
                    FROM ROLE_USERS
                   WHERE     USER_PIDM = f_get_pidm(DEPARTMENT_MANAGER_ID)
                         AND ROLE_CODE = 'RO_DEPT_MANAGER')
                         and DEPARTMENT_MANAGER_ID is not null ;
                         --INSERT VICE_DEAN

INSERT INTO ROLE_USERS
   SELECT  distinct'RO_VICE_DEAN',
          f_get_pidm(VICE_DEAN_ID),
          SYSDATE,
          USER,
          'Y',
          '',
          'Y'
     FROM course_temp
    WHERE NOT EXISTS
                 (SELECT '1'
                    FROM ROLE_USERS
                   WHERE     USER_PIDM = f_get_pidm(VICE_DEAN_ID)
                         AND ROLE_CODE = 'RO_VICE_DEAN')
                         and VICE_DEAN_ID is not null ;
                                                  --INSERT COLL_DEAN

INSERT INTO ROLE_USERS
   SELECT distinct 'RO_COLLEGE_DEAN',
          f_get_pidm(COLLEGE_DEAN_ID),
          SYSDATE,
          USER,
          'Y',
          '',
          'Y'
     FROM course_temp
    WHERE NOT EXISTS
                 (SELECT '1'
                    FROM ROLE_USERS
                   WHERE     USER_PIDM = f_get_pidm(COLLEGE_DEAN_ID)
                         AND ROLE_CODE = 'RO_COLLEGE_DEAN')
                         and COLLEGE_DEAN_ID is not null;
                         
                         