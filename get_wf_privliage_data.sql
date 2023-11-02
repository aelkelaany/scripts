/* Formatted on 4/12/2023 1:41:14 PM (QP5 v5.371) */
 --needs to adding new catalog depts

  SELECT f_get_std_id (a.USER_PIDM)                          emp_id,
         f_get_std_name (a.USER_PIDM)                        emp_name,
         ATTRIBUTE_VALUE                                     dept_code,
         f_get_desc_fnc ('STVDEPT', ATTRIBUTE_VALUE, 60)     department,
         a.USER_PIDM,
         spbpers_ssn, (select GOBEACC_USERNAME from GOBEACC  where   spbpers_pidm=GOBEACC_PIDM) username ,r.ACTIVITY_DATE
    FROM users_attributes a, ROLE_USERS r, spbpers  
   WHERE     a.USER_PIDM = r.USER_PIDM
         AND spbpers_pidm = a.USER_PIDM
         AND spbpers_pidm = r.USER_PIDM
         
         AND ATTRIBUTE_CODE = 'DEPARTMENT'
         AND ACTIVE = 'Y'
         AND a.ROLE_CODE = r.ROLE_CODE
         AND r.ROLE_CODE = 'RO_DEPT_MANAGER'
         AND ATTRIBUTE_VALUE LIKE NVL ( :dept, '%')
         and exists (select '1' from users_attributes where USER_PIDM = r.USER_PIDM and ROLE_CODE = r.ROLE_CODE
         and ATTRIBUTE_CODE = 'COLLEGE' AND ATTRIBUTE_VALUE LIKE NVL ( :COLL, '%')  )
ORDER BY 3, 1;







       --- COLLEGES

SELECT f_get_std_id (a.USER_PIDM)                          emp_id,
       a.ROLE_CODE,
       f_get_std_name (a.USER_PIDM)                        emp_name,
       ATTRIBUTE_VALUE                                     dept_code,
       f_get_desc_fnc ('STVCOLL', ATTRIBUTE_VALUE, 60)     department,
       a.USER_PIDM ,(select GOBEACC_USERNAME from GOBEACC  where   r.USER_PIDM=GOBEACC_PIDM) username
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
 WHERE STVDEPT_CODE LIKE '13%'
 order by 1;



SELECT f_get_std_id (a.USER_PIDM)                            emp_id,
       a.ROLE_CODE,
       f_get_std_name (a.USER_PIDM)                          emp_name,
       a.ATTRIBUTE_VALUE                                     dept_code,
       f_get_desc_fnc ('STVCOLL', a.ATTRIBUTE_VALUE, 60)     department,
       a.USER_PIDM
  FROM users_attributes a, ROLE_USERS r, users_attributes s
 WHERE     a.USER_PIDM = r.USER_PIDM
       AND a.ATTRIBUTE_CODE = 'COLLEGE'
       AND ACTIVE = 'Y'
       AND a.ROLE_CODE = r.ROLE_CODE
       AND a.ROLE_CODE IN ('RO_COLLEGE_DEAN', 'RO_VICE_DEAN')
       AND a.ATTRIBUTE_VALUE LIKE NVL ( :COLLEGE, '%')
       AND s.ATTRIBUTE_VALUE LIKE NVL ( :Department, '%')
       AND s.ATTRIBUTE_CODE = 'DEPARTMENT'
       AND a.USER_PIDM = s.USER_PIDM;
       
       
       -- email
       select f_get_std_id(GOBTPAC_PIDM),f_get_std_name (GOBTPAC_PIDM) ,upper(GOBTPAC_LDAP_USER)
       from 
       GOBTPAC where upper(GOBTPAC_LDAP_USER)=upper('falsalmi');
       
       -- id 
       select f_get_std_id(GOBTPAC_PIDM),f_get_std_name (GOBTPAC_PIDM) ,upper(GOBTPAC_LDAP_USER)
       from 
       GOBTPAC where GOBTPAC_PIDM=f_get_pidm('3898');
       
       
        
       -- ssn
       select f_get_std_id(GOBTPAC_PIDM),f_get_std_name (GOBTPAC_PIDM) ,upper(GOBTPAC_LDAP_USER)
       from 
       GOBTPAC ,spbpers 
       where 
       spbpers_pidm=GOBTPAC_PIDM
       and spbpers_ssn= '1040696682' ;
       
       
       
         select f_get_std_id(GOBEACC_PIDM),f_get_std_name (GOBEACC_PIDM)  ,GOBEACC_USERNAME
       from 
       GOBEACC ,spbpers 
       where 
       spbpers_pidm=GOBEACC_PIDM
       and spbpers_ssn= '1040696682' ;
       
        grant ALL on  ROLE_USERS to RZAHRANI ;
        
        
         