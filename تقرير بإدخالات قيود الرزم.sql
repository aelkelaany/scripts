/* Formatted on 8/24/2020 9:15:06 PM (QP5 v5.360) */
SELECT STVBLCK_CODE,
       STVBLCK_DESC,
       SYRBLKR_COLL_CODE,
       f_get_desc_fnc ('STVCOLL', SYRBLKR_COLL_CODE, 60)
           AS "«·ﬂ·Ì…",
       SYRBLKR_CAMP_CODE,
       f_get_desc_fnc ('STVCAMP', SYRBLKR_CAMP_CODE, 60)
           AS "«·›—⁄",
       SYRBLKR_MAJR_CODE,
       f_get_desc_fnc ('STVMAJR', SYRBLKR_MAJR_CODE, 60)
           AS "«· Œ’’",
       SYRBLKR_DEPT_CODE,
       f_get_desc_fnc ('STVDEPT', SYRBLKR_DEPT_CODE, 60)
           AS "«·ﬁ”„",
       SYRBLKR_PROGRAM,
       (SELECT smrprle_program_desc
          FROM smrprle
         WHERE smrprle_program = SYRBLKR_PROGRAM)
           AS "Ê’› «·»—‰«„Ã",
       SYRBLKR_CAPACITY_NO,
       SYRBLKR_CAPACITY_USED
  FROM stvblck, syrblkr
 WHERE     SYRBLKR_BLCK_CODE = STVBLCK_CODE
       AND SYRBLKR_TERM_CODE = '144210'
       AND EXISTS
               (SELECT 'x'
                  FROM SSRBLCK
                 WHERE     SSRBLCK_TERM_CODE = SYRBLKR_TERM_CODE
                       AND SSRBLCK_BLCK_CODE = SYRBLKR_BLCK_CODE)
       AND SYRBLKR_LEVL_CODE = 'Ã„'