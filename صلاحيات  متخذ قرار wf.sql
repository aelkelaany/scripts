/* Formatted on 10/25/2023 9:11:45 AM (QP5 v5.371) */
  SELECT f_get_std_id (g.USER_PIDM)      emp_id,
         f_get_std_name (g.USER_PIDM)    emp_name,
         r.ROLE_CODE,
         ATTRIBUTE_CODE,
         ATTRIBUTE_VALUE,
         CASE ATTRIBUTE_CODE  
             WHEN 'COLLEGE'
             THEN
                 f_get_desc_fnc ('STVcoll', ATTRIBUTE_VALUE, 60)
             when 'DEPARTMENT' then 
                 f_get_desc_fnc ('STVDEPT', ATTRIBUTE_VALUE, 60)
                 
         END     description   ,
         g.USER_PIDM,
         spbpers_ssn
    FROM users_attributes g, ROLE_USERS r, spbpers
   WHERE     g.USER_PIDM = r.USER_PIDM
         AND spbpers_pidm = g.USER_PIDM
         AND spbpers_pidm = r.USER_PIDM
         AND ACTIVE = 'Y'
         AND g.ROLE_CODE = r.ROLE_CODE
         AND r.USER_PIDM = f_get_pidm ( :user_id)
ORDER BY 3, 4, 5;