CREATE OR REPLACE TRIGGER  SSBSECT_PRVNT_TERM 
--
-- FILE NAME..:  prevent editing or inserting in old term
-- RELEASE....: 1.0
-- OBJECT NAME: SSBSECT_PRVNT_TERM
 
--
  AFTER INSERT OR UPDATE OR DELETE ON ssbsect
  FOR EACH ROW
DECLARE
  term_code    ssbsect.ssbsect_term_code%TYPE;
   CURSOR IS_VICE_DEAN IS SELECT 'Y' FROM GOVUROL2 WHERE GOVUROL2_SECURITY_CLASS IN ('BU_VICE_DEAN','BU_VICE_DEAN_M') AND GOVUROL2_USERID = USER AND ROWNUM<2;
   
  DUMMY CHAR :='';
BEGIN

OPEN IS_VICE_DEAN ;
FETCH IS_VICE_DEAN INTO DUMMY ;
CLOSE IS_VICE_DEAN ;
 
  IF inserting
  THEN
     IF:NEW.ssbsect_term_code!='144210'  AND DUMMY='Y'
     THEN 
      raise_application_error (
                     '-20001',
                     'You are not authorized to do this transaction');
                     END IF ;
    
  ELSIF updating
  THEN
     IF:NEW.ssbsect_term_code!='144210'  AND DUMMY='Y'
     THEN 
      raise_application_error (
                     '-20001',
                     'You are not authorized to do this transaction');
                     END IF ;
  ELSIF deleting
  THEN
    IF:NEW.ssbsect_term_code!='144210'  AND DUMMY='Y'
     THEN 
      raise_application_error (
                     '-20001',
                     'You are not authorized to do this transaction');
                     END IF ;
  END IF;

END;
/