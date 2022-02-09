 DECLARE 
 CURSOR GET_DATA IS 
 
 SELECT m.request_no
        FROM request_master m, wf_request_flow f ,REQUEST_DETAILS D
       WHERE     m.request_no = f.request_no
       AND  m.request_no = D.request_no
       AND D.ITEM_CODE='WITHDRAW_TYPE'
       AND ITEM_VALUE='„Œ'
       AND D.SEQUENCE_NO=1
             AND object_code ='WF_UN_WITHDRAW'
             AND m.request_status = 'P'
             AND f.SEQUENCE_NO = 5
             AND f.FLOW_SEQ = 5
             AND f.ACTION_CODE ='HOLD'
             AND USER_PIDM=0 ;
             BEGIN
              FOR i IN GET_DATA
   LOOP
      UPDATE wf_request_flow
         SET USER_PIDM = 216492,
             --ACTION_CODE = 'HOLD',
             ACTIVITY_DATE = SYSDATE,
             USER_ID = USER
       WHERE REQUEST_NO = i.request_no AND SEQUENCE_NO = 5 AND FLOW_SEQ = 5;
       
             DBMS_OUTPUT.put_line (i.request_no);
             END LOOP ; 
             END ;
             