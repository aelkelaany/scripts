 
DECLARE
   CURSOR get_std
   IS
     SELECT REQUESTER_PIDM pidm
        FROM request_master a, request_details b
       WHERE     object_code = UPPER ('wf_postpone_term')
             AND a.request_no = b.request_no
             AND item_code = 'TERM'
             AND item_value = '144210'
            -- AND REQUESTER_PIDM = 184138
             AND EXISTS
                    (SELECT 'y'
                       FROM sgbstdn
                      WHERE     SGBSTDN_PIDM = a.REQUESTER_PIDM
                            AND SGBSTDN_TERM_CODE_EFF = '144210'
                            AND SGBSTDN_STST_CODE = 'AS'); 
                         --  select f_get_pidm('438000924') pidm from dual ;

   v_reply_code      VARCHAR2 (150);
   v_reply_message   VARCHAR2 (150);
BEGIN
   FOR rec IN get_std
   LOOP
      p_update_student_status (rec.pidm,
                               f_get_param ('WORKFLOW', 'CURRENT_TERM', 1),
                               'ãæ',
                               'WORKFLOW',
                               v_reply_code,
                               v_reply_message);

      IF v_reply_code = '00'
      THEN
         p_update_registration_status (
            rec.pidm,
            f_get_param ('WORKFLOW', 'CURRENT_TERM', 1),
            'ãæ',
            v_reply_code,
            v_reply_message);

         IF v_reply_code = '00'
         THEN
            p_update_student_status (
               rec.pidm,
               f_get_param ('WORKFLOW', 'NEXT_TERM', 1),
               'AS',
               'WORKFLOW',
               v_reply_code,
               v_reply_message);
         END IF;
      END IF;

      DBMS_OUTPUT.put_line (v_reply_code || rec.pidm);
      DBMS_OUTPUT.put_line (v_reply_message || rec.pidm);
   END LOOP;
END;


 

stvdept