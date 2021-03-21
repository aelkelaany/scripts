/* Formatted on 9/10/2019 9:18:01 AM (QP5 v5.227.12220.39754) */
CREATE TABLE bu_dev.std_crn_temp
(
   std_id     VARCHAR2 (11),
   pidm       NUMBER,
   from_crn   VARCHAR2 (6),
   to_crn     VARCHAR2 (6)
);

DROP TABLE bu_dev.std_crn_temp;

UPDATE bu_dev.std_crn_temp
   SET pidm = f_get_pidm (std_id)
 WHERE std_id IS NOT NULL;

SELECT COUNT (*)
  FROM bu_dev.std_crn_temp
 WHERE pidm IS NULL;

--************************************************************START

DECLARE
  -- L_FROM_CRN   VARCHAR2 (6) := :L_FROM_CRN;
   --L_TO_CRN     VARCHAR2 (6) := :L_TO_CRN;

   CURSOR get_crn
   IS
      SELECT DISTINCT from_crn, to_crn
        FROM bu_dev.std_crn_temp
       WHERE std_id IS NOT NULL;

   CURSOR get_std (p_from_crn VARCHAR2, p_to_crn VARCHAR2)
   IS
      SELECT *
        FROM bu_dev.std_crn_temp
       WHERE from_crn = p_from_crn AND to_crn = p_to_crn;

BEGIN
   FOR c IN get_crn
   LOOP
      INSERT INTO GLBSLCT (GLBSLCT_APPLICATION,
                           GLBSLCT_SELECTION,
                           GLBSLCT_CREATOR_ID,
                           GLBSLCT_DESC,
                           GLBSLCT_LOCK_IND,
                           GLBSLCT_ACTIVITY_DATE,
                           GLBSLCT_TYPE_IND)
           VALUES ('STUDENT',
                   'FROM  ' || C.FROM_CRN || '  TO ' || C.TO_CRN,
                   'SAISUSR',
                   ' ”ÃÌ· ‘⁄» ' || C.TO_CRN,
                   'N',
                   SYSDATE,
                   NULL);

      -- DBMS_OUTPUT.put_line ('2- GLBSLCT' || ' ' || SQL%ROWCOUNT);
      FOR S IN GET_STD (C.FROM_CRN, C.TO_CRN)
      LOOP
         INSERT INTO GLBEXTR
            SELECT 'STUDENT',
                   'FROM  ' || C.FROM_CRN || '  TO ' || C.TO_CRN,
                   'SAISUSR',
                   'SAISUSR',
                   S.PIDM,
                   SYSDATE,
                   'S',
                   NULL
              FROM DUAL;

         
      END LOOP;
      DBMS_OUTPUT.put_line ('FROM  ' || C.FROM_CRN || '  TO ' || C.TO_CRN);
   END LOOP;
END;
----************************************************************* END