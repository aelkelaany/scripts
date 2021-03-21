DELETE FROM SFRSTCR A
      WHERE     EXISTS
                   (SELECT 'y'
                      FROM GLBEXTR
                     WHERE     GLBEXTR_KEY = A.SFRSTCR_PIDM
                           AND GLBEXTR_SELECTION = 'BLOCK_REG_143920_O1')
            AND SFRSTCR_TERM_CODE = '143920'
            AND SFRSTCR_RSTS_CODE IN ('RW', 'RE')
            AND SFRSTCR_CRN IN
                   (SELECT SSRBLCK_CRN
                      FROM SSRBLCK
                     WHERE     SSRBLCK_TERM_CODE = '143920'
                           AND SSRBLCK_BLCK_CODE = 'O1');

---------------------------------------------------------------------------------------------------------

UPDATE SGBSTDN A
   SET A.SGBSTDN_BLCK_CODE = 'O2'
 WHERE     EXISTS
              (SELECT 'y'
                 FROM GLBEXTR
                WHERE     GLBEXTR_KEY = A.SGBSTDN_PIDM
                      AND GLBEXTR_SELECTION = 'BLOCK_REG_143920_O1')
       AND A.SGBSTDN_BLCK_CODE = 'O1'
       AND A.SGBSTDN_TERM_CODE_EFF =
              (SELECT MAX (B.SGBSTDN_TERM_CODE_EFF)
                 FROM SGBSTDN B
                WHERE     SGBSTDN_TERM_CODE_EFF <= '143920'
                      AND B.SGBSTDN_PIDM = A.SGBSTDN_PIDM);