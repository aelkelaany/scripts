
/* Formatted on 8/22/2019 3:49:03 PM (QP5 v5.227.12220.39754) */
SELECT STUDENT_SSN,
       STUDENT_PIDM,
       ADMISSION_TYPE,
       APPLICATION_COMPLETE_IND,
       APPLICATION_PUSH_IND,
       FIRST_NAME_AR,
       MIDDLE_NAME_AR,
       LAST_NAME_AR,
       FIRST_NAME_EN,
       MIDDLE_NAME_EN,
       LAST_NAME_EN,
       GENDER
  FROM BU_APPS.STU_MAIN_DATA_VW
 WHERE STUDENT_SSN = '1120971880';
DECLARE
   l_pidm           NUMBER := :l_pidm;
   l_old            NUMBER := :l_old;
   l_new            NUMBER := :l_new;
   L_CU             NUMBER := :l_new;
   L_NEW_ENTRY      CHAR := :L_NEW_ENTRY;
   L_REJECT_CHECK   CHAR := 'N';
   L_PROGRAM        VARCHAR2 (50) := :L_PROGRAM;
   l_min_score      NUMBER ;
   l_choice         VARCHAR2 (50);
   l_APPLICANT_RATE number ; 
BEGIN
BEGIN
  IF L_NEW_ENTRY != 'Y' then 
   SELECT APPLICANT_CHOICE ,APPLICANT_RATE
     INTO l_choice ,l_APPLICANT_RATE
     FROM VW_APPLICANT_CHOICES
    WHERE APPLICANT_PIDM = l_pidm AND APPLICANT_CHOICE_NO = l_new;
end if;
EXCEPTION 
WHEN NO_DATA_FOUND THEN 
DBMS_OUTPUT.put_line ('11');
DBMS_OUTPUT.put_line ('NEW ENTRY');
END ; 
   IF L_NEW_ENTRY = 'Y'
   THEN
      l_choice := L_PROGRAM;
      l_APPLICANT_RATE:=:l_APPLICANT_RATE;
   END IF;
BEGIN
     SELECT  MIN (t.applicant_rate) 
       INTO l_min_score
       FROM bu_apps.adm_applicant_choices_seq t
      WHERE     quota_term = '144310'
            AND quota_run_sequence = 15
            AND applicant_choice = l_choice
            AND applicant_decision = 'QA'
            AND EXISTS
                   (SELECT 'X'
                      FROM bu_apps.adm_applicant_quota_batch_seq d
                     WHERE     d.applicant_pidm = t.applicant_pidm
                           AND d.applicant_program = t.applicant_choice
                           AND d.quota_run_sequence = 15
                           AND d.quota_batch_no = 1)
            AND EXISTS
                   (SELECT 'X'
                      FROM adm_student_confirmation d
                     WHERE d.applicant_pidm = t.applicant_pidm)
            AND NOT EXISTS
                       (SELECT 'X'
                          FROM vw_applicant_choices
                         WHERE     applicant_pidm = t.applicant_pidm
                               AND applicant_decision IN ('WA', 'RA'))
   GROUP BY t.applicant_choice;
