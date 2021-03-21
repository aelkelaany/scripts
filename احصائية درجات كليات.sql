/* Formatted on 3/24/2019 12:45:33 PM (QP5 v5.227.12220.39754) */
  SELECT *
    FROM (  SELECT DISTINCT
                   scbcrse_coll_code college,
                   f_get_desc_fnc ('STVCOLL', scbcrse_coll_code, 60) college_desc,
                   shrgrds_grde_code_substitute grade,
                   COUNT (sfrstcr_pidm) count_over_college
              FROM sfrstcr,
                   ssbsect,
                   scbcrse c1,
                   shrgrds s1
             WHERE     sfrstcr_term_code = ssbsect_term_code
                   AND sfrstcr_crn = ssbsect_crn
                   AND ssbsect_subj_code = c1.scbcrse_subj_code
                   AND ssbsect_crse_numb = c1.scbcrse_crse_numb
                   AND c1.scbcrse_eff_term =
                          (SELECT MAX (c2.scbcrse_eff_term)
                             FROM scbcrse c2
                            WHERE     c2.scbcrse_subj_code = c1.scbcrse_subj_code
                                  AND c2.scbcrse_crse_numb = c1.scbcrse_crse_numb)
                   AND s1.shrgrds_grde_code = sfrstcr_grde_code
                   AND s1.shrgrds_levl_code = sfrstcr_levl_code
                   AND s1.shrgrds_gmod_code_student = 'Ν'
                   AND s1.shrgrds_term_code_effective =
                          (SELECT MAX (s2.shrgrds_term_code_effective)
                             FROM shrgrds s2
                            WHERE     s2.shrgrds_grde_code = s1.shrgrds_grde_code
                                  AND s2.shrgrds_levl_code = s1.shrgrds_levl_code
                                  AND s2.shrgrds_gmod_code_student = 'Ν')
                   AND sfrstcr_term_code = :p_term
                   AND scbcrse_coll_code LIKE NVL (:p_coll, '%')
          GROUP BY scbcrse_coll_code, shrgrds_grde_code_substitute) PIVOT (SUM (
                                                                              count_over_college) AS "Count"
                                                                    FOR (grade)
                                                                    IN  ('Γ+' AS "A+",
                                                                        'Γ' AS "A",
                                                                        'Θ+' AS "B+",
                                                                        'Θ' AS "B",
                                                                        'Μ+' AS "C+",
                                                                        'Μ' AS "C",
                                                                        'Ο+' AS "D+",
                                                                        'Ο' AS "D",
                                                                        'εά' AS "F"))
ORDER BY 1, 2, 3