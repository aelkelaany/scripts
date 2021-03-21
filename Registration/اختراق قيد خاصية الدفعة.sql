 
  SELECT DISTINCT SFRSTCR_CRN, F_GET_STD_ID (SFRSTCR_PIDM), F_GET_STD_NAME (SFRSTCR_PIDM)  ,SFRSTCR_PIDM  , SSRRCHR_CHRT_CODE 
    FROM SFRSTCR ,SSRRCHR
   WHERE     SFRSTCR_TERM_CODE = '144030'
       AND SSRRCHR_CRN = SFRSTCR_CRN  
        AND SSRRCHR_TERM_CODE = '144030' 
          AND  SSRRCHR_CHRT_CODE IS NOT NULL 
         AND   NOT   EXISTS
                    (SELECT '1'
                       FROM SGRCHRT
                      WHERE SGRCHRT_PIDM=SFRSTCR_PIDM
                      AND  SGRCHRT_CHRT_CODE= SSRRCHR_CHRT_CODE 
                      AND SGRCHRT_TERM_CODE_EFF='144030'  
                            )
ORDER BY 1