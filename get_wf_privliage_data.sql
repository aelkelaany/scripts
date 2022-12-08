/* Formatted on 20/09/2021 13:56:45 (QP5 v5.227.12220.39754) */
 --needs to adding new catalog depts

SELECT f_get_std_id (a.USER_PIDM) emp_id,
       f_get_std_name (a.USER_PIDM) emp_name,
       ATTRIBUTE_VALUE dept_code,
       f_get_desc_fnc ('STVDEPT', ATTRIBUTE_VALUE, 60) department,
       a.USER_PIDM ,spbpers_ssn
  FROM users_attributes a, ROLE_USERS r ,spbpers
 WHERE     a.USER_PIDM = r.USER_PIDM
 and spbpers_pidm=a.USER_PIDM 
 and spbpers_pidm=r.USER_PIDM
       AND ATTRIBUTE_CODE = 'DEPARTMENT'
       AND ACTIVE = 'Y'
       AND a.ROLE_CODE = r.ROLE_CODE
       AND r.ROLE_CODE = 'RO_DEPT_MANAGER'
       AND ATTRIBUTE_VALUE LIKE NVL (:dept, '%')
ORDER BY 3,1 ;
       --- COLLEGES

SELECT f_get_std_id (a.USER_PIDM) emp_id, a.ROLE_CODE , f_get_std_name(a.USER_PIDM) emp_name,ATTRIBUTE_VALUE dept_code ,  f_get_desc_fnc ('STVCOLL', ATTRIBUTE_VALUE, 60)
            department ,
       a.USER_PIDM
  FROM users_attributes a, ROLE_USERS r
 WHERE     a.USER_PIDM = r.USER_PIDM
       AND ATTRIBUTE_CODE = 'COLLEGE'
       AND ACTIVE = 'Y'
       and    a.ROLE_CODE=r.ROLE_CODE
       AND a.ROLE_CODE in ( 'RO_COLLEGE_DEAN','RO_VICE_DEAN')
       AND ATTRIBUTE_VALUE like NVL (:COLLEGE, '%');
       
       
       
       
       
       SELECT 
   DISTINCT  TERM_CODE,  COLL_CODE ,DEPT_CODE ,F_GET_DESC_FNC('STVDEPT',DEPT_CODE,30)
    
FROM BU_APPS.GAC_CRN
WHERE
TERM_CODE = '144320'
AND DEPT_PIDM = 0
AND COLL_CODE = '16'
 ; 
SELECT 
   ROWID, STVDEPT_CODE, STVDEPT_DESC, STVDEPT_ACTIVITY_DATE, 
   STVDEPT_SYSTEM_REQ_IND, STVDEPT_VR_MSG_NO
FROM SATURN.STVDEPT
WHERE
STVDEPT_CODE like '16%'
