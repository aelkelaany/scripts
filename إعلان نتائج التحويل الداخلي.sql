/* Formatted on 12/08/2021 13:31:21 (QP5 v5.227.12220.39754) */
-- approval  ,

DECLARE
   l_cnt   NUMBER := 0;

   CURSOR get_requests
   IS
      SELECT a.request_no
        FROM request_master a
       WHERE     REQUEST_STATUS = 'P'
             AND OBJECT_CODE = 'WF_TRANSFER'
             AND EXISTS
                    (SELECT '1'
                       FROM wf_request_flow
                      WHERE     request_no = a.request_no
                            AND ROLE_CODE = 'RO_COLLEGE_DEAN'
                            AND ACTION_CODE = 'APPROVE');

BEGIN
   FOR rec IN get_requests
   LOOP
      UPDATE wf_request_flow
         SET ACTION_CODE = 'FINAL_APPROVE',
             user_pidm = '0',
             NOTES = ' „  «·„Ê«›ﬁ… ⁄·Ï ÿ·» «· ÕÊÌ· ',
             ACTIVITY_DATE = SYSDATE,
             user_id = USER
       WHERE     request_no = rec.request_no
             AND ROLE_CODE = 'RO_DAR_VICE_DEAN'
             AND ACTION_CODE IS NULL;

      UPDATE request_master
         SET REQUEST_STATUS = 'C', ACTIVITY_DATE = SYSDATE, user_id = USER
       WHERE request_no = rec.request_no AND REQUEST_STATUS = 'P';

      l_cnt := l_cnt + 1;
   END LOOP;

   DBMS_OUTPUT.put_line ('Final Approved Requests ' || l_cnt);
END;

------------rejection

DECLARE
   l_cnt   NUMBER := 0;

   CURSOR get_requests
   IS
      SELECT a.request_no
        FROM request_master a
       WHERE     REQUEST_STATUS = 'P'
             AND OBJECT_CODE = 'WF_TRANSFER'
             AND EXISTS
                    (SELECT '1'
                       FROM wf_request_flow
                      WHERE     request_no = a.request_no
                            AND ROLE_CODE = 'RO_COLLEGE_DEAN'
                            AND ACTION_CODE = 'APPROVE_07');

BEGIN
   FOR rec IN get_requests
   LOOP
      UPDATE wf_request_flow
         SET ACTION_CODE = 'FINAL_REJECT',
             user_pidm = '0',
             NOTES =
                '‰⁄ –— ⁄‰ ﬁ»Ê· ÿ·» «· ÕÊÌ· ·⁄œÊ„ ÊÃÊœ „ﬁ«⁄œ ‘«€—…',
             ACTIVITY_DATE = SYSDATE,
             user_id = USER
       WHERE     request_no = rec.request_no
             AND ROLE_CODE = 'RO_DAR_VICE_DEAN'
             AND ACTION_CODE IS NULL;

      UPDATE request_master
         SET REQUEST_STATUS = 'R', ACTIVITY_DATE = SYSDATE, user_id = USER
       WHERE request_no = rec.request_no AND REQUEST_STATUS = 'P';

      l_cnt := l_cnt + 1;
   END LOOP;

   DBMS_OUTPUT.put_line ('Final Approved Requests ' || l_cnt);
END;