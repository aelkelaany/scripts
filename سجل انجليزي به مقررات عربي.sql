SELECT distinct SHRTCKN_SUBJ_CODE SUBJ_CODE,
               SHRTCKN_CRSE_NUMB CRSE_NUMB, title ,SHRTCKN_TERM_CODE
  FROM (SELECT DISTINCT
               SHRTCKN_TERM_CODE,
               SHRTCKN_SUBJ_CODE,
               SHRTCKN_CRSE_NUMB,
               f_get_course_title_en (SHRTCKN_TERM_CODE,
                                   SHRTCKN_SUBJ_CODE,
                                   SHRTCKN_CRSE_NUMB)    TITLE
          FROM SHRTCKN
         WHERE EXISTS
                   (SELECT '1'
                      FROM shrdgmr
                     WHERE     shrdgmr_pidm = SHRTCKN_PIDM
                           AND shrdgmr_coll_code_1 IN ('32','55','33','14','25')
                           AND SHRDGMR_TERM_CODE_GRAD = '144320'
                           AND SHRDGMR_DEGS_CODE = 'ÎÌ'))
 WHERE     LOWER (title) NOT LIKE '%e%'
       AND LOWER (title) NOT LIKE '%a%'
       AND LOWER (title) NOT LIKE '%i%'
       AND LOWER (title) NOT LIKE '%o%'

      -- dle.SCRSYLN