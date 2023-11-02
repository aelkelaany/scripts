SELECT   a.*,
                   b.* ,
                     (SELECT NVL (SUM (tbraccd_amount), 0)
                        FROM sobterm, tbbdetc, tbraccd
                       WHERE     tbraccd_pidm = sgbstdn_pidm
                             AND tbraccd_term_code = :p_term
                             AND tbbdetc_detail_code = tbraccd_detail_code
                             AND tbbdetc_detail_code = 'REGF'
                             AND tbbdetc_dcat_code = 'TUI'
                             --AND (TBRACCD_SRCE_CODE = 'R' OR TBRACCD_SRCE_CODE BETWEEN '0' AND '9')
                             AND sobterm_term_code = tbraccd_term_code)
                   - NVL ( 
                         (SELECT WAIVED_AMT
                            FROM PG_invoices_waived_amt
                           WHERE     term_code = :p_term
                                 AND st_pidm = sgbstdn_pidm),
                         0)    total_fees ,
                         
                         (SELECT NVL (SUM (tbraccd_amount), 0)
                        FROM sobterm, tbbdetc, tbraccd
                       WHERE     tbraccd_pidm = sgbstdn_pidm
                             AND tbraccd_term_code = :p_term
                             AND tbbdetc_detail_code = tbraccd_detail_code
                             AND tbbdetc_detail_code = 'REGF'
                             AND tbbdetc_dcat_code = 'TUI'
                             --AND (TBRACCD_SRCE_CODE = 'R' OR TBRACCD_SRCE_CODE BETWEEN '0' AND '9')
                             AND sobterm_term_code = tbraccd_term_code) tution_fees,
                         
                         NVL ( 
                         (SELECT WAIVED_AMT
                            FROM PG_invoices_waived_amt
                           WHERE     term_code = :p_term
                                 AND st_pidm = sgbstdn_pidm),
                         0)    wavied_amount
              FROM sgbstdn a, spriden b
             WHERE     a.sgbstdn_pidm = spriden_pidm
                   AND spriden_change_ind IS NULL
                   AND a.sgbstdn_term_code_eff =
                       (SELECT MAX (b.sgbstdn_term_code_eff)
                          FROM sgbstdn b
                         WHERE     b.sgbstdn_pidm = a.sgbstdn_pidm
                               AND b.sgbstdn_term_code_eff <= :p_term)
                   AND sgbstdn_levl_code IN ('ãÌ', 'MA')
                   AND sgbstdn_stst_code IN ('AS', 'ãÚ', 'ãæ')
                   AND (spriden_id = :p_student_id OR :p_student_id IS NULL)
                 -- AND SPRIDEN_ID LIKE '444%'
                   AND NOT EXISTS
                           (SELECT 1
                              FROM bnk_invoices
                             WHERE     term_code = :p_term
                                   AND student_pidm = sgbstdn_pidm
                                   AND invoice_code IN
                                           (SELECT parameter_value
                                              FROM dev_sys_parameters
                                             WHERE     module =
                                                       'REGISTRATION'
                                                   AND parameter_code =
                                                       'REG_INVOICE_CODE')
                                                       
                                   -- AND invoice_status IN ('NEW', 'PENDING', 'PAID')
                                   ) 
                                           
                                           
                                           