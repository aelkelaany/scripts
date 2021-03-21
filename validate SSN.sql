 
 
declare 
v_ssn varchar2(10):='1036035978';
 BEGIN
  IF F_VALIDATE_SSN (v_ssn) THEN
    dbms_output.put_line(' SSN is true');
  else
    dbms_output.put_line('SSN is false');
  END IF;
 
END;