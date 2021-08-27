UPDATE bu_dev.tmp_tbl04
   SET (col02, col03, col06) =
           (SELECT f_get_std_id (STUDENT_PIDM)       stid,
                   STUDENT_PIDM,
                   f_get_std_name (STUDENT_PIDM)     std_name
              FROM STU_MAIN_DATA_VW
             WHERE  STUDENT_SSN = trim(col01)
               and    ADMIT_TERM='144210'
             and ADMISSION_TYPE='DP');
             --------------------
DECLARE
    CURSOR get_applicants IS
        SELECT DISTINCT
               col03 pidm, col04 new_program 
          FROM BU_DEV.TMP_TBL04  
         WHERE      
              
                 NVL (COL07, 'PENDING') <> 'DONE'
               and col09 is null
               and col03 is not null 
           -- AND col01 = '1119255329'
               /*AND col01 = '1119255329'*/;

    l_pidm             NUMBER;
    l_old              NUMBER;
    l_new              NUMBER;
    L_CU               NUMBER;
    L_NEW_ENTRY        CHAR;
    L_REJECT_CHECK     CHAR := 'N';
    L_PROGRAM          VARCHAR2 (50);
    l_min_score        NUMBER;
    l_choice           VARCHAR2 (50);
    l_APPLICANT_RATE   NUMBER;
    err_code           VARCHAR2 (10);
    err_msg            VARCHAR2 (200);
