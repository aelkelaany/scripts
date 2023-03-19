/* Formatted on 2/7/2023 12:52:32 PM (QP5 v5.371) */
SELECT SMBPOGN_PIDM,
       f_get_std_id (SMBPOGN_PIDM)                       AS "«·—ﬁ„ «·Ã«„⁄Ì",
       f_get_std_name (SMBPOGN_PIDM)                     AS "«·«”„",
       SMBPOGN_REQUEST_NO                                "REQUEST NEW",
       SMBPOGN_PROGRAM                                   AS "«·»—‰«„Ã",
       smrprle_program_desc,
       SMBPOGN_REQ_CREDITS_OVERALL                       AS "OVER_ALL",
       SMBPOGN_ACT_CREDITS_OVERALL                       AS "actual",
       (SELECT NVL (SUM (SFRSTCR_CREDIT_HR), 0)
          FROM SFRSTCR
         WHERE     SFRSTCR_PIDM = SMBPOGN_PIDM
               AND sfrstcr_term_code = '144420'
               AND sfrstcr_rsts_code IN ('RE', 'RW'))    AS "REG_HRS",
       SMBPOGN_COLL_CODE                                 AS "«·ﬂ·Ì…",
       f_get_desc_fnc ('stvcoll', SMBPOGN_COLL_CODE, 30),
       (SELECT sprtele_intl_access
          FROM sprtele
         WHERE     sprtele_pidm = sgbstdn_pidm
               AND sprtele_tele_code = 'MO'
               AND ROWNUM = 1)                           "Mobile NO",
       SMBPOGN_ACT_GPA,
       SMBPOGN_ACT_CREDITS_I_TRAD
  FROM SMBPOGN, sgbstdn, smrprle
 WHERE     SMBPOGN_pidm = sgbstdn_pidm
       AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                      FROM SGBSTDN
                                     WHERE SGBSTDN_PIDM = SMBPOGN_pidm)
       AND SGBSTDN_STST_CODE IN ('AS')
       AND SGBSTDN_DEGC_CODE_1 IN ('»ﬂ', '»ﬂ  ', '000000')
       AND SGBSTDN_STYP_CODE IN ('‰')
       AND SGBSTDN_LEVL_CODE = 'Ã„'
       AND SMBPOGN_REQUEST_NO = (SELECT MAX (SMBPOGN_REQUEST_NO)
                                   FROM SMBPOGN
                                  WHERE SMBPOGN_PIDM = sgbstdn_pidm)
       AND smrprle_program = SMBPOGN_PROGRAM