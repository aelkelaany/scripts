/* Formatted on 16/11/2021 12:35:10 (QP5 v5.371) */
  SELECT COUNT (PIDM)     TOTAL,
         stvcoll_desc,
         stvdept_desc,
         SUM (SAUDI_MALE)SAUDI_MALE,SUM (SAUDI_FEMALE)SAUDI_FEMALE,
          SUM (NON_SAUDI_MALE)NON_SAUDI_MALE,SUM (NON_SAUDI_FEMALE)NON_SAUDI_FEMALE
    FROM (SELECT SGBSTDN_PIDM
                     PIDM,
                 (SELECT COUNT (SPBPERS_PIDM)
                    FROM SPBPERS
                   WHERE SPBPERS_SEX = 'M' AND SPBPERS_CITZ_CODE='”'AND SPBPERS_PIDM = SGBSTDN_PIDM)
                     SAUDI_MALE,
                     (SELECT COUNT (SPBPERS_PIDM)
                    FROM SPBPERS
                   WHERE SPBPERS_SEX = 'F' AND SPBPERS_CITZ_CODE='”' AND SPBPERS_PIDM = SGBSTDN_PIDM)
                     SAUDI_FEMALE,
                     (SELECT COUNT (SPBPERS_PIDM)
                    FROM SPBPERS
                   WHERE SPBPERS_SEX = 'M' AND SPBPERS_CITZ_CODE<>'”' AND SPBPERS_PIDM = SGBSTDN_PIDM)
                     NON_SAUDI_MALE,
                     (SELECT COUNT (SPBPERS_PIDM)
                    FROM SPBPERS
                   WHERE SPBPERS_SEX = 'F' AND SPBPERS_CITZ_CODE<>'”' AND SPBPERS_PIDM = SGBSTDN_PIDM)
                     NON_SAUDI_FEMALE,
                 stvcoll_desc,
                 stvdept_desc,
                 STVCOLL_VR_MSG_NO
            FROM SGBSTDN a, stvcoll, stvdept
           WHERE    SGBSTDN_STST_CODE IN( '„”','ÿ”','„Œ')
                 AND SGBSTDN_TERM_CODE_EFF IN ('144310')
                 AND SGBSTDN_TERM_CODE_ADMIT='144210'
            --  AND SGBSTDN_COLL_CODE_1='12'
                 AND SGBSTDN_COLL_CODE_1 = stvcoll_code
                 AND SGBSTDN_DEPT_CODE = stvdept_code
                 AND SGBSTDN_LEVL_CODE = 'Ã„'             ------------ level
                                               )
GROUP BY stvcoll_desc, stvdept_desc, STVCOLL_VR_MSG_NO
ORDER BY STVCOLL_VR_MSG_NO ASC;