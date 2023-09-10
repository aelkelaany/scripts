/* Formatted on 8/29/2023 10:04:42 AM (QP5 v5.371) */
DECLARE
 
    l_id              VARCHAR2 (20) := '445039049';
    l_password        VARCHAR2 (20) := 'As123$#@1';
    v_reply_code      VARCHAR2 (2);
    v_reply_messege   VARCHAR2 (200);

    CURSOR get_data IS
        SELECT pidm,
               (SELECT sprtele_intl_access
                  FROM sprtele
                 WHERE     sprtele_pidm = pidm
                       AND sprtele_tele_code = 'MO'
                       AND ROWNUM = 1)     Mobile_NO ,
               "AccountPassword"          std_password,
               "SamAccountName"           std_id
          FROM new_students_email x
         WHERE     BATCH_NO = 14
               AND EXISTS
                       (SELECT '1'
                          FROM sgbstdn
                         WHERE     SGBSTDN_PIDM = pidm
                               AND SGBSTDN_TERM_CODE_EFF = '144510'
                               AND SGBSTDN_STST_CODE = 'AS')
                            
                              
                             and not exists (select '1' from bu_apps.log_sms where
           STUDENT_PIDM=  pidm                
and  MESSAGE_JUSTIFICATION = '1445 New StudentsPG')
                               union
                               select 123,'0568134765','Z7n4$G3i','445000000' from dual
                                
                               
                               
                               ;
BEGIN
    FOR rec IN get_data
    LOOP
        bu_apps.p_send_sms (
            rec.Mobile_NO,
 ' ⁄“Ì“Ì «·ÿ«·» / ⁄“Ì“ Ì «·ÿ«·»…
‰√„· «·œŒÊ· ⁄·Ï Õ”«»ﬂ »»Ê«»… Ã«„⁄ Ì (myBU) »Ã«„⁄… «·»«Õ… ··«ÿ·«⁄ ⁄·Ï ÃœÊ·ﬂ «·œ—«”Ì.
»Ì«‰«  «·œŒÊ· «·Œ«’… »ﬂ
«”„ «·„” Œœ„:
 '
                            || rec.std_id
                            || ' 
ﬂ·„… «·„—Ê—: '
                            || rec.std_password
                            || '
—«»ÿ »Ê«»… Ã«„⁄ Ì:  https://banner.bu.edu.sa  
  
',
            v_reply_code,
            v_reply_messege);

DBMS_OUTPUT.put_line (rec.std_id||'Sending Ststus for' || rec.Mobile_NO||' --> '||v_reply_code||' ~ '||v_reply_messege);
begin
        INSERT INTO bu_apps.log_sms (student_pidm,
                                     mobile_no,
                                     MESSAGE,
                                     message_justification,
                                     message_status,
                                     activity_date,
                                     user_id)
                 VALUES (
                            rec.pidm,
                            rec.Mobile_NO,
                               ' ⁄“Ì“Ì «·ÿ«·» / ⁄“Ì“ Ì «·ÿ«·»…
‰√„· «·œŒÊ· ⁄·Ï Õ”«»ﬂ »»Ê«»… Ã«„⁄ Ì (myBU) »Ã«„⁄… «·»«Õ… ··«ÿ·«⁄ ⁄·Ï ÃœÊ·ﬂ «·œ—«”Ì.
»Ì«‰«  «·œŒÊ· «·Œ«’… »ﬂ
«”„ «·„” Œœ„:
 '
                            || rec.std_id
                            || ' 
ﬂ·„… «·„—Ê—: '
                            || rec.std_password
                            || '
—«»ÿ »Ê«»… Ã«„⁄ Ì:  https://banner.bu.edu.sa  
  
',
                            '1445 New StudentsPG',
                            v_reply_code,
                            SYSDATE,
                            'SAISUSR');
                            exception
                            when others then 
                            DBMS_OUTPUT.put_line (rec.pidm||' error Sending Ststus for' || sqlerrm);
                            end ;

        COMMIT;
    END LOOP;
END;