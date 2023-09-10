DECLARE
   CURSOR std_c
   IS
      SELECT student_pidm "PIDM", mobile "MOBILE"
        FROM stu_main_data_vw vw,
             saradap,
             sarappd d1,
             adm_decision_msg m,
             adm_programs_rules p
       WHERE     sarappd_pidm = student_pidm
             AND d1.sarappd_term_code_entry = admit_term
             AND d1.sarappd_seq_no =
                    (SELECT MAX (d2.sarappd_seq_no)
                       FROM sarappd d2
                      WHERE     d2.sarappd_pidm = d1.sarappd_pidm
                            AND d2.sarappd_term_code_entry =
                                   d1.sarappd_term_code_entry
                            AND d2.sarappd_appl_no = d1.sarappd_appl_no)
             AND m.decision_code = d1.sarappd_apdc_code
             AND SARADAP_PIDM = SARAPPD_PIDM
             AND SARADAP_TERM_CODE_ENTRY = SARAPPD_TERM_CODE_ENTRY
             AND SARADAP_APPL_NO = SARAPPD_APPL_NO
             AND p.TERM_CODE = vw.admit_term
             AND p.WAPP_CODE = vw.admission_type
             AND PROGRAM_CODE = SARADAP_PROGRAM_1
             AND acceptance_ind = 'Y'
             AND sarappd_apdc_code = 'WP'
             AND admit_term = '144510'
             AND admission_type = 'P2'
             AND EXISTS
                    (SELECT 1
                       FROM bnk_invoices py
                      WHERE     py.student_pidm = vw.student_pidm
                            AND py.term_code = vw.admit_term
                            AND py.invoice_code IN ('ADMA', 'ADM')
                            AND invoice_status IN ('NEW', 'PENDING'))
                            and  SARAPPD_DATA_ORIGIN='Dr.Saeed Email to aelkilany'
                           
                             
                           -- AND '1'='2'
      UNION ALL
      SELECT 0 "PIDM", '0568134765' "MOBILE" FROM DUAL;

   v_message         VARCHAR2 (4000)
      := ' Â‰∆ﬂ„ Ã«„⁄… «·»«Õ… »«·ﬁ»Ê· ⁄·Ï «·„ﬁ«⁄œ «·‘«€—… ›Ì »—‰«„Ã «·„«Ã” Ì—° Ì—ÃÏ «·œŒÊ· ·Õ”«»ﬂ„ »»Ê«»… «·ﬁ»Ê· ·≈ „«„ ⁄„·Ì… ”œ«œ «·—”Ê„ «·œ—«”Ì… ﬁ»· «·”«⁄… 2 ŸÂ—« „‰ ÌÊ„ «·≈À‰Ì‰ 1445/02/12 «·„Ê«›ﬁ 2023/08/28 „  Ã‰»« ·≈·€«¡ «·ﬁ»Ê·. https://banner.bu.edu.sa/PROD_ar/xwskcadm.dispAdmissionGate?admissionType=P2
';
   v_reply_code      VARCHAR2 (2);
   v_reply_messege   VARCHAR2 (200);
BEGIN
   FOR r IN std_c
   LOOP
      IF r."MOBILE" IS NOT NULL
      THEN
         bu_apps.p_send_sms (r."MOBILE",
                             v_message,
                             v_reply_code,
                             v_reply_messege);
                             
                      DBMS_OUTPUT.put_line (v_reply_code || '----' || r."MOBILE");          

         INSERT INTO bu_apps.log_sms (student_pidm,
                                      mobile_no,
                                      MESSAGE,
                                      message_justification,
                                      message_status,
                                      activity_date,
                                      user_id)
              VALUES (
                        r."PIDM",
                        r."MOBILE",
                        v_message,
                        '—”«·… ﬁ»Ê· œ—«”«  ⁄·Ì« „‰ ‘Ê«€— 144510 3',
                        v_reply_code,
                        SYSDATE,
                        'SAISUSR');

         COMMIT;
      END IF;
   END LOOP;
END;