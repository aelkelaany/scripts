/* Formatted on 28/03/2021 09:23:38 (QP5 v5.227.12220.39754) */
  SELECT DISTINCT F_GET_STD_ID (SIRDPCL_PIDM) FAC_ID,
                  F_GET_STD_NAME (SIRDPCL_PIDM) FAC_NAME,
                  SIRDPCL_COLL_CODE,
                  F_GET_DESC_FNC ('STVCOLL', SIRDPCL_COLL_CODE, 30) COLLEGE,
                  SIRDPCL_DEPT_CODE,
                  F_GET_DESC_FNC ('STVDEPT', SIRDPCL_DEPT_CODE, 30) DEPARTMENT
    FROM SATURN.SIRDPCL a
   WHERE     SIRDPCL_TERM_CODE_EFF = (SELECT MAX (SIRDPCL_TERM_CODE_EFF)
                                        FROM SIRDPCL
                                       WHERE SIRDPCL_PIDM = a.SIRDPCL_PIDM)
         AND SIRDPCL_PIDM IN
                (  SELECT SIRDPCL_PIDM
                     FROM (SELECT DISTINCT SIRDPCL_PIDM,
                                           SIRDPCL_COLL_CODE,
                                           SIRDPCL_DEPT_CODE,
                                           A.SIRDPCL_HOME_IND
                             FROM SATURN.SIRDPCL a, sibinst
                            WHERE     SIRDPCL_TERM_CODE_EFF =
                                         (SELECT MAX (SIRDPCL_TERM_CODE_EFF)
                                            FROM SIRDPCL
                                           WHERE SIRDPCL_PIDM = a.SIRDPCL_PIDM)
                                  AND sibinst_pidm = a.SIRDPCL_PIDM
                                  AND sibinst_TERM_CODE_EFF =
                                         (SELECT MAX (sibinst_TERM_CODE_EFF)
                                            FROM sibinst
                                           WHERE sibinst_PIDM = a.SIRDPCL_PIDM)
                                  AND SIBINST_FCST_CODE = 'ä'
                                  AND A.SIRDPCL_HOME_IND IS NULL
                                  AND NOT EXISTS
                                             (SELECT '1'
                                                FROM SATURN.SIRDPCL c
                                               WHERE     SIRDPCL_TERM_CODE_EFF =
                                                            (SELECT MAX (
                                                                       SIRDPCL_TERM_CODE_EFF)
                                                               FROM SIRDPCL
                                                              WHERE SIRDPCL_PIDM =
                                                                       c.SIRDPCL_PIDM)
                                                     AND c.SIRDPCL_HOME_IND = 'Y'
                                                     AND c.SIRDPCL_PIDM =
                                                            a.SIRDPCL_PIDM))
                 GROUP BY SIRDPCL_PIDM
                   HAVING COUNT (SIRDPCL_PIDM) = 1)
ORDER BY 3, 5;

---------------------------------
  SELECT DISTINCT F_GET_STD_ID (SIRDPCL_PIDM) FAC_ID,
                  F_GET_STD_NAME (SIRDPCL_PIDM) FAC_NAME,
                  SIRDPCL_COLL_CODE,
                  F_GET_DESC_FNC ('STVCOLL', SIRDPCL_COLL_CODE, 30) COLLEGE,
                  SIRDPCL_DEPT_CODE,
                  F_GET_DESC_FNC ('STVDEPT', SIRDPCL_DEPT_CODE, 30) DEPARTMENT
    FROM SATURN.SIRDPCL a
   WHERE     SIRDPCL_TERM_CODE_EFF = (SELECT MAX (SIRDPCL_TERM_CODE_EFF)
                                        FROM SIRDPCL
                                       WHERE SIRDPCL_PIDM = a.SIRDPCL_PIDM)
         AND SIRDPCL_PIDM IN
                (  SELECT SIRDPCL_PIDM
                     FROM (SELECT DISTINCT SIRDPCL_PIDM,
                                           SIRDPCL_COLL_CODE,
                                           SIRDPCL_DEPT_CODE,
                                           A.SIRDPCL_HOME_IND
                             FROM SATURN.SIRDPCL a, sibinst
                            WHERE     SIRDPCL_TERM_CODE_EFF =
                                         (SELECT MAX (SIRDPCL_TERM_CODE_EFF)
                                            FROM SIRDPCL
                                           WHERE SIRDPCL_PIDM = a.SIRDPCL_PIDM)
                                  AND sibinst_pidm = a.SIRDPCL_PIDM
                                  AND sibinst_TERM_CODE_EFF =
                                         (SELECT MAX (sibinst_TERM_CODE_EFF)
                                            FROM sibinst
                                           WHERE sibinst_PIDM = a.SIRDPCL_PIDM)
                                  AND SIBINST_FCST_CODE = 'ä'
                                  AND A.SIRDPCL_HOME_IND IS NULL
                                  AND NOT EXISTS
                                             (SELECT '1'
                                                FROM SATURN.SIRDPCL c
                                               WHERE     SIRDPCL_TERM_CODE_EFF =
                                                            (SELECT MAX (
                                                                       SIRDPCL_TERM_CODE_EFF)
                                                               FROM SIRDPCL
                                                              WHERE SIRDPCL_PIDM =
                                                                       c.SIRDPCL_PIDM)
                                                     AND c.SIRDPCL_HOME_IND = 'Y'
                                                     AND c.SIRDPCL_PIDM =
                                                            a.SIRDPCL_PIDM))
                 GROUP BY SIRDPCL_PIDM
                   HAVING COUNT (SIRDPCL_PIDM) > 1)
ORDER BY 1;