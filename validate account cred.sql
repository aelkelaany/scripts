twbkwbis.P_ValLogin?SID=434011571&PIN=Aa123456*



declare 
lv_pinhash       gobtpac.gobtpac_pin%TYPE:='*****';
        lv_pinhash_md5   gobtpac.gobtpac_pin%TYPE;
        lpidm spriden.spriden_pidm%type;
        p_student_id spriden.spriden_id%type:='434011571';
        gobtpac_rec      gobtpac%ROWTYPE; 
        pin varchar2(10) :='Aa123456*' ;
begin
 

 
OPEN twbkglib.gobtpacc (twbkslib.f_fetchpidm (p_student_id));

        FETCH twbkglib.gobtpacc INTO gobtpac_rec;

        IF twbkglib.gobtpacc%NOTFOUND
        THEN
            /* User has no GOBTPAC record */
            CLOSE twbkglib.gobtpacc;

            --RAISE twbklibs.getusererror;
            RAISE twbklibs.missinggobtpac;
        ELSE
lv_pinhash :=
                        gb_third_party_access.F_GET_PINHASH (
                            gobtpac_rec.gobtpac_pidm,
                            pin) ;
                            gspcrpt.p_saltedhash_md5 (pin, lv_pinhash_md5);
                            
                            if (gobtpac_rec.gobtpac_pin = lv_pinhash  or gobtpac_rec.gobtpac_pin = lv_pinhash_md5) then
                             
                             dbms_output.put_line('Matched pwd');
                             else
                             dbms_output.put_line('Unmatch pwd');
                            end if ; 
                            
                            close   twbkglib.gobtpacc;
                            
                       f_authenticate_ldap (student_id, pin, 'S') = 'Y'     
                            
     end if;                        
                            dbms_output.put_line('lv_pinhash    '||lv_pinhash);
                             dbms_output.put_line('lv_pinhash_md5   '||lv_pinhash_md5);
end ; 