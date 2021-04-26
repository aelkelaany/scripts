 --needs to adding new catalog depts
SELECT f_get_std_id (a.USER_PIDM) emp_id,
       f_get_std_name (a.USER_PIDM) emp_name,ATTRIBUTE_VALUE dept_code ,  f_get_desc_fnc ('STVDEPT', ATTRIBUTE_VALUE, 60)
            department ,
       a.USER_PIDM
  FROM users_attributes a, ROLE_USERS r
 WHERE     a.USER_PIDM = r.USER_PIDM
       AND ATTRIBUTE_CODE = 'DEPARTMENT'
       AND ACTIVE = 'Y'
       and    a.ROLE_CODE=r.ROLE_CODE
       AND r.ROLE_CODE = 'RO_DEPT_MANAGER'
       AND ATTRIBUTE_VALUE like NVL (:dept, '%');
       
       --- COLLEGES 
       
       SELECT f_get_std_id (a.USER_PIDM) emp_id,
       f_get_std_name (a.USER_PIDM) emp_name,ATTRIBUTE_VALUE dept_code ,  f_get_desc_fnc ('STVCOLL', ATTRIBUTE_VALUE, 60)
            department ,
       a.USER_PIDM
  FROM users_attributes a, ROLE_USERS r
 WHERE     a.USER_PIDM = r.USER_PIDM
       AND ATTRIBUTE_CODE = 'COLLEGE'
       AND ACTIVE = 'Y'
       and    a.ROLE_CODE=r.ROLE_CODE
       AND a.ROLE_CODE = 'RO_COLLEGE_DEAN'
       AND ATTRIBUTE_VALUE like NVL (:dept, '%');
       
       
   