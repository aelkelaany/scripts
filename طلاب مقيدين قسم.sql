SELECT   F_GET_STD_ID(SGBSTDN_PIDM), F_GET_STD_NAME(SGBSTDN_PIDM),A.SGBSTDN_STYP_CODE ,SGBSTDN_STST_CODE
         
             FROM SGBSTDN A  ,  stvcoll, stvdept
            WHERE     A.SGBSTDN_TERM_CODE_EFF =
                         (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                            FROM SGBSTDN
                           WHERE SGBSTDN_PIDM = A.SGBSTDN_PIDM)
                  AND SGBSTDN_STST_CODE IN( 'AS','ãÚ','ãæ')

                  AND SGBSTDN_DEPT_CODE='1501'
                   AND SGBSTDN_COLL_CODE_1='15'
                    AND SGBSTDN_LEVL_CODE = 'Ìã' 
                     AND SGBSTDN_COLL_CODE_1 = stvcoll_code
                 AND SGBSTDN_DEPT_CODE = stvdept_code
             ORDER BY  F_GET_STD_ID(SGBSTDN_PIDM)