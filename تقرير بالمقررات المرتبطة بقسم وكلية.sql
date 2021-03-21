 
  SELECT A.SCBCRSE_SUBJ_CODE || A.SCBCRSE_CRSE_NUMB AS "Course Number",
         A.SCBCRSE_TITLE AS "Course Title",
         A.SCBCRSE_COLL_CODE AS "College Code",
         nvl(B.STVCOLL_DESC,'€Ì— „— »ÿ') AS "College Name",
         A.SCBCRSE_DEPT_CODE AS "Department  Code",
         nvl(C.STVDEPT_DESC,'€Ì— „— »ÿ') AS "Department Name" 
          
    FROM SCBCRSE A,
         STVCOLL B,
         STVDEPT C 
   WHERE     A.SCBCRSE_EFF_TERM =
                (SELECT MAX (SCBCRSE_EFF_TERM)
                   FROM SCBCRSE
                  WHERE     SCBCRSE_SUBJ_CODE = A.SCBCRSE_SUBJ_CODE
                        AND SCBCRSE_CRSE_NUMB = A.SCBCRSE_CRSE_NUMB
                        AND SCBCRSE_EFF_TERM <= '144210')
         AND A.SCBCRSE_COLL_CODE = B.STVCOLL_CODE(+)
         AND A.SCBCRSE_DEPT_CODE = C.STVDEPT_CODE(+)
         and A.SCBCRSE_CSTA_CODE='A'
         and A.SCBCRSE_COLL_CODE not in ('12','35','44','34')
          
          
              
ORDER BY 3, 4, 1  