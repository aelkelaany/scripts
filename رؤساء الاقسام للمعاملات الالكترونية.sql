/* Formatted on 11/2/2023 10:05:24 AM (QP5 v5.371) */
  SELECT DISTINCT
         c.ATTRIBUTE_VALUE
             coll_code,
         f_get_desc_fnc ('stvcoll', c.ATTRIBUTE_VALUE, 30)
             coll_desc,
         stvdept_CODE
             AS "Department  Code",
         b.STVDEPT_DESC
             AS "Department Name",
         DECODE (F_GET_STD_ID (E.USER_PIDM), 0, '', F_GET_STD_ID (E.USER_PIDM))
             AS "Department Manager ID",
         DECODE (F_GET_STD_NAME (E.USER_PIDM),
                 '0', '',
                 F_GET_STD_NAME (E.USER_PIDM))
             AS "Department Manager Name"
    FROM STVdept B, USERS_ATTRIBUTES e, USERS_ATTRIBUTES c
   WHERE     B.STVdept_CODE = e.ATTRIBUTE_VALUE
         AND NVL (e.ATTRIBUTE_CODE, 'DEPARTMENT') = 'DEPARTMENT'
         AND e.ROLE_CODE = 'RO_DEPT_MANAGER'
         AND EXISTS
                 (SELECT '1'
                    FROM ROLE_USERS
                   WHERE     USER_PIDM = e.USER_PIDM
                         AND ROLE_CODE = 'RO_DEPT_MANAGER'
                         AND ACTIVE = 'Y')
         AND c.ROLE_CODE = e.ROLE_CODE
         AND c.USER_PIDM = E.USER_PIDM
         AND c.ATTRIBUTE_CODE = 'COLLEGE'
ORDER BY 1, 3