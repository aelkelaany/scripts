/* Formatted on 3/16/2023 9:38:13 PM (QP5 v5.371) */
 --needs to adding new catalog depts
insert into users_attributes
  SELECT distinct 'RO_COLLEGE_DEAN',32800,/*f_get_std_id (g.USER_PIDM)                          emp_id,
         f_get_std_name (g.USER_PIDM)                        emp_name,*/
         ATTRIBUTE_CODE,
         ATTRIBUTE_VALUE  ,sysdate                                    ,user 
         /*,f_get_desc_fnc ('STVDEPT', ATTRIBUTE_VALUE, 60)     department,
         g.USER_PIDM,
         spbpers_ssn*/
    FROM users_attributes g, ROLE_USERS r, spbpers
   WHERE     g.USER_PIDM = r.USER_PIDM
         AND spbpers_pidm = g.USER_PIDM
         AND spbpers_pidm = r.USER_PIDM
         AND ATTRIBUTE_CODE = 'DEPARTMENT'
         AND ACTIVE = 'Y'
         AND g.ROLE_CODE = r.ROLE_CODE
         AND r.ROLE_CODE = 'RO_DEPT_MANAGER'
         -- AND ATTRIBUTE_VALUE LIKE NVL (:dept, '%')
         AND EXISTS
                 (SELECT '1'
                    FROM users_attributes a, ROLE_USERS r
                   WHERE     a.USER_PIDM = r.USER_PIDM
                         AND a.USER_PIDM = g.USER_PIDM
                         AND ATTRIBUTE_CODE = 'COLLEGE'
                         AND ACTIVE = 'Y'
                         AND a.ROLE_CODE = r.ROLE_CODE
                         AND a.ROLE_CODE IN ('RO_DEPT_MANAGER')
                         AND ATTRIBUTE_VALUE LIKE NVL ( :COLLEGE, '%'))
ORDER BY 2, 1;

       --- COLLEGES

SELECT f_get_std_id (a.USER_PIDM)                          emp_id,
       a.ROLE_CODE,
       f_get_std_name (a.USER_PIDM)                        emp_name,
       ATTRIBUTE_VALUE                                     dept_code,
       f_get_desc_fnc ('STVCOLL', ATTRIBUTE_VALUE, 60)     department,
       a.USER_PIDM
  FROM users_attributes a, ROLE_USERS r
 WHERE     a.USER_PIDM = r.USER_PIDM
       AND ATTRIBUTE_CODE = 'COLLEGE'
       AND ACTIVE = 'Y'
       AND a.ROLE_CODE = r.ROLE_CODE
       AND a.ROLE_CODE IN ('RO_COLLEGE_DEAN', 'RO_VICE_DEAN')
       AND ATTRIBUTE_VALUE LIKE NVL ( :COLLEGE, '%');



SELECT DISTINCT TERM_CODE,
                COLL_CODE,
                DEPT_CODE,
                F_GET_DESC_FNC ('STVDEPT', DEPT_CODE, 30)
  FROM BU_APPS.GAC_CRN
 WHERE TERM_CODE = '144320' AND DEPT_PIDM = 0 AND COLL_CODE = '16';

SELECT ROWID,
       STVDEPT_CODE,
       STVDEPT_DESC,
       STVDEPT_ACTIVITY_DATE,
       STVDEPT_SYSTEM_REQ_IND,
       STVDEPT_VR_MSG_NO
  FROM SATURN.STVDEPT
 WHERE STVDEPT_CODE LIKE '16%'