DECLARE
   CURSOR crs_get_students
   IS
      SELECT sgbstdn_pidm student_pidm, sgbstdn_term_code_eff eff_term
        FROM sgbstdn a
       WHERE     sgbstdn_term_code_eff =
                    (SELECT MAX (b.sgbstdn_term_code_eff)
                       FROM sgbstdn b
                      WHERE b.sgbstdn_pidm = a.sgbstdn_pidm)
             AND sgbstdn_stst_code = 'AS'
             AND sgbstdn_levl_code = 'Ìã'
             AND sgbstdn_styp_code NOT IN ('ä', 'Ê')
             AND sgbstdn_pidm = 167037;

   v_chances_count    NUMBER := 0;
   v_student_status   stvstst.stvstst_code%TYPE;
   v_reply_code       VARCHAR2 (2);
   v_reply_message    VARCHAR2 (200);
BEGIN
   FOR r IN crs_get_students
   LOOP
      v_chances_count := 0;
      v_chances_count := bu_apps.f_chances_count (r.student_pidm, 'C');

      v_student_status := '';

      IF v_chances_count >= 6
      THEN
         v_student_status := 'ãÝ';
      ELSIF v_chances_count >= 3
      THEN
         v_student_status := 'Ýß';
      END IF;

      IF v_student_status IS NOT NULL
      THEN
         p_update_student_status (r.student_pidm,
                                  r.eff_term,
                                  v_student_status,
                                  'SAISUSR',
                                  v_reply_code,
                                  v_reply_message);
      END IF;
   END LOOP;
END;
/
