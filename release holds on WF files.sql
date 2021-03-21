 
UPDATE WF_REQUEST_FLOW
   SET ACTION_CODE = NULL,
       USER_PIDM = NULL,
       NOTES = NULL,
       ACTIVITY_DATE = NULL,
       USER_ID = NULL
 WHERE     REQUEST_NO IN
              (SELECT request_no
                 FROM request_master
                WHERE     object_code IN ('WF_CLEARANCE', 'WF_UN_WITHDRAW')
                      AND request_status = 'P')
       AND ACTION_CODE = 'HOLD'
       AND user_pidm IS NOT NULL
       AND ROLE_CODE = 'RO_DAR_FILES'