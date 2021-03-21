 select DISTINCT F_GET_STD_ID(SMBPOGN_PIDM) ,F_GET_STD_NAME(SMBPOGN_PIDM) NAME
                 FROM SMBPOGN A , sgbstdn B 
                 WHERE   
                   SMBPOGN_REQUEST_NO =
                      (SELECT MAX (SMBPOGN_REQUEST_NO)
                         FROM SMBPOGN
                        WHERE SMBPOGN_PIDM = A.SMBPOGN_PIDM)
                        AND SMBPOGN_REQ_CREDITS_OVERALL=SMBPOGN_ACT_CREDITS_OVERALL 
                         AND B.sgbstdn_pidm = SMBPOGN_PIDM
                        AND    B.sgbstdn_stst_code='AS'
                          AND SGBSTDN_LEVL_CODE='Ã„'
AND B.sgbstdn_term_code_eff =
                     (SELECT MAX (sgbstdn_term_code_eff)
                        FROM sgbstdn  
                       WHERE  sgbstdn_pidm = B.sgbstdn_pidm)
                       
AND A.SMBPOGN_PIDM NOT IN (SELECT  
                 
                 SHRTCKN_PIDM 
            FROM shrtckn,
                 sgbstdn a,
                 shrtckg g1,
                 scbcrse c1
           WHERE     
                   a.sgbstdn_pidm = shrtckn_pidm
                 AND a.sgbstdn_term_code_eff =
                     (SELECT MAX (b.sgbstdn_term_code_eff)
                        FROM sgbstdn b
                       WHERE b.sgbstdn_pidm = a.sgbstdn_pidm)
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
                 
                  
                   AND shrtckg_grde_code_final='‰œ'
                   AND SGBSTDN_LEVL_CODE='Ã„'
                 and sgbstdn_stst_code='AS'
                 and scbcrse_title like '%Œœ„…%'
               )
              