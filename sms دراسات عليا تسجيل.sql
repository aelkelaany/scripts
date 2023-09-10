/* Formatted on 8/24/2023 1:34:10 PM (QP5 v5.371) */
DECLARE
    CURSOR crs_accepted_students IS
        SELECT DISTINCT spriden_pidm               "Pidm",
                        (SELECT sprtele_intl_access
                           FROM sprtele
                          WHERE     sprtele_pidm = sgbstdn_pidm
                                AND sprtele_tele_code = 'MO'
                                AND ROWNUM = 1)    "Mobile NO"
          FROM sgbstdn x, stvstst, spriden d
         WHERE     sgbstdn_pidm = spriden_pidm
               AND spriden_change_ind IS NULL
               AND sgbstdn_term_code_eff =
                   (SELECT MAX (sgbstdn_term_code_eff)
                      FROM sgbstdn d
                     WHERE d.sgbstdn_pidm = x.sgbstdn_pidm)
               AND sgbstdn_stst_code = stvstst_code
               AND stvstst_code IN ('AS')
               /*exclude Buljorashi*/
               AND SGBSTDN_coll_code_1 = '17'

               AND EXISTS
                       (SELECT '1'
                          FROM SFBRGRP
                         WHERE     SFBRGRP_PIDM = x.sgbstdn_pidm
                               AND SFBRGRP_RGRP_CODE = 'MA2'
                               AND SFBRGRP_TERM_CODE = '144510')
               --AND 'a' = 'b'
        UNION
        SELECT 123, '0568134765' FROM DUAL;

    v_message         VARCHAR2 (300)
        := '
⁄“Ì“Ì «·ÿ«·»/«·ÿ«·»…
  Êœ Ã«„⁄… «·»«Õ… ≈Õ«ÿ ﬂ„ »› Õ  ”ÃÌ· «·„ﬁ——«  «·œ—«”Ì… ·»—«„Ã «·„«Ã” Ì— ··›’· «·œ—«”Ì «·√Ê· „‰ «·⁄«„ «·Ã«„⁄Ì 1445Â‹ Œ·«· «·› —… „‰ «·Œ„Ì” 1445/2/24 Â‹ ÊÕ Ï «·√Õœ 1445/2/11 Â‹° Ê–·ﬂ ⁄»— »Ê«»… Ã«„⁄ Ì.';

    v_reply_code      VARCHAR2 (2);
    v_reply_messege   VARCHAR2 (200);
BEGIN
    FOR r IN crs_accepted_students
    LOOP
        bu_apps.p_send_sms ('0' || r."Mobile NO",
                            v_message,
                            v_reply_code,
                            v_reply_messege);

        INSERT INTO bu_apps.log_sms (student_pidm,
                                     mobile_no,
                                     MESSAGE,
                                     message_justification,
                                     message_status,
                                     activity_date,
                                     user_id)
             VALUES (r."Pidm",
                     r."Mobile NO",
                     v_message,
                     'PG Reg 1445102',
                     v_reply_code,
                     SYSDATE,
                     'SAISUSR');

        DBMS_OUTPUT.put_line (v_reply_code || '----' || r."Mobile NO");


        COMMIT;
    END LOOP;
END;
/
