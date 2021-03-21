DECLARE
   CURSOR crs_check_user
   IS
      SELECT 'Y'
        FROM dev_sys_parameters
       WHERE     module = 'GENERAL'
             AND parameter_code = 'UPDATE_BANNER_PASSWORD'
             AND parameter_value = 'MMAKKI';

   v_dummy     VARCHAR2 (1);
   temp_flag   VARCHAR (1);
BEGIN
   OPEN crs_check_user;

   FETCH crs_check_user INTO v_dummy;

   CLOSE crs_check_user;

   IF NVL (v_dummy, 'N') = 'N'
   THEN
      BEGIN
         SELECT DISTINCT 'X'
           INTO temp_flag
           FROM sgbstdn
          WHERE sgbstdn_pidm = f_get_pidm('2975');
          dbms_output.put_line('0');
      EXCEPTION
         WHEN OTHERS
         THEN
            dbms_output.put_line('1');
          
      END;
   else
       DECLARE
           L_CHECK CHAR ;
   BEGIN
   SELECT DISTINCT 'X'
           INTO temp_flag
           FROM sgbstdn
          WHERE sgbstdn_pidm = f_get_pidm('2975');
          dbms_output.put_line('0');
        EXCEPTION   
        when no_data_found then 
   L_CHECK:=    F_FACULTY_PWD_VALIDATE('MMAKKI'   , '2975' );
       IF L_CHECK='N' then 
            dbms_output.put_line ('2');
            ELSE
             dbms_output.put_line ('0');
            
       END IF ;
       
           WHEN OTHERS
         THEN
             dbms_output.put_line ('3');
            
       END ; 
   END IF;
END;