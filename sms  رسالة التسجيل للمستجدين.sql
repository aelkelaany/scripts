/* Formatted on 8/17/2023 7:04:50 PM (QP5 v5.371) */
DECLARE
    v_reply_code      VARCHAR2 (2);
    v_reply_messege   VARCHAR2 (200);

    CURSOR get_data IS
        SELECT pidm,
               (SELECT sprtele_intl_access
                  FROM sprtele
                 WHERE     sprtele_pidm = pidm
                       AND sprtele_tele_code = 'MO'
                       AND ROWNUM = 1)    Mobile_NO
          FROM new_students_email x
         WHERE     BATCH_NO = 11
               AND EXISTS
                       (SELECT '1'
                          FROM sgbstdn
                         WHERE     SGBSTDN_PIDM = pidm
                               AND SGBSTDN_TERM_CODE_EFF = '144510'
                               AND SGBSTDN_STST_CODE = 'AS')
               AND EXISTS
                       (SELECT '1'
                          FROM sfrstcr
                         WHERE     sfrstcr_PIDM = pidm
                               AND sfrstcr_term_code = '144510'
                               AND sfrstcr_rsts_code IN ('RE', 'RW'))
                              -- and '1' ='2'
                              and exists (select '1' from GLBEXTR where GLBEXTR_APPLICATION='STUDENT' AND GLBEXTR_SELECTION='BLOCK_REG_1445102'
                              AND GLBEXTR_KEY=pidm )
                               union
                               select 123,'0568134765' from dual ;
                                
BEGIN
    FOR rec IN get_data
    LOOP
        bu_apps.p_send_sms (
            rec.Mobile_NO,
            '⁄“Ì“Ì «·ÿ«·»‹ / ‹… Ã«„⁄… «·»«Õ…  —Õ» »ﬂ„ Ê ›Ìœﬂ„ »√‰Â  „  ”ÃÌ· ÃœÊ·ﬂ «·œ—«”Ì ÊÌ„ﬂ‰ «·œŒÊ· ⁄·Ï »Ê«»… «·Œœ„«  «·–« Ì… «·√ﬂ«œÌ„Ì… ⁄»— «·—«»ÿ «· «·Ì  https://banner.bu.edu.sa  »«” Œœ«„ »Ì«‰«  «·œŒÊ· «·„—”·… ·ﬂ„ Ê«·«” ⁄·«„ ⁄‰ «·ÃœÊ· «·œ—«”Ì „‰ Œ·«· «ÌﬁÊ‰… "ÿ»«⁄… «·ÃœÊ· «·œ—«”Ì".',
            v_reply_code,
            v_reply_messege);

        INSERT INTO BU_DEV.TMP_TBL_KILANY2 (col01, col02, col03)
             VALUES (v_reply_code, rec.pidm, 'MSG3');

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
                            '⁄“Ì“Ì «·ÿ«·»‹ / ‹… Ã«„⁄… «·»«Õ…  —Õ» »ﬂ„ Ê ›Ìœﬂ„ »√‰Â  „  ”ÃÌ· ÃœÊ·ﬂ «·œ—«”Ì ÊÌ„ﬂ‰ «·œŒÊ· ⁄·Ï »Ê«»… «·Œœ„«  «·–« Ì… «·√ﬂ«œÌ„Ì… ⁄»— «·—«»ÿ «· «·Ì  https://banner.bu.edu.sa  »«” Œœ«„ »Ì«‰«  «·œŒÊ· «·„—”·… ·ﬂ„ Ê«·«” ⁄·«„ ⁄‰ «·ÃœÊ· «·œ—«”Ì „‰ Œ·«· «ÌﬁÊ‰… "ÿ»«⁄… «·ÃœÊ· «·œ—«”Ì".',
                            '1445 New Students Reg2',
                            v_reply_code,
                            SYSDATE,
                            'SAISUSR');

        COMMIT;
    END LOOP;
END;