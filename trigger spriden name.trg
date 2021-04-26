 DROP TRIGGER validation_NAMES_spriden ;
CREATE OR REPLACE TRIGGER validation_NAMES_spriden
   BEFORE INSERT OR UPDATE OR DELETE
   ON saturn.SPRIDEN
   FOR EACH ROW
DECLARE
   invalid_user_exp   EXCEPTION;
   PRAGMA EXCEPTION_INIT (invalid_user_exp, -20001);
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
   IF INSERTING OR UPDATING
   THEN
      IF   LENGTH (:NEW.SPRIDEN_LAST_NAME) BETWEEN 2 AND 30
      THEN
      NULL ;
      ELSE
         raise_application_error (
            '-20001',
            '(«·Õœ «·√œ‰Ï 2 Œ«‰… - «·Õœ «·√ﬁ’Ï 30 Œ«‰…) «·«”„ «·√ŒÌ— : ');
      END IF;

   /*   IF   LENGTH (:NEW.SPRIDEN_FIRST_NAME) BETWEEN 2 AND 30
      THEN
      NULL;
      ELSE
         raise_application_error (
            '-20001',
            '(«·Õœ «·√œ‰Ï 2 Œ«‰… - «·Õœ «·√ﬁ’Ï 30 Œ«‰…) «·«”„ «·√Ê· : ');
      END IF;

      IF   LENGTH (:NEW.SPRIDEN_MI) BETWEEN 2 AND 30
      THEN
      NULL ;
      ELSE
         raise_application_error (
            '-20001',
            '(«·Õœ «·√œ‰Ï 2 Œ«‰… - «·Õœ «·√ﬁ’Ï 30 Œ«‰…) «·«”„ «·√Ê”ÿ : ');
      END IF;*/
   END IF;
END;
/