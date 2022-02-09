declare 

cursor get_data is 
SELECT sgbstdn_pidm st_pidm,f_get_std_id(sgbstdn_pidm),f_get_std_name(sgbstdn_pidm)
           FROM sgbstdn a
          WHERE     sgbstdn_term_code_eff =
                       (SELECT MAX (b.sgbstdn_term_code_eff)
                          FROM sgbstdn b
                         WHERE b.sgbstdn_pidm = a.sgbstdn_pidm
                         and b.sgbstdn_term_code_eff <= '144320')
                AND sgbstdn_stst_code = 'AS'
                AND sgbstdn_levl_code  IN ('Ìã')
                and exists (select '1' from shrttrm
                where 
                SHRTTRM_PIDM =  a.sgbstdn_pidm
AND SHRTTRM_ASTD_CODE_END_OF_TERM = 'Ýß'
AND SHRTTRM_TERM_CODE = '144310'
  )
                ;

 reply_code              VARCHAR2(150);
      reply_message         VARCHAR2(150);

begin
for rec in get_data
loop 
 bu_apps.p_update_student_status (
         :i_initiator_pidm,
         f_get_param ('WORKFLOW', 'CURRENT_TERM', 1),
         :l_withdraw_type,                                              --'ãÓ',
         'WORKFLOW',
         reply_code,
         reply_message);
           DBMS_OUTPUT.put_line ('reply code : ' || reply_code);
        end loop ;  

end ; 