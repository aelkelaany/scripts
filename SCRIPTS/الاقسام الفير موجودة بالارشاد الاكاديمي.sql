
SELECT -- SG.SGBSTDN_PIDM,
    COUNT(SG.SGBSTDN_PIDM) CNT,  f_get_desc_fnc ('STVCOLL', SG.sgbstdn_coll_code_1, 60)
          AS "«·ﬂ·Ì…",
       SG.sgbstdn_coll_code_1,
       f_get_desc_fnc ('STVDEPT', SG.sgbstdn_dept_code, 60) AS "«·ﬁ”„",
       SG.sgbstdn_dept_codE , (SELECT F_GET_STD_NAME(a.USER_PIDM )     
                  FROM ROLE_USERS a
                 WHERE     ROLE_CODE = 'RO_DEPT_MANAGER'
                      /* AND EXISTS
                               (SELECT 'Y'
                                  FROM USERS_ATTRIBUTES t1
                                 WHERE     t1.USER_PIDM = a.USER_PIDM
                                       AND t1.ATTRIBUTE_CODE = 'COLLEGE'
                                       AND t1.ATTRIBUTE_VALUE = SG.sgbstdn_coll_code_1)*/
                       AND EXISTS
                               (SELECT 'Y'
                                  FROM USERS_ATTRIBUTES t2
                                 WHERE     t2.USER_PIDM = a.USER_PIDM
                                       AND t2.ATTRIBUTE_CODE = 'DEPARTMENT'
                                       AND t2.ATTRIBUTE_VALUE = SG.sgbstdn_dept_code) 
                                       AND ROWNUM<2 ) AS "«·„—‘œ"
  FROM sgbstdn SG
 WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                      FROM sgbstdn
                                     WHERE sgbstdn_pidm = SG.sgbstdn_pidm)
       AND SG.sgbstdn_dept_code NOT IN
              (SELECT DISTINCT sgbstdn_dept_code
                 FROM SATURN.SGRADVR, SGBSTDN
                WHERE     sgbstdn_pidm = SGRADVR_PIDM
                      AND SGBSTDN_TERM_CODE_EFF =
                             (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                FROM sgbstdn
                               WHERE sgbstdn_pidm = SGRADVR_PIDM))
       AND SG.sgbstdn_dept_code IN (SELECT ATTRIBUTE_VALUE
                                      FROM USERS_ATTRIBUTES
                                     WHERE ATTRIBUTE_CODE = 'DEPARTMENT')
                                        AND SG.sgbstdn_coll_code_1 IN (SELECT ATTRIBUTE_VALUE
                                      FROM USERS_ATTRIBUTES
                                     WHERE ATTRIBUTE_CODE = 'COLLEGE')
       AND SG.SGBSTDN_PIDM NOT IN (SELECT SGRADVR_PIDM FROM SGRADVR)
       AND SG.SGBSTDN_STST_CODE NOT IN ('ŒÃ', '„”', 'ÿ”', '„Œ')
       GROUP BY SG.sgbstdn_coll_code_1 ,SG.sgbstdn_dept_code
       ORDER BY 5