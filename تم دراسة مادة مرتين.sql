/* Formatted on 25/03/2021 11:56:41 (QP5 v5.227.12220.39754) */
SELECT F_GET_DESC_FNC ('STVCOLL', SGBSTDN_COLL_CODE_1, 30) college,
       F_GET_DESC_FNC ('STVDEPT', SGBSTDN_DEPT_CODE, 30) department,
       F_GET_STD_ID (G1.SHRTCKG_PIDM) STD_NAME,
       F_GET_STD_NAME (G1.SHRTCKG_PIDM) STD_ID,
       F_GET_DESC_FNC ('STVSTYP', SGBSTDN_STYP_CODE, 30) STYPE,
       F_GET_DESC_FNC ('STVSTst', SGBSTDN_STst_CODE, 30) STst,
       L.SHRTCKN_SUBJ_CODE || L.SHRTCKN_CRSE_NUMB SUBJ_CODE1,
       CAPP_MANIPULATION_FUNCTIONAL.F_GET_CRSE_TITLE (L.SHRTCKN_SUBJ_CODE,
                                                      L.SHRTCKN_CRSE_NUMB)
          SUBJ_TITLE_1,
       G1.SHRTCKG_TERM_CODE,
       G1.SHRTCKG_GRDE_CODE_FINAL,
       NULL,
       G2.SHRTCKG_TERM_CODE,
       G2.SHRTCKG_GRDE_CODE_FINAL
  FROM SHRTCKN L,
       SHRTCKG G1,
       SGBSTDN A,
       SHRTCKN L2,
       SHRTCKG G2
 WHERE     L.SHRTCKN_PIDM = G1.SHRTCKG_PIDM
       AND G1.SHRTCKG_PIDM = a.sgbstdn_pidm
       AND a.sgbstdn_term_code_eff =
              (SELECT MAX (b.sgbstdn_term_code_eff)
                 FROM sgbstdn b
                WHERE     b.sgbstdn_pidm = a.sgbstdn_pidm
                      AND b.sgbstdn_term_code_eff <= '144220')
       AND L2.SHRTCKN_TERM_CODE = G2.SHRTCKG_TERM_CODE
       AND G2.SHRTCKG_TCKN_SEQ_NO = L2.SHRTCKN_SEQ_NO
       AND sgbstdn_stst_code NOT IN ('ŒÃ', '„Œ', 'ÿ”')
       -- AND SGBSTDN_DEPT_CODE = '1502'
       AND G2.SHRTCKG_PIDM = G1.SHRTCKG_PIDM
       AND L2.SHRTCKN_PIDM = G2.SHRTCKG_PIDM
       AND L.SHRTCKN_TERM_CODE < L2.SHRTCKN_TERM_CODE
       AND L.SHRTCKN_SUBJ_CODE || L.SHRTCKN_CRSE_NUMB =
              L2.SHRTCKN_SUBJ_CODE || L2.SHRTCKN_CRSE_NUMB
       AND L.SHRTCKN_TERM_CODE = G1.SHRTCKG_TERM_CODE
       AND G1.SHRTCKG_TCKN_SEQ_NO = L.SHRTCKN_SEQ_NO
       AND G1.SHRTCKG_SEQ_NO =
              (SELECT MAX (G3.SHRTCKG_SEQ_NO)
                 FROM SHRTCKG G3
                WHERE     G3.SHRTCKG_PIDM = G1.SHRTCKG_PIDM
                      AND G3.SHRTCKG_TERM_CODE = G1.SHRTCKG_TERM_CODE
                      AND G3.SHRTCKG_TCKN_SEQ_NO = G1.SHRTCKG_TCKN_SEQ_NO)
       AND G2.SHRTCKG_SEQ_NO =
              (SELECT MAX (G4.SHRTCKG_SEQ_NO)
                 FROM SHRTCKG G4
                WHERE     G4.SHRTCKG_PIDM = G2.SHRTCKG_PIDM
                      AND G4.SHRTCKG_TERM_CODE = G2.SHRTCKG_TERM_CODE
                      AND G4.SHRTCKG_TCKN_SEQ_NO = G2.SHRTCKG_TCKN_SEQ_NO)
       AND G1.SHRTCKG_CREDIT_HOURS > 0
       AND G2.SHRTCKG_CREDIT_HOURS > 0
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
                      AND SHRGRDE_PASSED_IND = 'Y')
       --«÷«›… «·Œ›ﬁ«‰ ›Ï «·„—… «·À«‰Ì…
       AND EXISTS
              (SELECT 1
                 FROM SHRGRDE R1
                WHERE     SHRGRDE_CODE = G2.SHRTCKG_GRDE_CODE_FINAL
                      AND SHRGRDE_LEVL_CODE = SGBSTDN_LEVL_CODE
                      AND SHRGRDE_TERM_CODE_EFFECTIVE =
                             (SELECT MAX (R2.SHRGRDE_TERM_CODE_EFFECTIVE)
                                FROM SHRGRDE R2
                               WHERE     R1.SHRGRDE_CODE = R2.SHRGRDE_CODE
                                     AND R1.SHRGRDE_LEVL_CODE =
                                            R2.SHRGRDE_LEVL_CODE)
                      AND SHRGRDE_PASSED_IND != 'Y');
                      --------------------------------------------
                      /* Formatted on 25/03/2021 12:06:01 (QP5 v5.227.12220.39754) */
