 
 
SELECT DISTINCT  A.SCBCRSE_SUBJ_CODE || A.SCBCRSE_CRSE_NUMB AS "Course Number",
         A.SCBCRSE_TITLE AS "Course Title",
         A.SCBCRSE_COLL_CODE AS "College Code",
         B.STVCOLL_DESC AS "College Name",
         A.SCBCRSE_DEPT_CODE AS "Department  Code",
         C.STVDEPT_DESC AS "Department Name",
         DECODE(F_GET_STD_ID (D.USER_PIDM),0,'',F_GET_STD_ID (D.USER_PIDM)) AS "College Dean ID",
         DECODE(F_GET_STD_NAME (D.USER_PIDM),'0','',F_GET_STD_NAME (D.USER_PIDM)) AS "College Dean Name",
         DECODE(F_GET_STD_ID (E.USER_PIDM),0,'',F_GET_STD_ID (E.USER_PIDM)) AS "Department Manager ID",
         DECODE(F_GET_STD_NAME (E.USER_PIDM),'0','',F_GET_STD_NAME (E.USER_PIDM)) AS "Department Manager Name" ,
         DECODE(F_GET_STD_ID (F.USER_PIDM),0,'',F_GET_STD_ID (F.USER_PIDM)) AS "Vice Dean  ID",
         DECODE(F_GET_STD_NAME (F.USER_PIDM),'0','',F_GET_STD_NAME (F.USER_PIDM)) AS "Vice Dean Name"
    FROM SCBCRSE A,
         STVCOLL B,
         STVDEPT C,
         USERS_ATTRIBUTES D,
         USERS_ATTRIBUTES E ,USERS_ATTRIBUTES F 
   WHERE     A.SCBCRSE_EFF_TERM =
                (SELECT MAX (SCBCRSE_EFF_TERM)
                   FROM SCBCRSE
                  WHERE     SCBCRSE_SUBJ_CODE = A.SCBCRSE_SUBJ_CODE
                        AND SCBCRSE_CRSE_NUMB = A.SCBCRSE_CRSE_NUMB
                        AND SCBCRSE_EFF_TERM <= '143920')
         AND A.SCBCRSE_COLL_CODE = B.STVCOLL_CODE(+)
         AND A.SCBCRSE_DEPT_CODE = C.STVDEPT_CODE(+)
         AND A.SCBCRSE_COLL_CODE = D.ATTRIBUTE_VALUE(+)
         AND NVL (D.ATTRIBUTE_CODE, 'COLLEGE') = 'COLLEGE'
         AND (   EXISTS
                    (SELECT '1'
                       FROM ROLE_USERS
                      WHERE     USER_PIDM = D.USER_PIDM
                            AND ROLE_CODE = 'RO_COLLEGE_DEAN')
              OR D.USER_PIDM IS NULL)
         AND A.SCBCRSE_DEPT_CODE = E.ATTRIBUTE_VALUE(+)
         AND NVL (E.ATTRIBUTE_CODE, 'DEPARTMENT') = 'DEPARTMENT'
         AND (   EXISTS
                    (SELECT '1'
                       FROM ROLE_USERS
                      WHERE     USER_PIDM = E.USER_PIDM
                            AND ROLE_CODE = 'RO_DEPT_MANAGER')
              OR E.USER_PIDM IS NULL)
              AND (   EXISTS
                    (SELECT '1'
                       FROM USERS_ATTRIBUTES
                      WHERE     USER_PIDM = E.USER_PIDM
                            AND ATTRIBUTE_CODE  ='COLLEGE'
                            AND ATTRIBUTE_VALUE=A.SCBCRSE_COLL_CODE)
              OR E.USER_PIDM IS NULL)
                AND A.SCBCRSE_COLL_CODE = F.ATTRIBUTE_VALUE(+)
                AND NVL (F.ATTRIBUTE_CODE, 'COLLEGE') = 'COLLEGE'
                AND (   EXISTS
                    (SELECT '1'
                       FROM ROLE_USERS
                      WHERE     USER_PIDM = F.USER_PIDM
                            AND ROLE_CODE = 'RO_VICE_DEAN')
              OR F.USER_PIDM IS NULL)
               
 
