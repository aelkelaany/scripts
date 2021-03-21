CREATE OR REPLACE TRIGGER validation_staff_data_spriden
   BEFORE INSERT OR UPDATE OR DELETE
   ON saturn.SPRIDEN
   FOR EACH ROW
DECLARE
  
   invalid_user_exp   EXCEPTION;
   PRAGMA EXCEPTION_INIT (invalid_user_exp, -20001);
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
   
         IF INSERTING 
         THEN 
         IF   F_VALIDATE_STAFF_DATA('I',:NEW.SPRIDEN_PIDM)='Y' THEN 
         
                  raise_application_error (
                     '-20001',
                     '·«Ì„ﬂ‰ﬂ ≈œŒ«· »Ì«‰«  √⁄÷«¡ ÂÌ∆… «· œ—Ì”');
               END IF;
               ELSE
              
         IF   F_VALIDATE_STAFF_DATA('U',:NEW.SPRIDEN_PIDM)='Y' THEN 
         
                  raise_application_error (
                     '-20001',
                     '€Ì— „”„ÊÕ »«· ⁄œÌ· ⁄·Ï »Ì«‰«  √⁄÷«¡ ÂÌ∆… «· œ—Ì”');
               END IF;
         END IF ;
        
         
         
         END;
/
CREATE OR REPLACE TRIGGER validation_staff_data_SPRADDR
   BEFORE INSERT OR UPDATE OR DELETE
   ON saturn.SPRADDR
   FOR EACH ROW
DECLARE
  
   invalid_user_exp   EXCEPTION;
   PRAGMA EXCEPTION_INIT (invalid_user_exp, -20001);
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
   
         IF INSERTING 
         THEN 
         IF   F_VALIDATE_STAFF_DATA('I',:NEW.SPRADDR_PIDM)='Y' THEN 
         
                  raise_application_error (
                     '-20001',
                     '·«Ì„ﬂ‰ﬂ ≈œŒ«· »Ì«‰«  √⁄÷«¡ ÂÌ∆… «· œ—Ì”');
               END IF;
               ELSE
              
         IF   F_VALIDATE_STAFF_DATA('U',:NEW.SPRADDR_PIDM)='Y' THEN 
         
                  raise_application_error (
                     '-20001',
                     '€Ì— „”„ÊÕ »«· ⁄œÌ· ⁄·Ï »Ì«‰«  √⁄÷«¡ ÂÌ∆… «· œ—Ì”');
               END IF;
         END IF ;
        
         
         
         END;
/

CREATE OR REPLACE TRIGGER validation_staff_data_SPRTELE
   BEFORE INSERT OR UPDATE OR DELETE
   ON saturn.SPRTELE
   FOR EACH ROW
DECLARE
  
   invalid_user_exp   EXCEPTION;
   PRAGMA EXCEPTION_INIT (invalid_user_exp, -20001);
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
   
         IF INSERTING 
         THEN 
         IF   F_VALIDATE_STAFF_DATA('I',:NEW.SPRTELE_PIDM)='Y' THEN 
         
                  raise_application_error (
                     '-20001',
                     '·«Ì„ﬂ‰ﬂ ≈œŒ«· »Ì«‰«  √⁄÷«¡ ÂÌ∆… «· œ—Ì”');
               END IF;
               ELSE
              
         IF   F_VALIDATE_STAFF_DATA('U',:NEW.SPRTELE_PIDM)='Y' THEN 
         
                  raise_application_error (
                     '-20001',
                     '€Ì— „”„ÊÕ »«· ⁄œÌ· ⁄·Ï »Ì«‰«  √⁄÷«¡ ÂÌ∆… «· œ—Ì”');
               END IF;
         END IF ;
        
         
         
         END;
/

CREATE OR REPLACE TRIGGER validation_staff_data_SPBPERS
   BEFORE INSERT OR UPDATE OR DELETE
   ON saturn.SPBPERS
   FOR EACH ROW
DECLARE
  
   invalid_user_exp   EXCEPTION;
   PRAGMA EXCEPTION_INIT (invalid_user_exp, -20001);
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
   
         IF INSERTING 
         THEN 
         IF   F_VALIDATE_STAFF_DATA('I',:NEW.SPBPERS_PIDM)='Y' THEN 
         
                  raise_application_error (
                     '-20001',
                     '·«Ì„ﬂ‰ﬂ ≈œŒ«· »Ì«‰«  √⁄÷«¡ ÂÌ∆… «· œ—Ì”');
               END IF;
               ELSE
              
         IF   F_VALIDATE_STAFF_DATA('U',:NEW.SPBPERS_PIDM)='Y' THEN 
         
                  raise_application_error (
                     '-20001',
                     '€Ì— „”„ÊÕ »«· ⁄œÌ· ⁄·Ï »Ì«‰«  √⁄÷«¡ ÂÌ∆… «· œ—Ì”');
               END IF;
         END IF ;
        
         
         
         END;
