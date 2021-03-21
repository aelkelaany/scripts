SELECT username, account_status, created, nvl(trim(GURLOGN_FIRST_NAME||' '||GURLOGN_last_NAME),'€Ì— „ «Õ') emp_name, lock_date
  FROM  dba_users,GURLOGN
 WHERE account_status not like '%LOCKED%'
 AND GURLOGN_USER=username
 --order by lock_date
-- and lock_date is null
 
 AND EXISTS (
 SELECT 'X' FROM GOVUROL2
 WHERE  GOVUROL2_USERID=username
 AND  GOVUROL2_SECURITY_CLASS not like 'BU%'
 ) ;
 
 
/* Formatted on 9/16/2019 9:53:24 AM (QP5 v5.227.12220.39754) */
SELECT DISTINCT  username,
        account_status,
       created,
       NVL (TRIM (GURLOGN_FIRST_NAME || ' ' || GURLOGN_last_NAME),
            '€Ì— „ «Õ')
          emp_name,
       GOVUROL2_SECURITY_CLASS
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
  

 ---------------------’·«ÕÌ«  „” Œœ„Ì «·‰Ÿ«„ »«·‘«‘« 
 SELECT DISTINCT
       username,
       account_status,
       created,
       NVL (TRIM (GURLOGN_FIRST_NAME || ' ' || GURLOGN_last_NAME),
            '€Ì— „ «Õ')        emp_name,
       GOVUROL2_SECURITY_CLASS,
       a.GURUOBJ_OBJECT,
       a.GURUOBJ_ROLE,
       GUBOBJS_desc,
       '’·«ÕÌ… „»«‘—…'    AS "TYPE"
  FROM dba_users,
       GURLOGN,
       GOVUROL2,
       GURUOBJ  a,
       GUBOBJS
 WHERE     account_status NOT LIKE '%LOCKED%'
       AND GURLOGN_USER = username
       --order by lock_date
       -- and lock_date is null
       AND GOVUROL2_USERID = username
       --AND GOVUROL2_SECURITY_CLASS   IN ('BU_DEPARTMENT_MANAGER')
       -- AND GOVUROL2_SECURITY_CLASS   IN ('BU_DEPARTMENT_MANAGER','BU_VICE_DEAN_M','BU_VICE_DEAN','BU_DEAN','BU_DEAN_REP')
       -- AND GOVUROL2_SECURITY_CLASS NOT IN ('BU_LOGIN')
       --AND USERNAME NOT IN ('MAALZAHRANI','CHANCELLOR')
       AND EXISTS
               (SELECT 'x'
                  FROM GORFBPR
                 WHERE GORFBPR_FGAC_USER_ID = username)
       AND a.GURUOBJ_USERID = GURLOGN_USER
       AND GUBOBJS_NAME = a.GURUOBJ_OBJECT
       AND GOVUROL2_SECURITY_CLASS IS NULL
     --AND a.GURUOBJ_OBJECT = 'SSASECT' --- object 
      -- AND username = 'SSALOMARI'  ---------- user
UNION --++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
SELECT DISTINCT
       username,
       account_status,
       created,
       NVL (TRIM (GURLOGN_FIRST_NAME || ' ' || GURLOGN_last_NAME),
            '€Ì— „ «Õ')    emp_name,
       GOVUROL2_SECURITY_CLASS,
       a.GURUOBJ_OBJECT,
       a.GURUOBJ_ROLE,
       GUBOBJS_desc,
       'IN'
  FROM dba_users,
       GURLOGN,
       GOVUROL2,
       GURUOBJ  a,
       GUBOBJS
 WHERE     account_status NOT LIKE '%LOCKED%'
       AND GURLOGN_USER = username
       --order by lock_date
       -- and lock_date is null
       AND GOVUROL2_USERID = username
       --AND GOVUROL2_SECURITY_CLASS   IN ('BU_DEPARTMENT_MANAGER')
       -- AND GOVUROL2_SECURITY_CLASS   IN ('BU_DEPARTMENT_MANAGER','BU_VICE_DEAN_M','BU_VICE_DEAN','BU_DEAN','BU_DEAN_REP')
       --AND GOVUROL2_SECURITY_CLASS NOT IN ('BU_LOGIN')
       --AND USERNAME NOT IN ('MAALZAHRANI','CHANCELLOR')
       AND EXISTS
               (SELECT 'x'
                  FROM GORFBPR
                 WHERE GORFBPR_FGAC_USER_ID = username)
       AND a.GURUOBJ_USERID = GOVUROL2_SECURITY_CLASS
       AND GUBOBJS_NAME = a.GURUOBJ_OBJECT
         AND GOVUROL2_SECURITY_CLASS IS not NULL
       --AND a.GURUOBJ_OBJECT = 'SSASECT' --- object 
       -- AND username = 'SSALOMARI'  ---------- user
