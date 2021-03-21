/* Formatted on 2/23/2020 3:00:44 PM (QP5 v5.227.12220.39754) */
  SELECT DISTINCT
         username,
         decode (account_status ,'LOCKED','„€·ﬁ','EXPIRED','ÃœÌœ','OPEN','›⁄«·',account_status) account_status,
         created,
         NVL (TRIM (GURLOGN_FIRST_NAME || ' ' || GURLOGN_last_NAME),
              '€Ì— „ «Õ')
            emp_name,
         GOVUROL2_SECURITY_CLASS,
         REPLACE (GORFBPR_FBPR_CODE, 'DEPT_') dept_code,
         f_get_desc_fnc ('STVDEPT', REPLACE (GORFBPR_FBPR_CODE, 'DEPT_'), 60)
            department
    FROM dba_users,
         GURLOGN,
         GOVUROL2,
         GORFBPR
   WHERE     GURLOGN_USER = username
         AND GORFBPR_FGAC_USER_ID = username
         AND GORFBPR_FBPR_CODE LIKE '%DEPT%'
         AND GOVUROL2_USERID = username
         AND GOVUROL2_SECURITY_CLASS IN ('BU_DEPARTMENT_MANAGER')
         AND GOVUROL2_SECURITY_CLASS NOT IN ('BU_LOGIN')
         AND USERNAME NOT IN ('MAALZAHRANI', 'CHANCELLOR')
         
         AND EXISTS
                (SELECT 'x'
                   FROM GORFBPR
                  WHERE GORFBPR_FGAC_USER_ID = username)
                  and  REPLACE (GORFBPR_FBPR_CODE, 'DEPT_') like nvl(:dept,'%')
ORDER BY 6;