/* Formatted on 3/15/2023 10:24:18 AM (QP5 v5.371) */
INSERT INTO SATURN.SIRDPCL (SIRDPCL_PIDM,
                            SIRDPCL_TERM_CODE_EFF,
                            SIRDPCL_COLL_CODE,
                            SIRDPCL_DEPT_CODE,
                            SIRDPCL_HOME_IND,
                            SIRDPCL_PERCENTAGE,
                            SIRDPCL_ACTIVITY_DATE)
    SELECT SIRDPCL_PIDM,
           '144430',
           SIRDPCL_COLL_CODE,
           SIRDPCL_DEPT_CODE,
           SIRDPCL_HOME_IND,
           SIRDPCL_PERCENTAGE,
           SYSDATE
      FROM SIRDPCL a
     WHERE     SIRDPCL_DEPT_CODE = '1705'
           AND SIRDPCL_TERM_CODE_EFF = (SELECT MAX (SIRDPCL_TERM_CODE_EFF)
                                          FROM SIRDPCL
                                         WHERE SIRDPCL_PIDM = a.SIRDPCL_pidm)
           AND EXISTS
                   (SELECT '1'
                      FROM sibinst
                     WHERE     SIBINST_PIDM = SIRDPCL_PIDM
                           AND SIBINST_FCST_CODE = 'ä'
                           AND SIBINST_TERM_CODE_EFF =
                               (SELECT MAX (SIBINST_TERM_CODE_EFF)
                                  FROM SIBINST
                                 WHERE SIBINST_PIDM = SIRDPCL_PIDM))
           AND NOT EXISTS
                   (SELECT '1'
                      FROM SIRDPCL
                     WHERE     SIRDPCL_PIDM = a.SIRDPCL_pidm
                           AND SIRDPCL_TERM_CODE_EFF = '144430'
                           AND SIRDPCL_COLL_CODE = a.SIRDPCL_COLL_CODE
                           AND SIRDPCL_DEPT_CODE = a.SIRDPCL_DEPT_CODE)
                           AND NOT EXISTS
                   (SELECT '1'
                      FROM SIRDPCL
                     WHERE     SIRDPCL_PIDM = a.SIRDPCL_pidm
                           AND SIRDPCL_TERM_CODE_EFF = '144430'
                           AND SIRDPCL_COLL_CODE = '12'
                           AND SIRDPCL_DEPT_CODE = '1217')
                           and SIRDPCL_HOME_IND='Y';

 -------
 INSERT INTO SATURN.SIRDPCL (SIRDPCL_PIDM,
                            SIRDPCL_TERM_CODE_EFF,
                            SIRDPCL_COLL_CODE,
                            SIRDPCL_DEPT_CODE,
                            SIRDPCL_HOME_IND,
                            SIRDPCL_PERCENTAGE,
                            SIRDPCL_ACTIVITY_DATE)
    SELECT distinct SIRDPCL_PIDM,
           '144430',
           '12',
           :dep,
           '',
           '',
           SYSDATE
      FROM SIRDPCL a
     WHERE     SIRDPCL_DEPT_CODE = '1705'
           AND SIRDPCL_TERM_CODE_EFF = (SELECT MAX (SIRDPCL_TERM_CODE_EFF)
                                          FROM SIRDPCL
                                         WHERE SIRDPCL_PIDM = a.SIRDPCL_pidm)
           AND EXISTS
                   (SELECT '1'
                      FROM sibinst
                     WHERE     SIBINST_PIDM = SIRDPCL_PIDM
                           AND SIBINST_FCST_CODE = 'ä'
                           AND SIBINST_TERM_CODE_EFF =
                               (SELECT MAX (SIBINST_TERM_CODE_EFF)
                                  FROM SIBINST
                                 WHERE SIBINST_PIDM = SIRDPCL_PIDM))
           AND NOT EXISTS
                   (SELECT '1'
                      FROM SIRDPCL
                     WHERE     SIRDPCL_PIDM = a.SIRDPCL_pidm
                           AND SIRDPCL_TERM_CODE_EFF = '144430'
                           AND SIRDPCL_COLL_CODE = '12'
                           AND SIRDPCL_DEPT_CODE = :dep)
                            
                           ;