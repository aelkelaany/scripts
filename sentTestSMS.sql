/* Formatted on 9/12/2019 10:13:42 AM (QP5 v5.227.12220.39754) */
DECLARE
   v_message         VARCHAR2 (300)
      := '����� ������ / �� ����� ������ ���� ��� ������� ��� ��� �������� ����� ��� �� : ';
   v_message2        VARCHAR2 (300)
      := '������ ����� �� *Aa123456 ������� ��� ����� ������� ������� ���������� ���� ������ ������: https://banner.bu.edu.sa/';
   v_reply_code      VARCHAR2 (2);
   v_reply_messege   VARCHAR2 (200);
BEGIN
   bu_apps.p_send_sms ('0530011115',
                       v_message || ' ' || '441002365' || ' ' || v_message2,
                       v_reply_code,
                       v_reply_messege);
END;