DECLARE
   l_count   NUMBER := 0;
BEGIN
   FOR i
      IN (SELECT student_pidm pidm,
                 SARAPPD_TERM_CODE_ENTRY term,
                 SARAPPD_APPL_NO app_no,
                 SARAPPD_SEQ_NO seq_no
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
                 AND admit_term = '144510'
                 AND admission_type  in ( 'PG','P2')
                 AND NOT EXISTS
                            (SELECT 1
                               FROM bnk_invoices py
                              WHERE     py.student_pidm = vw.student_pidm
                                    AND py.term_code = vw.admit_term
                                    AND py.invoice_code IN ('ADMA', 'ADM')
                                    AND invoice_status IN
                                           ('NEW', 'PENDING', 'PAID')))
   LOOP
      INSERT INTO sarappd (SARAPPD_PIDM,
                           SARAPPD_TERM_CODE_ENTRY,
                           SARAPPD_APPL_NO,
                           SARAPPD_SEQ_NO,
                           SARAPPD_APDC_DATE,
                           SARAPPD_APDC_CODE,
                           SARAPPD_MAINT_IND,
                           SARAPPD_ACTIVITY_DATE,
                           SARAPPD_USER,
                           SARAPPD_DATA_ORIGIN)
           VALUES (i.pidm,
                   i.term,
                   i.app_no,
                   i.seq_no + 1,
                   SYSDATE,
                   'GR',
                   'S',
                   SYSDATE,
                   'SAISUSR',
                   'Banner');

      l_count := l_count + SQL%ROWCOUNT;
   END LOOP;

   DBMS_OUTPUT.put_line ('Cancled ADM Count :' || l_count);
END;



DECLARE
   l_count   NUMBER;
BEGIN
   p_update_saradap_apst ('144510',
                          'WP',
                          'A',
                          l_count);
   DBMS_OUTPUT.put_line (l_count);
END;