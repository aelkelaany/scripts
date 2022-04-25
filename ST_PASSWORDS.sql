/* Formatted on 10/11/2021 13:51:32 (QP5 v5.371) */
SELECT ROWID,
       USER_ID,
       USER_PWD,
       STATUS,
       SEQ_ID
  FROM BU_APPS.GINUCRD G
 WHERE     SEQ_ID = (SELECT MAX (SEQ_ID)
                       FROM GINUCRD
                      WHERE USER_ID = G.USER_ID)
       AND user_id = '439001148';



------

SELECT ROWID,
       USER_ID,
       USER_PWD,
       STATUS,
       SEQ_ID
  FROM BU_APPS.GINUCRD G
 WHERE     SEQ_ID = (SELECT MAX (SEQ_ID)
                       FROM GINUCRD
                      WHERE USER_ID = G.USER_ID)
       --and substr(USER_ID,0,3)='442'
       AND USER_ID IN
               (SELECT F_GET_STD_ID (SG.sgbstdn_pidm)
                  FROM SGBSTDN SG
                 WHERE     SGBSTDN_TERM_CODE_EFF =
                           (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                              FROM SGBSTDN
                             WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                       AND SGBSTDN_STST_CODE IN ('AS')
                       AND SGBSTDN_DEGC_CODE_1 IN ('ох')
                       -- AND SGBSTDN_STYP_CODE IN ('Ц')
                       AND SGBSTDN_LEVL_CODE = 'ох'
                       AND NOT EXISTS
                               (SELECT '1'
                                  FROM spriden
                                 WHERE     spriden_pidm = SG.sgbstdn_pidm
                                       AND SUBSTR (spriden_id, 1, 3) = '443'));
                                       
                                       
                                       
 STUDENT_EMAIL_PASSWORD
 
 SEC_HOLD_STD_CHANGE_PIN
 
 LOG_SUCCESS_LOGIN
 
 ---------------
 
 SELECT student_pidm,
       student_id,
       SEQUENCE_NO,
       STUDENT_PIN,
       ACTIVITY_DATE,
       unhashed_pin,
       LENGTH (unhashed_pin) len
  FROM (SELECT student_pidm,
               spriden_id student_id,
               SEQUENCE_NO,
               STUDENT_PIN,
               ACTIVITY_DATE,
               data_encryption.decrypt (STUDENT_PIN || '',
                                        'h9MI2zwWy3gF22v5')
                  unhashed_pin
          FROM log_success_login l1, spriden
         WHERE     spriden_pidm = l1.student_pidm
               AND spriden_change_ind IS NULL
               AND SEQUENCE_NO = (SELECT MAX (SEQUENCE_NO)
                                    FROM log_success_login l2
                                   WHERE l2.student_pidm = l1.student_pidm))
WHERE STUDENT_PIDM  = F_GET_PIDM('443047492')
;

 

 