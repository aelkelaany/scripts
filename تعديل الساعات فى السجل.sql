declare 
cursor get_data is 
SELECT   distinct
           SHRTCKN_TERM_CODE TermCode , SHRTCKN_CRN  crn
            FROM shrtckn,
                 sgbstdn a,
                 shrtckg g1,
                 scbcrse c1,spriden
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
                 AND EXISTS    ( select '1'
                 FROM SMBPOGN
                 WHERE SMBPOGN_PIDM=shrtckn_pidm 
                 AND SMBPOGN_REQUEST_NO =
                      (SELECT MAX (SMBPOGN_REQUEST_NO)
                         FROM SMBPOGN
                        WHERE SMBPOGN_PIDM = shrtckn_pidm)
                        AND SMBPOGN_REQ_courses_OVERALL=SMBPOGN_ACT_courses_OVERALL)
                 AND NOT EXISTS (SELECT '2' FROM SFRSTCR
                 WHERE SFRSTCR_PIDM=SHRTCKN_PIDM
                 AND SFRSTCR_TERM_CODE='144030')
                  
                                 and sgbstdn_stst_code='AS'
                 
                 and spriden_pidm=SHRTCKN_PIDM
                 and SPRIDEN_CHANGE_IND is null 
                 and substr(spriden_id,1,3)<'438'
                 and SHRTCKG_CREDIT_HOURS=2
      and shrtckn_subj_code || shrtckn_crse_numb   in ('11020103')  ;
begin
for rec in get_data
loop 

P_UPDATE_CRN_CRHRS (rec.TermCode ,rec.CRN ,3,'') ;
end loop ;

end ; 