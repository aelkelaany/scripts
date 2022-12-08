/* Formatted on 11/16/2022 9:15:07 AM (QP5 v5.371) */
  SELECT sfrstcr_pidm,
         f_get_std_id (sfrstcr_pidm)
             std_id,
         f_get_std_name (sfrstcr_pidm)
             std_name,SGBSTDN_PROGRAM_1 ,
         f_get_program_full_desc ('144410', SGBSTDN_PROGRAM_1)
             stprogram,
         SUM (SFRSTCR_BILL_HR)
             bill_hrs,
         COUNT (DISTINCT ssbsect_subj_code || ssbsect_crse_numb)
             crse_cnt,
         (SELECT SUM (AMOUNT)
            FROM BU_APPS.BNK_INVOICES
           WHERE     TERM_CODE = sfrstcr_term_code
                 AND STUDENT_PIDM = sfrstcr_pidm
                 AND INVOICE_STATUS = 'PAID'
                 AND INVOICE_CODE IN ('REGA', 'ADMA'))
             paid_amount,
         (SELECT SPRTELE_INTL_ACCESS
            FROM sprtele
           WHERE     SPRTELE_pidm = sfrstcr_pidm
                 AND SPRTELE_TELE_CODE = 'MO'
                 AND ROWNUM < 2)
             phone
    FROM sfrstcr, ssbsect, sgbstdn
   WHERE     sfrstcr_term_code = '144420'
         AND ssbsect_term_code = sfrstcr_term_code
         AND ssbsect_crn = sfrstcr_crn
         AND ssbsect_ptrm_code = 4
         AND sfrstcr_rsts_code IN ('RE', 'RW')
         AND SGBSTDN_PIDM = sfrstcr_pidm
         AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                        FROM SGBSTDN
                                       WHERE SGBSTDN_PIDM = sfrstcr_pidm)
--         AND EXISTS
--                 (SELECT '1'
--                    FROM spriden
--                   WHERE spriden_PIDM = sfrstcr_pidm AND spriden_id LIKE '444%')
GROUP BY sfrstcr_term_code, sfrstcr_pidm ,SGBSTDN_PROGRAM_1
ORDER BY 1