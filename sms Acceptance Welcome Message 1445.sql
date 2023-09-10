/* Formatted on 8/15/2023 4:10:58 PM (QP5 v5.371) */
DECLARE
    v_message         VARCHAR2 (300)
        := 'Úׂםׂם ַב״ַבָ / Üֹ ַּדÚֹ ַבַָֹֽ Êָֽׁ ָßד זÊÝםֿßד ֳָה ַ׃ד ַבד׃Ê־ֿד ַב־ַױ ָßד וז : ';
    v_message2        VARCHAR2 (300)
        := 'זַבׁÞד ַב׃ׁם וז *Aa123456 זבבֿ־זב Úבל ָזַָֹ ַב־ֿדַÊ ַב׀ַÊםֹ ַבֳßַֿםדםֹ ֵײÛ״ ַבַָׁ״ ַבÊַבם: https://banner.bu.edu.sa/';
    v_msg             VARCHAR2 (1000)
        := 'Úׂםׂם ַב״ַבָÜ / Üֹ ַּדÚֹ ַבַָֹֽ Êָֽׁ ָßד זÊÝםֿßד ֳָה ַ׃ד ַבד׃Ê־ֿד ַב־ַױ ָßד וז  445****
זßבדֹ ַבדׁזׁ ום ****
זםדßה ַבֿ־זב Úבל ָזַָֹ ַב־ֿדַÊ ַב׀ַÊםֹ ַבֳßַֿםדםֹ Úָׁ ַבַָׁ״ ַבÊַבם  https://banner.bu.edu.sa  
Úבדַנ ֳָה ßבדֹ ַבדׁזׁ דִÞÊֹ¡ Ê׃Ê־ֿד בדֹׁ זַֹֽֿ ÝÞ״¡ זםָּ Úבםßד ÊÛםםׁוַ ָÚֿ ֳזב Úדבםֹ ֿ־זב.

ßדַ םדßהß ַבַה׃ַָֽ דה ַבַּדÚֹ דה ַםÞזהֹ ַב־ֿדַÊ ַבֵבßÊׁזהםֹ ז״בָ ֵ־בֱַ ַב״ׁÝ ָ׃ָָ ַבַה׃ַָֽ דה ַבַּדÚֹ ֳז ַבÊֽזםב ֵבל ַּדÚֹ ֳ־ׁל זַ־Êםַׁ ַב׃ָָ "ַה׃ַָֽ דה ַבַּדÚֹ". 
 
ז ׃םÊד ֵװÚַׁßד ָׁ׃ַבֹ הױםֹ Úהֿ ַבַהÊוֱַ דה Ê׃ּםב ּֿזבß ַבַֿׁ׃ם.';
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
               ' Úׂםׂם ַב״ַבָÜ / Üֹ ַּדÚֹ ַבַָֹֽ Êָֽׁ ָßד זÊÝםֿßד ֳָה ַ׃ד ַבד׃Ê־ֿד ַב־ַױ ָßד וז '
            || rec.std_id
            || ' 
 זßבדֹ ַבדׁזׁ ום '
            || rec.std_password
            || '
זםדßה ַבֿ־זב Úבל ָזַָֹ ַב־ֿדַÊ ַב׀ַÊםֹ ַבֳßַֿםדםֹ Úָׁ ַבַָׁ״ ַבÊַבם  https://banner.bu.edu.sa  
Úבדַנ ֳָה ßבדֹ ַבדׁזׁ דִÞÊֹ¡ Ê׃Ê־ֿד בדֹׁ זַֹֽֿ ÝÞ״¡ זםָּ Úבםßד ÊÛםםׁוַ ָÚֿ ֳזב Úדבםֹ ֿ־זב.
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
                               ' Úׂםׂם ַב״ַבָÜ / Üֹ ַּדÚֹ ַבַָֹֽ Êָֽׁ ָßד זÊÝםֿßד ֳָה ַ׃ד ַבד׃Ê־ֿד ַב־ַױ ָßד וז '
                            || rec.std_id
                            || ' 
 זßבדֹ ַבדׁזׁ ום '
                            || rec.std_password
                            || '
זםדßה ַבֿ־זב Úבל ָזַָֹ ַב־ֿדַÊ ַב׀ַÊםֹ ַבֳßַֿםדםֹ Úָׁ ַבַָׁ״ ַבÊַבם  https://banner.bu.edu.sa  
Úבדַנ ֳָה ßבדֹ ַבדׁזׁ דִÞÊֹ¡ Ê׃Ê־ֿד בדֹׁ זַֹֽֿ ÝÞ״¡ זםָּ Úבםßד ÊÛםםׁוַ ָÚֿ ֳזב Úדבםֹ ֿ־זב.

ßדַ םדßהß ַבַה׃ַָֽ דה ַבַּדÚֹ דה ַםÞזהֹ ַב־ֿדַÊ ַבֵבßÊׁזהםֹ ז״בָ ֵ־בֱַ ַב״ׁÝ ָ׃ָָ ַבַה׃ַָֽ דה ַבַּדÚֹ ֳז ַבÊֽזםב ֵבל ַּדÚֹ ֳ־ׁל זַ־Êםַׁ ַב׃ָָ "ַה׃ַָֽ דה ַבַּדÚֹ". 
 
ז ׃םÊד ֵװÚַׁßד ָׁ׃ַבֹ הױםֹ Úהֿ ַבַהÊוֱַ דה Ê׃ּםב ּֿזבß ַבַֿׁ׃ם.',
                            '1445 New Students',
                            v_reply_code,
                            SYSDATE,
                            'SAISUSR');

        COMMIT;
    END LOOP;
END;