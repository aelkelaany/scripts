 
DECLARE
   v_CHANGE_LOG_SEQ   NUMBER (8);

   CURSOR get_std
   IS
      SELECT f_get_pidm (spriden_id) pidm
        FROM BU_DEV.JAMEE_SPRIDEN_WRONG1
       WHERE COL01 IS NULL;

BEGIN
   FOR rec IN get_std
   LOOP
      BEGIN
         v_CHANGE_LOG_SEQ := 0;

         SELECT MAX (CHANGE_LOG_SEQ) + 1
           INTO v_CHANGE_LOG_SEQ
           FROM JAMEE.CHANGE_LOG
          WHERE STUDENT_PIDM = rec.pidm;

         INSERT
           INTO JAMEE.CHANGE_LOG (CHANGE_LOG_SEQ, STUDENT_PIDM, ACTIVITY_DATE)
         VALUES (v_CHANGE_LOG_SEQ, rec.pidm, SYSDATE + 1);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            v_CHANGE_LOG_SEQ := 1;
      END;
   END LOOP;
END;

update JAMEE.JADARA  set  ACTIVITY_DATE=SYSDATE + 1
where 
 STUDENT_ID in ( SELECT  spriden_id 
        FROM BU_DEV.JAMEE_SPRIDEN_WRONG1
       WHERE COL01 IS NULL) ;