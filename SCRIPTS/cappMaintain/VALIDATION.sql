/* Formatted on 26/01/2021 13:09:09 (QP5 v5.227.12220.39754) */
BU_APPS.CAPP_MANIPULATION_FUNCTIONAL
CAPP_MNPL_LOG_header
CAPP_MNPL_LOG_main
CAPP_MNPL_LOG_DETAIL
BU_APPS.CAPP_MNPL_LOG_NOT_USED
general.GJBPRUN
BU_APPS.CAPP_PROGRAM_MAPPING
--
;

SELECT *
  FROM SMRDOUS
 WHERE     SMRDOUS_PIDM = 183685
       AND SMRDOUS_REQUEST_NO = (SELECT MAX (SMRDOUS_REQUEST_NO)
                                   FROM SMRDOUS
                                  WHERE SMRDOUS_PIDM = 183685)
       AND (SMRDOUS_SUBJ_CODE, SMRDOUS_CRSE_NUMB) NOT IN
              (SELECT RHS_SUBJ_CODE, RHS_CRSE_NUMB
                 FROM BU_APPS.CAPP_MNPL_LOG_DETAIL
                WHERE     STD_PIDM = 183685
                      AND MAPPING_SUCCESS_IND = 'Y'
                      AND process_id = 1000);

                ------------DORQ

SELECT F_GET_STD_ID (STD_PIDM) ID, A.*
  FROM CAPP_MNPL_LOG_DETAIL A
 WHERE     STD_PIDM = 183685
       AND (RHS_SUBJ_CODE, RHS_CRSE_NUMB) IN
              (SELECT SMRDORQ_SUBJ_CODE, SMRDORQ_CRSE_NUMB_LOW
                 FROM SMRDORQ
                WHERE     SMRDORQ_PIDM = 183685
                      AND SMRDORQ_REQUEST_NO =
                             (SELECT MAX (SMRDORQ_REQUEST_NO)
                                FROM SMRDORQ
                               WHERE SMRDORQ_PIDM = 183685)
                      AND SMRDORQ_MET_IND = 'Y'
                      AND (SMRDORQ_SUBJ_CODE, SMRDORQ_CRSE_NUMB_LOW) NOT IN
                             (SELECT RHS_SUBJ_CODE, RHS_CRSE_NUMB
                                FROM BU_APPS.CAPP_MNPL_LOG_DETAIL
                               WHERE     STD_PIDM = 183685
                                     AND MAPPING_SUCCESS_IND = 'Y'
                                     AND process_id = 1000));

SELECT *
  FROM BU_APPS.CAPP_MNPL_LOG_DETAIL
 WHERE     STD_PIDM = 215468
       AND MAPPING_SUCCESS_IND = 'Y'
       AND (RHS_SUBJ_CODE, RHS_CRSE_NUMB) NOT IN
              (SELECT SMRDOUS_SUBJ_CODE, SMRDOUS_CRSE_NUMB
                 FROM SMRDOUS
                WHERE     SMRDOUS_PIDM = 215468
                      AND SMRDOUS_REQUEST_NO =
                             (SELECT MAX (SMRDOUS_REQUEST_NO)
                                FROM SMRDOUS
                               WHERE SMRDOUS_PIDM = 215468));



                                  -------------------COMPARE COUNTS



SELECT PROCESS_ID,
       STD_PIDM,
       F_GET_STD_ID (STD_PIDM) ID,
       SDOUS - MNPL RESULT
  FROM (  SELECT PROCESS_ID,
                 COUNT (*) MNPL,
                 STD_PIDM,
                 (SELECT COUNT (*)
                    FROM SMRDOUS
                   WHERE     SMRDOUS_PIDM = STD_PIDM
                         AND SMRDOUS_REQUEST_NO =
                                (SELECT MAX (SMRDOUS_REQUEST_NO)
                                   FROM SMRDOUS
                                  WHERE SMRDOUS_PIDM = STD_PIDM))
                    SDOUS
            FROM CAPP_MNPL_LOG_DETAIL
           WHERE MAPPING_SUCCESS_IND = 'Y' AND PROCESS_ID = 200
        GROUP BY STD_PIDM, PROCESS_ID)
 WHERE SDOUS - MNPL = 0;

------------------DORQ

SELECT PROCESS_ID,
       STD_PIDM,
       F_GET_STD_ID (STD_PIDM) ID,
       SDOUS - MNPL RESULT
  FROM (  SELECT PROCESS_ID,
                 COUNT (*) MNPL,
                 STD_PIDM,
                 (SELECT COUNT (*)
                    FROM SMRDORQ
                   WHERE     SMRDORQ_PIDM = STD_PIDM
                         AND SMRDORQ_MET_IND = 'Y'
                         AND SMRDORQ_REQUEST_NO =
                                (SELECT MAX (SMRDORQ_REQUEST_NO)
                                   FROM SMRDORQ
                                  WHERE SMRDORQ_PIDM = STD_PIDM))
                    SDOUS
            FROM CAPP_MNPL_LOG_DETAIL
           WHERE MAPPING_SUCCESS_IND = 'Y' AND PROCESS_ID = 2300
        GROUP BY STD_PIDM, PROCESS_ID)
 WHERE SDOUS - MNPL > 0;

 ------------------

  SELECT DISTINCT                                          /*PROGRAM_CODE , */
                 SUBJECT_CODE, COURSE_NUMBER, COURSE_TITLE
    FROM BU_APPS.VW_ACADEMIC_PLANS
   WHERE     PROGRAM_CODE IN
                ('1-1704-1433',
                 '2-1704-1433',
                 '1-1804-1433',
                 '2-1804-1433',
                 '1-1903-1433',
                 '2-1903-1433',
                 '1-3104-1433',
                 '2-3104-1433',
                 '1-4204-1433',
                 '2-4204-1433')
         AND EFFECTIVE_TERM = '143810'
         AND (SUBJECT_CODE, COURSE_NUMBER) NOT IN
                (SELECT EQUV_SUBJ_CODE, EQUV_CRSE_NUMB
                   FROM BU_APPS.PROGRAM_EQUV_COURSES
                  WHERE PROGRAM_CODE = '1M31MATH38')
