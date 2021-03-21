SELECT COUNT(*) ,EDUCATION_CENTER FROM MOE_CD
WHERE --EDUCATION_CENTER = '«·≈œ«—… «·⁄«„… ·· ⁄·Ì„ »„Õ«›Ÿ… «·«Õ”«¡'
--AND 
EXISTS (SELECT '1' FROM sybssnl 
WHERE SYBSSNL_SSN =STUDENT_SSN
AND SYBSSNL_TERM_CODE='144010')
GROUP BY EDUCATION_CENTER ;

 



------------------
/* Formatted on 8/25/2019 2:10:15 PM (QP5 v5.227.12220.39754) */
SELECT COUNT ( * ), EDUCATION_CENTER
  FROM MOE_CD A, stu_main_data_vw B
 WHERE     A.STUDENT_SSN = B.STUDENT_SSN
 and ADMISSION_TYPE IN ('U2','UG')
       AND EXISTS
              (SELECT 1
                 FROM SGBSTDN
                WHERE     SGBSTDN_pidm = B.STUDENT_PIDM
                and sgbstdn_term_code_admit='144010'
                       )
 

                              GROUP BY EDUCATION_CENTER;