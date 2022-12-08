/* Formatted on 11/24/2022 1:04:49 PM (QP5 v5.371) */
DECLARE
    CURSOR crs_accepted_students IS
        SELECT spriden_pidm                                   "Pidm",
               spriden_id                                     "Student Number",
               (SELECT spbpers_ssn
                  FROM spbpers
                 WHERE spbpers_pidm = sgbstdn_pidm)           "SSN",
               (SELECT spbpers_sex
                  FROM spbpers
                 WHERE spbpers_pidm = sgbstdn_pidm)           "Gender",
               d.spriden_first_name                           "Arabic First Name",
               d.spriden_mi                                   "Arabic Middle Name",
               d.spriden_last_name                            "Arabic Last Name",
                  d.spriden_first_name
               || ' '
               || d.spriden_mi
               || ' '
               || d.spriden_last_name                         "Arabic Full Name",
               (SELECT stvcoll_desc
                  FROM stvcoll
                 WHERE stvcoll_code = sgbstdn_coll_code_1)    "College",
               (SELECT stvdept_desc
                  FROM stvdept
                 WHERE stvdept_code = sgbstdn_dept_code)      "Department",
               (SELECT sprtele_intl_access
                  FROM sprtele
                 WHERE     sprtele_pidm = sgbstdn_pidm
                       AND sprtele_tele_code = 'MO'
                       AND ROWNUM = 1)                        "Mobile NO"
          FROM sgbstdn x, stvstst, spriden d
         WHERE     sgbstdn_pidm = spriden_pidm
               AND spriden_change_ind IS NULL
               AND sgbstdn_term_code_eff =
                   (SELECT MAX (sgbstdn_term_code_eff)
                      FROM sgbstdn d
                     WHERE d.sgbstdn_pidm = x.sgbstdn_pidm)
               AND sgbstdn_stst_code = stvstst_code
               AND stvstst_code IN ('AS')
               AND EXISTS
                       (SELECT '1'
                          FROM BU_APPS.BNK_INVOICES
                         WHERE     
                           STUDENT_PIDM=sgbstdn_pidm
                         and TERM_CODE = '144420'
                               AND INVOICE_STATUS = 'NEW')
                               
 
                               ;


    v_message         VARCHAR2 (300)
        := 'ÚÒíÒí ÇáØÇáÈ/ÇáØÇáÈÉ äÃãá ãäßã ÓÏÇÏ ÇáÑÓæã ÇáÏÑÇÓíÉ áÈÑÇãÌ ÇáãÇÌÓÊíÑ ÈÌÇãÚÉ ÇáÈÇÍÉ ááÝÕá ÇáÏÑÇÓí ÇáËÇäí 1444åÜ ÚÈÑ ÈæÇÈÉ ÌÇãÚÊí (My BU) Ýí ãæÚÏ ÃÞÕÇå  íæã ÇáÎãíÓ 7-5-1444åÜ¡  æÓíÊã ÇáÛÇÁ ÇáÊÓÌíá æØí ÇáÞíÏ áãä áã íÏÝÚ ÇáÑÓæã.';

    v_reply_code      VARCHAR2 (2);
    v_reply_messege   VARCHAR2 (200);
BEGIN
    FOR r IN crs_accepted_students
    LOOP
       -- bu_apps.p_send_sms ('0' || r."Mobile NO",
                            v_message,
                            v_reply_code,
                            v_reply_messege);

        INSERT INTO bu_apps.log_sms (student_pidm,
                                     mobile_no,
                                     MESSAGE,
                                     message_justification,
                                     message_status,
                                     activity_date,
                                     user_id)
             VALUES (r."Pidm",
                     r."Mobile NO",
                     v_message,
                     'ÊÓÌíá ØáÇÈ ÇáÏÑÇÓÇÊ ÇáÚáíÇ',
                     v_reply_code,
                     SYSDATE,
                     'SAISUSR');

        DBMS_OUTPUT.put_line (f_get_std_id(r."Pidm")||' >>> '||v_reply_code || '----' || r."Mobile NO");


        COMMIT;
    END LOOP;
END;
/
