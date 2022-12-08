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
      --  AND GOVUROL2_SECURITY_CLASS    IN ('BU_DEPARTMENT_MANAGER','BU_VICE_DEAN_M','BU_VICE_DEAN','BU_DEAN','BU_DEAN_REP')
       -- AND GOVUROL2_SECURITY_CLASS NOT IN ('BU_LOGIN')
       --AND USERNAME NOT IN ('MAALZAHRANI','CHANCELLOR')
       AND not EXISTS
               (SELECT 'x'
                  FROM GORFBPR
                 WHERE GORFBPR_FGAC_USER_ID = username)
       AND a.GURUOBJ_USERID = GURLOGN_USER
       AND GUBOBJS_NAME = a.GURUOBJ_OBJECT
       AND GOVUROL2_SECURITY_CLASS IS NULL
     --AND a.GURUOBJ_OBJECT = 'SSASECT' --- object 
        AND username   in ( 'AALGHAMDI','MMSALGHAMDI','OMALGHAMDI','ALGHAMDIAS')
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
       AND not EXISTS
               (SELECT 'x'
                  FROM GORFBPR
                 WHERE GORFBPR_FGAC_USER_ID = username)
       AND a.GURUOBJ_USERID = GOVUROL2_SECURITY_CLASS
       AND GUBOBJS_NAME = a.GURUOBJ_OBJECT
         AND GOVUROL2_SECURITY_CLASS IS not NULL
       --AND a.GURUOBJ_OBJECT = 'SSASECT' --- object 
       AND username   in ( 'AALGHAMDI','MMSALGHAMDI','OMALGHAMDI','ALGHAMDIAS')
ORDER BY 1 ;