/* Formatted on 4/9/2020 6:49:51 PM (QP5 v5.354) */
SELECT DISTINCT COL01,
       COL02,
       COL03,
       COL04,
       COL05,
       COL06,
       COL07,
       COL08,
       F_GET_STD_ID (DMGR_PIDM)       DEPT_ID,
       F_GET_STD_NAME (DMGR_PIDM)     DEPT_NAME,
       F_GET_STD_ID (VICE_PIDM)       VICE_ID,
       F_GET_STD_NAME (VICE_PIDM)     VICE_NAME,
       F_GET_STD_ID (DEAN_PIDM)       DEAN_ID,
       F_GET_STD_NAME (DEAN_PIDM)     DEAN_NAME
  FROM (SELECT COL01,
               COL02,
               COL03,
               COL04,
               COL05,
               COL06,
               COL07,
               COL08,
               (SELECT a.USER_PIDM     DMGR_PIDM
                  FROM ROLE_USERS a
                 WHERE     ROLE_CODE = 'RO_DEPT_MANAGER'
                       AND EXISTS
                               (SELECT 'Y'
                                  FROM USERS_ATTRIBUTES t1
                                 WHERE     t1.USER_PIDM = a.USER_PIDM
                                       AND t1.ATTRIBUTE_CODE = 'COLLEGE'
                                       AND t1.ATTRIBUTE_VALUE = COL07)
                       AND EXISTS
                               (SELECT 'Y'
                                  FROM USERS_ATTRIBUTES t2
                                 WHERE     t2.USER_PIDM = a.USER_PIDM
                                       AND t2.ATTRIBUTE_CODE = 'DEPARTMENT'
                                       AND t2.ATTRIBUTE_VALUE = COL08)
                       AND ACTIVE = 'Y')    DMGR_PIDM,
               (SELECT a.USER_PIDM     VICE_PIDM
                  FROM ROLE_USERS a
                 WHERE     ROLE_CODE = 'RO_VICE_DEAN'
                       AND EXISTS
                               (SELECT 'Y'
                                  FROM USERS_ATTRIBUTES t1
                                 WHERE     t1.USER_PIDM = a.USER_PIDM
                                       AND t1.ATTRIBUTE_CODE = 'COLLEGE'
                                       AND t1.ATTRIBUTE_VALUE = COL07)
                       AND EXISTS
                               (SELECT 'Y'
                                  FROM USERS_ATTRIBUTES t2
                                 WHERE     t2.USER_PIDM = a.USER_PIDM
                                       AND t2.ATTRIBUTE_CODE = 'DEPARTMENT'
                                       AND t2.ATTRIBUTE_VALUE = COL08)
                       AND ACTIVE = 'Y')    VICE_PIDM,
               (SELECT a.USER_PIDM     DEAN_PIDM
                  FROM ROLE_USERS a
                 WHERE     ROLE_CODE = 'RO_COLLEGE_DEAN_GA'
                       AND EXISTS
                               (SELECT 'Y'
                                  FROM USERS_ATTRIBUTES t1
                                 WHERE     t1.USER_PIDM = a.USER_PIDM
                                       AND t1.ATTRIBUTE_CODE = 'COLLEGE'
                                       AND t1.ATTRIBUTE_VALUE = COL07)
                       AND EXISTS
                               (SELECT 'Y'
                                  FROM USERS_ATTRIBUTES t2
                                 WHERE     t2.USER_PIDM = a.USER_PIDM
                                       AND t2.ATTRIBUTE_CODE = 'DEPARTMENT'
                                       AND t2.ATTRIBUTE_VALUE = COL08)
                       AND ACTIVE = 'Y')    DEAN_PIDM
          FROM BU_DEV.TMP_TBL03)
 WHERE DMGR_PIDM IS not NULL OR VICE_PIDM IS not NULL OR DEAN_PIDM IS not NULL