UNION 
 (
 
 
 SELECT A.SCBCRSE_SUBJ_CODE || A.SCBCRSE_CRSE_NUMB AS "Course Number",
         A.SCBCRSE_TITLE AS "Course Title",
         A.SCBCRSE_COLL_CODE AS "College Code",
         B.STVCOLL_DESC AS "College Name",
         A.SCBCRSE_DEPT_CODE AS "Department  Code",
         C.STVDEPT_DESC AS "Department Name",
         DECODE(F_GET_STD_ID (D.USER_PIDM),0,'',F_GET_STD_ID (D.USER_PIDM)) AS "College Dean ID",
         DECODE(F_GET_STD_NAME (D.USER_PIDM),'0','',F_GET_STD_NAME (D.USER_PIDM)) AS "College Dean Name" ,NULL ,NULL,NULL,NULL
 
 
    FROM SCBCRSE A,
         STVCOLL B,
         STVDEPT C,
         USERS_ATTRIBUTES D 
         
   WHERE     A.SCBCRSE_EFF_TERM =
                (SELECT MAX (SCBCRSE_EFF_TERM)
                   FROM SCBCRSE
                  WHERE     SCBCRSE_SUBJ_CODE = A.SCBCRSE_SUBJ_CODE
                        AND SCBCRSE_CRSE_NUMB = A.SCBCRSE_CRSE_NUMB
                        AND SCBCRSE_EFF_TERM <= '144010')
         AND A.SCBCRSE_COLL_CODE = B.STVCOLL_CODE(+)
         AND A.SCBCRSE_DEPT_CODE = C.STVDEPT_CODE(+)
         AND A.SCBCRSE_COLL_CODE = D.ATTRIBUTE_VALUE(+)
         AND NVL (D.ATTRIBUTE_CODE, 'COLLEGE') = 'COLLEGE'
         AND (   EXISTS
                    (SELECT '1'
                       FROM ROLE_USERS
                      WHERE     USER_PIDM = D.USER_PIDM
                            AND ROLE_CODE = 'RO_COLLEGE_DEAN')
              OR D.USER_PIDM IS NULL)
          
 
 MINUS 
 
 SELECT A.SCBCRSE_SUBJ_CODE || A.SCBCRSE_CRSE_NUMB AS "Course Number",
         A.SCBCRSE_TITLE AS "Course Title",
         A.SCBCRSE_COLL_CODE AS "College Code",
         B.STVCOLL_DESC AS "College Name",
         A.SCBCRSE_DEPT_CODE AS "Department  Code",
         C.STVDEPT_DESC AS "Department Name",
         DECODE(F_GET_STD_ID (D.USER_PIDM),0,'',F_GET_STD_ID (D.USER_PIDM)) AS "College Dean ID",
         DECODE(F_GET_STD_NAME (D.USER_PIDM),'0','',F_GET_STD_NAME (D.USER_PIDM)) AS "College Dean Name" ,NULL ,NULL,NULL,NULL
 
 
    FROM SCBCRSE A,
         STVCOLL B,
         STVDEPT C,
         USERS_ATTRIBUTES D,
         USERS_ATTRIBUTES E  
   WHERE     A.SCBCRSE_EFF_TERM =
                (SELECT MAX (SCBCRSE_EFF_TERM)
                   FROM SCBCRSE
                  WHERE     SCBCRSE_SUBJ_CODE = A.SCBCRSE_SUBJ_CODE
                        AND SCBCRSE_CRSE_NUMB = A.SCBCRSE_CRSE_NUMB
                        AND SCBCRSE_EFF_TERM <= '144010')
         AND A.SCBCRSE_COLL_CODE = B.STVCOLL_CODE(+)
         AND A.SCBCRSE_DEPT_CODE = C.STVDEPT_CODE(+)
         AND A.SCBCRSE_COLL_CODE = D.ATTRIBUTE_VALUE(+)
         AND NVL (D.ATTRIBUTE_CODE, 'COLLEGE') = 'COLLEGE'
         AND (   EXISTS
                    (SELECT '1'
                       FROM ROLE_USERS
                      WHERE     USER_PIDM = D.USER_PIDM
                            AND ROLE_CODE = 'RO_COLLEGE_DEAN')
              OR D.USER_PIDM IS NULL)
         AND A.SCBCRSE_DEPT_CODE = E.ATTRIBUTE_VALUE(+)
         AND NVL (E.ATTRIBUTE_CODE, 'DEPARTMENT') = 'DEPARTMENT'
         AND (   EXISTS
                    (SELECT '1'
                       FROM ROLE_USERS
                      WHERE     USER_PIDM = E.USER_PIDM
                            AND ROLE_CODE = 'RO_DEPT_MANAGER')
              OR E.USER_PIDM IS NULL)
              AND (   EXISTS
                    (SELECT '1'
                       FROM USERS_ATTRIBUTES
                      WHERE     USER_PIDM = E.USER_PIDM
                            AND ATTRIBUTE_CODE  ='COLLEGE'
                            AND ATTRIBUTE_VALUE=A.SCBCRSE_COLL_CODE)
              OR E.USER_PIDM IS NULL)
 
 
 )
 UNION 
 (SELECT A.SCBCRSE_SUBJ_CODE || A.SCBCRSE_CRSE_NUMB AS "Course Number",
         A.SCBCRSE_TITLE AS "Course Title",
         A.SCBCRSE_COLL_CODE AS "College Code",
         B.STVCOLL_DESC AS "College Name",
         A.SCBCRSE_DEPT_CODE AS "Department  Code",
         C.STVDEPT_DESC AS "Department Name",
         DECODE(F_GET_STD_ID (D.USER_PIDM),0,'',F_GET_STD_ID (D.USER_PIDM)) AS "College Dean ID",
         DECODE(F_GET_STD_NAME (D.USER_PIDM),'0','',F_GET_STD_NAME (D.USER_PIDM)) AS "College Dean Name",
         DECODE(F_GET_STD_ID (E.USER_PIDM),0,'',F_GET_STD_ID (E.USER_PIDM)) AS "Department Manager ID",
         DECODE(F_GET_STD_NAME (E.USER_PIDM),'0','',F_GET_STD_NAME (E.USER_PIDM)) AS "Department Manager Name"  ,NULL ,NULL
   
    FROM SCBCRSE A,
         STVCOLL B,
         STVDEPT C,
         USERS_ATTRIBUTES D,
         USERS_ATTRIBUTES E 
 
   WHERE     A.SCBCRSE_EFF_TERM =
                (SELECT MAX (SCBCRSE_EFF_TERM)
                   FROM SCBCRSE
                  WHERE     SCBCRSE_SUBJ_CODE = A.SCBCRSE_SUBJ_CODE
                        AND SCBCRSE_CRSE_NUMB = A.SCBCRSE_CRSE_NUMB
                        AND SCBCRSE_EFF_TERM <= '144010')
         AND A.SCBCRSE_COLL_CODE = B.STVCOLL_CODE(+)
         AND A.SCBCRSE_DEPT_CODE = C.STVDEPT_CODE(+)
         AND A.SCBCRSE_COLL_CODE = D.ATTRIBUTE_VALUE(+)
         AND NVL (D.ATTRIBUTE_CODE, 'COLLEGE') = 'COLLEGE'
         AND (   EXISTS
                    (SELECT '1'
                       FROM ROLE_USERS
                      WHERE     USER_PIDM = D.USER_PIDM
                            AND ROLE_CODE = 'RO_COLLEGE_DEAN')
              OR D.USER_PIDM IS NULL)
         AND A.SCBCRSE_DEPT_CODE = E.ATTRIBUTE_VALUE(+)
         AND NVL (E.ATTRIBUTE_CODE, 'DEPARTMENT') = 'DEPARTMENT'
         AND (   EXISTS
                    (SELECT '1'
                       FROM ROLE_USERS
                      WHERE     USER_PIDM = E.USER_PIDM
                            AND ROLE_CODE = 'RO_DEPT_MANAGER')
              OR E.USER_PIDM IS NULL)
              AND (   EXISTS
                    (SELECT '1'
                       FROM USERS_ATTRIBUTES
                      WHERE     USER_PIDM = E.USER_PIDM
                            AND ATTRIBUTE_CODE  ='COLLEGE'
                            AND ATTRIBUTE_VALUE=A.SCBCRSE_COLL_CODE)
              OR E.USER_PIDM IS NULL)
 
              
              
 MINUS 
 SELECT A.SCBCRSE_SUBJ_CODE || A.SCBCRSE_CRSE_NUMB AS "Course Number",
         A.SCBCRSE_TITLE AS "Course Title",
         A.SCBCRSE_COLL_CODE AS "College Code",
         B.STVCOLL_DESC AS "College Name",
         A.SCBCRSE_DEPT_CODE AS "Department  Code",
         C.STVDEPT_DESC AS "Department Name",
         DECODE(F_GET_STD_ID (D.USER_PIDM),0,'',F_GET_STD_ID (D.USER_PIDM)) AS "College Dean ID",
         DECODE(F_GET_STD_NAME (D.USER_PIDM),'0','',F_GET_STD_NAME (D.USER_PIDM)) AS "College Dean Name",
         DECODE(F_GET_STD_ID (E.USER_PIDM),0,'',F_GET_STD_ID (E.USER_PIDM)) AS "Department Manager ID",
         DECODE(F_GET_STD_NAME (E.USER_PIDM),'0','',F_GET_STD_NAME (E.USER_PIDM)) AS "Department Manager Name"  ,NULL ,NULL
 
    FROM SCBCRSE A,
         STVCOLL B,
         STVDEPT C,
         USERS_ATTRIBUTES D,
         USERS_ATTRIBUTES E ,USERS_ATTRIBUTES F 
   WHERE     A.SCBCRSE_EFF_TERM =
                (SELECT MAX (SCBCRSE_EFF_TERM)
                   FROM SCBCRSE
                  WHERE     SCBCRSE_SUBJ_CODE = A.SCBCRSE_SUBJ_CODE
                        AND SCBCRSE_CRSE_NUMB = A.SCBCRSE_CRSE_NUMB
                        AND SCBCRSE_EFF_TERM <= '144010')
         AND A.SCBCRSE_COLL_CODE = B.STVCOLL_CODE(+)
         AND A.SCBCRSE_DEPT_CODE = C.STVDEPT_CODE(+)
         AND A.SCBCRSE_COLL_CODE = D.ATTRIBUTE_VALUE(+)
         AND NVL (D.ATTRIBUTE_CODE, 'COLLEGE') = 'COLLEGE'
         AND (   EXISTS
                    (SELECT '1'
                       FROM ROLE_USERS
                      WHERE     USER_PIDM = D.USER_PIDM
                            AND ROLE_CODE = 'RO_COLLEGE_DEAN')
              OR D.USER_PIDM IS NULL)
         AND A.SCBCRSE_DEPT_CODE = E.ATTRIBUTE_VALUE(+)
         AND NVL (E.ATTRIBUTE_CODE, 'DEPARTMENT') = 'DEPARTMENT'
         AND (   EXISTS
                    (SELECT '1'
                       FROM ROLE_USERS
                      WHERE     USER_PIDM = E.USER_PIDM
                            AND ROLE_CODE = 'RO_DEPT_MANAGER')
              OR E.USER_PIDM IS NULL)
              AND (   EXISTS
                    (SELECT '1'
                       FROM USERS_ATTRIBUTES
                      WHERE     USER_PIDM = E.USER_PIDM
                            AND ATTRIBUTE_CODE  ='COLLEGE'
                            AND ATTRIBUTE_VALUE=A.SCBCRSE_COLL_CODE)
              OR E.USER_PIDM IS NULL)
                AND A.SCBCRSE_COLL_CODE = F.ATTRIBUTE_VALUE(+)
                AND NVL (F.ATTRIBUTE_CODE, 'COLLEGE') = 'COLLEGE'
                AND (   EXISTS
                    (SELECT '1'
                       FROM ROLE_USERS
                      WHERE     USER_PIDM = F.USER_PIDM
                            AND ROLE_CODE = 'RO_VICE_DEAN')
              OR F.USER_PIDM IS NULL))
              ORDER BY 3, 4, 1