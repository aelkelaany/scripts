/* Formatted on 5/26/2020 9:05:52 PM (QP5 v5.227.12220.39754) */
  SELECT DISTINCT F_GET_STD_ID (SFRSTCR_PIDM), F_GET_STD_NAME (SFRSTCR_PIDM)
    FROM SFRSTCR, SGBSTDN SG
   WHERE     SFRSTCR_TERM_CODE = '144030'
         AND SGBSTDN_TERM_CODE_EFF =
                (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                   FROM SGBSTDN
                  WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                        AND SGBSTDN_TERM_CODE_EFF <= '144030')
         AND SGBSTDN_PIDM = SFRSTCR_PIDM
         AND EXISTS
                (SELECT '1'
                   FROM SSRRCOL
                  WHERE     SSRRCOL_CRN = SFRSTCR_CRN
                        AND SSRRCOL_TERM_CODE = '144030')
         AND  NOT EXISTS
                    (SELECT '1'
                       FROM SSRRCOL
                      WHERE     SSRRCOL_CRN = SFRSTCR_CRN
                            AND SSRRCOL_TERM_CODE = '144030'
                            AND SSRRCOL_COLL_CODE = SGBSTDN_COLL_CODE_1)
ORDER BY 1