DECLARE
   l_reply_code      VARCHAR (100);
   l_reply_message   VARCHAR (100);
BEGIN
   DELETE FROM adm_student_confirmation
         WHERE ADMIT_TERM = '144010' AND APPLICANT_PIDM = :pidm;

   pg_quota.p_add_decision ('144010',
                            :pidm,
                            12,
                            'CU',
                            l_reply_code,
                            l_reply_message);
   DBMS_OUTPUT.put_line (l_reply_code);
   DBMS_OUTPUT.put_line (l_reply_message);
END;

sfrstcr
sorlfos
sorlcur