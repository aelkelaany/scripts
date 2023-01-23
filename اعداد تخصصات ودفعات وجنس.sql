/* Formatted on 1/8/2023 9:42:26 PM (QP5 v5.365) */
  SELECT st_coll ,st_level,
         intake,
         major_desc,
         sex,
         COUNT (std_id)
    FROM (SELECT spriden_id
                     std_id,
                 (CASE
                      WHEN SUBSTR (spriden_id, 1, 3) <= '439' THEN '439'
                      ELSE SUBSTR (spriden_id, 1, 3)
                  END)
                     intake,
                 spbpers_sex
                     sex,
                 SGBSTDN_MAJR_CODE_1
                     major,
                 f_get_desc_fnc ('stvmajr', SGBSTDN_MAJR_CODE_1, 30)
                     major_desc,
                 f_get_desc_fnc ('stvlevl', SGBSTDN_levl_CODE, 30)
                     st_level , f_get_desc_fnc ('stvcoll', sgbstdn_coll_code_1, 30) st_coll
            FROM sgbstdn, spriden, spbpers
           WHERE     sgbstdn_pidm = spriden_pidm
                 AND SPRIDEN_CHANGE_IND IS NULL
                 AND SGBSTDN_TERM_CODE_EFF =
                     (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                        FROM SGBSTDN
                       WHERE sgbstdn_pidm = spriden_pidm)
                 AND SGBSTDN_STST_CODE IN ('AS', 'ãæ', 'ãÚ','Øí')
                 AND sgbstdn_coll_code_1 in('15','31','17','18','19','42')
                 AND sgbstdn_pidm = spbpers_pidm)
GROUP BY st_coll ,st_level,
         sex,
         intake,
         major_desc
ORDER BY st_coll ,st_level,
         intake,
         major_desc,
         sex;