ORDER BY 3;

--1F17FASH38 ( '2-1929-1433','2-1911-1433' ,'2-1726-1433','2-1710-1433'  )
--1F18NUTR38  ('2-1818-1433', '2-1808-1433', '2-1711-1433', '2-1716-1433')
--BU_APPS.F_CAPP_NUTR_38
-- 1M18ISLM38   ( '1-1708-1433','2-1708-1433', '1-1807-1433','2-1807-1433','1-1901-1433','2-1901-1433' )
--1M16BUS38    ( '1-1601-1433','2-1601-1433' )
-- 1M15ENGL38 F_CAPP_ENGL_38 ( '1-1502-1433','2-1502-1433','1-4209-1433','2-4209-1433','1-1904-1433','2-1904-1433','1-1802-1433','2-1802-1433','1-1709-1433','2-1709-1433')
--F_CAPP_BUS_38  ( '1-1601-1433','2-1601-1433' ,'1F16BUS38','1M16BUS38' )
--1M16ACC38 F_CAPP_ACC_38 ( '1-1602-1433','2-1602-1433'   )
-- 1M16MKT38 F_CAPP_MKT_38  ( '1-1604-1433','2-1604-1433'  )
-- 1M16MIS38 F_CAPP_MIS_38   ( '1-1603-1433','2-1603-1433')
-- 1M16LAW38  F_CAPP_LAW_38  ( '1-1605-1433'  )
-- 1M15ARAB38 F_CAPP_ARAB_38 ( '1-1707-1433','2-1707-1433', '1-1809-1433','2-1809-1433','1-1902-1433','2-1902-1433' ,'1-1501-1433','2-1501-1433' )
-- 1M41CS38  F_CAPP_CS_38  ( '1-4102-1433','2-4102-1433'  ,'1-4111-1433','2-4111-1433')
-- 1M41IT38 F_CAPP_IT_38  ( '1-4104-1433','2-4104-1433' )
--F_CAPP_BIO_38 ( '1-1701-1433','2-1701-1433','1-1801-1433','2-1801-1433','1-3101-1433','2-3101-1433','1-4201-1433','2-4201-1433','1-1907-1433','2-1907-1433' )
    -- 1M31PHYS38      F_CAPP_PHYS_38       ( '1-1703-1433','2-1703-1433', '1-1803-1433','2-1803-1433','1-1905-1433','2-1905-1433' ,'1-3103-1433','2-3103-1433' ,'1-4203-1433','2-4203-1433'  )
    -- 1M31MATH38  F_CAPP_MATH_38   ( '1-1704-1433','2-1704-1433', '1-1804-1433','2-1804-1433','1-1903-1433','2-1903-1433' ,'1-3104-1433','2-3104-1433' ,'1-4204-1433','2-4204-1433'  )

BEGIN
   /* CAPP_MANIPULATION_FUNCTIONAL.LOG_DELETE(400);
    CAPP_MANIPULATION_FUNCTIONAL.LOG_DELETE(500);
         CAPP_MANIPULATION_FUNCTIONAL.LOG_DELETE(400);*/
   COMMIT;
   SYKCMPG.SYPCMPG;
   COMMIT;
END;

--ORA-01407: cannot update ("SATURN"."SHRLGPA"."SHRLGPA_HOURS_EARNED") to NULL



;

  SELECT *
    FROM BU_APPS.VW_ACADEMIC_PLANS
   WHERE     PROGRAM_CODE = '1M16BUS38'
         AND EFFECTIVE_TERM = '143810'
         AND EXISTS
                (SELECT '1'
                   FROM CAPP_MNPL_LOG_DETAIL
                  WHERE     LHS_SUBJ_CODE = SUBJECT_CODE
                        AND LHS_CRSE_NUMB = COURSE_NUMBER
                        AND PROCESS_ID = 200
                        AND STD_PIDM = 169029
                        AND MAPPING_SUCCESS_IND = 'N')
         AND AREA_PRIORITY = 2
ORDER BY AREA_PRIORITY, COURSE_TITLE;


 ------------- notused ---------

  SELECT COUNT (STD_PIDM),
         SUBJ_CODE,
         CRSE_NUMB,
         CREDIT_HOURS,
         TITLE
    FROM BU_APPS.CAPP_MNPL_LOG_NOT_USED m
   WHERE     PROCESS_ID = 2300
         AND SUBJ_CODE || '-' || CRSE_NUMB NOT IN
                (SELECT FAILURE_MESSAGE
                   FROM CAPP_MNPL_LOG_detail
                  WHERE     STD_PIDM = m.STD_PIDM
                        AND MAPPING_SUCCESS_IND = 'Y'
                        AND PROCESS_ID = m.PROCESS_ID)
GROUP BY SUBJ_CODE,
         CRSE_NUMB,
         CREDIT_HOURS,
         TITLE
ORDER BY 1 DESC;