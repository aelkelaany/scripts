/* Formatted on 8/29/2023 10:04:42 AM (QP5 v5.371) */
DECLARE
    v_message         VARCHAR2 (300)
        := '����� ������ / �� ����� ������ ���� ��� ������� ��� ��� �������� ����� ��� �� : ';
    v_message2        VARCHAR2 (300)
        := '������ ����� �� *Aa123456 ������� ��� ����� ������� ������� ���������� ���� ������ ������: https://banner.bu.edu.sa/';
    v_msg             VARCHAR2 (1000)
        := '����� ������� / �� ����� ������ ���� ��� ������� ��� ��� �������� ����� ��� ��  445****
����� ������ �� ****
����� ������ ��� ����� ������� ������� ���������� ��� ������ ������  https://banner.bu.edu.sa  
����� ��� ���� ������ ����ɡ ������ ���� ����� ��ء ���� ����� ������� ��� ��� ����� ����.

��� ����� �������� �� ������� �� ������ ������� ����������� ���� ����� ����� ���� �������� �� ������� �� ������� ��� ����� ���� ������� ����� "������ �� �������". 
 
� ���� ������� ������ ���� ��� �������� �� ����� ����� �������.';
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
         WHERE     BATCH_NO = 13
               AND EXISTS
                       (SELECT '1'
                          FROM sgbstdn
                         WHERE     SGBSTDN_PIDM = pidm
                               AND SGBSTDN_TERM_CODE_EFF = '144510'
                               AND SGBSTDN_STST_CODE = 'AS')
                             --  and '1'='2'
                             and "SamAccountName" not in ('445041784') 
                             and not exists (select '1' from bu_apps.log_sms where
           STUDENT_PIDM=  pidm                
and  MESSAGE_JUSTIFICATION = '1445 New Students2')
                               union
                               select 123,'0568134765','RE$%CDD1$','445000000' from dual
                               where 1=2
                               
                               
                               ;
BEGIN
    FOR rec IN get_data
    LOOP
        bu_apps.p_send_sms (
            rec.Mobile_NO,
               '����� ������� / �� ����� ������ ���� ��� ������� ��� ��� �������� ����� ��� �� 
 '
            || rec.std_id
            || '
  � ���� ������ �� '
            || rec.std_password
            || '
����� ������ ��� ����� ������� ������� ���������� ��� ������ ������  https://banner.bu.edu.sa  

 ����� ��������� �� ������ ������� �� ���� ������ "����� ������ �������". 
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
                               ' ����� ������� / �� ����� ������ ���� ��� ������� ��� ��� �������� ����� ��� �� '
                            || rec.std_id
                            || ' 
 ����� ������ �� '
                            || rec.std_password
                            || '
����� ������ ��� ����� ������� ������� ���������� ��� ������ ������  https://banner.bu.edu.sa  

 ����� ��������� �� ������ ������� �� ���� ������ "����� ������ �������". 
',
                            '1445 New Students3',
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