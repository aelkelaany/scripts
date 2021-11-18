/* Formatted on 16/11/2021 12:35:10 (QP5 v5.371) */
  SELECT COUNT (PIDM)     TOTAL,
         stvcoll_desc,
         stvdept_desc,
         SUM (SAUDI_MALE)SAUDI_MALE,SUM (SAUDI_FEMALE)SAUDI_FEMALE,
          SUM (NON_SAUDI_MALE)NON_SAUDI_MALE,SUM (NON_SAUDI_FEMALE)NON_SAUDI_FEMALE
    FROM (SELECT shrdgmr_PIDM
                     PIDM,
                 (SELECT COUNT (SPBPERS_PIDM)
                    FROM SPBPERS
                   WHERE SPBPERS_SEX = 'M' AND SPBPERS_CITZ_CODE='”'AND SPBPERS_PIDM = SHRDGMR_PIDM)
                     SAUDI_MALE,
                     (SELECT COUNT (SPBPERS_PIDM)
                    FROM SPBPERS
                   WHERE SPBPERS_SEX = 'F' AND SPBPERS_CITZ_CODE='”' AND SPBPERS_PIDM = SHRDGMR_PIDM)
                     SAUDI_FEMALE,
                     (SELECT COUNT (SPBPERS_PIDM)
                    FROM SPBPERS
                   WHERE SPBPERS_SEX = 'M' AND SPBPERS_CITZ_CODE<>'”' AND SPBPERS_PIDM = SHRDGMR_PIDM)
                     NON_SAUDI_MALE,
                     (SELECT COUNT (SPBPERS_PIDM)
                    FROM SPBPERS
                   WHERE SPBPERS_SEX = 'F' AND SPBPERS_CITZ_CODE<>'”' AND SPBPERS_PIDM = SHRDGMR_PIDM)
                     NON_SAUDI_FEMALE,
                 stvcoll_desc,
                 stvdept_desc,
                 STVCOLL_VR_MSG_NO
            FROM shrdgmr a, stvcoll, stvdept
           WHERE     SHRDGMR_DEGS_CODE = 'ŒÃ'
                 AND SHRDGMR_TERM_CODE_GRAD IN ('144210', '144220', '144230')
              AND SHRDGMR_COLL_CODE_1='12'
                 AND SHRDGMR_COLL_CODE_1 = stvcoll_code
                 AND SHRDGMR_DEPT_CODE = stvdept_code
                 AND SHRDGMR_LEVL_CODE = 'œ»'             ------------ level
                                               )
GROUP BY stvcoll_desc, stvdept_desc, STVCOLL_VR_MSG_NO
ORDER BY STVCOLL_VR_MSG_NO ASC;