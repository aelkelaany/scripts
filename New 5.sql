SELECT * FROM  SFRSTCR A
 WHERE     EXISTS
              (SELECT 'y'
                 FROM GLBEXTR
                WHERE     GLBEXTR_KEY = A.SFRSTCR_PIDM
                      AND GLBEXTR_SELECTION = 'BLOCK_REG_143920_f16')
       AND SFRSTCR_TERM_CODE = '143920'
       AND SFRSTCR_RSTS_CODE IN ('RW', 'RE')
--       AND SFRSTCR_CRN IN
--              (SELECT SSRBLCK_CRN
--                 FROM SSRBLCK
--                WHERE     SSRBLCK_TERM_CODE = '143920'
--                      AND SSRBLCK_BLCK_CODE = 'F16') ;