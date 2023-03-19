/* Formatted on 8/25/2020 7:59:31 PM (QP5 v5.360) */
/*CREATE TABLE DEV_BACKUP.SFRSTCR_DEL26052020 AS SELECT * FROM SFRSTCR 
WHERE 
(SFRSTCR_CRN,SFRSTCR_PIDM,SFRSTCR_TERM_CODE)
IN (*/


SELECT DISTINCT
       SFRSTCR_CRN,
       SFRSTCR_PIDM,
       SFRSTCR_TERM_CODE,
       f_get_std_name (SFRSTCR_PIDM),f_get_std_id (SFRSTCR_PIDM) stid,
       sfrstcr_rsts_code,
       sgbstdn_camp_code,
       f_get_desc_fnc ('STVCAMP', sgbstdn_camp_code, 60)
           AS "ÝÑÚ ÇáØÇáÈ",
       (SELECT ssbsect_camp_code
          FROM ssbsect
         WHERE     ssbsect_term_code = sfrstcr_term_code
               AND ssbsect_crn = sfrstcr_crn)
           AS "ÇáÝÑÚ ÈÇáÌÏæá",
       f_get_desc_fnc (
           'STVCAMP',
           (SELECT ssbsect_camp_code
              FROM ssbsect
             WHERE     ssbsect_term_code = sfrstcr_term_code
                   AND ssbsect_crn = sfrstcr_crn),
           60) AS "ÇáÝÑÚ ÈÇáÌÏæá",
       (SELECT MIN (SSRRCMP_CAMP_CODE)
          FROM SSRRCMP
         WHERE     SSRRCMP_CRN = SFRSTCR_CRN
               AND SSRRCMP_TERM_CODE = SFRSTCR_TERM_CODE
               AND SSRRCMP_REC_TYPE = '2'
               AND SSRRCMP_CAMP_IND IS NULL)
           ssrcampus,
       f_get_desc_fnc (
           'STVCAMP',
           (SELECT MIN (SSRRCMP_CAMP_CODE)
              FROM SSRRCMP
             WHERE     SSRRCMP_CRN = SFRSTCR_CRN
                   AND SSRRCMP_TERM_CODE = SFRSTCR_TERM_CODE
                   AND SSRRCMP_REC_TYPE = '2'
                   AND SSRRCMP_CAMP_IND IS NULL),
           60)
           AS "ÞíÏ ÇáÝÑÚ"
  FROM SFRSTCR, SGBSTDN SG
 WHERE     SFRSTCR_TERM_CODE = '144430'
       AND SGBSTDN_TERM_CODE_EFF =
           (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
              FROM SGBSTDN
             WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                   AND SGBSTDN_TERM_CODE_EFF <= '144430')
       AND SGBSTDN_PIDM = SFRSTCR_PIDM
       AND EXISTS
               (SELECT '1'
                  FROM SSRRCMP
                 WHERE     SSRRCMP_CRN = SFRSTCR_CRN
                       AND SSRRCMP_TERM_CODE = '144430'
                       AND sfrstcr_rsts_code IN ('RW', 'RE')
                       AND SGBSTDN_CAMP_CODE IS NOT NULL)
       AND NOT EXISTS
               (SELECT '1'
                  FROM SSRRCMP
                 WHERE     SSRRCMP_CRN = SFRSTCR_CRN
                       AND SSRRCMP_TERM_CODE = '144430'
                       AND SSRRCMP_CAMP_CODE = SGBSTDN_CAMP_CODE)
ORDER BY 1
--  )