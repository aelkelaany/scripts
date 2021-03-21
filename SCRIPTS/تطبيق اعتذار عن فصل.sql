DECLARE 

      i_initiator_pidm       spriden.spriden_pidm%TYPE :=F_GET_PIDM(:ID) ;
 
  
      v_reply_code      VARCHAR2 (5);
      v_reply_message   VARCHAR2 (500);
   BEGIN
      p_update_student_status (i_initiator_pidm,
                               f_get_param ('WORKFLOW', 'CURRENT_TERM', 1),
                               'ук',
                               'WORKFLOW',
                               v_reply_code,
                               v_reply_message);

      IF v_reply_code = '00'
      THEN
         p_update_registration_status (
            i_initiator_pidm,
            f_get_param ('WORKFLOW', 'CURRENT_TERM', 1),
            'к',
            v_reply_code,
            v_reply_message);

         IF v_reply_code = '00'
         THEN
            p_update_student_status (
               i_initiator_pidm,
               f_get_param ('WORKFLOW', 'NEXT_TERM', 1),
               'AS',
               'WORKFLOW',
               v_reply_code,
               v_reply_message);
         END IF;  
      END IF;   

        dbms_output.put_line( v_reply_code);
        dbms_output.put_line( wf_navigation.g_request_no);
   END;