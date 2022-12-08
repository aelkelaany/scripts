 
  SELECT DISTINCT SFRSTCR_CRN, F_GET_STD_ID (SFRSTCR_PIDM), F_GET_STD_NAME (SFRSTCR_PIDM) ,SGBSTDN_DEPT_CODE ,SGBSTDN_COLL_CODE_1
    FROM SFRSTCR, SGBSTDN SG
   WHERE     SFRSTCR_TERM_CODE = '144410'
         AND SGBSTDN_TERM_CODE_EFF =
                (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                   FROM SGBSTDN
                  WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                        AND SGBSTDN_TERM_CODE_EFF <= '144410')
         AND SGBSTDN_PIDM = SFRSTCR_PIDM
         AND EXISTS
                (SELECT '1'
                   FROM SSRRDEP
                  WHERE     SSRRDEP_CRN = SFRSTCR_CRN
                        AND SSRRDEP_TERM_CODE = '144410')
         AND  NOT EXISTS
                    (SELECT '1'
                       FROM SSRRDEP
                      WHERE     SSRRDEP_CRN = SFRSTCR_CRN
                            AND SSRRDEP_TERM_CODE = '144410'
                            AND SSRRDEP_DEPT_CODE = SGBSTDN_DEPT_CODE)
ORDER BY 1