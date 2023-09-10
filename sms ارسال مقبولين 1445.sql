/* Formatted on 8/16/2023 9:22:51 AM (QP5 v5.371) */
DECLARE
    v_reply_code      VARCHAR2 (2);
    v_reply_messege   VARCHAR2 (200);

    CURSOR get_data IS
        SELECT pidm,
               (SELECT sprtele_intl_access
                  FROM sprtele
                 WHERE     sprtele_pidm = pidm
                       AND sprtele_tele_code = 'MO'
                       AND ROWNUM = 1)    Mobile_NO,
               "AccountPassword"          std_password,
               "SamAccountName"           std_id
          FROM new_students_email x
         WHERE     BATCH_NO = 12
               AND EXISTS
                       (SELECT '1'
                          FROM sgbstdn
                         WHERE     SGBSTDN_PIDM = pidm
                               AND SGBSTDN_TERM_CODE_EFF = '144510'
                               AND SGBSTDN_STST_CODE = 'AS')
               AND  EXISTS
                       (SELECT '1'
                          FROM log_success_login
                         WHERE STUDENT_PIDM = pidm)
               AND NOT EXISTS
                       (SELECT '1'
                          FROM BU_DEV.TMP_TBL_KILANY2
                         WHERE col01 = '00' AND col02 = pidm)
                         
                         and not exists (select '1'   FROM BU_DEV.TMP_TBL_KILANY2
                         WHERE col01 = '00' AND col02 = pidm
                         and col03='MSG4' )
                         
                         ;
BEGIN
    FOR rec IN get_data
    LOOP
        bu_apps.p_send_sms (
            rec.Mobile_NO,
               ' ⁄“Ì“Ì «·ÿ«·»‹ / ‹… Ã«„⁄… «·»«Õ…  —Õ» »ﬂ„ Ê ›Ìœﬂ„ »√‰ «”„ «·„” Œœ„ «·Œ«’ »ﬂ„ ÂÊ '
            || rec.std_id
            || '
ÊÌ„ﬂ‰ «·œŒÊ· ⁄·Ï »Ê«»… «·Œœ„«  «·–« Ì… «·√ﬂ«œÌ„Ì… ⁄»— «·—«»ÿ «· «·Ì  https://banner.bu.edu.sa  
»«” Œœ«„ ﬂ·„… «·„—Ê— «· Ì ﬁ„ „ »≈⁄«œ… ÷»ÿÂ«. 

ﬂ„« Ì„ﬂ‰ﬂ «·«‰”Õ«» „‰ «·Ã«„⁄… „‰ «ÌﬁÊ‰… «·Œœ„«  «·≈·ﬂ —Ê‰Ì… Êÿ·» ≈Œ·«¡ «·ÿ—› »”»» «·«‰”Õ«» „‰ «·Ã«„⁄… √Ê «· ÕÊÌ· ≈·Ï Ã«„⁄… √Œ—Ï Ê«Œ Ì«— «·”»» "«‰”Õ«» „‰ «·Ã«„⁄…". 
 
Ê ”Ì „ ≈‘⁄«—ﬂ„ »—”«·… ‰’Ì… ⁄‰œ «·«‰ Â«¡ „‰  ”ÃÌ· ÃœÊ·ﬂ «·œ—«”Ì.',
            v_reply_code,
            v_reply_messege);

        INSERT INTO BU_DEV.TMP_TBL_KILANY2 (col01, col02,col03)
             VALUES (v_reply_code, rec.pidm,'MSG2');

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
                           ' ⁄“Ì“Ì «·ÿ«·»‹ / ‹… Ã«„⁄… «·»«Õ…  —Õ» »ﬂ„ Ê ›Ìœﬂ„ »√‰ «”„ «·„” Œœ„ «·Œ«’ »ﬂ„ ÂÊ '
            || rec.std_id
            || '
ÊÌ„ﬂ‰ «·œŒÊ· ⁄·Ï »Ê«»… «·Œœ„«  «·–« Ì… «·√ﬂ«œÌ„Ì… ⁄»— «·—«»ÿ «· «·Ì  https://banner.bu.edu.sa  
»«” Œœ«„ ﬂ·„… «·„—Ê— «· Ì ﬁ„ „ »≈⁄«œ… ÷»ÿÂ«. 

ﬂ„« Ì„ﬂ‰ﬂ «·«‰”Õ«» „‰ «·Ã«„⁄… „‰ «ÌﬁÊ‰… «·Œœ„«  «·≈·ﬂ —Ê‰Ì… Êÿ·» ≈Œ·«¡ «·ÿ—› »”»» «·«‰”Õ«» „‰ «·Ã«„⁄… √Ê «· ÕÊÌ· ≈·Ï Ã«„⁄… √Œ—Ï Ê«Œ Ì«— «·”»» "«‰”Õ«» „‰ «·Ã«„⁄…". 
 
Ê ”Ì „ ≈‘⁄«—ﬂ„ »—”«·… ‰’Ì… ⁄‰œ «·«‰ Â«¡ „‰  ”ÃÌ· ÃœÊ·ﬂ «·œ—«”Ì.',
                            '1445 New Students2',
                            v_reply_code,
                            SYSDATE,
                            'SAISUSR');

        COMMIT;
    END LOOP;
END;