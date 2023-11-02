/* Formatted on 9/12/2019 10:13:42 AM (QP5 v5.227.12220.39754) */
DECLARE
 
   v_reply_code      VARCHAR2 (2);
   v_reply_messege   VARCHAR2 (200);
BEGIN
   bu_apps.p_send_sms ('0568134765',
                       'test12f2',
                       v_reply_code,
                       v_reply_messege);
                       
      dbms_output.put_line('v_reply_code '||v_reply_code); 
      dbms_output.put_line('v_reply_messege '||v_reply_messege);                  
END;