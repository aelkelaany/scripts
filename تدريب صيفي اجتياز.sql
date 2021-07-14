 
SELECT F_GET_DESC_FNC ('STVCOLL', SGBSTDN_COLL_CODE_1, 30)
           college,
       F_GET_DESC_FNC ('STVDEPT', SGBSTDN_DEPT_CODE, 30)
           department,
       F_GET_STD_ID (G1.SHRTCKG_PIDM)
           STD_NAME,
       F_GET_STD_NAME (G1.SHRTCKG_PIDM)
           STD_ID,
       F_GET_DESC_FNC ('STVSTYP', SGBSTDN_STYP_CODE, 30)
           STYPE,
       F_GET_DESC_FNC ('STVSTst', SGBSTDN_STst_CODE, 30)
           STst,
       L.SHRTCKN_SUBJ_CODE || L.SHRTCKN_CRSE_NUMB
           SUBJ_CODE1,
       CAPP_MANIPULATION_FUNCTIONAL.F_GET_CRSE_TITLE (L.SHRTCKN_SUBJ_CODE,
                                                      L.SHRTCKN_CRSE_NUMB)
           SUBJ_TITLE_1,
       G1.SHRTCKG_TERM_CODE,
       G1.SHRTCKG_GRDE_CODE_FINAL ,sgbstdn_stst_code ,(select SMBPOGN_ACT_CREDITS_OVERALL from SMBPOGN where 
       SMBPOGN_pidm=sgbstdn_pidm
       and SMBPOGN_REQUEST_NO=(select max(SMBPOGN_REQUEST_NO) from SMBPOGN where  SMBPOGN_pidm=sgbstdn_pidm )
       ) act_hrs
  FROM SHRTCKN  L,
       SHRTCKG  G1,
       SGBSTDN  A,
       spriden
 WHERE     L.SHRTCKN_PIDM = G1.SHRTCKG_PIDM
       AND G1.SHRTCKG_PIDM = a.sgbstdn_pidm
       AND a.sgbstdn_term_code_eff =
           (SELECT MAX (b.sgbstdn_term_code_eff)
              FROM sgbstdn b
             WHERE     b.sgbstdn_pidm = a.sgbstdn_pidm
                   AND b.sgbstdn_term_code_eff <= '144220')
       AND sgbstdn_stst_code NOT IN ('ÎÌ', 'ãÎ', 'ØÓ','ãÓ','ÊÍ')
       and L.SHRTCKN_PIDM=spriden_pidm
       AND SPRIDEN_CHANGE_IND IS NULL
       AND SUBSTR (spriden_id, 1, 3) <= '437'
       AND sgbstdn_coll_code_1 = '32'
       AND  l.SHRTCKN_SUBJ_CODE || l.SHRTCKN_CRSE_NUMB in ( '32000400' ) --first 
       AND L.SHRTCKN_TERM_CODE = G1.SHRTCKG_TERM_CODE
       AND G1.SHRTCKG_TCKN_SEQ_NO = L.SHRTCKN_SEQ_NO
       AND G1.SHRTCKG_SEQ_NO =
           (SELECT MAX (G3.SHRTCKG_SEQ_NO)
              FROM SHRTCKG G3
             WHERE     G3.SHRTCKG_PIDM = G1.SHRTCKG_PIDM
                   AND G3.SHRTCKG_TERM_CODE = G1.SHRTCKG_TERM_CODE
                   AND G3.SHRTCKG_TCKN_SEQ_NO = G1.SHRTCKG_TCKN_SEQ_NO)
       AND G1.SHRTCKG_CREDIT_HOURS > 0
       AND EXISTS
               (SELECT 1
                  FROM SHRGRDE R1
                 WHERE     SHRGRDE_CODE = G1.SHRTCKG_GRDE_CODE_FINAL
                       AND SHRGRDE_LEVL_CODE = SGBSTDN_LEVL_CODE
                       AND SHRGRDE_TERM_CODE_EFFECTIVE =
                           (SELECT MAX (R2.SHRGRDE_TERM_CODE_EFFECTIVE)
                              FROM SHRGRDE R2
                             WHERE     R1.SHRGRDE_CODE = R2.SHRGRDE_CODE
                                   AND R1.SHRGRDE_LEVL_CODE =
                                       R2.SHRGRDE_LEVL_CODE)
                       AND SHRGRDE_PASSED_IND = 'N')
                       
                       union 
                       SELECT F_GET_DESC_FNC ('STVCOLL', SGBSTDN_COLL_CODE_1, 30)
           college,
       F_GET_DESC_FNC ('STVDEPT', SGBSTDN_DEPT_CODE, 30)
           department,
       F_GET_STD_ID (G1.SHRTCKG_PIDM)
           STD_NAME,
       F_GET_STD_NAME (G1.SHRTCKG_PIDM)
           STD_ID,
       F_GET_DESC_FNC ('STVSTYP', SGBSTDN_STYP_CODE, 30)
           STYPE,
       F_GET_DESC_FNC ('STVSTst', SGBSTDN_STst_CODE, 30)
           STst,
       L.SHRTCKN_SUBJ_CODE || L.SHRTCKN_CRSE_NUMB
           SUBJ_CODE1,
       CAPP_MANIPULATION_FUNCTIONAL.F_GET_CRSE_TITLE (L.SHRTCKN_SUBJ_CODE,
                                                      L.SHRTCKN_CRSE_NUMB)
           SUBJ_TITLE_1,
       G1.SHRTCKG_TERM_CODE,
       G1.SHRTCKG_GRDE_CODE_FINAL ,sgbstdn_stst_code,(select SMBPOGN_ACT_CREDITS_OVERALL from SMBPOGN where 
       SMBPOGN_pidm=sgbstdn_pidm
       and SMBPOGN_REQUEST_NO=(select max(SMBPOGN_REQUEST_NO) from SMBPOGN where  SMBPOGN_pidm=sgbstdn_pidm )
       ) act_hrs
  FROM SHRTCKN  L,
       SHRTCKG  G1,
       SGBSTDN  A,
       spriden
 WHERE     L.SHRTCKN_PIDM = G1.SHRTCKG_PIDM
       AND G1.SHRTCKG_PIDM = a.sgbstdn_pidm
       AND a.sgbstdn_term_code_eff =
           (SELECT MAX (b.sgbstdn_term_code_eff)
              FROM sgbstdn b
             WHERE     b.sgbstdn_pidm = a.sgbstdn_pidm
                   AND b.sgbstdn_term_code_eff <= '144220')
       AND sgbstdn_stst_code NOT IN ('ÎÌ', 'ãÎ', 'ØÓ','ãÓ','ÊÍ')
       and L.SHRTCKN_PIDM=spriden_pidm
       AND SPRIDEN_CHANGE_IND IS NULL
       AND SUBSTR (spriden_id, 1, 3) <= '437'
       AND sgbstdn_coll_code_1 = '32'
       AND  l.SHRTCKN_SUBJ_CODE || l.SHRTCKN_CRSE_NUMB in ( '32000500' ) --second
       AND L.SHRTCKN_TERM_CODE = G1.SHRTCKG_TERM_CODE
       AND G1.SHRTCKG_TCKN_SEQ_NO = L.SHRTCKN_SEQ_NO
       AND G1.SHRTCKG_SEQ_NO =
           (SELECT MAX (G3.SHRTCKG_SEQ_NO)
              FROM SHRTCKG G3
             WHERE     G3.SHRTCKG_PIDM = G1.SHRTCKG_PIDM
                   AND G3.SHRTCKG_TERM_CODE = G1.SHRTCKG_TERM_CODE
                   AND G3.SHRTCKG_TCKN_SEQ_NO = G1.SHRTCKG_TCKN_SEQ_NO)
       AND G1.SHRTCKG_CREDIT_HOURS > 0
       AND EXISTS
               (SELECT 1
                  FROM SHRGRDE R1
                 WHERE     SHRGRDE_CODE = G1.SHRTCKG_GRDE_CODE_FINAL
                       AND SHRGRDE_LEVL_CODE = SGBSTDN_LEVL_CODE
                       AND SHRGRDE_TERM_CODE_EFFECTIVE =
                           (SELECT MAX (R2.SHRGRDE_TERM_CODE_EFFECTIVE)
                              FROM SHRGRDE R2
                             WHERE     R1.SHRGRDE_CODE = R2.SHRGRDE_CODE
                                   AND R1.SHRGRDE_LEVL_CODE =
                                       R2.SHRGRDE_LEVL_CODE)
                       AND SHRGRDE_PASSED_IND = 'N')
                       
                       order by 3