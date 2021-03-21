 
DECLARE
   CURSOR WF_CUR
   IS
      SELECT request_no, REQUESTER_PIDM
        FROM REQUEST_MASTER
       WHERE     OBJECT_CODE IN ('WF_CLEARANCE')
             AND REQUEST_STATUS = 'P'
              ;

   L_SEX   CHAR;
   L_CNT   NUMBER;
BEGIN
   FOR REC IN WF_CUR
   LOOP
      UPDATE WF_REQUEST_FLOW
         SET ACTION_CODE = 'AUTO_APPROVE',
             ACTIVITY_DATE = SYSDATE,
             USER_ID = USER ,USER_PIDM=0
       WHERE     ROLE_CODE IN
                    ('RO_STD_ACTIVITY',
                     'RO_STD_BOX',
                     'RO_STD_FOOD',
                     'RO_STD_SERVICES')
             AND ACTION_CODE IS NULL
             AND request_no = REC.request_no;

      SELECT SPBPERS_SEX
        INTO L_SEX
        FROM SPBPERS
       WHERE SPBPERS_PIDM = REC.REQUESTER_PIDM;

      IF L_SEX = 'F'
      THEN
         SELECT COUNT (ACTION_CODE)
           INTO L_CNT
           FROM WF_REQUEST_FLOW
          WHERE     request_no = REC.request_no
                AND ACTION_CODE = 'APPROVE'
                and SEQUENCE_NO=2;

         IF L_CNT = 4
         THEN
         begin
            INSERT INTO WF_REQUEST_FLOW (REQUEST_NO,
                                         SEQUENCE_NO,
                                         FLOW_SEQ,
                                         ROLE_CODE)
                 VALUES (REC.request_no,
                         3,
                         3,
                         'RO_DAR_AUDITOR');
                         exception
                         when dup_val_on_index then 
                         null ;
                         end;
         END IF;
      ELSE
         SELECT COUNT (ACTION_CODE)
           INTO L_CNT
           FROM WF_REQUEST_FLOW
          WHERE     request_no = REC.request_no
                AND ACTION_CODE = 'APPROVE'
                and SEQUENCE_NO=2;
-- male student 
         IF L_CNT = 3
         THEN
            begin INSERT INTO WF_REQUEST_FLOW (REQUEST_NO,
                                         SEQUENCE_NO,
                                         FLOW_SEQ,
                                         ROLE_CODE)
                 VALUES (REC.request_no,
                         3,
                         3,
                         'RO_DAR_AUDITOR');
                         exception
                         when dup_val_on_index then 
                         null ;
                         end;
         END IF;
      END IF;
   END LOOP;
END;