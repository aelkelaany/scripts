/* Formatted on 1/29/2020 4:09:22 PM (QP5 v5.227.12220.39754) */
DECLARE
   CURSOR get_req
   IS
      SELECT DISTINCT m.request_no
        FROM request_master m, wf_request_flow f
       WHERE     m.request_no = f.request_no
             AND object_code = 'WF_ADDITIONAL_CHANCE'
             AND m.request_status = 'P'
             AND F.FLOW_SEQ = 2
             AND M.REQUESTER_PIDM IN
                    (SELECT DISTINCT COL02 FROM bu_dev.tmp_tbl03);

BEGIN
   FOR i IN get_req
   LOOP
      BEGIN
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
                       4,
                       4,
                       'RO_DAR_VICE_DEAN',
                       NULL,
                       NULL,
                       'ÊãÊ ÇáãæÇÝÞÉ Úáì ÇáØáÈ íÑÌì ãÑÇÌÚÉ ÇáãÑÔÏ ÇáÇßÇÏíãí áÊÓÌíá ÇáãÞÑÑÇÊ',
                       SYSDATE,
                       USER); 

        /* UPDATE wf_request_flow
            SET USER_PIDM = 0,
                ACTION_CODE = 'APPROVE',
                ACTIVITY_DATE = SYSDATE,
                USER_ID = USER,
                notes =
                   'ÊãÊ ÇáãæÇÝÞÉ Úáì ÇáØáÈ íÑÌì ãÑÇÌÚÉ ÇáãÑÔÏ ÇáÇßÇÏíãí áÊÓÌíá ÇáãÞÑÑÇÊ'
          WHERE     REQUEST_NO = i.request_no
                AND SEQUENCE_NO = 4
                AND FLOW_SEQ = 4;*/

         UPDATE request_master
            SET REQUEST_STATUS = 'C', ACTIVITY_DATE = SYSDATE
          WHERE request_no = i.request_no;

         DBMS_OUTPUT.put_line (i.request_no);
      EXCEPTION
         WHEN OTHERS
         THEN
            DBMS_OUTPUT.put_line (i.request_no || '>>>>' || SQLERRM);
      END;
   END LOOP;
END;