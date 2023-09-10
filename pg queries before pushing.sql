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
             AND admission_type = 'P2';
             
             
             
             ----- check completed req 
             
             
             SELECT 
   ROWID, TERM_CODE, ADMISSION_TYPE, COLL_CODE, 
   DEPT_CODE, PROGRAM_CODE, APPLICATIONS_COUNT, 
   ALLOW_IND, WF_REQUEST_NO, ACTIVITY_DATE, 
   USER_ID, ALLOW_APPROVAL_IND
FROM BU_APPS.ADM_PG_DEPT_PROG
WHERE
TERM_CODE = '144510'
AND ALLOW_IND = 'Y'
AND ALLOW_APPROVAL_IND = 'Y'
AND ADMISSION_TYPE = 'P2'
and not exists (select '1' from request_master where request_no=WF_REQUEST_NO and request_status='C') ;