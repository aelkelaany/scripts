/* Formatted on 3/24/2020 1:59:27 PM (QP5 v5.354) */
  SELECT DISTINCT
         f_get_std_id (sfrstcr_pidm)       id,
         f_get_std_name (sfrstcr_pidm)     name,
         SUM (SFRSTCR_CREDIT_HR) total_hours ,f_get_desc_fnc ('STVCOLL', sgbstdn_coll_code_1, 60) AS "«·ﬂ·Ì…",

       f_get_desc_fnc ('STVDEPT', sgbstdn_dept_code, 60) AS "«·ﬁ”„",

       f_get_desc_fnc ('STVCAMP', sgbstdn_camp_code, 60) AS "«·›—⁄",

       f_get_desc_fnc ('STVMAJR', sgbstdn_majr_code_1, 60) AS "«· Œ’’"
    FROM sfrstcr,sgbstdn
   WHERE sgbstdn_pidm=sfrstcr_pidm
   and   SGBSTDN_TERM_CODE_EFF =(select max(SGBSTDN_TERM_CODE_EFF) from sgbstdn where sgbstdn_pidm=sfrstcr_pidm)
   and sfrstcr_term_code = '144020'
         AND sfrstcr_rsts_code IN  ('RE','RW')
         AND f_get_styp (sfrstcr_pidm) = '‰'
GROUP BY sfrstcr_pidm ,sgbstdn_coll_code_1,sgbstdn_dept_code,sgbstdn_camp_code,sgbstdn_majr_code_1
ORDER BY 6,4,5,3 desc