/
CREATE OR REPLACE TRIGGER validation_staff_data_GOREMAL
   BEFORE INSERT OR UPDATE OR DELETE
   ON general.GOREMAL
   FOR EACH ROW
DECLARE
  
   invalid_user_exp   EXCEPTION;
   PRAGMA EXCEPTION_INIT (invalid_user_exp, -20001);
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
   
         IF INSERTING 
         THEN 
         IF   F_VALIDATE_STAFF_DATA('I',:NEW.GOREMAL_PIDM)='Y' THEN 
         
                  raise_application_error (
                     '-20001',
                     '·«Ì„ﬂ‰ﬂ ≈œŒ«· »Ì«‰«  √⁄÷«¡ ÂÌ∆… «· œ—Ì”');
               END IF;
               ELSE
              
         IF   F_VALIDATE_STAFF_DATA('U',:NEW.GOREMAL_PIDM)='Y' THEN 
         
                  raise_application_error (
                     '-20001',
                     '€Ì— „”„ÊÕ »«· ⁄œÌ· ⁄·Ï »Ì«‰«  √⁄÷«¡ ÂÌ∆… «· œ—Ì”');
               END IF;
         END IF ;
        
         
         
         END;
/
CREATE OR REPLACE TRIGGER validation_staff_data_SPREMRG
   BEFORE INSERT OR UPDATE OR DELETE
   ON saturn.SPREMRG
   FOR EACH ROW
DECLARE
  
   invalid_user_exp   EXCEPTION;
   PRAGMA EXCEPTION_INIT (invalid_user_exp, -20001);
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
   
         IF INSERTING 
         THEN 
         IF   F_VALIDATE_STAFF_DATA('I',:NEW.SPREMRG_PIDM)='Y' THEN 
         
                  raise_application_error (
                     '-20001',
                     '·«Ì„ﬂ‰ﬂ ≈œŒ«· »Ì«‰«  √⁄÷«¡ ÂÌ∆… «· œ—Ì”');
               END IF;
               ELSE
              
         IF   F_VALIDATE_STAFF_DATA('U',:NEW.SPREMRG_PIDM)='Y' THEN 
         
                  raise_application_error (
                     '-20001',
                     '€Ì— „”„ÊÕ »«· ⁄œÌ· ⁄·Ï »Ì«‰«  √⁄÷«¡ ÂÌ∆… «· œ—Ì”');
               END IF;
         END IF ;
        
         
         
         END;
/
CREATE OR REPLACE TRIGGER validation_staff_data_GORADID
   BEFORE INSERT OR UPDATE OR DELETE
   ON general.GORADID
   FOR EACH ROW
DECLARE
  
   invalid_user_exp   EXCEPTION;
   PRAGMA EXCEPTION_INIT (invalid_user_exp, -20001);
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
   
         IF INSERTING 
         THEN 
         IF   F_VALIDATE_STAFF_DATA('I',:NEW.GORADID_PIDM)='Y' THEN 
         
                  raise_application_error (
                     '-20001',
                     '·«Ì„ﬂ‰ﬂ ≈œŒ«· »Ì«‰«  √⁄÷«¡ ÂÌ∆… «· œ—Ì”');
               END IF;
               ELSE
              
         IF   F_VALIDATE_STAFF_DATA('U',:NEW.GORADID_PIDM)='Y' THEN 
         
                  raise_application_error (
                     '-20001',
                     '€Ì— „”„ÊÕ »«· ⁄œÌ· ⁄·Ï »Ì«‰«  √⁄÷«¡ ÂÌ∆… «· œ—Ì”');
               END IF;
         END IF ;
        
         
         
         END;
/
CREATE OR REPLACE TRIGGER validation_staff_data_GORADID
   BEFORE INSERT OR UPDATE OR DELETE
   ON general.GORADID
   FOR EACH ROW
DECLARE
  
   invalid_user_exp   EXCEPTION;
   PRAGMA EXCEPTION_INIT (invalid_user_exp, -20001);
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
   
         IF INSERTING 
         THEN 
         IF   F_VALIDATE_STAFF_DATA('I',:NEW.GORADID_PIDM)='Y' THEN 
         
                  raise_application_error (
                     '-20001',
                     '·«Ì„ﬂ‰ﬂ ≈œŒ«· »Ì«‰«  √⁄÷«¡ ÂÌ∆… «· œ—Ì”');
               END IF;
               ELSE
              
         IF   F_VALIDATE_STAFF_DATA('U',:NEW.GORADID_PIDM)='Y' THEN 
         
                  raise_application_error (
                     '-20001',
                     '€Ì— „”„ÊÕ »«· ⁄œÌ· ⁄·Ï »Ì«‰«  √⁄÷«¡ ÂÌ∆… «· œ—Ì”');
               END IF;
         END IF ;
        
         
         
         END;
/