/* Formatted on 9/12/2019 10:13:42 AM (QP5 v5.227.12220.39754) */
DECLARE
   v_message         VARCHAR2 (3000)
      := 'íÚáä ãÑßÒ ÇááÛÉ ÇáÅäÌáíÒíÉ Úä ÅŞÇãÉ ÇÎÊÈÇÑ ÊÍÏíÏ ãÓÊæì ááÅÚİÇÁ ãä ÏÑÇÓÉ ãŞÑÑÇÊ ÇááÛÉ ÇáÅäÌáíÒíÉ ááØáÇÈ æÇáØÇáÈÇÊ ÇáãŞÈæáíä æÇáãÚÏáÉ ŞÈæáÇÊåã ãÄÎÑÇğ İŞØ¡ æİŞ ÇáÊÇáí:
íæã ÇáÇÎÊÈÇÑ: ÇáËáÇËÇÁ 5 ÓÈÊãÈÑ 2023
æŞÊ ÇáÇÎÊÈÇÑ: ÇáÏÎæá ãÊÇÍ İí Ãí æŞÊ Èíä 11 ÕÈÇÍÇğ æ 1 ÙåÑğÇ
ãŞÑ ÇáÇÎÊÈÇÑ ááØáÇÈ: ÇáãÏíäÉ ÇáÌÇãÚíÉ ÈÇáÚŞíŞ - ãÈäì 4 - ŞÇÚÉ G409
ãŞÑ ÇáÇÎÊÈÇÑ ááØÇáÈÇÊ: ÇáãÌãÚ ÇáÃßÇÏíãí ááØÇáÈÇÊ ÈÈåÑ - ãÈäì ÇáİÕæá ÇáÏÑÇÓíÉ - ŞÇÚÉ FF13';
    
   v_reply_code      VARCHAR2 (2);
   v_reply_messege   VARCHAR2 (150);
   cursor get_data is select col01 phoneNumber from BU_DEV.TMP_TBL_KILANY2 where col01 is not null and nvl(col02,'c')!='00'
   union 
   select '0568134765' from dual  ;
BEGIN
for rec in get_data loop 
   bu_apps.p_send_sms (rec.phoneNumber,
                       v_message ,
                       v_reply_code,
                       v_reply_messege);
                       update BU_DEV.TMP_TBL_KILANY2 set col02=v_reply_code where col01=rec.phoneNumber;
                       commit ; 
                       
          DBMS_OUTPUT.put_line ('Phone  :' ||rec.phoneNumber|| 'replyCode : '||v_reply_code ||'replyMsg : '||v_reply_messege);    
          end loop ;            
END;