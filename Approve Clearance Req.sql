/* from 2 to 3  */
DECLARE
   CURSOR get_req
   IS
      SELECT distinct m.request_no
        FROM request_master m, wf_request_flow f
       WHERE     m.request_no = f.request_no
             AND object_code = 'WF_CLEARANCE'
             AND m.request_status = 'P'
             AND f.SEQUENCE_NO = 2
             AND f.FLOW_SEQ = 2
             AND f.ACTION_CODE IS NULL;

BEGIN
   FOR i IN get_req
   LOOP
      UPDATE wf_request_flow
         SET USER_PIDM = 0,
             ACTION_CODE = 'APPROVE',
             ACTIVITY_DATE = SYSDATE,
             USER_ID = USER
       WHERE REQUEST_NO = i.request_no AND SEQUENCE_NO = 2 AND FLOW_SEQ = 2;

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
                   'RO_DAR_AUDITOR',
                   NULL,
                   NULL,
                   NULL,
                   SYSDATE,
                   USER);

      DBMS_OUTPUT.put_line (i.request_no);
   END LOOP;
END;


/* Formatted on 1/13/2020 11:22:44 AM (QP5 v5.227.12220.39754) */
DECLARE
   CURSOR get_req
   IS
      SELECT m.request_no
        FROM request_master m, wf_request_flow f
       WHERE     m.request_no = f.request_no
             AND object_code = 'WF_CLEARANCE'
             AND m.request_status = 'P'
             AND f.SEQUENCE_NO = 3
             AND f.FLOW_SEQ = 3
             AND f.ACTION_CODE IS NULL;

BEGIN
   FOR i IN get_req
   LOOP
      UPDATE wf_request_flow
         SET USER_PIDM = 0,
             ACTION_CODE = 'APPROVE',
             ACTIVITY_DATE = SYSDATE,
             USER_ID = USER
       WHERE REQUEST_NO = i.request_no AND SEQUENCE_NO = 3 AND FLOW_SEQ = 3;

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
                   4,
                   4,
                   'RO_DAR_FILES',
                   NULL,
                   NULL,
                   NULL,
                   SYSDATE,
                   USER);

      DBMS_OUTPUT.put_line (i.request_no);
   END LOOP;
END;

/* final  */
DECLARE
   CURSOR get_req
   IS
      SELECT distinct m.request_no
        FROM request_master m, wf_request_flow f
       WHERE     m.request_no = f.request_no
             AND object_code = 'WF_CLEARANCE'
             AND m.request_status = 'P'
             AND f.SEQUENCE_NO = 4
             AND f.FLOW_SEQ = 4
             AND f.ACTION_CODE IS NULL
             ;

BEGIN
   FOR i IN get_req
   LOOP
      UPDATE wf_request_flow
         SET USER_PIDM = 0,
             ACTION_CODE = 'FINAL_APPROVE',
             ACTIVITY_DATE = SYSDATE,
             USER_ID = USER
       WHERE REQUEST_NO = i.request_no AND SEQUENCE_NO = 4 AND FLOW_SEQ = 4;

update request_master 
set REQUEST_STATUS='C' ,ACTIVITY_DATE=sysdate ,USER_ID=user
where 
request_no= i.request_no ;


      DBMS_OUTPUT.put_line (i.request_no);
   END LOOP;
END;