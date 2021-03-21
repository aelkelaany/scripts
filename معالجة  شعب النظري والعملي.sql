 
CREATE TABLE applied_sc_temp
(
   pidm   NUMBER (6),
   crn    VARCHAR2 (8)
);



--************************************************************START

DECLARE
   L_THEROTICAL_CRN   VARCHAR2 (6) := :L_THEROTICAL_CRN;
   L_1ST_CRN          VARCHAR2 (6) := :L_1ST_CRN;
   L_2ND_CRN          VARCHAR2 (6) := :L_2ND_CRN;
   L_COUNT            NUMBER := :L_COUNT ;
BEGIN
   INSERT INTO applied_sc_temp
      SELECT sfrstcr_pidm, L_1ST_CRN
        FROM sfrstcr
       WHERE     sfrstcr_term_code = '144010'
             AND sfrstcr_crn = :L_THEROTICAL_CRN
             AND ROWNUM < :L_COUNT+1;

   DBMS_OUTPUT.put_line ('1- applied_sc_temp' || ' ' || SQL%ROWCOUNT);

   INSERT INTO GLBSLCT (GLBSLCT_APPLICATION,
                        GLBSLCT_SELECTION,
                        GLBSLCT_CREATOR_ID,
                        GLBSLCT_DESC,
                        GLBSLCT_LOCK_IND,
                        GLBSLCT_ACTIVITY_DATE,
                        GLBSLCT_TYPE_IND)
        VALUES ('STUDENT',
                'AS_REG_' || L_1ST_CRN,
                'SAISUSR',
                'ÊÓÌíá ÔÚÈ Úáãí' || L_1ST_CRN,
                'N',
                SYSDATE,
                NULL);

   DBMS_OUTPUT.put_line ('2- GLBSLCT' || ' ' || SQL%ROWCOUNT);

   INSERT INTO GLBEXTR
      SELECT 'STUDENT',
             'AS_REG_' || L_1ST_CRN,
             'SAISUSR',
             'SAISUSR',
             PIDM,
             SYSDATE,
             'S',
             NULL
        FROM (SELECT DISTINCT PIDM
                FROM applied_sc_temp
               WHERE CRN = L_1ST_CRN);

   DBMS_OUTPUT.put_line ('3- GLBEXTR' || ' ' || SQL%ROWCOUNT);

   ------------------------------------------------
   INSERT INTO applied_sc_temp
      SELECT sfrstcr_pidm, L_2ND_CRN
        FROM sfrstcr
       WHERE     sfrstcr_term_code = '144010'
             AND sfrstcr_crn = :L_THEROTICAL_CRN
             AND NOT EXISTS
                    (SELECT '1'
                       FROM applied_sc_temp
                      WHERE pidm = sfrstcr_pidm AND crn = L_1ST_CRN);

   DBMS_OUTPUT.put_line ('4- applied_sc_temp' || ' ' || SQL%ROWCOUNT);

   INSERT INTO GLBSLCT (GLBSLCT_APPLICATION,
                        GLBSLCT_SELECTION,
                        GLBSLCT_CREATOR_ID,
                        GLBSLCT_DESC,
                        GLBSLCT_LOCK_IND,
                        GLBSLCT_ACTIVITY_DATE,
                        GLBSLCT_TYPE_IND)
        VALUES ('STUDENT',
                'AS_REG_' || L_2ND_CRN,
                'SAISUSR',
                'ÊÓÌíá ÔÚÈ Úáãí' || L_2ND_CRN,
                'N',
                SYSDATE,
                NULL);

   DBMS_OUTPUT.put_line ('5- GLBSLCT' || ' ' || SQL%ROWCOUNT);

   INSERT INTO GLBEXTR
      SELECT 'STUDENT',
             'AS_REG_' || L_2ND_CRN,
             'SAISUSR',
             'SAISUSR',
             PIDM,
             SYSDATE,
             'S',
             NULL
        FROM (SELECT DISTINCT PIDM
                FROM applied_sc_temp
               WHERE CRN = L_2ND_CRN);

   DBMS_OUTPUT.put_line ('6- GLBEXTR' || ' ' || SQL%ROWCOUNT);
   
   DBMS_OUTPUT.put_line ('OUTPUT : ');
   DBMS_OUTPUT.put_line ('AS_REG_' || L_1ST_CRN);
   DBMS_OUTPUT.put_line ('AS_REG_' || L_2ND_CRN);
END;
----************************************************************* END
            
         DELETE FROM   GLBEXTR WHERE  GLBEXTR_SELECTION ='AS_REG_14910' ;
            
             DELETE FROM GLBSLCT WHERE GLBSLCT_SELECTION LIKE 'AS_REG_14910' ;
            
            
            
                                                     --drop table applied_sc_temp purge ;



                                           --SATURN.ST_SFTREGS_POST_DELETE_ROW

SELECT NVL (MAX (sfrstca_seq_number), 0) + 1
  FROM sfrstca
 WHERE     sfrstca_term_code = NVL ('144010', '144010')
       AND sfrstca_pidm =
              NVL (f_get_pidm ('439010071'), f_get_pidm ('439010071'));
              
              
              SGBSTDN
              
              
                          UPDATE ssbsect
   SET SSBSECT_ENRL =
          (SELECT COUNT (*)
             FROM sfrstcr
            WHERE     sfrstcr_term_code = '144010'
                  AND sfrstcr_crn = ssbsect_crn
                  AND SFRSTCR_RSTS_CODE IN ('RE', 'RW'))
 WHERE     ssbsect_term_code = '144010'
       AND ssbsect_crn ='14910';
       
       
       