ORDER BY 1;
 
 
 -----------++++++++++++++++++++++++++++++++++++++++++++++++
 SELECT DISTINCT
       username,
       account_status,
       created,
       NVL (TRIM (GURLOGN_FIRST_NAME || ' ' || GURLOGN_last_NAME),
            '€Ì— „ «Õ')    emp_name,
       REPLACE(GORFBPR_FBPR_CODE,'COLL_') COLLEGE_CODE ,decode(GOVUROL2_SECURITY_CLASS, 'BU_DEPARTMENT_MANAGER','—∆Ì” «·ﬁ”„ / „‘—›… «·ﬁ”„','BU_VICE_DEAN_M','ÊﬂÌ·… «·ﬂ·Ì…',
       'BU_VICE_DEAN','ÊﬂÌ· «·ﬂ·Ì…','BU_COLLEGE_DEAN','⁄„Ìœ «·ﬂ·Ì…',
       'BU_DEAN_REP','„‰œÊ» ⁄„Ìœ «·ﬂ·Ì…') as "role"
  FROM dba_users,
       GURLOGN,
       GOVUROL2,
       
       GORFBPR
 WHERE     account_status   LIKE '%OPEN%'
       AND GURLOGN_USER = username
       
       AND GOVUROL2_USERID = username
        
         AND GOVUROL2_SECURITY_CLASS   IN ('BU_DEPARTMENT_MANAGER','BU_VICE_DEAN_M','BU_VICE_DEAN','BU_COLLEGE_DEAN','BU_DEAN_REP')
 

       AND GORFBPR_FGAC_USER_ID = username
       ;
       
       --------=======================================
       SELECT A.* ,C.STVDEPT_DESC ,B.STVCOLL_DESC   FROM  (
  SELECT DISTINCT
         username,
         NVL (TRIM (GURLOGN_FIRST_NAME || ' ' || GURLOGN_last_NAME),
              '€Ì— „ «Õ')
             emp_name,
         DECODE (
             GOVUROL2_SECURITY_CLASS,
             'BU_DEPARTMENT_MANAGER', '—∆Ì” «·ﬁ”„ / „‘—›… «·ﬁ”„',
             'BU_VICE_DEAN_M', 'ÊﬂÌ·… «·ﬂ·Ì…',
             'BU_VICE_DEAN', 'ÊﬂÌ· «·ﬂ·Ì…',
             'BU_COLLEGE_DEAN', '⁄„Ìœ «·ﬂ·Ì…',
             'BU_DEAN_REP', '„‰œÊ» ⁄„Ìœ «·ﬂ·Ì…')
             AS "role",
         DECODE (SUBSTR (GORFBPR_FBPR_CODE, 1, 4),
                 'COLL', REPLACE (GORFBPR_FBPR_CODE, 'COLL_'))
             AS "COLLEGE_CODE",
         DECODE (SUBSTR (GORFBPR_FBPR_CODE, 1, 4),
                 'DEPT', REPLACE (GORFBPR_FBPR_CODE, 'DEPT_'))
             DEPT_CODE ,GURLOGN_INB_LOGON_COUNT
    FROM dba_users,
         GURLOGN,
         GOVUROL2,
         GORFBPR
   WHERE     account_status NOT LIKE '%LOCK%'
         AND GURLOGN_USER = username
         AND GOVUROL2_USERID = username
         AND GOVUROL2_SECURITY_CLASS IN ('BU_DEPARTMENT_MANAGER',
                                         'BU_VICE_DEAN_M',
                                         'BU_VICE_DEAN',
                                         'BU_COLLEGE_DEAN',
                                         'BU_DEAN_REP')
         AND GORFBPR_FGAC_USER_ID = username
         AND REPLACE (GORFBPR_FBPR_CODE, 'COLL_') NOT IN ('12', '22')
) A ,STVCOLL B,
         STVDEPT C
         WHERE 
        A.COLLEGE_CODE=B.STVCOLL_CODE(+)
          AND A.DEPT_CODE=C.STVDEPT_CODE(+)
          ORDER BY TRIM (A.COLLEGE_CODE || A.DEPT_CODE)