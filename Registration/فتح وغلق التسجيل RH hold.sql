delete from sfbetrm where SFBETRM_TERM_CODE ='144030' ;


/* Formatted on 2/2/2020 12:27:24 PM (QP5 v5.227.12220.39754) */
UPDATE SPRHOLD
   SET SPRHOLD_FROM_DATE = SPRHOLD_FROM_DATE - 100 ,
   SPRHOLD_TO_DATE=SYSDATE+100
 WHERE SPRHOLD_HLDD_CODE = 'RH';


INSERT INTO SPRHOLD (SPRHOLD_PIDM,
                     SPRHOLD_HLDD_CODE,
                     SPRHOLD_USER,
                     SPRHOLD_FROM_DATE,
                     SPRHOLD_TO_DATE,
                     SPRHOLD_RELEASE_IND,
                     SPRHOLD_REASON,
                     SPRHOLD_AMOUNT_OWED,
                     SPRHOLD_ORIG_CODE,
                     SPRHOLD_ACTIVITY_DATE,
                     SPRHOLD_DATA_ORIGIN)
   SELECT a.sgbstdn_pidm,
          'RH',
          'SAISUSR',
          SYSDATE - 3,
          SYSDATE + 1000,
          'N',
          NULL,
          NULL,
          NULL,
          SYSDATE,
          'Banner IT'
     FROM sgbstdn a
    WHERE     NOT EXISTS
                     (SELECT '1'
                        FROM sprhold
                       WHERE     sprhold_pidm = a.sgbstdn_pidm
                             AND SPRHOLD_HLDD_CODE = 'RH')
          AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                         FROM sgbstdn
                                        WHERE sgbstdn_pidm = a.sgbstdn_pidm)
          AND SGBSTDN_STST_CODE IN ('AS');


          --- open registration  «‰ Ÿ«„ »ﬂ«·—ÌÊ” Ê Ã”Ì— Ê„«ÃÌ” Ì— «‰ Ÿ«„

---€·ﬁ «· ”ÃÌ· »ﬂ«·—ÌÊ” «‰ Ÿ«„--
INSERT INTO SPRHOLD (SPRHOLD_PIDM,
                     SPRHOLD_HLDD_CODE,
                     SPRHOLD_USER,
                     SPRHOLD_FROM_DATE,
                     SPRHOLD_TO_DATE,
                     SPRHOLD_RELEASE_IND,
                     SPRHOLD_REASON,
                     SPRHOLD_AMOUNT_OWED,
                     SPRHOLD_ORIG_CODE,
                     SPRHOLD_ACTIVITY_DATE,
                     SPRHOLD_DATA_ORIGIN)
   SELECT a.sgbstdn_pidm,
          'RH',
          'SAISUSR',
          SYSDATE - 3,
          SYSDATE + 1000,
          'N',
          NULL,
          NULL,
          NULL,
          SYSDATE,
          'Banner IT'
     FROM sgbstdn a
    WHERE     NOT EXISTS
                     (SELECT '1'
                        FROM sprhold
                       WHERE     sprhold_pidm = a.sgbstdn_pidm
                             AND SPRHOLD_HLDD_CODE = 'RH')
          AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                         FROM sgbstdn
                                        WHERE sgbstdn_pidm = a.sgbstdn_pidm
                                       )
          AND SGBSTDN_STST_CODE IN ('AS')
          AND SGBSTDN_DEGC_CODE_1 IN
                                  ('»ﬂ')
                           AND SGBSTDN_STYP_CODE IN ('„', ' ');
                           -----------------
--SELECT *

/* › Õ «· ”ÃÌ· */

