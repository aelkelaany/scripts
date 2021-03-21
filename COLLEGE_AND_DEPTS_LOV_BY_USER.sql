/* Formatted on 10/22/2019 3:20:39 PM (QP5 v5.227.12220.39754) */
-- COLLEGES

SELECT STVCOLL_CODE, STVCOLL_DESC
  FROM STVCOLL
 WHERE EXISTS
          (SELECT 'X'
             FROM GORFBPR
            WHERE     GORFBPR_FGAC_USER_ID = USER
                  AND (   REPLACE (GORFBPR_FBPR_CODE, 'COLL_') = STVCOLL_CODE
                       OR SUBSTR (REPLACE (GORFBPR_FBPR_CODE, 'DEPT_'), 1, 2) =
                             STVCOLL_CODE))
UNION
SELECT STVCOLL_CODE, STVCOLL_DESC
  FROM STVCOLL
 WHERE NOT EXISTS
          (SELECT 'X'
             FROM GORFBPR
            WHERE GORFBPR_FGAC_USER_ID = USER)
            union
            SELECT STVDEPT_CODE, STVDEPT_DESC
  FROM STVDEPT
 WHERE     EXISTS
               (SELECT 'X'
                  FROM GORFBPR
                 WHERE     GORFBPR_FGAC_USER_ID = USER
                       AND REPLACE (GORFBPR_FBPR_CODE, 'COLL_') =
                           SUBSTR (STVDEPT_CODE, 1, 2))
       or EXISTS
               (SELECT 'X'
                  FROM GORFBPR
                 WHERE     GORFBPR_FGAC_USER_ID = USER
                       AND REPLACE (GORFBPR_FBPR_CODE, 'COLL_') = '55'
                       AND SUBSTR (STVDEPT_CODE, 1, 2) = '20');

   -----------------


--  MDEPARTMENTS


SELECT STVDEPT_CODE, STVDEPT_DESC
  FROM STVDEPT
 WHERE     EXISTS
              (SELECT 'X'
                 FROM GORFBPR
                WHERE     GORFBPR_FGAC_USER_ID = USER
                      AND (REPLACE (GORFBPR_FBPR_CODE, 'DEPT_') =
                              STVDEPT_CODE))
       AND SUBSTR (STVDEPT_CODE, 1, 2) = :COLL_CODE
UNION
SELECT STVDEPT_CODE, STVDEPT_DESC
  FROM STVDEPT
 WHERE     NOT EXISTS
              (SELECT 'X'
                 FROM GORFBPR
                WHERE GORFBPR_FGAC_USER_ID = USER)
       AND SUBSTR (STVDEPT_CODE, 1, 2) = :COLL_CODE;


;


CREATE TABLE acd_adv_std_proc
(
   session_id   VARCHAR2 (20),
   std_pidm     NUMBER (8)
);

ALTER TABLE BU_APPS.ACD_ADV_STD_PROC
 ADD CONSTRAINT ACD_ADV_STD_PROC_PK
  PRIMARY KEY
  (SESSION_ID, STD_PIDM);

CREATE TABLE acd_adv_fac_proc
(
   session_id   VARCHAR2 (20),
   fac_pidm     NUMBER (8),
   qouta        NUMBER (3)
);

ALTER TABLE BU_APPS.acd_adv_fac_proc
 ADD CONSTRAINT acd_adv_fac_proc_PK
  PRIMARY KEY
  (SESSION_ID, fac_pidm);
  
  ALTER TABLE BU_APPS.ACD_ADV_FAC_PROC
RENAME COLUMN QOUTA TO QUOTA ;