BEGIN
    FOR rec IN get_applicants
    LOOP
        --initialization **
        l_pidm := rec.pidm;
        l_old := 0;
        l_new := 0;
        L_PROGRAM := '';
        L_NEW_ENTRY := '';

        DECLARE
        BEGIN                                  --check and get rank of choices
            SELECT APPLICANT_CHOICE_NO
              INTO l_new
              FROM VW_APPLICANT_CHOICES
             WHERE     ADMIT_TERM = '144210'
                   AND APPLICANT_PIDM = l_pidm
                   AND APPLICANT_CHOICE = rec.new_program;

            L_CU := l_new;
            L_NEW_ENTRY := 'N';
            DBMS_OUTPUT.put_line (
                   'NEW exist choice'
                || l_new
                || 'for student'
                || f_get_std_id (rec.pidm));
        EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
                SELECT MAX (APPLICANT_CHOICE_NO) + 1
                  INTO l_new
                  FROM VW_APPLICANT_CHOICES
                 WHERE ADMIT_TERM = '144210' AND APPLICANT_PIDM = l_pidm;

                L_PROGRAM := rec.new_program;
                L_NEW_ENTRY := 'Y';
                L_CU := l_new;
                DBMS_OUTPUT.put_line (
                       'NEW entry choice'
                    || l_new
                    || 'for student'
                    || f_get_std_id (rec.pidm));
            WHEN OTHERS
            THEN
                err_code := SQLCODE;
                err_msg := SUBSTR (SQLERRM, 1, 200);

                UPDATE BU_DEV.TMP_TBL04 
                   SET col07 = err_code || err_msg
                 WHERE col02 = l_pidm;
        END;

        BEGIN
            --double check ...
            IF L_NEW_ENTRY != 'Y'
            THEN
                SELECT APPLICANT_CHOICE, APPLICANT_RATE
                  INTO l_choice, l_APPLICANT_RATE
                  FROM VW_APPLICANT_CHOICES
                 WHERE     APPLICANT_PIDM = l_pidm
                       AND APPLICANT_CHOICE_NO = l_new;
            END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
                DBMS_OUTPUT.put_line ('11');
                DBMS_OUTPUT.put_line ('NEW ENTRY' || f_get_std_id (rec.pidm));
            WHEN OTHERS
            THEN
                err_code := SQLCODE;
                err_msg := SUBSTR (SQLERRM, 1, 200);

                UPDATE BU_DEV.TMP_TBL04 
                   SET col07 = err_code || err_msg
                 WHERE col02 = l_pidm;
        END;

        IF L_NEW_ENTRY = 'Y'
        THEN
            l_choice := L_PROGRAM;
            l_APPLICANT_RATE := :l_APPLICANT_RATE;
        END IF;

        BEGIN
              SELECT MIN (t.applicant_rate)
                INTO l_min_score
                FROM bu_apps.adm_applicant_choices_seq t
               WHERE     quota_term = '144210'
                     AND quota_run_sequence = 15
                     AND applicant_choice = l_choice
                     AND applicant_decision = 'QA'
                     AND EXISTS
                             (SELECT 'X'
                                FROM bu_apps.adm_applicant_quota_batch_seq d
                               WHERE     d.applicant_pidm = t.applicant_pidm
                                     AND d.applicant_program =
                                         t.applicant_choice
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
            WHEN NO_DATA_FOUND
            THEN
                l_min_score := 0;
            WHEN OTHERS
            THEN
                err_code := SQLCODE;
                err_msg := SUBSTR (SQLERRM, 1, 200);

                UPDATE BU_DEV.TMP_TBL04 
                   SET col07 = err_code || err_msg
                 WHERE col02 = l_pidm;
        END;

        IF l_APPLICANT_RATE >= l_min_score OR :L_PASS = 'Y'
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
                               AND SARADAP_TERM_CODE_ENTRY = '144210'
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
                                 '144210',
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
                    WHEN OTHERS
                    THEN
                        err_code := SQLCODE;
                        err_msg := SUBSTR (SQLERRM, 1, 200);

                        UPDATE BU_DEV.TMP_TBL04 
                           SET col07 = err_code || err_msg
                         WHERE col02 = l_pidm;
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
                WHEN OTHERS
                THEN
                    err_code := SQLCODE;
                    err_msg := SUBSTR (SQLERRM, 1, 200);

                    UPDATE BU_DEV.TMP_TBL04 
                       SET col07 = err_code || err_msg
                     WHERE col02 = l_pidm;
            END;

            --DELETE  FROM  SARAPPD WHERE sarappd_pidm= l_pidm AND SARAPPD_APDC_CODE in ( 'CM' ,'CA' ,'WM' ,'WA' ,'CU') ;
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
                                       AND i.sarappd_appl_no =
                                           o.sarappd_appl_no);

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
                                       AND i.sarappd_appl_no =
                                           o.sarappd_appl_no);
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
                                       AND i.sarappd_appl_no =
                                           o.sarappd_appl_no);
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


            --confirm
            BEGIN
                INSERT INTO BU_APPS.ADM_STUDENT_CONFIRMATION (ADMIT_TERM,
                                                              APPLICANT_PIDM,
                                                              ACTIVITY_DATE,
                                                              USER_ID)
                     VALUES ('144210',
                             l_pidm,
                             SYSDATE,
                             'BU_APPS');
            EXCEPTION
                WHEN DUP_VAL_ON_INDEX
                THEN
                    NULL;
                WHEN OTHERS
                THEN
                    err_code := SQLCODE;
                    err_msg := SUBSTR (SQLERRM, 1, 200);

                    UPDATE BU_DEV.TMP_TBL04 
                       SET col07 = err_code || err_msg
                     WHERE col02 = l_pidm;
            END;
        -- cancel upgrade
        /*  DECLARE
              l_reply_code      VARCHAR (100);
              l_reply_message   VARCHAR (100);
          BEGIN
              DELETE FROM adm_student_confirmation
                    WHERE ADMIT_TERM = '144210' AND APPLICANT_PIDM = l_pidm;

              pg_quota.p_add_decision ('144210',
                                       l_pidm,
                                       L_CU,
                                       'CU',
                                       l_reply_code,
                                       l_reply_message);
              DBMS_OUTPUT.put_line (l_reply_code);
              DBMS_OUTPUT.put_line (l_reply_message);
          END;*/
        ELSE
            DBMS_OUTPUT.put_line ('99');
            DBMS_OUTPUT.put_line ('less than ratio' || ' ' || l_min_score);
        END IF;

        UPDATE BU_DEV.TMP_TBL04 
           SET col07 = 'DONE'
         WHERE col03 = l_pidm;
    END LOOP;
END;