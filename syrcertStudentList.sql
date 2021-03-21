 
SELECT DISTINCT f_get_std_id (shrdgmr_pidm) st_id,
                f_get_std_name (shrdgmr_pidm),
                SPBPERS_SSN ssn_id,
                ' ' Student_signature
  FROM saturn.shrdgmr,
       saturn.stvdegs,
       saturn.spriden,
       saturn.spbpers,
       SATURN.SGBSTDN
 WHERE     spriden_id BETWEEN :p_id_from AND NVL (:p_id_to, :p_id_from)
        
       AND shrdgmr_grad_date LIKE NVL (:p_grad_date, shrdgmr_grad_date)
       AND NVL (shrdgmr_term_code_grad, '%') LIKE NVL (:p_term_code, '%')
       AND NVL (shrdgmr_camp_code, '%') LIKE NVL (:p_camp, '%')
       AND NVL (shrdgmr_coll_code_1, '%') LIKE NVL (:p_coll_code, '%')
       AND NVL (shrdgmr_majr_code_1, '%') LIKE NVL (:p_majr_code, '%')
       AND NVL (shrdgmr_levl_code, '%') LIKE NVL (:p_level, '%')
       AND NVL (SGBSTDN_STYP_CODE, '%') LIKE NVL (:P_TYPE, '%')
       AND spriden_change_ind IS NULL
       AND stvdegs_award_status_ind = 'A'
       AND shrdgmr_degs_code = stvdegs_code
       AND shrdgmr_pidm = spriden_pidm
       AND shrdgmr_pidm = sgbstdn_pidm
       AND spbpers_pidm(+) = shrdgmr_pidm
       AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (A.SGBSTDN_TERM_CODE_EFF)
                                      FROM SGBSTDN A
                                     WHERE A.SGBSTDN_PIDM = shrdgmr_pidm)
       AND (   (    :P_FLAG = 'Y'
                AND EXISTS
                       (SELECT 'Y'
                          FROM request_master
                         WHERE     REQUEST_STATUS = 'C'
                               AND OBJECT_CODE = 'WF_UPDATE_STD_INFO'
                               AND REQUESTER_PIDM = shrdgmr_pidm
                               AND ACTIVITY_DATE > :p_from_date
                               AND ACTIVITY_DATE < :p_to_date
                               AND ROWNUM < 2))
            OR (    :P_FLAG = 'N'
                AND NOT EXISTS
                           (SELECT 'Y'
                              FROM request_master
                             WHERE     REQUEST_STATUS = 'C'
                                   AND OBJECT_CODE = 'WF_UPDATE_STD_INFO'
                                   AND REQUESTER_PIDM = shrdgmr_pidm))
            OR :P_FLAG = 'A');