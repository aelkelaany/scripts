--Create a temp Table and upload the provided data from Dr.Musaad

CREATE TABLE bu_dev.pg_wl_applicants
(
   student_ssn    VARCHAR2 (50) PRIMARY KEY,
   student_pidm   NUMBER
);

--Update PIDM

UPDATE bu_dev.pg_wl_applicants a
   SET a.student_pidm =
          (SELECT vw.student_pidm
             FROM stu_main_data_vw vw
            WHERE     vw.admit_term = '144510'
                  AND vw.admission_type = 'PG'
                  AND vw.student_ssn = a.student_ssn);



--Add the Acceptance Decision [WP] to the Wait List Students [WL]
DECLARE
   l_count   NUMBER := 0;
BEGIN
   FOR i
      IN (SELECT student_pidm pidm,
                 SARAPPD_TERM_CODE_ENTRY term,
                 SARAPPD_APPL_NO app_no,
                 SARAPPD_SEQ_NO seq_no,
                 sarappd_apdc_code apdc
            FROM stu_main_data_vw vw,
                 saradap,
                 sarappd d1,
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
                 AND SARADAP_PIDM = SARAPPD_PIDM
                 AND SARADAP_TERM_CODE_ENTRY = SARAPPD_TERM_CODE_ENTRY
                 AND SARADAP_APPL_NO = SARAPPD_APPL_NO
                 AND p.TERM_CODE = vw.admit_term
                 AND p.WAPP_CODE = vw.admission_type
                 AND PROGRAM_CODE = SARADAP_PROGRAM_1
                 AND admit_term = '144510'
                 AND admission_type = 'PG'
                 AND EXISTS
                        (SELECT 1
                           FROM bu_dev.pg_wl_applicants t
                          WHERE t.student_pidm = vw.student_pidm))
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
                   'WP',
                   'S',
                   SYSDATE,
                   'SAISUSR',
                   'Dr.Musaad Email to aelhamrawy');

      l_count := l_count + SQL%ROWCOUNT;
   END LOOP;

   DBMS_OUTPUT.put_line ('Accepted ADM Count :' || l_count);
END;