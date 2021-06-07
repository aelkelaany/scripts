/* Formatted on 06/06/2021 12:03:31 (QP5 v5.227.12220.39754) */
  SELECT DISTINCT std.item_value pidm,
                  f_get_std_id (std.item_value),
                  f_get_std_name (std.item_value),
                  term.item_value,
                  TO_CHAR (M.ACTIVITY_DATE, 'dd/mm/yyyy'),
                  TO_CHAR (M.request_date, 'dd/mm/yyyy')
    FROM BU_APPS.REQUEST_MASTER m, request_details std, request_details term
   WHERE     OBJECT_CODE IN ('WF_GRADE_CHANGE')
         AND REQUEST_STATUS = 'C'
         AND std.request_no = m.request_no
         AND std.SEQUENCE_NO = 1
         AND std.item_code = 'SELECTED_PIDM'
         AND term.request_no = m.request_no
         AND term.SEQUENCE_NO = 1
         AND term.item_code = 'TERM'
         AND term.item_value IN ('144210', '144220', '144230')
         AND TO_CHAR (M.ACTIVITY_DATE, 'yyyymmdd') >= '20210607'
ORDER BY 4 DESC;

  --process data was 20210607



INSERT INTO GLBSLCT (GLBSLCT_APPLICATION,
                     GLBSLCT_SELECTION,
                     GLBSLCT_CREATOR_ID,
                     GLBSLCT_DESC,
                     GLBSLCT_LOCK_IND,
                     GLBSLCT_ACTIVITY_DATE,
                     GLBSLCT_TYPE_IND)
     VALUES ('STUDENT',
             'GPA_GRADE_CHANGE01',
             'SAISUSR',
             'ãÚÏá ÊÑÇßãí ',
             'N',
             SYSDATE,
             NULL);


INSERT INTO GLBEXTR
   SELECT DISTINCT 'STUDENT',
                   'GPA_GRADE_CHANGE01',
                   'SAISUSR',
                   'SAISUSR',
                   PIDM,
                   SYSDATE,
                   'S',
                   NULL
     FROM (SELECT DISTINCT std.item_value pidm,
                           f_get_std_id (std.item_value),
                           f_get_std_name (std.item_value),
                           term.item_value,
                           TO_CHAR (M.ACTIVITY_DATE, 'dd/mm/yyyy'),
                           TO_CHAR (M.request_date, 'dd/mm/yyyy')
             FROM BU_APPS.REQUEST_MASTER m,
                  request_details std,
                  request_details term
            WHERE     OBJECT_CODE IN ('WF_GRADE_CHANGE')
                  AND REQUEST_STATUS = 'C'
                  AND std.request_no = m.request_no
                  AND std.SEQUENCE_NO = 1
                  AND std.item_code = 'SELECTED_PIDM'
                  AND term.request_no = m.request_no
                  AND term.SEQUENCE_NO = 1
                  AND term.item_code = 'TERM'
                  AND term.item_value IN ('144210', '144220', '144230')
                  AND TO_CHAR (M.ACTIVITY_DATE, 'yyyymmdd') > '20210607');


    ----------------------- CHECK ACADEMIC STATDING

SELECT *
  FROM (SELECT stid,
               PIDM,
               stname,
               TERM_CODE,
               SHRTTRM_ASTD_CODE_END_OF_TERM ASTD_CODE,
               ASATD,
               (SELECT ROUND (
                            SUM (SHRTGPA_QUALITY_POINTS)
                          / SUM (SHRTGPA_GPA_HOURS),
                          2)
                  FROM shrtgpa
                 WHERE     SHRTGPA_TERM_CODE <= TERM_CODE
                       AND SHRTGPA_LEVL_CODE = 'Ìã'
                       AND SHRTGPA_PIDM = PIDM)
                  cgpa
          FROM (  SELECT DISTINCT
                         SHRTTRM_PIDM PIDM,
                         f_get_std_id (SHRTTRM_PIDM) stid,
                         f_get_std_name (SHRTTRM_PIDM) stname,
                         SHRTTRM_TERM_CODE TERM_CODE,
                         f_get_desc_fnc ('STVASTD',
                                         SHRTTRM_ASTD_CODE_END_OF_TERM,
                                         60)
                            ASATD,
                         SHRTTRM_ASTD_CODE_END_OF_TERM
                    FROM shrttrm, SHRLGPA
                   WHERE     SHRTTRM_PIDM = SHRLGPA_PIDM
                         AND SHRLGPA_GPA_TYPE_IND = 'O'
                         AND EXISTS
                                (SELECT '1'
                                   FROM GLBEXTR
                                  WHERE     GLBEXTR_SELECTION =
                                               'GPA_GRADE_CHANGE01'
                                        AND GLBEXTR_KEY = SHRTTRM_PIDM)
                ORDER BY stid, SHRTTRM_TERM_CODE ASC))
 WHERE (   (cgpa BETWEEN 3.50 AND 4.00 AND ASATD NOT LIKE 'ããÊÇÒ')
        OR (cgpa BETWEEN 2.75 AND 3.49 AND ASATD NOT LIKE 'ÌíÏ ÌÏÇ')
        OR (cgpa BETWEEN 1.75 AND 2.74 AND ASATD NOT LIKE 'ÌíÏ')
        OR (cgpa BETWEEN 1 AND 1.75 AND ASATD NOT LIKE 'ãÞÈæá'));