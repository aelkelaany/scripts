 
SELECT *
  FROM (SELECT shrdgmr_pidm,
               SPBPERS_SSN,
               f_get_std_id (shrdgmr_pidm)
                   stu_id,
               f_get_std_name (shrdgmr_pidm)
                   stu_name,
            
               f_get_desc_fnc ('stvcoll', shrdgmr_coll_code_1, 30)
                   college,
               shrdgmr_program,
               f_get_desc_fnc ('stvmajr', shrdgmr_majr_code_1, 30)
                   major,
               get_student_terms_count (shrdgmr_pidm, '144410')
                   st_terms_count,
               (SELECT SWRPRDU_MAX_NO_TERM
                  FROM SWRPRDU a
                 WHERE     SWRPRDU_PROGRAM = shrdgmr_program
                       AND SWRPRDU_EFF_TERM =
                           (SELECT MAX (SWRPRDU_EFF_TERM)
                              FROM SWRPRDU
                             WHERE SWRPRDU_PROGRAM = A.SWRPRDU_PROGRAM))
                   program_terms_count
          FROM shrdgmr, spbpers
         WHERE     SHRDGMR_DEGS_CODE = 'ÎÌ'
               AND SHRDGMR_TERM_CODE_GRAD LIKE '144410'
               AND SHRDGMR_DEGC_CODE = 'Èß'
               AND SUBSTR (shrdgmr_program, 1, 1) < '3'
               AND SPBPERS_PIDM = shrdgmr_pidm
               AND SPBPERS_SSN LIKE '1%'
               AND SPBPERS_CITZ_CODE = 'Ó'
               --       AND get_student_terms_count (shrdgmr_pidm) <=
               --           (SELECT SWRPRDU_MAX_NO_TERM
               --              FROM SWRPRDU a
               --             WHERE     SWRPRDU_PROGRAM = shrdgmr_program
               --                   AND SWRPRDU_EFF_TERM =
               --                       (SELECT MAX (SWRPRDU_EFF_TERM)
               --                          FROM SWRPRDU
               --                         WHERE SWRPRDU_PROGRAM = A.SWRPRDU_PROGRAM))
               AND EXISTS
                       (SELECT '1'
                          FROM shrtgpa, SHRASTR
                         WHERE     shrtgpa_PIDM = shrdgmr_pidm
                               AND shrtgpa_TERM_CODE = '144410'
                               AND shrtgpa_gpa BETWEEN SHRASTR_MIN_GPA_CUM
                                                   AND SHRASTR_MAX_GPA_CUM
                               AND SHRASTR_TERM_CODE_EFFECTIVE =
                                   (SELECT MAX (SHRASTR_TERM_CODE_EFFECTIVE)
                                      FROM SHRASTR
                                     WHERE     SHRASTR_LEVL_CODE =
                                               shrdgmr_levl_code
                                           AND SHRASTR_COLL_CODE = '99'
                                           AND SHRASTR_ASTD_CODE_NEXT =
                                               'ãã')
                               AND SHRASTR_COLL_CODE = '99'
                               AND SHRASTR_ASTD_CODE_NEXT = 'ãã')--and exists (select '1' from sgbstdn where sgbstdn_pidm =shrdgmr_pidm and sgbstdn_stst_code='ãæ')
                                                                   )
 WHERE st_terms_count<=program_terms_count
 order by  SHRDGMR_PROGRAM;