/* Formatted on 8/15/2023 4:10:58 PM (QP5 v5.371) */
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
                       AND ROWNUM = 1
                       )    "Mobile_NO",
               "AccountPassword"          std_password,
               "SamAccountName"           std_id
          FROM new_students_email x
         WHERE     BATCH_NO = 12
               AND EXISTS
                       (SELECT '1'
                          FROM sgbstdn
                         WHERE     SGBSTDN_PIDM = pidm
                               AND SGBSTDN_TERM_CODE_EFF = '144510'
                               AND SGBSTDN_STST_CODE = 'AS');
BEGIN
    FOR rec IN get_data
    LOOP
        bu_apps.p_send_sms (
            rec.Mobile_NO,
               ' ����� ������� / �� ����� ������ ���� ��� ������� ��� ��� �������� ����� ��� �� '
            || rec.std_id
            || ' 
 ����� ������ �� '
            || rec.std_password
            || '
����� ������ ��� ����� ������� ������� ���������� ��� ������ ������  https://banner.bu.edu.sa  
����� ��� ���� ������ ����ɡ ������ ���� ����� ��ء ���� ����� ������� ��� ��� ����� ����.
',
            v_reply_code,
            v_reply_messege);



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
����� ��� ���� ������ ����ɡ ������ ���� ����� ��ء ���� ����� ������� ��� ��� ����� ����.

��� ����� �������� �� ������� �� ������ ������� ����������� ���� ����� ����� ���� �������� �� ������� �� ������� ��� ����� ���� ������� ����� "������ �� �������". 
 
� ���� ������� ������ ���� ��� �������� �� ����� ����� �������.',
                            '1445 New Students',
                            v_reply_code,
                            SYSDATE,
                            'SAISUSR');

        COMMIT;
    END LOOP;
END;