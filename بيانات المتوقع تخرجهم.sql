/* Formatted on 3/8/2023 11:20:47 AM (QP5 v5.371) */
  -- «·Ã‰”- «·ﬂ·Ì…- «· Œ’’- «·”Ã· «·„œ‰Ì- «·—ﬁ„ «·Ã«„⁄Ì- «·ÃÊ«·- «Ì„Ì· «·Ã«„⁄…- «·«Ì„Ì· «·‘Œ’Ì

  SELECT sgbstdn_pidm
             pidm,
         f_get_std_id (sgbstdn_pidm)
             st_id,
         f_get_std_name (sgbstdn_pidm)
             st_name,
         DECODE (spbpers_sex, 'M', '–ﬂ—', '√‰ÀÏ')
             sex,
         sgbstdn_coll_code_1
             coll_code,
         SMBPOGN_ACT_CREDITS_OVERALL
             tot_act,
         SMBPOGN_REQ_CREDITS_OVERALL
             tot_req,
         SMBPOGN_REQ_CREDITS_OVERALL - SMBPOGN_ACT_CREDITS_OVERALL
             remaining,
         spbpers_ssn,
         (SELECT sprtele_intl_access
            FROM sprtele
           WHERE     sprtele_pidm = sgbstdn_pidm
                 AND sprtele_tele_code = 'MO'
                 AND ROWNUM = 1)
             "Mobile NO",
         (SELECT GOREMAL_EMAIL_ADDRESS
            FROM GENERAL.GOREMAL
           WHERE     GOREMAL_EMAL_CODE = 'BU'
                 AND GOREMAL_STATUS_IND = 'A'
                 AND GOREMAL_PIDM = sgbstdn_pidm
                 AND ROWNUM < 2)
             BU_email,
         (SELECT GOREMAL_EMAIL_ADDRESS
            FROM GENERAL.GOREMAL
           WHERE     GOREMAL_EMAL_CODE = 'PS'
                 AND GOREMAL_STATUS_IND = 'A'
                 AND GOREMAL_PIDM = sgbstdn_pidm
                 AND ROWNUM < 2)
             personal_email,
         f_get_desc_fnc ('stvmajr', a.SGBSTDN_MAJR_CODE_1, 30)
             major_desc,
         f_get_desc_fnc ('stvcoll', a.sgbstdn_coll_code_1, 30)
             coll_desc
    FROM sgbstdn a, SMBPOGN, spbpers
   WHERE     A.SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                          FROM SGBSTDN
                                         WHERE SGBSTDN_PIDM = A.SGBSTDN_PIDM)
         AND sgbstdn_PIDM = SMBPOGN_PIDM
         AND sgbstdn_PIDM = Spbpers_PIDM
         AND a.SGBSTDN_MAJR_CODE_1 IN (/*'4111',
                                       '4102',*/
                                       '3203'/*,
                                       '4104',
                                       '4103',
                                       '1602',
                                       '1604'*/)
         AND sgbstdn_levl_code = 'Ã„'
         AND a.sgbstdn_stst_code = 'AS'
         AND SMBPOGN_REQUEST_NO = (SELECT MAX (SMBPOGN_REQUEST_NO)
                                     FROM SMBPOGN
                                    WHERE SMBPOGN_PIDM = A.SGBSTDN_PIDM)
         AND SMBPOGN_REQ_CREDITS_OVERALL - SMBPOGN_ACT_CREDITS_OVERALL BETWEEN 1
                                                                           AND 24
ORDER BY coll_desc,
         major_desc,
         sex,
         st_id;