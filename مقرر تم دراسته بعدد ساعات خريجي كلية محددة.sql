SELECT   distinct
           SHRTCKN_TERM_CODE TermCode , SHRTCKN_CRN  crn ,(select ssbsect_credit_hrs from ssbsect where ssbsect_term_code= SHRTCKN_TERM_CODE and ssbsect_crn=SHRTCKN_CRN) credit_hrs
            FROM shrtckn,
                 sgbstdn a,
                 shrtckg g1 
                 
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
                  
                 and sgbstdn_coll_code_1='32'
                 and exists  (SELECT '1' FROM SHRDGMR
     WHERE SHRDGMR_PIDM=shrtckn_PIDM
     AND  SHRDGMR_DEGS_CODE ='ÎÌ'
     and SHRDGMR_TERM_CODE_GRAD='144020')  
                                 and sgbstdn_stst_code='ÎÌ'
                 
                 
                 and SHRTCKG_CREDIT_HOURS=2
      and shrtckn_subj_code || shrtckn_crse_numb   in ('11020103') 
      
      order by 1