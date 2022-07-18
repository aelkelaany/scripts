/* Formatted on 6/30/2022 8:49:11 AM (QP5 v5.371) */
  SELECT DISTINCT
         f_get_std_id (sgbstdn_pidm)                           std_id,
         f_get_std_name (sgbstdn_pidm)                         std_name,
         f_get_desc_fnc ('stvstst', sgbstdn_stst_CODE, 30)     ststs_CODE,
         DECODE (SPBPERS_SEX, 'M', '–ﬂ—', '«‰ÀÏ')       SPBPERS_SEX,
         SPRADDR_CITY,
         f_get_desc_fnc ('stvlevl', sgbstdn_LEVL_CODE, 30)     LEVL_CODE,
         f_get_desc_fnc ('stvmajr', sgbstdn_majr_CODE_1, 30)     majr_CODE,SPRTELE_INTL_ACCESS
    FROM sgbstdn sg, spbpers, SPRADDR,sprtele
   WHERE     SGBSTDN_TERM_CODE_EFF =
             (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                FROM sgbstdn
               WHERE     sgbstdn_pidm = sg.sgbstdn_pidm
                     )
         AND SPBPERS_pidm = sg.sgbstdn_pidm
         AND sgbstdn_stst_code IN ('AS',
                                   '„Ê',
                                   '„⁄',
                                   'ÿ„',
                                   '≈ﬁ',
                                   '›ﬂ')
         AND sgbstdn_coll_CODE_1 = '35'
         AND sgbstdn_pidm = SPRADDR_pidm(+)
            AND sgbstdn_pidm =SPRTELE_PIDM(+)
            and SPRTELE_TELE_CODE = 'MO'
ORDER BY 2

;