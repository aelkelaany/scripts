/* —’œ ‘⁄»… „⁄Ì‰… */
SELECT *
  FROM sfrstcr
 WHERE     sfrstcr_term_code = '143510'
       AND sfrstcr_crn = '10047'
       AND SFRSTCR_GRDE_CODE IS NULL
        AND sfrstcr_rsts_code IN ('RE', 'RW')
        AND sfrstcr_grde_date IS NULL
       AND EXISTS
              (SELECT 's'
                 FROM SGBSTDN SG
                WHERE     SGBSTDN_TERM_CODE_EFF =
                             (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN
                               WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                                     AND SGBSTDN_TERM_CODE_EFF <= '144210')
                      AND SGBSTDN_STST_CODE NOT IN
                             ('ŒÃ', 'ÿ”', '„”')
                      AND SG.SGBSTDN_PIDM = sfrstcr_pidm);

                     

UPDATE sfrstcr
   SET SFRSTCR_GRDE_CODE = '‰œ'
 WHERE     sfrstcr_term_code = '143510'
       AND sfrstcr_crn = '10047'
       AND SFRSTCR_GRDE_CODE IS NULL
         AND sfrstcr_rsts_code IN ('RE', 'RW')
        AND sfrstcr_grde_date IS NULL
       AND EXISTS
              (SELECT 's'
                 FROM SGBSTDN SG
                WHERE     SGBSTDN_TERM_CODE_EFF =
                             (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN
                               WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                                     AND SGBSTDN_TERM_CODE_EFF <= '144210')
                      AND SGBSTDN_STST_CODE NOT IN
                             ('ŒÃ', 'ÿ”', '„”')
                      AND SG.SGBSTDN_PIDM = sfrstcr_pidm);


                      ----////////////////////////////// —’œ „‰ „·›

UPDATE sfrstcr
   SET SFRSTCR_GRDE_CODE = '‰œ'
 WHERE     SFRSTCR_TERM_CODE = '144030'
      AND sfrstcr_rsts_code IN ('RE', 'RW')
        AND sfrstcr_grde_date IS NULL
       AND SFRSTCR_CRN = '30858'
       AND EXISTS
              (SELECT '1'
                 FROM bu_dev.tmp_tbl03
                WHERE COL02 = SFRSTCR_PIDM)
       AND SFRSTCR_GRDE_CODE IS NULL;