DELETE FROM sprhold
      WHERE     EXISTS
                   (SELECT DISTINCT f_get_std_id (SGBSTDN_PIDM)
                      FROM SGBSTDN SG
                     WHERE     SGBSTDN_TERM_CODE_EFF =
                                  (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                     FROM SGBSTDN
                                    WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                           AND SGBSTDN_STST_CODE IN ('AS')
                           AND SGBSTDN_DEGC_CODE_1 IN
                                  ('»ﬂ', '»ﬂ  ', '000000', '„Ã', 'MA')
                           AND SGBSTDN_STYP_CODE IN ('„', ' ')
                           AND sprhold_pidm = SG.sgbstdn_pidm)
            AND SPRHOLD_HLDD_CODE = 'RH';


            -----› Õ « ”ÃÌ· «‰ ”«»
            SELECT F_GET_STD_ID(SGBSTDN_PIDM)
     FROM sgbstdn a
    WHERE     NOT EXISTS
                     (SELECT '1'
                        FROM sprhold
                       WHERE     sprhold_pidm = a.sgbstdn_pidm
                             AND SPRHOLD_HLDD_CODE = 'RH')
          AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                         FROM sgbstdn
                                        WHERE sgbstdn_pidm = a.sgbstdn_pidm)
          AND SGBSTDN_STST_CODE IN ('AS')
          AND SGBSTDN_STYP_CODE<>'‰';

