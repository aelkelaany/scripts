/* Formatted on 5/16/2020 4:04:00 AM (QP5 v5.227.12220.39754) */
DECLARE
   CURSOR get_std_cur
   IS
      SELECT SHRTTRM_PIDM PIDM, SHRTTRM_ASTD_CODE_END_OF_TERM current_astd
        FROM SHRTTRM
       WHERE SHRTTRM_TERM_CODE = '144020';

   CURSOR get_pre_astd (
      p_pidm NUMBER)
   IS
      SELECT SHRTTRM_ASTD_CODE_END_OF_TERM
        FROM SHRTTRM s
       WHERE     SHRTTRM_PIDM = p_pidm
             AND SHRTTRM_TERM_CODE =
                    (SELECT MAX (SHRTTRM_TERM_CODE)
                       FROM SHRTTRM
                      WHERE     SHRTTRM_PIDM = p_pidm
                            AND SHRTTRM_TERM_CODE < '144020');

   l_pre_astd   SHRTTRM.SHRTTRM_ASTD_CODE_END_OF_TERM%TYPE;
   dummy        CHAR;
BEGIN
   FOR curr_rec IN get_std_cur
   LOOP
      OPEN get_pre_astd (curr_rec.PIDM);

      FETCH get_pre_astd INTO l_pre_astd;

      CLOSE get_pre_astd;

      IF l_pre_astd = 'ãã'
      THEN
         BEGIN
            SELECT 'Y'
              INTO dummy
              FROM DUAL
             WHERE curr_rec.current_astd IN
                      ('ÌÌ',
                       'ÌÏ',
                       'ãÞ',
                       'Ûã',
                       'ä1',
                       'ä2',
                       'Ý1',
                       'Ý2',
                       'Ì2',
                       'Ì1');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
         END;

         IF dummy = 'Y'
         THEN
            DBMS_OUTPUT.put_line (
                  curr_rec.PIDM
               || 'pre-'
               || l_pre_astd
               || 'curr'
               || curr_rec.current_astd);
            EXIT WHEN (dummy = 'Y');
         END IF;
      ELSIF l_pre_astd = 'ÌÌ'
      THEN
         BEGIN
            SELECT 'Y'
              INTO dummy
              FROM DUAL
             WHERE curr_rec.current_astd IN
                      ('ÌÏ',
                       'ãÞ',
                       'Ûã',
                       'ä1',
                       'ä2',
                       'Ý1',
                       'Ý2',
                       'Ì2',
                       'Ì1');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
         END;

         IF dummy = 'Y'
         THEN
            DBMS_OUTPUT.put_line (
                  curr_rec.PIDM
               || 'pre-'
               || l_pre_astd
               || 'curr'
               || curr_rec.current_astd);
            EXIT WHEN (dummy = 'Y');
         END IF;
      -----------
      ELSIF l_pre_astd = 'ÌÏ'
      THEN
         BEGIN
            SELECT 'Y'
              INTO dummy
              FROM DUAL
             WHERE curr_rec.current_astd IN
                      ('ãÞ',
                       'Ûã',
                       'ä1',
                       'ä2',
                       'Ý1',
                       'Ý2',
                       'Ì2',
                       'Ì1');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
         END;

         IF dummy = 'Y'
         THEN
            DBMS_OUTPUT.put_line (
                  curr_rec.PIDM
               || 'pre-'
               || l_pre_astd
               || 'curr'
               || curr_rec.current_astd);
            EXIT WHEN (dummy = 'Y');
         END IF;
      -------------
      ELSIF l_pre_astd = 'Ì2'
      THEN
         BEGIN
            SELECT 'Y'
              INTO dummy
              FROM DUAL
             WHERE curr_rec.current_astd IN
                      ('ãÞ', 'Ûã', 'ä1', 'ä2', 'Ý1', 'Ý2', 'Ì1');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
         END;

         IF dummy = 'Y'
         THEN
            DBMS_OUTPUT.put_line (
                  curr_rec.PIDM
               || 'pre-'
               || l_pre_astd
               || 'curr'
               || curr_rec.current_astd);
            EXIT WHEN (dummy = 'Y');
         END IF;
      --------------
      ELSIF l_pre_astd = 'Ì1'
      THEN
         BEGIN
            SELECT 'Y'
              INTO dummy
              FROM DUAL
             WHERE curr_rec.current_astd IN
                      ('ãÞ', 'Ûã', 'ä1', 'ä2', 'Ý1', 'Ý2');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
         END;

         IF dummy = 'Y'
         THEN
            DBMS_OUTPUT.put_line (
                  curr_rec.PIDM
               || 'pre-'
               || l_pre_astd
               || 'curr'
               || curr_rec.current_astd);
            EXIT WHEN (dummy = 'Y');
         END IF;
      --------------
      ELSIF l_pre_astd = 'ãÞ'
      THEN
         BEGIN
            SELECT 'Y'
              INTO dummy
              FROM DUAL
             WHERE curr_rec.current_astd IN
                      ('Ûã', 'ä1', 'ä2', 'Ý1', 'Ý2');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
         END;

         IF dummy = 'Y'
         THEN
            DBMS_OUTPUT.put_line (
                  curr_rec.PIDM
               || 'pre-'
               || l_pre_astd
               || 'curr'
               || curr_rec.current_astd);
            EXIT WHEN (dummy = 'Y');
         END IF;
      --------------
      ELSIF l_pre_astd = 'ä1'
      THEN
         BEGIN
            SELECT 'Y'
              INTO dummy
              FROM DUAL
             WHERE curr_rec.current_astd IN ('ä2', 'Ýß');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
         END;

         IF dummy = 'Y'
         THEN
            DBMS_OUTPUT.put_line (
                  curr_rec.PIDM
               || 'pre-'
               || l_pre_astd
               || 'curr'
               || curr_rec.current_astd);
            EXIT WHEN (dummy = 'Y');
         END IF;
      ELSIF l_pre_astd = 'ä2'
      THEN
         BEGIN
            SELECT 'Y'
              INTO dummy
              FROM DUAL
             WHERE curr_rec.current_astd IN ('Ýß');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
         END;

         IF dummy = 'Y'
         THEN
            DBMS_OUTPUT.put_line (
                  curr_rec.PIDM
               || 'pre-'
               || l_pre_astd
               || 'curr'
               || curr_rec.current_astd);
            EXIT WHEN (dummy = 'Y');
         END IF;
      END IF;
   END LOOP;
END;