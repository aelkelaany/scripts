 
SELECT f_get_std_id(SHRTTRM_PIDM) stid ,f_get_std_name(SHRTTRM_PIDM) stName
  FROM SHRTTRM m
 WHERE EXISTS
           (SELECT '1'
              FROM SHRTTRM
             WHERE     SHRTTRM_pidm = m.SHRTTRM_pidm
                   AND SHRTTRM_term_code = '144320'
                   AND SHRTTRM_ASTD_CODE_END_OF_TERM IN ('ä1')
                   )
                   
                   and not exists (SELECT '1'
              FROM SHRTTRM
             WHERE     SHRTTRM_pidm = m.SHRTTRM_pidm
                   AND SHRTTRM_term_code = '144340'
                   AND SHRTTRM_ASTD_CODE_END_OF_TERM IN ('ãÞ')
                   )
                   AND SHRTTRM_ASTD_CODE_END_OF_TERM  not IN ('ä1')
                   and SHRTTRM_term_code = '144340' ;







SELECT f_get_std_id(SHRTTRM_PIDM) stid ,f_get_std_name(SHRTTRM_PIDM) stName
  FROM SHRTTRM m
 WHERE EXISTS
           (SELECT '1'
              FROM SHRTTRM
             WHERE     SHRTTRM_pidm = m.SHRTTRM_pidm
                   AND SHRTTRM_term_code = '144320'
                   AND SHRTTRM_ASTD_CODE_END_OF_TERM IN ('ä2')
                   )
                   
                   and not exists (SELECT '1'
              FROM SHRTTRM
             WHERE     SHRTTRM_pidm = m.SHRTTRM_pidm
                   AND SHRTTRM_term_code = '144340'
                   AND SHRTTRM_ASTD_CODE_END_OF_TERM IN ('ãÞ')
                   )
                   and SHRTTRM_term_code = '144340'
                   AND SHRTTRM_ASTD_CODE_END_OF_TERM not IN ('ä2') ;