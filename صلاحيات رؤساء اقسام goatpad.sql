 SELECT DISTINCT  username,
        account_status,
       created,
       NVL (TRIM (GURLOGN_FIRST_NAME || ' ' || GURLOGN_last_NAME),
            '€Ì— „ «Õ')
          emp_name,
       GOVUROL2_SECURITY_CLASS ,(select replace(GORFBPR_FBPR_CODE,'DEPT') from GORFBPR WHERE  GORFBPR_FGAC_USER_ID=username )
  FROM dba_users, GURLOGN, GOVUROL2
 WHERE     account_status NOT LIKE '%LOCKED%'
       AND GURLOGN_USER = username
       --order by lock_date
       -- and lock_date is null
       AND GOVUROL2_USERID = username
       AND GOVUROL2_SECURITY_CLASS   IN ('BU_DEPARTMENT_MANAGER')
      -- AND GOVUROL2_SECURITY_CLASS   IN ('BU_DEPARTMENT_MANAGER','BU_VICE_DEAN_M','BU_VICE_DEAN','BU_DEAN','BU_DEAN_REP')
       AND GOVUROL2_SECURITY_CLASS NOT IN ('BU_LOGIN')
       AND USERNAME NOT IN ('MAALZAHRANI','CHANCELLOR')
       AND EXISTS (select 'x' from 
       GORFBPR
       where GORFBPR_FGAC_USER_ID=username
       )
       ORDER BY 5;
       --------------------------------
       
Insert into DEV_SYS_PARAMETERS
   (MODULE, PARAMETER_CODE, SEQUENCE_NO, PARAMETER_VALUE, ACTIVITY_DATE, 
    USER_ID, ACTIVE, SYSTEM_REQ_IND)
 select
    'GENERAL', 'UPDATE_BANNER_PASSWORD', 12+rownum, col01, sysdate, 
    'BU_APPS', 'Y', ''
    
    from BU_DEV.TMP_TBL03
 where not exists 
 (select 'x' from DEV_SYS_PARAMETERS
 where 
module = 'GENERAL'
             AND parameter_code = 'UPDATE_BANNER_PASSWORD'
             AND parameter_value =  col01)
             
             
             
             F_FACULTY_PWD_VALIDATE
             
             
             ---******************************new query --------------------
             /* Formatted on 2/23/2020 3:00:44 PM (QP5 v5.227.12220.39754) */
  SELECT DISTINCT
         username,
         decode (account_status ,'LOCKED','„€·ﬁ','EXPIRED','ÃœÌœ','OPEN','›⁄«·','EXPIRED & LOCKED','„€·ﬁ',account_status) account_status,
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