declare  
 p_pidm sgbstdn.sgbstdn_pidm%TYPE:=f_get_pidm('437002445');
   
   --Function calculate how many times student
   --has been disconnected

   CURSOR get_student_records
   IS
        SELECT sgbstdn_term_code_eff term_code, sgbstdn_stst_code
          FROM sgbstdn s1
         WHERE sgbstdn_pidm = p_pidm
      ORDER BY 1;

   l_disconnect_count     NUMBER := 0;
   l_still_disconnected   BOOLEAN := FALSE;
BEGIN
   FOR i IN get_student_records
   LOOP
      IF i.sgbstdn_stst_code in( 'иэ','иг','уг')
      THEN
         IF NOT l_still_disconnected
         THEN
            l_disconnect_count := l_disconnect_count + 1;
             dbms_output.put_line( i.term_code||'--->>'|| l_disconnect_count );
         END IF;

         l_still_disconnected := TRUE;
      ELSIF i.sgbstdn_stst_code IN ('AS', 'ук', 'уц')
      THEN
         l_still_disconnected := FALSE;
          dbms_output.put_line( i.term_code||'--->>'|| l_disconnect_count );
      END IF;
   END LOOP;

   dbms_output.put_line( 'final : '||'--->>'|| l_disconnect_count );
END;
/