SELECT F_GET_DESC_FNC ('STVCOLL', SGBSTDN_COLL_CODE_1, 30) college,
       F_GET_DESC_FNC ('STVDEPT', SGBSTDN_DEPT_CODE, 30) department,
       F_GET_STD_ID (G1.SHRTCKG_PIDM) STD_NAME,
       F_GET_STD_NAME (G1.SHRTCKG_PIDM) STD_ID,
       F_GET_DESC_FNC ('STVSTYP', SGBSTDN_STYP_CODE, 30) STYPE,
       F_GET_DESC_FNC ('STVSTst', SGBSTDN_STst_CODE, 30) STst,
       L.SHRTCKN_SUBJ_CODE || L.SHRTCKN_CRSE_NUMB SUBJ_CODE1,
       CAPP_MANIPULATION_FUNCTIONAL.F_GET_CRSE_TITLE (L.SHRTCKN_SUBJ_CODE,
                                                      L.SHRTCKN_CRSE_NUMB)
          SUBJ_TITLE_1,
       G1.SHRTCKG_TERM_CODE,
       G1.SHRTCKG_GRDE_CODE_FINAL,
       NULL,
       G2.SHRTCKG_TERM_CODE,
       G2.SHRTCKG_GRDE_CODE_FINAL
  FROM SHRTCKN L,
       SHRTCKG G1,
       SGBSTDN A,
       SHRTCKN L2,
       SHRTCKG G2
 WHERE     L.SHRTCKN_PIDM = G1.SHRTCKG_PIDM
       AND G1.SHRTCKG_PIDM = a.sgbstdn_pidm
       AND a.sgbstdn_term_code_eff =
              (SELECT MAX (b.sgbstdn_term_code_eff)
                 FROM sgbstdn b
                WHERE     b.sgbstdn_pidm = a.sgbstdn_pidm
                      AND b.sgbstdn_term_code_eff <= '144220')
       AND L2.SHRTCKN_TERM_CODE = G2.SHRTCKG_TERM_CODE
       AND G2.SHRTCKG_TCKN_SEQ_NO = L2.SHRTCKN_SEQ_NO
       AND sgbstdn_stst_code NOT IN ('ŒÃ', '„Œ', 'ÿ”')
       -- AND SGBSTDN_DEPT_CODE = '1502'
       AND G2.SHRTCKG_PIDM = G1.SHRTCKG_PIDM
       AND L2.SHRTCKN_PIDM = G2.SHRTCKG_PIDM
       AND L.SHRTCKN_TERM_CODE < L2.SHRTCKN_TERM_CODE
       AND L.SHRTCKN_SUBJ_CODE || L.SHRTCKN_CRSE_NUMB =
              L2.SHRTCKN_SUBJ_CODE || L2.SHRTCKN_CRSE_NUMB
       AND L.SHRTCKN_TERM_CODE = G1.SHRTCKG_TERM_CODE
       AND G1.SHRTCKG_TCKN_SEQ_NO = L.SHRTCKN_SEQ_NO
       AND G1.SHRTCKG_SEQ_NO =
              (SELECT MAX (G3.SHRTCKG_SEQ_NO)
                 FROM SHRTCKG G3
                WHERE     G3.SHRTCKG_PIDM = G1.SHRTCKG_PIDM
                      AND G3.SHRTCKG_TERM_CODE = G1.SHRTCKG_TERM_CODE
                      AND G3.SHRTCKG_TCKN_SEQ_NO = G1.SHRTCKG_TCKN_SEQ_NO)
       AND G2.SHRTCKG_SEQ_NO =
              (SELECT MAX (G4.SHRTCKG_SEQ_NO)
                 FROM SHRTCKG G4
                WHERE     G4.SHRTCKG_PIDM = G2.SHRTCKG_PIDM
                      AND G4.SHRTCKG_TERM_CODE = G2.SHRTCKG_TERM_CODE
                      AND G4.SHRTCKG_TCKN_SEQ_NO = G2.SHRTCKG_TCKN_SEQ_NO)
       AND G1.SHRTCKG_CREDIT_HOURS > 0
       AND G2.SHRTCKG_CREDIT_HOURS > 0
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
                      AND SHRGRDE_PASSED_IND = 'Y')
       --«÷«›… «·Œ›ﬁ«‰ ›Ï «·„—… «·À«‰Ì…
       AND EXISTS
              (SELECT 1
                 FROM SHRGRDE R1
                WHERE     SHRGRDE_CODE = G2.SHRTCKG_GRDE_CODE_FINAL
                      AND SHRGRDE_LEVL_CODE = SGBSTDN_LEVL_CODE
                      AND SHRGRDE_TERM_CODE_EFFECTIVE =
                             (SELECT MAX (R2.SHRGRDE_TERM_CODE_EFFECTIVE)
                                FROM SHRGRDE R2
                               WHERE     R1.SHRGRDE_CODE = R2.SHRGRDE_CODE
                                     AND R1.SHRGRDE_LEVL_CODE =
                                            R2.SHRGRDE_LEVL_CODE)
                      AND SHRGRDE_PASSED_IND = 'Y')
       AND (SELECT SHRGRDE_NUMERIC_VALUE
              FROM SHRGRDE R1
             WHERE     SHRGRDE_CODE = G2.SHRTCKG_GRDE_CODE_FINAL
                   AND SHRGRDE_LEVL_CODE = SGBSTDN_LEVL_CODE
                   AND SHRGRDE_TERM_CODE_EFFECTIVE =
                          (SELECT MAX (R2.SHRGRDE_TERM_CODE_EFFECTIVE)
                             FROM SHRGRDE R2
                            WHERE     R1.SHRGRDE_CODE = R2.SHRGRDE_CODE
                                  AND R1.SHRGRDE_LEVL_CODE =
                                         R2.SHRGRDE_LEVL_CODE)) <
              (SELECT SHRGRDE_NUMERIC_VALUE
                 FROM SHRGRDE R1
                WHERE     SHRGRDE_CODE = G1.SHRTCKG_GRDE_CODE_FINAL
                      AND SHRGRDE_LEVL_CODE = SGBSTDN_LEVL_CODE
                      AND SHRGRDE_TERM_CODE_EFFECTIVE =
                             (SELECT MAX (R2.SHRGRDE_TERM_CODE_EFFECTIVE)
                                FROM SHRGRDE R2
                               WHERE     R1.SHRGRDE_CODE = R2.SHRGRDE_CODE
                                     AND R1.SHRGRDE_LEVL_CODE =
                                            R2.SHRGRDE_LEVL_CODE));