DELETE FROM sprhold
      WHERE     EXISTS
                   (SELECT DISTINCT f_get_std_id (SGBSTDN_PIDM)
                      FROM SGBSTDN SG
                     WHERE     SGBSTDN_TERM_CODE_EFF =
                                  (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                     FROM SGBSTDN
                                    WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                           AND SGBSTDN_STST_CODE IN ('AS')
                           AND SGBSTDN_DEGC_CODE_1 IN
                                  ('»ﬂ', '»ﬂ  ', '000000', '„Ã', 'MA')
                           AND SGBSTDN_STYP_CODE IN ('‰')
                           AND sprhold_pidm = SG.sgbstdn_pidm)
            AND SPRHOLD_HLDD_CODE = 'RH';

---- «‰ ”«» »œÊ‰ ÿ·«» «·›Ê« Ì—
DELETE  FROM sprhold A
      WHERE     EXISTS
                   (SELECT DISTINCT f_get_std_id (SGBSTDN_PIDM)
                      FROM SGBSTDN SG
                     WHERE     SGBSTDN_TERM_CODE_EFF =
                                  (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                     FROM SGBSTDN
                                    WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                           AND SGBSTDN_STST_CODE IN ('AS')
                           AND SGBSTDN_DEGC_CODE_1 IN
                                  ('»ﬂ', '»ﬂ  ', '000000', '„Ã', 'MA')
                           AND SGBSTDN_STYP_CODE IN ('‰')
                           AND sprhold_pidm = SG.sgbstdn_pidm)
                         AND  NOT EXISTS
                  (SELECT 'c'
                     FROM sprhold
                    WHERE     SPRHOLD_HLDD_CODE = 'RP'
                          AND sprhold_pidm = A.sprhold_pidm)
            AND SPRHOLD_HLDD_CODE = 'RH'
            ;
            -------------------------
SELECT DISTINCT f_get_std_id (SGBSTDN_PIDM)
  FROM SGBSTDN SG
 WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                      FROM SGBSTDN
                                     WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
       AND SGBSTDN_STST_CODE IN ('AS')
       AND SGBSTDN_STYP_CODE IN ('‰')
       AND NOT EXISTS
                  (SELECT 'c'
                     FROM sprhold
                    WHERE     SPRHOLD_HLDD_CODE = 'RP'
                          AND sprhold_pidm = SGBSTDN_PIDM);

                           -- › Õ œ»·Ê„« 

SELECT DISTINCT f_get_std_id (SGBSTDN_PIDM)
  FROM SGBSTDN SG
 WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                      FROM SGBSTDN
                                     WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
       AND SGBSTDN_STST_CODE IN ('AS')
       AND SGBSTDN_DEGC_CODE_1 IN ('œ»')
       AND SGBSTDN_COLL_CODE_1='35'
       AND  not EXISTS
                  (SELECT 'c'
                     FROM sprhold
                    WHERE     SPRHOLD_HLDD_CODE = 'RH'
                          AND sprhold_pidm = SGBSTDN_PIDM);

DELETE FROM sprhold
      WHERE     EXISTS
                   (SELECT DISTINCT f_get_std_id (SGBSTDN_PIDM)
                      FROM SGBSTDN SG
                     WHERE     SGBSTDN_TERM_CODE_EFF =
                                  (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                     FROM SGBSTDN
                                    WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                           AND SGBSTDN_STST_CODE IN ('AS')
                           AND SGBSTDN_DEGC_CODE_1 IN ('œ»')
                           AND SGBSTDN_COLL_CODE_1='35'
                           AND sprhold_pidm = SG.sgbstdn_pidm)
            AND SPRHOLD_HLDD_CODE = 'RH';


            --€·ﬁ «· ”ÃÌ· œ»·Ê„« 

INSERT INTO SPRHOLD (SPRHOLD_PIDM,
                     SPRHOLD_HLDD_CODE,
                     SPRHOLD_USER,
                     SPRHOLD_FROM_DATE,
                     SPRHOLD_TO_DATE,
                     SPRHOLD_RELEASE_IND,
                     SPRHOLD_REASON,
                     SPRHOLD_AMOUNT_OWED,
                     SPRHOLD_ORIG_CODE,
                     SPRHOLD_ACTIVITY_DATE,
                     SPRHOLD_DATA_ORIGIN)
   SELECT a.sgbstdn_pidm,
          'RH',
          'SAISUSR',
          SYSDATE - 3,
          SYSDATE + 1000,
          'N',
          NULL,
          NULL,
          NULL,
          SYSDATE,
          'Banner IT'
     FROM sgbstdn a
    WHERE     NOT EXISTS
                     (SELECT '1'
                        FROM sprhold
                       WHERE     sprhold_pidm = a.sgbstdn_pidm
                             AND SPRHOLD_HLDD_CODE = 'RH')
          AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                         FROM sgbstdn
                                        WHERE sgbstdn_pidm = a.sgbstdn_pidm)
          AND SGBSTDN_STST_CODE IN ('AS')
          AND SGBSTDN_DEGC_CODE_1 IN ('œ»')
         -- AND F_GET_STD_ID(sgbstdn_pidm) LIKE '441%'
         ;
--  F_WFR_POSTPONE_TERM

-- › Õ  ”ÃÌ· „«ÃÌ” Ì— „œ›Ê⁄ 
SELECT DISTINCT f_get_std_id (SGBSTDN_PIDM),f_get_std_name(SGBSTDN_PIDM)
  FROM SGBSTDN SG
                     WHERE     SGBSTDN_TERM_CODE_EFF =
                                  (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                     FROM SGBSTDN
                                    WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                           AND SGBSTDN_STST_CODE IN ('AS')
                           AND SGBSTDN_DEGC_CODE_1 IN
                                  ( '„Ã', 'MA')
                           and sgbstdn_dept_code in ('13063','13076','13093','1310','13016','15021')
                             AND   EXISTS
                  (SELECT 'c'
                     FROM sprhold
                    WHERE     SPRHOLD_HLDD_CODE = 'RH'
                          AND sprhold_pidm = SGBSTDN_PIDM); 
DELETE FROM sprhold
      WHERE     EXISTS
                   (SELECT DISTINCT f_get_std_id (SGBSTDN_PIDM)
                      FROM SGBSTDN SG
                     WHERE     SGBSTDN_TERM_CODE_EFF =
                                  (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                     FROM SGBSTDN
                                    WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                           AND SGBSTDN_STST_CODE IN ('AS')
                           AND SGBSTDN_DEGC_CODE_1 IN
                                  ( '„Ã', 'MA')
                           and sgbstdn_dept_code in ('13063','13076','13093','1310','13016','15021')
                           AND sprhold_pidm = SG.sgbstdn_pidm)
            AND SPRHOLD_HLDD_CODE = 'RH';
            
            -- › Õ  ”ÃÌ· „‰ ﬁ«∆„… 
                  select * FROM sprhold
      WHERE     EXISTS
                   (SELECT '1'
                      FROM bu_dev.summer_reg_list
                     WHERE      
                            pidm= sprhold_pidm)
            AND SPRHOLD_HLDD_CODE = 'RH';
            
            --
         DELETE FROM sprhold
      WHERE     EXISTS
                   (SELECT '1'
                      FROM bu_dev.summer_reg_list
                     WHERE      
                            pidm= sprhold_pidm)
            AND SPRHOLD_HLDD_CODE = 'RH';
            
            
            delete FROM sprhold
      WHERE SPRHOLD_HLDD_CODE = 'RP' ;
      
       select distinct f_get_std_id(sprhold_pidm) FROM sprhold
      WHERE     EXISTS
                   (SELECT '1'
                      FROM spriden
                     WHERE      
                            spriden_pidm= sprhold_pidm
                            and substr(spriden_id,1,3)<='438')
                            and  EXISTS
                   (SELECT '2'
                      FROM SGBSTDN SG
                     WHERE     SGBSTDN_TERM_CODE_EFF =
                                  (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                     FROM SGBSTDN
                                    WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                           AND SGBSTDN_STST_CODE IN ('AS')
                          /* AND SGBSTDN_DEGC_CODE_1 IN
                                  ('»ﬂ', '»ﬂ  ', '000000')*/
                           AND SGBSTDN_STYP_CODE IN ('„',' ')
                           and SGBSTDN_LEVL_CODE='Ã„'
                           AND sprhold_pidm = SG.sgbstdn_pidm)
            AND SPRHOLD_HLDD_CODE = 'RH'
            order by 1;
            -------------------› Õ «· ”ÃÌ· ·œ›⁄… 438 Ê„«ﬁ»· «‰ Ÿ«„ Ã«„⁄Ì
            delete   FROM sprhold
      WHERE     EXISTS
                   (SELECT '1'
                      FROM spriden
                     WHERE      
                            spriden_pidm= sprhold_pidm
                            and substr(spriden_id,1,3)<='438')
                            and  EXISTS
                   (SELECT '2'
                      FROM SGBSTDN SG
                     WHERE     SGBSTDN_TERM_CODE_EFF =
                                  (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                     FROM SGBSTDN
                                    WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                           AND SGBSTDN_STST_CODE IN ('AS')
                           AND SGBSTDN_DEGC_CODE_1 IN
                                  ('»ﬂ', '»ﬂ  ', '000000')
                           AND SGBSTDN_STYP_CODE IN ('„',' ')
                           and SGBSTDN_LEVL_CODE='Ã„'
                           AND sprhold_pidm = SG.sgbstdn_pidm)
            AND SPRHOLD_HLDD_CODE = 'RH' ;
            
            
            -------------------› Õ «· ”ÃÌ· ·œ›⁄… 439Ê„«ﬁ»· «‰ Ÿ«„ Ã«„⁄Ì
            
            select count(*)   FROM sprhold
      WHERE     EXISTS
                   (SELECT '1'
                      FROM spriden
                     WHERE      
                            spriden_pidm= sprhold_pidm
                            and substr(spriden_id,1,3)<='439')
                            and  EXISTS
                   (SELECT '2'
                      FROM SGBSTDN SG
                     WHERE     SGBSTDN_TERM_CODE_EFF =
                                  (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                     FROM SGBSTDN
                                    WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                           AND SGBSTDN_STST_CODE IN ('AS')
                           AND SGBSTDN_DEGC_CODE_1 IN
                                  ('»ﬂ', '»ﬂ  ', '000000')
                           AND SGBSTDN_STYP_CODE IN ('„',' ')
                           and SGBSTDN_LEVL_CODE='Ã„'
                           AND sprhold_pidm = SG.sgbstdn_pidm)
            AND SPRHOLD_HLDD_CODE = 'RH' ;
            
            
            
            delete   FROM sprhold
      WHERE     EXISTS
                   (SELECT '1'
                      FROM spriden
                     WHERE      
                            spriden_pidm= sprhold_pidm
                            and substr(spriden_id,1,3)<='439')
                            and  EXISTS
                   (SELECT '2'
                      FROM SGBSTDN SG
                     WHERE     SGBSTDN_TERM_CODE_EFF =
                                  (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                     FROM SGBSTDN
                                    WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                           AND SGBSTDN_STST_CODE IN ('AS')
                           AND SGBSTDN_DEGC_CODE_1 IN
                                  ('»ﬂ', '»ﬂ  ', '000000')
                           AND SGBSTDN_STYP_CODE IN ('„',' ')
                           and SGBSTDN_LEVL_CODE='Ã„'
                           AND sprhold_pidm = SG.sgbstdn_pidm)
            AND SPRHOLD_HLDD_CODE = 'RH' ;
            
            -- €·ﬁ ÿ·»… 39 Ê 38 «œ«» 
            
            INSERT INTO SPRHOLD (SPRHOLD_PIDM,
                     SPRHOLD_HLDD_CODE,
                     SPRHOLD_USER,
                     SPRHOLD_FROM_DATE,
                     SPRHOLD_TO_DATE,
                     SPRHOLD_RELEASE_IND,
                     SPRHOLD_REASON,
                     SPRHOLD_AMOUNT_OWED,
                     SPRHOLD_ORIG_CODE,
                     SPRHOLD_ACTIVITY_DATE,
                     SPRHOLD_DATA_ORIGIN)
   SELECT a.sgbstdn_pidm,
          'RH',
          'SAISUSR',
          SYSDATE - 3,
          SYSDATE + 1000,
          'N',
          NULL,
          NULL,
          NULL,
          SYSDATE,
          'Banner IT'
     FROM sgbstdn a
    WHERE     NOT EXISTS
                     (SELECT '1'
                        FROM sprhold
                       WHERE     sprhold_pidm = a.sgbstdn_pidm
                             AND SPRHOLD_HLDD_CODE = 'RH')
          AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                         FROM sgbstdn
                                        WHERE sgbstdn_pidm = a.sgbstdn_pidm)
           AND SGBSTDN_STST_CODE IN ('AS')
                           AND SGBSTDN_DEGC_CODE_1 IN
                                  ('»ﬂ', '»ﬂ  ', '000000')
                           AND SGBSTDN_STYP_CODE IN ('„',' ')
                           and sgbstdn_coll_code_1='15'
                           
                           and SGBSTDN_LEVL_CODE='Ã„'
                           and  EXISTS
                   (SELECT '1'
                      FROM spriden
                     WHERE      
                            spriden_pidm= sgbstdn_pidm
                            and substr(spriden_id,1,3)in('439','438')) ;
                            
                            
                            
                                       -------------------› Õ «· ”ÃÌ· ·œ›⁄… 441 «‰ Ÿ«„ Ã«„⁄Ì
            
            select count(distinct sprhold_pidm)   FROM sprhold
      WHERE     EXISTS
                   (SELECT '1'
                      FROM spriden
                     WHERE      
                            spriden_pidm= sprhold_pidm
                            and substr(spriden_id,1,3)<='441')
                            and  EXISTS
                   (SELECT '2'
                      FROM SGBSTDN SG
                     WHERE     SGBSTDN_TERM_CODE_EFF =
                                  (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                     FROM SGBSTDN
                                    WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                           AND SGBSTDN_STST_CODE IN ('AS')
                           AND SGBSTDN_DEGC_CODE_1 IN
                                  ('»ﬂ', '»ﬂ  ', '000000')
                           AND SGBSTDN_STYP_CODE IN ('„',' ')
                           and SGBSTDN_LEVL_CODE='Ã„'
                           AND sprhold_pidm = SG.sgbstdn_pidm)
            AND SPRHOLD_HLDD_CODE = 'RH' ;
            
            
            
            delete   FROM sprhold
      WHERE     EXISTS
                   (SELECT '1'
                      FROM spriden
                     WHERE      
                            spriden_pidm= sprhold_pidm
                            and substr(spriden_id,1,3)<='441')
                            and  EXISTS
                   (SELECT '2'
                      FROM SGBSTDN SG
                     WHERE     SGBSTDN_TERM_CODE_EFF =
                                  (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                     FROM SGBSTDN
                                    WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                           AND SGBSTDN_STST_CODE IN ('AS')
                           AND SGBSTDN_DEGC_CODE_1 IN
                                  ('»ﬂ', '»ﬂ  ', '000000')
                           AND SGBSTDN_STYP_CODE IN ('„',' ')
                           and SGBSTDN_LEVL_CODE='Ã„'
                           AND sprhold_pidm = SG.sgbstdn_pidm)
            AND SPRHOLD_HLDD_CODE = 'RH' ;