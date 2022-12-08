/* Formatted on 8/28/2022 12:51:09 PM (QP5 v5.371) */
SELECT f_get_std_id (SHRTTRM_PIDM) stid, f_get_std_name (SHRTTRM_PIDM) stName
  FROM SHRTTRM m
 WHERE     SHRTTRM_ASTD_CODE_END_OF_TERM IN ('Ýß')
       AND SHRTTRM_term_code = (SELECT MAX (SHRTTRM_term_code)
                                  FROM SHRTTRM
                                 WHERE SHRTTRM_pidm = m.SHRTTRM_pidm)
       AND EXISTS
               (SELECT '1'
                  FROM sgbstdn SG
                 WHERE     sgbstdn_pidm = m.SHRTTRM_pidm
                       AND SGBSTDN_TERM_CODE_EFF =
                           (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                              FROM SGBSTDN
                             WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                       AND SGBSTDN_STST_CODE = 'AS'
                       and SGBSTDN_ASTD_CODE is null);