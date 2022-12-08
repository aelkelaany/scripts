/* Formatted on 12/4/2022 2:42:18 PM (QP5 v5.371) */
SELECT f_get_std_id (sgbstdn_pidm),
       f_get_std_name (sgbstdn_pidm),
       SPBPERS_CITZ_CODE,
       SPBPERS_SSN,
       F_GET_DESC_FNC ('STVCITZ', SPBPERS_CITZ_CODE, 60),
       F_GET_DESC_FNC ('STVLEVL', SGBSTDN_LEVL_CODE, 60)      LEVL_DESC,
       F_GET_DESC_FNC ('STVCOLL', SGBSTDN_COLL_CODE_1, 60)    COLL_DESC,
       F_GET_DESC_FNC ('STVDEPT', SGBSTDN_DEPT_CODE, 60)      DEPT_DESC,
       F_GET_DESC_FNC ('STVMAJR', SGBSTDN_MAJR_CODE_1, 60)    MAJR_DESC,
       SPBPERS_SEX,
       (SELECT SPRTELE_INTL_ACCESS
          FROM sprtele
         WHERE     SPRTELE_pidm = sgbstdn_pidm
               AND SPRTELE_TELE_CODE = 'MO'
               AND ROWNUM < 2)                                phone
  FROM sgbstdn sg, spbpers
 WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                      FROM sgbstdn
                                     WHERE sgbstdn_pidm = sg.sgbstdn_pidm)
       AND SPBPERS_pidm = sg.sgbstdn_pidm
       AND SPBPERS_CITZ_CODE <> 'Ó'
       AND sgbstdn_stst_code IN ('AS',
                                 'ãæ',
                                 'ãÚ',
                                 'Øã',
                                 'ÅÞ',
                                 'Ýß')
-- AND SPBPERS_SEX='F'
UNION
SELECT f_get_std_id (sgbstdn_pidm),
       f_get_std_name (sgbstdn_pidm),
       SPBPERS_CITZ_CODE,
       SPBPERS_SSN,
       F_GET_DESC_FNC ('STVCITZ', SPBPERS_CITZ_CODE, 60),
       F_GET_DESC_FNC ('STVLEVL', SGBSTDN_LEVL_CODE, 60)      LEVL_DESC,
       F_GET_DESC_FNC ('STVCOLL', SGBSTDN_COLL_CODE_1, 60)    COLL_DESC,
       F_GET_DESC_FNC ('STVDEPT', SGBSTDN_DEPT_CODE, 60)      DEPT_DESC,
       F_GET_DESC_FNC ('STVMAJR', SGBSTDN_MAJR_CODE_1, 60)    MAJR_DESC,
       SPBPERS_SEX,
       (SELECT SPRTELE_INTL_ACCESS
          FROM sprtele
         WHERE     SPRTELE_pidm = sgbstdn_pidm
               AND SPRTELE_TELE_CODE = 'MO'
               AND ROWNUM < 2)                                phone
  FROM sgbstdn sg, spbpers
 WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                      FROM sgbstdn
                                     WHERE sgbstdn_pidm = sg.sgbstdn_pidm)
       AND SPBPERS_pidm = sg.sgbstdn_pidm
       AND SPBPERS_SSN LIKE '2%'
       AND sgbstdn_stst_code IN ('AS',
                                 'ãæ',
                                 'ãÚ',
                                 'Øã',
                                 'ÅÞ',
                                 'Ýß')
-- AND SPBPERS_SEX='F'

ORDER BY 6, 5, 1