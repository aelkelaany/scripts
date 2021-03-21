 
DECLARE
   CURSOR WF_CUR
   IS
      SELECT REQUEST_NO, REQUESTER_PIDM
        FROM REQUEST_MASTER
       WHERE     OBJECT_CODE IN ('WF_UN_WITHDRAW')
             AND REQUEST_STATUS = 'P'
              
             ;

   L_SEX   CHAR;
   L_CNT   NUMBER;
BEGIN
   FOR REC IN WF_CUR
   LOOP
      UPDATE WF_REQUEST_FLOW
         SET ACTION_CODE = 'AUTO_APPROVE',
             ACTIVITY_DATE = SYSDATE,USER_PIDM=0,
             USER_ID = USER
       WHERE     ROLE_CODE IN
                    ('RO_STD_ACTIVITY',
                     'RO_STD_BOX',
                     'RO_STD_FOOD',
                     'RO_STD_SERVICES')
             AND ACTION_CODE IS NULL
             AND REQUEST_NO = REC.REQUEST_NO;

      SELECT SPBPERS_SEX
        INTO L_SEX
        FROM SPBPERS
       WHERE SPBPERS_PIDM = REC.REQUESTER_PIDM;

      IF L_SEX = 'F'
      THEN
         SELECT COUNT (ACTION_CODE)
           INTO L_CNT
           FROM WF_REQUEST_FLOW
          WHERE     REQUEST_NO = REC.REQUEST_NO
                AND ACTION_CODE = 'APPROVE'
                and SEQUENCE_NO=3;

         IF L_CNT = 3
         THEN
         begin
            INSERT INTO WF_REQUEST_FLOW (REQUEST_NO,
                                         SEQUENCE_NO,
                                         FLOW_SEQ,
                                         ROLE_CODE)
                 VALUES (REC.REQUEST_NO,
                         4,
                         4,
                         'RO_DAR_AUDITOR');
                         exception when dup_val_on_index then 
                         null; 
                         end;
         END IF;
      ELSE
         SELECT COUNT (ACTION_CODE)
           INTO L_CNT
           FROM WF_REQUEST_FLOW
          WHERE     REQUEST_NO = REC.REQUEST_NO
                AND ACTION_CODE = 'APPROVE'
                and SEQUENCE_NO=3;
-- male student 
         IF L_CNT = 2
         THEN
            INSERT INTO WF_REQUEST_FLOW (REQUEST_NO,
                                         SEQUENCE_NO,
                                         FLOW_SEQ,
                                         ROLE_CODE)
                 VALUES (REC.REQUEST_NO,
                         4,
                         4,
                         'RO_DAR_AUDITOR');
         END IF;
      END IF;
   END LOOP;
END;