declare 
   p_pidm          spriden.spriden_pidm%TYPE :=f_get_pidm('437007201');
   p_totoal_ind    VARCHAR2(1) := 'C' ;
   
 
   CURSOR shrttrmc
   IS
        SELECT shrttrm_term_code term_code, shrttrm_astd_code_end_of_term
          FROM shrttrm
         WHERE shrttrm_pidm = p_pidm AND SUBSTR (shrttrm_term_code, 5) != '30'
      ORDER BY shrttrm_term_code ASC;

   l_chances_count   NUMBER := 0;
BEGIN
   FOR i IN shrttrmc
   LOOP
      IF i.shrttrm_astd_code_end_of_term IN ('ä1', 'ä2', 'Ýß','Ý1','Ý2')
      THEN
         l_chances_count := l_chances_count + 1;
         dbms_output.put_line( i.term_code||'--->>'|| l_chances_count );
      ELSE
         --Count total chances given to student
         IF p_totoal_ind != 'T'
         THEN
            l_chances_count := 0;
         END IF;
         dbms_output.put_line( i.term_code||'--->>'|| l_chances_count );
      END IF;
   END LOOP;

   dbms_output.put_line(  l_chances_count);
END;

ssrmeet
sfbetrm