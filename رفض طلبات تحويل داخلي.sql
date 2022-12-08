/* Formatted on 8/18/2022 2:17:28 PM (QP5 v5.371) */
DECLARE
    CURSOR get_req IS
        SELECT DISTINCT W.request_no
          FROM request_master m, wf_request_flow f, REQUEST_DETAILS W
         WHERE     m.request_no = f.request_no
               AND object_code = 'WF_TRANSFER'
               AND m.request_status = 'P'
               AND f.SEQUENCE_NO = (SELECT MAX (SEQUENCE_NO)
                                      FROM wf_request_flow D
                                     WHERE d.request_no = m.request_no)
               AND f.SEQUENCE_NO = 2
               AND f.FLOW_SEQ = (SELECT MAX (FLOW_SEQ)
                                   FROM wf_request_flow D
                                  WHERE d.request_no = m.request_no)
               AND f.FLOW_SEQ = 2
               AND f.ACTION_CODE IS NULL
               AND m.REQUEST_NO = W.REQUEST_NO
               AND W.SEQUENCE_NO = 1
               AND W.ITEM_CODE = 'TRANSFER_COLLEGE'
               AND EXISTS
                       (SELECT '1'
                          FROM request_details d
                         WHERE     d.request_no = m.request_no
                               AND d.sequence_no = 1
                               AND d.item_code = 'TERM'
                               AND D.ITEM_VALUE = '144340')
               AND EXISTS
                       (SELECT '2'
                          FROM request_details d
                         WHERE     d.request_no = m.request_no
                               AND d.sequence_no = 1
                               AND d.item_code = 'TRANSFER_COLLEGE'
                               AND D.ITEM_VALUE IN ('17',
                                                    '18',
                                                    '19',
                                                    '42'))
           -- AND M.REQUEST_NO = '382757'
               AND ROWNUM < 110;

    CNT_FLOW     NUMBER (3);
    CNT_MASTER   NUMBER (3);
BEGIN
    FOR i IN get_req
    LOOP
        UPDATE wf_request_flow
           SET USER_PIDM = 67800,
               ACTION_CODE = 'FINAL_REJECT',
               ACTIVITY_DATE = SYSDATE,
               USER_ID = USER,
               ROLE_CODE = 'RO_DAR_VICE_DEAN',
               NOTES =
                   'ÊÚÊÐÑ ÇáÌÇãÚÉ Úä ÞÈæá ØáÈ ÇáÊÍæíá' ,SEQUENCE_NO = 4 ,FLOW_SEQ = 4
         WHERE     REQUEST_NO = i.request_no
               AND SEQUENCE_NO = 2
               AND FLOW_SEQ = 2
               AND role_code = 'RO_DEPT_MANAGER';

        CNT_FLOW := SQL%ROWCOUNT;

        UPDATE REQUEST_MASTER
           SET REQUEST_STATUS = 'R',ACTIVITY_DATE=SYSDATE,USER_ID=USER
         WHERE REQUEST_NO = i.request_no;

        CNT_MASTER := SQL%ROWCOUNT;

        DBMS_OUTPUT.put_line (
               i.request_no
            || 'FLOW>>'
            || CNT_FLOW
            || ' *** MASTER'
            || CNT_MASTER);
    END LOOP;
END;