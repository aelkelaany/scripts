exec p_update_std_status (f_get_pidm('438000906'),'144020','AS','Banner');
DECLARE
   CURSOR get_req
   IS
      /*SELECT distinct m.request_no
        FROM request_master m, wf_request_flow f
       WHERE     m.request_no = f.request_no
             AND object_code ='WF_REACTIVATE'
             AND m.request_status = 'P'
             and F.FLOW_SEQ=2
              and M.REQUESTER_PIDM in(SELECT DISTINCT COL02
        FROM bu_dev.tmp_tbl03  );*/
        SELECT distinct m.request_no
        FROM request_master m, wf_request_flow f
       WHERE     m.request_no = f.request_no
             AND object_code ='WF_REACTIVATE'
             AND m.request_status = 'P'
             and F.FLOW_SEQ=2
              and M.REQUESTER_PIDM in(select f_get_pidm('438000906') from dual ) ;
            

BEGIN
   FOR i IN get_req
   LOOP
   begin
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
                   
                   update request_master set REQUEST_STATUS='C' ,ACTIVITY_DATE=sysdate
                   where request_no=i.request_no;

      DBMS_OUTPUT.put_line (i.request_no);
      exception 
      when others then 
      DBMS_OUTPUT.put_line (i.request_no||'>>>>'||sqlerrm);
      end;
   END LOOP;
END;



exec p_update_std_status (90472,'144030','AS','Banner');




 









SELECT 
   REQUEST_NO, REQUESTER_PIDM,   
    REQUEST_DATE, ACTIVITY_DATE, 
   USER_ID
FROM BU_APPS.REQUEST_MASTER
Where
OBJECT_CODE='WF_REACTIVATE'
AND  REQUEST_STATUS='C'
AND NOT EXISTS (SELECT '1'
                      FROM SGBSTDN SG 
                     WHERE     SGBSTDN_TERM_CODE_EFF =
                                  (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                     FROM SGBSTDN
                                    WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                           AND SGBSTDN_STST_CODE IN ('AS')
                           AND SG.SGBSTDN_PIDM=REQUESTER_PIDM ) ;