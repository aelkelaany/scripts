/* Formatted on 8/30/2022 1:11:54 PM (QP5 v5.371) */
UPDATE request_master
   SET REQUEST_STATUS = 'P'
 WHERE REQUEST_NO IN
           (SELECT m.REQUEST_NO
              FROM BU_APPS.REQUEST_MASTER M
             WHERE     OBJECT_CODE = 'WF_INTERNAL_EQUATION'
                   AND REQUEST_STATUS = 'R'
                   --
                   AND EXISTS
                           (SELECT '1'
                              FROM wf_request_flow
                             WHERE     REQUEST_NO = m.REQUEST_NO
                                   AND ROLE_CODE = 'RO_DAR_REGISTRATION'
                                   AND user_pidm = F_GET_PIDM ('947')
                                   AND ACTION_CODE = 'FINAL_REJECT'));

      --      select * from wf_request_flow 

UPDATE wf_request_flow
   SET user_pidm = f_get_pidm ('2521'), ACTION_CODE = ''
 WHERE     ROLE_CODE = 'RO_DAR_REGISTRATION'
       AND user_pidm = F_GET_PIDM ('947')
       AND ACTION_CODE = 'FINAL_REJECT'
       AND REQUEST_NO IN
               (SELECT m.REQUEST_NO
                  FROM BU_APPS.REQUEST_MASTER m
                 WHERE     OBJECT_CODE = 'WF_INTERNAL_EQUATION'
                       AND REQUEST_STATUS = 'P'
                       AND EXISTS
                               (SELECT '1'
                                  FROM wf_request_flow
                                 WHERE     REQUEST_NO = m.REQUEST_NO
                                       AND ROLE_CODE = 'RO_DAR_REGISTRATION'
                                       AND user_pidm = F_GET_PIDM ('947')
                                       AND ACTION_CODE = 'FINAL_REJECT'));