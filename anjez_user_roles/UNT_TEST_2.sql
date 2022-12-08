SELECT *
              FROM anjez_users_roles
             WHERE RQST_STATUS = 'P' AND DCN_TYP = 'E' ;
             
             declare 
             begin 
               intg_angez_users_roles.deactive_user_wf;
             end ; 
             
             
             SELECT ROLE_CODE r_code, USER_PIDM, GOBEACC_USERNAME
          FROM spbpers, ROLE_USERS, GOBEACC
         WHERE     spbpers_ssn = :P_SSN
               AND USER_PIDM = spbpers_pidm
               AND GOBEACC_pidm(+) = spbpers_pidm
               AND ACTIVE = 'Y'
               AND DECODE (ROLE_CODE,
                           'RO_COLLEGE_DEAN', 'CDN',
                           'RO_COLLEGE_DEAN_VICE', 'VDN',
                           'RO_DEPT_MANAGER', 'DPT') =
                   :P_ROLE;
                   
                   
                   ---------
                   
                     select ATTRIBUTE_CODE ,ATTRIBUTE_VALUE from users_attributes
                       where user_pidm=33029
                       and role_code='RO_DEPT_MANAGER'
                       AND ATTRIBUTE_CODE='DEPARTMENT'
                       AND ATTRIBUTE_VALUE IN (SELECT GENERAL_DEPT FROM SYMTRCL_DEPT_MAPPING 
                       WHERE DEPT_CODE='3201' 
                       UNION
                       SELECT '3201' FROM DUAL )