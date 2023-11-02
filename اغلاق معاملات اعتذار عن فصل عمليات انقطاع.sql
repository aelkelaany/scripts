/* Formatted on 10/2/2023 10:40:46 AM (QP5 v5.371) */
SELECT *
  FROM request_master
 WHERE REQUEST_STATUS = 'P' AND object_code = 'WF_WITHDRAW_TERM';





DECLARE
    CURSOR get_req IS
          SELECT MAX (f.SEQUENCE_NO) seq_no, m.request_no, REQUESTER_PIDM
            FROM request_master m, wf_request_flow f
           WHERE     m.request_no = f.request_no
                 AND object_code = 'WF_WITHDRAW_TERM'
                 AND m.request_status = 'P'
                            AND f.SEQUENCE_NO > 1
                 --             AND f.FLOW_SEQ = 2
                 AND f.ACTION_CODE IS NULL
                 --and m.request_no=523971
        GROUP BY m.request_no, REQUESTER_PIDM;

    i_initiator_pidm   NUMBER (6);
BEGIN
    FOR i IN get_req
    LOOP
        i_initiator_pidm := i.REQUESTER_PIDM;
/* from 2 to 3  */
        IF i.seq_no = 2
        THEN
            UPDATE wf_request_flow
               SET USER_PIDM = 0,
                   ACTION_CODE = 'AUTO_APPROVE',
                   ACTIVITY_DATE = SYSDATE,
                   USER_ID = USER
             WHERE     REQUEST_NO = i.request_no
                   AND SEQUENCE_NO = 2
                   AND FLOW_SEQ = 2;

            INSERT INTO wf_request_flow (REQUEST_NO,
                                         SEQUENCE_NO,
                                         FLOW_SEQ,
                                         ROLE_CODE,
                                         USER_PIDM,
                                         ACTION_CODE,
                                         NOTES,
                                         ACTIVITY_DATE,
                                         USER_ID)
                 VALUES (i.request_no,
                         3,
                         3,
                         'RO_COLLEGE_DEAN',
                         '0',
                         'AUTO_FINAL_APPROVE',
                         NULL,
                         SYSDATE,
                         USER);
        ELSE
            UPDATE wf_request_flow
               SET USER_PIDM = 0,
                   ACTION_CODE = 'AUTO_FINAL_APPROVE',
                   ACTIVITY_DATE = SYSDATE,
                   USER_ID = USER
             WHERE     REQUEST_NO = i.request_no
                   AND SEQUENCE_NO = 3
                   AND FLOW_SEQ = 3;
        END IF;

        DBMS_OUTPUT.put_line (i.request_no);


        DECLARE
            v_reply_code      VARCHAR2 (5);
            v_reply_message   VARCHAR2 (500);
        BEGIN
            p_update_student_status (
                i_initiator_pidm,
                f_get_param ('WORKFLOW', 'CURRENT_TERM', 1),
                'ук',
                'WORKFLOW',
                v_reply_code,
                v_reply_message);

            IF v_reply_code = '00'
            THEN
                p_update_registration_status (
                    i_initiator_pidm,
                    f_get_param ('WORKFLOW', 'CURRENT_TERM', 1),
                    'к',
                    v_reply_code,
                    v_reply_message);

                IF v_reply_code = '00'
                THEN
                    p_update_student_status (
                        i_initiator_pidm,
                        f_get_param ('WORKFLOW', 'NEXT_TERM', 1),
                        'AS',
                        'WORKFLOW',
                        v_reply_code,
                        v_reply_message);
                END IF;
            END IF;
        END;

update request_master 
set REQUEST_STATUS='C' ,ACTIVITY_DATE=sysdate ,USER_ID=user
where 
request_no= i.request_no ;

        i_initiator_pidm := 0;
    END LOOP;
END;



