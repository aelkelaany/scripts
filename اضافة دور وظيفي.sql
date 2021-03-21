/* Formatted on 12/17/2019 9:58:19 AM (QP5 v5.227.12220.39754) */
-- DEFINITION

INSERT INTO ROLE_DEFINITION (ROLE_CODE,
                             ROLE_DECRIPTION,
                             ACTIVITY_DATE,
                             USER_ID)
     VALUES ('RO_COLLEGE_DEAN_GA',
             '⁄„Ìœ «·ﬂ·Ì…',
             SYSDATE,
             'SAISUSR');

-- WORKFLOW PATH

UPDATE WF_FLOW
   SET ROLE_CODE = 'RO_COLLEGE_DEAN_GA'
 WHERE OBJECT_CODE = 'WF_GRADE_APPROVAL' AND FLOW_SEQ = 4;

-- INSERT USERS TO NEW ROLE

INSERT INTO ROLE_USERS (ROLE_CODE,
                        USER_PIDM,
                        ACTIVITY_DATE,
                        USERID,
                        ACTIVE,
                        USER_MAIL,
                        SEND_EMAIL_FLAG)
   SELECT 'RO_COLLEGE_DEAN_GA',
          USER_PIDM,
          SYSDATE,
          'SAISUSR',
          'Y',
          NULL,
          'N'
     FROM ROLE_USERS
    WHERE ROLE_CODE = 'RO_COLLEGE_DEAN';

    -- UPDATE CURRENT REQUESTS

UPDATE wf_request_flow A 
   SET A.ROLE_CODE = 'RO_COLLEGE_DEAN_GA'
 WHERE     A.FLOW_SEQ = 4
       AND EXISTS
              (SELECT 'Y'
                 FROM REQUEST_MASTER
                WHERE     OBJECT_CODE = 'WF_GRADE_APPROVAL'
                      AND REQUEST_STATUS = 'P'
                      AND REQUEST_NO=A.REQUEST_NO);
                      
                    