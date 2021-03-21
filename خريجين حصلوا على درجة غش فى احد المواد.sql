/* Formatted on 06/01/2021 10:25:22 (QP5 v5.227.12220.39754) */
SELECT F_GET_STD_ID (SHRTCKN_PIDM) STD_ID,
       F_GET_STD_NAME (SHRTCKN_PIDM) NAME,
       shrtckn_term_code,
       scbcrse_title ,a.sgbstdn_term_code_eff
  FROM shrtckn,
       sgbstdn a,
       shrtckg g1,
       scbcrse c1
 WHERE     a.sgbstdn_pidm = shrtckn_pidm
       AND a.sgbstdn_term_code_eff ='144210' /* (SELECT MAX (b.sgbstdn_term_code_eff)
                                        FROM sgbstdn b
                                       WHERE b.sgbstdn_pidm = a.sgbstdn_pidm) */
       AND shrtckn_pidm = g1.shrtckg_pidm
       AND g1.shrtckg_term_code = shrtckn_term_code
       AND g1.shrtckg_tckn_seq_no = shrtckn_seq_no
       AND g1.shrtckg_seq_no =
              (SELECT MAX (g2.shrtckg_seq_no)
                 FROM shrtckg g2
                WHERE     g2.shrtckg_pidm = shrtckn_pidm
                      AND g2.shrtckg_term_code = shrtckn_term_code
                      AND g2.shrtckg_tckn_seq_no = shrtckn_seq_no)
       AND c1.scbcrse_subj_code = shrtckn_subj_code
       AND c1.scbcrse_crse_numb = shrtckn_crse_numb
       AND c1.scbcrse_eff_term =
              (SELECT MAX (c2.scbcrse_eff_term)
                 FROM scbcrse c2
                WHERE     c2.scbcrse_subj_code = c1.scbcrse_subj_code
                      AND c2.scbcrse_crse_numb = c1.scbcrse_crse_numb
                      AND c2.scbcrse_eff_term <= shrtckn_term_code)
       AND shrtckg_grde_code_final = 'ÛÔ'
       AND sgbstdn_stst_code = 'ÎÌ'
       