EXCEPTION
WHEN NO_DATA_FOUND THEN 
l_min_score:=0;
END;
   IF l_APPLICANT_RATE >= l_min_score OR :L_PASS='Y'
   THEN
      IF L_NEW_ENTRY = 'Y'
      THEN
         BEGIN
            INSERT INTO SARADAP
               SELECT L_PIDM,
                      SARADAP_TERM_CODE_ENTRY,
                      l_new,
                      SARADAP_LEVL_CODE,
                      SYSDATE,
                      SARADAP_APST_CODE,
                      SYSDATE,
                      SARADAP_MAINT_IND,
                      SARADAP_ADMT_CODE,
                      SARADAP_STYP_CODE,
                      SARADAP_CAMP_CODE,
                      SARADAP_SITE_CODE,
                      SARADAP_COLL_CODE_1,
                      SARADAP_DEGC_CODE_1,
                      SARADAP_MAJR_CODE_1,
                      SARADAP_COLL_CODE_2,
                      SARADAP_DEGC_CODE_2,
                      SARADAP_MAJR_CODE_2,
                      SARADAP_RESD_CODE,
                      SARADAP_FULL_PART_IND,
                      SARADAP_SESS_CODE,
                      SARADAP_WRSN_CODE,
                      SARADAP_INTV_CODE,
                      SARADAP_FEE_IND,
                      SYSDATE,
                      SYSDATE,
                      SARADAP_RATE_CODE,
                      SARADAP_EGOL_CODE,
                      SARADAP_EDLV_CODE,
                      SARADAP_MAJR_CODE_CONC_1,
                      SARADAP_DEPT_CODE,
                      SARADAP_SBGI_CODE,
                      SARADAP_RECR_CODE,
                      SARADAP_RTYP_CODE,
                      SARADAP_DEPT_CODE_2,
                      SARADAP_MAJR_CODE_CONC_2,
                      SARADAP_PROGRAM_1,
                      SARADAP_TERM_CODE_CTLG_1,
                      SARADAP_MAJR_CODE_1_2,
                      SARADAP_DEPT_CODE_1_2,
                      SARADAP_MAJR_CODE_CONC_1_2,
                      SARADAP_MAJR_CODE_CONC_1_3,
                      SARADAP_MAJR_CODE_CONC_121,
                      SARADAP_MAJR_CODE_CONC_122,
                      SARADAP_MAJR_CODE_CONC_123,
                      SARADAP_MAJR_CODE_MINR_1_1,
                      SARADAP_MAJR_CODE_MINR_1_2,
                      SARADAP_PROGRAM_2,
                      SARADAP_TERM_CODE_CTLG_2,
                      SARADAP_LEVL_CODE_2,
                      SARADAP_CAMP_CODE_2,
                      SARADAP_MAJR_CODE_2_2,
                      SARADAP_DEPT_CODE_2_2,
                      SARADAP_MAJR_CODE_CONC_211,
                      SARADAP_MAJR_CODE_CONC_212,
                      SARADAP_MAJR_CODE_CONC_213,
                      SARADAP_MAJR_CODE_CONC_221,
                      SARADAP_MAJR_CODE_CONC_222,
                      SARADAP_MAJR_CODE_CONC_223,
                      SARADAP_MAJR_CODE_MINR_2_1,
                      SARADAP_MAJR_CODE_MINR_2_2,
                      SARADAP_CURR_RULE_1,
                      SARADAP_CMJR_RULE_1_1,
                      SARADAP_CCON_RULE_11_1,
                      SARADAP_CCON_RULE_11_2,
                      SARADAP_CCON_RULE_11_3,
                      SARADAP_CMJR_RULE_1_2,
                      SARADAP_CCON_RULE_12_1,
                      SARADAP_CCON_RULE_12_2,
                      SARADAP_CCON_RULE_12_3,
                      SARADAP_CMNR_RULE_1_1,
                      SARADAP_CMNR_RULE_1_2,
                      SARADAP_CURR_RULE_2,
                      SARADAP_CMJR_RULE_2_1,
                      SARADAP_CCON_RULE_21_1,
                      SARADAP_CCON_RULE_21_2,
                      SARADAP_CCON_RULE_21_3,
                      SARADAP_CMJR_RULE_2_2,
                      SARADAP_CCON_RULE_22_1,
                      SARADAP_CCON_RULE_22_2,
                      SARADAP_CCON_RULE_22_3,
                      SARADAP_CMNR_RULE_2_1,
                      SARADAP_CMNR_RULE_2_2,
                      SARADAP_WEB_ACCT_MISC_IND,
                      SARADAP_WEB_CASHIER_USER,
                      SARADAP_WEB_TRANS_NO,
                      SARADAP_WEB_AMOUNT,
                      SARADAP_WEB_RECEIPT_NUMBER,
                      SARADAP_WAIV_CODE,
                      'BannerIT',
                      USER,
                      SARADAP_APPL_PREFERENCE
                 FROM SATURN.SARADAP
                WHERE     SARADAP_PROGRAM_1 = L_PROGRAM
                      AND SARADAP_TERM_CODE_ENTRY = '144310'
                      AND ROWNUM < 2;

            INSERT INTO SARAPPD (SARAPPD_PIDM,
                                 SARAPPD_TERM_CODE_ENTRY,
                                 SARAPPD_APPL_NO,
                                 SARAPPD_SEQ_NO,
                                 SARAPPD_APDC_DATE,
                                 SARAPPD_APDC_CODE,
                                 SARAPPD_MAINT_IND,
                                 SARAPPD_ACTIVITY_DATE,
                                 SARAPPD_USER,
                                 SARAPPD_DATA_ORIGIN)
                 VALUES (L_PIDM,
                         '144310',
                         l_new,
                         1,
                         SYSDATE,
                         'I',
                         'S',
                         SYSDATE,
                         USER,
                         'BannerIT');
         EXCEPTION
            WHEN DUP_VAL_ON_INDEX
            THEN
               NULL;
         END;
      END IF;


      BEGIN
         SELECT 'Y'
           INTO L_REJECT_CHECK
           FROM VW_APPLICANT_CHOICES
          WHERE     APPLICANT_PIDM = l_pidm
                AND APPLICANT_DECISION = 'QA'
                AND ROWNUM < 2;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            L_REJECT_CHECK := 'N';
      END;

      DELETE  FROM  SARAPPD WHERE sarappd_pidm= l_pidm AND SARAPPD_APDC_CODE in ( 'CM' ,'CA' ,'WM' ,'WA' ,'CU') ;
      IF L_REJECT_CHECK = 'Y'
      THEN
         INSERT INTO SARAPPD
            SELECT SARAPPD_PIDM,
                   SARAPPD_TERM_CODE_ENTRY,
                   SARAPPD_APPL_NO,
                   SARAPPD_SEQ_NO + 1,
                   SYSDATE,
                   'R',
                   SARAPPD_MAINT_IND,
                   SYSDATE,
                   SARAPPD_USER,
                   SARAPPD_DATA_ORIGIN
              FROM sarappd o
             WHERE     sarappd_pidm = l_pidm
                   AND SARAPPD_APPL_NO BETWEEN l_old AND l_new - 1
                   AND sarappd_seq_no =
                          (SELECT MAX (sarappd_seq_no)
                             FROM sarappd i
                            WHERE     i.sarappd_pidm = o.sarappd_pidm
                                  AND i.sarappd_term_code_entry =
                                         o.sarappd_term_code_entry
                                  AND i.sarappd_appl_no = o.sarappd_appl_no);

         INSERT INTO SARAPPD
            SELECT SARAPPD_PIDM,
                   SARAPPD_TERM_CODE_ENTRY,
                   SARAPPD_APPL_NO,
                   SARAPPD_SEQ_NO + 1,
                   SYSDATE,
                   'QN',
                   SARAPPD_MAINT_IND,
                   SYSDATE,
                   SARAPPD_USER,
                   SARAPPD_DATA_ORIGIN
              FROM sarappd o
             WHERE     sarappd_pidm = l_pidm
                   AND SARAPPD_APPL_NO BETWEEN l_new + 1 AND l_old
                   AND sarappd_seq_no =
                          (SELECT MAX (sarappd_seq_no)
                             FROM sarappd i
                            WHERE     i.sarappd_pidm = o.sarappd_pidm
                                  AND i.sarappd_term_code_entry =
                                         o.sarappd_term_code_entry
                                  AND i.sarappd_appl_no = o.sarappd_appl_no);
      ELSE
         INSERT INTO SARAPPD
            SELECT SARAPPD_PIDM,
                   SARAPPD_TERM_CODE_ENTRY,
                   SARAPPD_APPL_NO,
                   SARAPPD_SEQ_NO + 1,
                   SYSDATE,
                   'QN',
                   SARAPPD_MAINT_IND,
                   SYSDATE,
                   SARAPPD_USER,
                   SARAPPD_DATA_ORIGIN
              FROM sarappd o
             WHERE     sarappd_pidm = l_pidm
                   AND SARAPPD_APPL_NO > l_new
                   AND sarappd_seq_no =
                          (SELECT MAX (sarappd_seq_no)
                             FROM sarappd i
                            WHERE     i.sarappd_pidm = o.sarappd_pidm
                                  AND i.sarappd_term_code_entry =
                                         o.sarappd_term_code_entry
                                  AND i.sarappd_appl_no = o.sarappd_appl_no);
      END IF;

      INSERT INTO SARAPPD
         SELECT SARAPPD_PIDM,
                SARAPPD_TERM_CODE_ENTRY,
                SARAPPD_APPL_NO,
                SARAPPD_SEQ_NO + 1,
                SYSDATE,
                'QA',
                SARAPPD_MAINT_IND,
                SYSDATE,
                SARAPPD_USER,
                SARAPPD_DATA_ORIGIN
           FROM sarappd o
          WHERE     sarappd_pidm = l_pidm
                AND SARAPPD_APPL_NO = l_new
                AND sarappd_seq_no =
                       (SELECT MAX (sarappd_seq_no)
                          FROM sarappd i
                         WHERE     i.sarappd_pidm = o.sarappd_pidm
                               AND i.sarappd_term_code_entry =
                                      o.sarappd_term_code_entry
                               AND i.sarappd_appl_no = o.sarappd_appl_no);



      -- cancel upgrade
      DECLARE
         l_reply_code      VARCHAR (100);
         l_reply_message   VARCHAR (100);
      BEGIN
         DELETE FROM adm_student_confirmation
               WHERE ADMIT_TERM = '144310' AND APPLICANT_PIDM = l_pidm;

         pg_quota.p_add_decision ('144310',
                                  l_pidm,
                                  L_CU,
                                  'CU',
                                  l_reply_code,
                                  l_reply_message);
         DBMS_OUTPUT.put_line (l_reply_code);
         DBMS_OUTPUT.put_line (l_reply_message);
      END;
   ELSE
      DBMS_OUTPUT.put_line ('99');
      DBMS_OUTPUT.put_line ('less than ratio'||' '||l_min_score);
   END IF; 
   
END;