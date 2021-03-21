CREATE OR REPLACE FUNCTION BANINST1.F_VALIDATE_STAFF_DATA (P_MODE    VARCHAR2,
                                                  P_PIDM    NUMBER)
   RETURN VARCHAR2
IS
   L_CHECK   VARCHAR2 (1);
BEGIN
   IF      USER NOT IN
                ('BU_APPS', 'BANSECR', 'BANINST1', 'SAISUSR', 'WWW2_USER')
   THEN
      IF LENGTH (f_get_std_id (P_PIDM)) > 5
      THEN
         RETURN 'N';
      ELSE
         RETURN 'Y';
      END IF;
      else
       RETURN 'N';
   END IF;
END;
/
