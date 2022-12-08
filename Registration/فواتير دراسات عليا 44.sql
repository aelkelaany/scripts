 
--insert into bu_dev.tmp_tbl_kilany1 (COL01, COL02, COL03, 
--   COL04, COL05, COL06, 
--   COL07, COL08, COL09, 
--   COL10, COL11)
  SELECT sfrstcr_pidm,
         f_get_std_id (sfrstcr_pidm)
             std_id,
         f_get_std_name (sfrstcr_pidm)
             std_name,
         SGBSTDN_PROGRAM_1,
         f_get_program_full_desc ('144410', SGBSTDN_PROGRAM_1)
             stprogram,
         SUM (SFRSTCR_BILL_HR)
             bill_hrs,
         COUNT (DISTINCT ssbsect_subj_code || ssbsect_crse_numb)
             crse_cnt,
         (SELECT SUM (AMOUNT)
            FROM BU_APPS.BNK_INVOICES
           WHERE     TERM_CODE = '144410'
                 AND STUDENT_PIDM = sfrstcr_pidm
                 AND INVOICE_STATUS = 'PAID'
                 AND INVOICE_CODE IN ('REGA', 'ADMA'))
             pre_paid_amount,
         (SELECT NVL (SUM (tbraccd_amount - NVL (TBRACCD_EXCHANGE_DIFF /*waived amount*/
                                                                      , 0)), 0)
            FROM sobterm, tbbdetc, tbraccd
           WHERE     tbraccd_pidm = sfrstcr_pidm
                 AND tbraccd_term_code = '144410'
                 AND tbbdetc_detail_code = tbraccd_detail_code
                 AND tbbdetc_detail_code = 'REGF'
                 AND tbbdetc_dcat_code = 'TUI'
                 --AND (TBRACCD_SRCE_CODE = 'R' OR TBRACCD_SRCE_CODE BETWEEN '0' AND '9')
                 AND sobterm_term_code = tbraccd_term_code)
             reg_amount,
         (SELECT col09
            FROM bu_dev.tmp_tbl_kilany 
           WHERE col10 = sfrstcr_pidm)
             wavied_amount,
         (SELECT SPRTELE_INTL_ACCESS
            FROM sprtele
           WHERE     SPRTELE_pidm = sfrstcr_pidm
                 AND SPRTELE_TELE_CODE = 'MO'
                 AND ROWNUM < 2)
             phone
    FROM sfrstcr, ssbsect, sgbstdn
   WHERE     sfrstcr_term_code = '144410'
         AND ssbsect_term_code = sfrstcr_term_code
         AND ssbsect_crn = sfrstcr_crn
         AND ssbsect_ptrm_code = 4
         AND sfrstcr_rsts_code   IN ('RE', 'RW')
         AND SGBSTDN_PIDM = sfrstcr_pidm
         and sgbstdn_stst_code ='AS'
         AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                        FROM SGBSTDN
                                       WHERE SGBSTDN_PIDM = sfrstcr_pidm)
                                       and SGBSTDN_PIDM=f_get_pidm('444000767')
--         AND not EXISTS
--                 (SELECT '1'
--                    FROM spriden
--                   WHERE spriden_PIDM = sfrstcr_pidm AND spriden_id LIKE '444%')
GROUP BY sfrstcr_term_code, sfrstcr_pidm, SGBSTDN_PROGRAM_1
ORDER BY 1