SELECT  --DISTINCT SG.SGBSTDN_PROGRAM_1 ,SMRPRLE_PROGRAM_DESC
f_get_std_id (SGBSTDN_PIDM) id, f_get_std_name (SGBSTDN_PIDM) ,SG.SGBSTDN_PROGRAM_1 ,SMRPRLE_PROGRAM_DESC,SG.SGBSTDN_MAJR_CODE_1 ,F_GET_DESC_FNC('STVMAJR',SG.SGBSTDN_MAJR_CODE_1,30) ,'13'||substr(SG.SGBSTDN_PROGRAM_1,6,2)newmajor_code
 ,F_GET_DESC_FNC('STVMAJR', '13'||substr(SG.SGBSTDN_PROGRAM_1,6,2),30) ,X.STVMAJR_DESC
  FROM SGBSTDN SG ,SMRPRLE ,shrdgmr ,dle.stvmajr x 
 WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                      FROM SGBSTDN
                                     WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
       AND SGBSTDN_STST_CODE not IN ('ŒÃ','„”')
       AND SGBSTDN_DEGC_CODE_1 IN ('»ﬂ', '»ﬂ  ', '000000')
      and SG.SGBSTDN_COLL_CODE_1='13'
      AND SG.SGBSTDN_MAJR_CODE_1='1301'
     AND SG.SGBSTDN_PROGRAM_1=SMRPRLE_PROGRAM
     and shrdgmr_pidm=SGBSTDN_PIDM
     and SHRDGMR_SEQ_NO=(select max(SHRDGMR_SEQ_NO) from SHRDGMR where shrdgmr_pidm=SGBSTDN_PIDM and SHRDGMR_DEGS_CODE='SO' )
     and X.STVMAJR_CODE(+)='13'||substr(SG.SGBSTDN_PROGRAM_1,6,2)
      ORDER BY SMRPRLE_PROGRAM_DESC ;
--«⁄«ﬁ… ⁄ﬁ·Ì…
 --«÷ÿ—«»«  ‰ÿﬁ Ê·€… 
    --’⁄Ê»«   ⁄·„ 
    --******************************QUERY STATMENT***************
    
SELECT  --DISTINCT SG.SGBSTDN_PROGRAM_1 ,SMRPRLE_PROGRAM_DESC
f_get_std_id (SGBSTDN_PIDM) id, f_get_std_name (SGBSTDN_PIDM) ,SG.SGBSTDN_PROGRAM_1 ,SMRPRLE_PROGRAM_DESC,SG.SGBSTDN_MAJR_CODE_1 ,F_GET_DESC_FNC('STVMAJR',SG.SGBSTDN_MAJR_CODE_1,30)
  FROM SGBSTDN SG ,SMRPRLE 
 WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                      FROM SGBSTDN
                                     WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
       AND SGBSTDN_STST_CODE IN ('ŒÃ')
       AND SGBSTDN_DEGC_CODE_1 IN ('»ﬂ', '»ﬂ  ', '000000')
      and SG.SGBSTDN_COLL_CODE_1='13'
      AND SG.SGBSTDN_MAJR_CODE_1='1301'
      AND EXISTS(SELECT 'Y' FROM SHRDGMR
      WHERE SHRDGMR_PIDM=SG.SGBSTDN_PIDM
       AND SHRDGMR_DEGS_CODE='ŒÃ'
      AND SHRDGMR_TERM_CODE_GRAD='144310'
      )
      AND SG.SGBSTDN_PROGRAM_1=SMRPRLE_PROGRAM
        AND SG.SGBSTDN_PROGRAM_1 IN('1-13013-1433','2-13013-1433')
      ORDER BY SMRPRLE_PROGRAM_DESC ;
    --*************************UPDATE STATEMENTS ****************
--«⁄«ﬁ… ⁄ﬁ·Ì…

UPDATE SHRDGMR
   SET SHRDGMR_MAJR_CODE_1 = '1312'
 WHERE     SHRDGMR_DEGS_CODE = 'ŒÃ'
       AND SHRDGMR_TERM_CODE_GRAD = '144310' --***********›’· «· Œ—Ã
       AND SHRDGMR_MAJR_CODE_1 = '1301'
       AND EXISTS
              (SELECT 'Y'
                 FROM SGBSTDN SG
                WHERE     SGBSTDN_TERM_CODE_EFF =
                             (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN
                               WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                      AND SGBSTDN_STST_CODE IN ('ŒÃ')
                      AND SGBSTDN_DEGC_CODE_1 IN
                             ('»ﬂ', '»ﬂ  ', '000000')
                      AND SG.SGBSTDN_COLL_CODE_1 = '13'
                      AND SG.SGBSTDN_MAJR_CODE_1 = '1301'
                      AND SG.SGBSTDN_PIDM = SHRDGMR_PIDM
                      AND SG.SGBSTDN_PROGRAM_1 IN
                             ('1-13012-1433', '2-13012-1433'));
                    
UPDATE sgbstdn sg
   SET sgbstdn_MAJR_CODE_1 = '1312'
 WHERE      
          SGBSTDN_TERM_CODE_EFF =
                             (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN
                               WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                      AND SGBSTDN_STST_CODE IN ('ŒÃ')
                      AND SGBSTDN_DEGC_CODE_1 IN
                             ('»ﬂ', '»ﬂ  ', '000000')
                      AND SG.SGBSTDN_COLL_CODE_1 = '13'
                      AND SG.SGBSTDN_MAJR_CODE_1 = '1301'
                     
                      AND SG.SGBSTDN_PROGRAM_1 IN
                             ('1-13012-1433', '2-13012-1433') ;




         
                             --«÷ÿ—«»«  ‰ÿﬁ Ê·€… 
                             UPDATE SHRDGMR
   SET SHRDGMR_MAJR_CODE_1 = '1315'
 WHERE     SHRDGMR_DEGS_CODE = 'ŒÃ'
       AND SHRDGMR_TERM_CODE_GRAD = '144310' --***********›’· «· Œ—Ã
       AND SHRDGMR_MAJR_CODE_1 = '1301'
       AND EXISTS
              (SELECT 'Y'
                 FROM SGBSTDN SG
                WHERE     SGBSTDN_TERM_CODE_EFF =
                             (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN
                               WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                      AND SGBSTDN_STST_CODE IN ('ŒÃ')
                      AND SGBSTDN_DEGC_CODE_1 IN
                             ('»ﬂ', '»ﬂ  ', '000000')
                      AND SG.SGBSTDN_COLL_CODE_1 = '13'
                      AND SG.SGBSTDN_MAJR_CODE_1 = '1301'
                      AND SG.SGBSTDN_PIDM = SHRDGMR_PIDM
                      AND SG.SGBSTDN_PROGRAM_1 IN
                             ('1-13015-1433', '2-13015-1433'));
                             
         UPDATE sgbstdn sg
   SET sgbstdn_MAJR_CODE_1 = '1315'
 WHERE      
          SGBSTDN_TERM_CODE_EFF =
                             (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN
                               WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                      AND SGBSTDN_STST_CODE IN ('ŒÃ')
                      AND SGBSTDN_DEGC_CODE_1 IN
                             ('»ﬂ', '»ﬂ  ', '000000')
                      AND SG.SGBSTDN_COLL_CODE_1 = '13'
                      AND SG.SGBSTDN_MAJR_CODE_1 = '1301'
                     
                      AND SG.SGBSTDN_PROGRAM_1 IN
                             ('1-13015-1433', '2-13015-1433') ;        
                             --’⁄Ê»«   ⁄·„ 
                             
 UPDATE SHRDGMR
   SET SHRDGMR_MAJR_CODE_1 = '1313'
 WHERE     SHRDGMR_DEGS_CODE = 'ŒÃ'
       AND SHRDGMR_TERM_CODE_GRAD = '144310' --***********›’· «· Œ—Ã
       AND SHRDGMR_MAJR_CODE_1 = '1301'
       AND EXISTS
              (SELECT 'Y'
                 FROM SGBSTDN SG
                WHERE     SGBSTDN_TERM_CODE_EFF =
                             (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN
                               WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                      AND SGBSTDN_STST_CODE IN ('ŒÃ')
                      AND SGBSTDN_DEGC_CODE_1 IN
                             ('»ﬂ', '»ﬂ  ', '000000')
                      AND SG.SGBSTDN_COLL_CODE_1 = '13'
                      AND SG.SGBSTDN_MAJR_CODE_1 = '1301'
                      AND SG.SGBSTDN_PIDM = SHRDGMR_PIDM
                      AND SG.SGBSTDN_PROGRAM_1 IN
                             ('1-13013-1433', '2-13013-1433'));
                             
      UPDATE sgbstdn sg
   SET sgbstdn_MAJR_CODE_1 = '1313'
 WHERE      
          SGBSTDN_TERM_CODE_EFF =
                             (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN
                               WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                      AND SGBSTDN_STST_CODE IN ('ŒÃ')
                      AND SGBSTDN_DEGC_CODE_1 IN
                             ('»ﬂ', '»ﬂ  ', '000000')
                      AND SG.SGBSTDN_COLL_CODE_1 = '13'
                      AND SG.SGBSTDN_MAJR_CODE_1 = '1301'
                     
                      AND SG.SGBSTDN_PROGRAM_1 IN
                             ('1-13013-1433', '2-13013-1433') ;  
                             
        -- «⁄«ﬁ… ”„⁄Ì…                                                    
 UPDATE SHRDGMR
   SET SHRDGMR_MAJR_CODE_1 = '1311'
 WHERE     SHRDGMR_DEGS_CODE = 'ŒÃ'
       AND SHRDGMR_TERM_CODE_GRAD = '144310' --***********›’· «· Œ—Ã
       AND SHRDGMR_MAJR_CODE_1 = '1301'
       AND EXISTS
              (SELECT 'Y'
                 FROM SGBSTDN SG
                WHERE     SGBSTDN_TERM_CODE_EFF =
                             (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN
                               WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                      AND SGBSTDN_STST_CODE IN ('ŒÃ')
                      AND SGBSTDN_DEGC_CODE_1 IN
                             ('»ﬂ', '»ﬂ  ', '000000')
                      AND SG.SGBSTDN_COLL_CODE_1 = '13'
                      AND SG.SGBSTDN_MAJR_CODE_1 = '1301'
                      AND SG.SGBSTDN_PIDM = SHRDGMR_PIDM
                      AND SG.SGBSTDN_PROGRAM_1 IN
                             ('1-13011-1430', '2-13011-1430'));
                             UPDATE sgbstdn sg
   SET sgbstdn_MAJR_CODE_1 = '1311'
 WHERE      
          SGBSTDN_TERM_CODE_EFF =
                             (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN
                               WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                      AND SGBSTDN_STST_CODE IN ('ŒÃ')
                      AND SGBSTDN_DEGC_CODE_1 IN
                             ('»ﬂ', '»ﬂ  ', '000000')
                      AND SG.SGBSTDN_COLL_CODE_1 = '13'
                      AND SG.SGBSTDN_MAJR_CODE_1 = '1301'
                     
                      AND SG.SGBSTDN_PROGRAM_1 IN
                             ('1-13011-1433', '2-13011-1433') ;
                             
                             ----------------------------------------------
                             /* Formatted on 6/3/2020 11:08:42 AM (QP5 v5.227.12220.39754) */
  SELECT f_get_std_id (SGBSTDN_PIDM) ID,
         f_get_std_name (SGBSTDN_PIDM),
         SG.SGBSTDN_PROGRAM_1,
         SMRPRLE_PROGRAM_DESC,
         SG.SGBSTDN_MAJR_CODE_1,
         F_GET_DESC_FNC ('STVMAJR', SG.SGBSTDN_MAJR_CODE_1, 30),
         '13' || SUBSTR (SG.SGBSTDN_PROGRAM_1, 6, 2) newmajor_code,
         F_GET_DESC_FNC ('STVMAJR',
                         '13' || SUBSTR (SG.SGBSTDN_PROGRAM_1, 6, 2),
                         30),
         X.STVMAJR_DESC ,SHRDGMR_MAJR_CODE_1
    FROM SGBSTDN SG,
         SMRPRLE,
         shrdgmr,
         dle.stvmajr x
   WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                        FROM SGBSTDN
                                       WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
         AND SGBSTDN_STST_CODE   IN ('ŒÃ')
         AND SGBSTDN_DEGC_CODE_1 IN ('»ﬂ', '»ﬂ  ', '000000')
         AND SG.SGBSTDN_COLL_CODE_1 = '13'
         AND SG.SGBSTDN_MAJR_CODE_1 = '1301'
         AND SG.SGBSTDN_PROGRAM_1 = SMRPRLE_PROGRAM
         AND shrdgmr_pidm = SGBSTDN_PIDM
        AND  shrdgmr_pidm IN (  SELECT DISTINCT COL01 PIDM
FROM bu_dev.tmp_tbl04 )

    -- AND SHRDGMR_MAJR_CODE_1='1301'
     and   EXISTS (SELECT '1' FROM SHRDGMR
     WHERE SHRDGMR_PIDM=SGBSTDN_PIDM
     AND  SHRDGMR_DEGS_CODE ='ŒÃ') 
     and SHRDGMR_SEQ_NO=(select max(SHRDGMR_SEQ_NO) from SHRDGMR where shrdgmr_pidm=SGBSTDN_PIDM and SHRDGMR_DEGS_CODE='ŒÃ' )
         AND X.STVMAJR_CODE(+) = '13' || SUBSTR (SG.SGBSTDN_PROGRAM_1, 6, 2)
ORDER BY SMRPRLE_PROGRAM_DESC ;




------ SGBSTDN

UPDATE SGBSTDN SG
   AND EXISTS
              (SELECT 'Y'
                 FROM SGBSTDN SG
                WHERE     SGBSTDN_TERM_CODE_EFF =
                             (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN
                               WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                      AND SGBSTDN_STST_CODE IN ('ŒÃ')
                      AND SGBSTDN_DEGC_CODE_1 IN
                             ('»ﬂ', '»ﬂ  ', '000000')
                      AND SG.SGBSTDN_COLL_CODE_1 = '13'
                      AND SG.SGBSTDN_MAJR_CODE_1 = '1301'
                      AND SG.SGBSTDN_PIDM = SHRDGMR_PIDM
                      AND SG.SGBSTDN_PROGRAM_1 IN
                             ('1-13011-1430', '2-13011-1430'));
       
       
       
      SELECT * FROM  SGBSTDN SG
    -- SGBSTDN_MAJR_CODE_1 = '1312'
       WHERE 
         SGBSTDN_TERM_CODE_EFF = '144310' --***********›’· «· Œ—Ã
       AND SGBSTDN_MAJR_CODE_1 = '1301'
       AND SGBSTDN_LEVL_CODE='Ã„'
         AND SGBSTDN_STST_CODE='ŒÃ'
       AND   SG.SGBSTDN_PROGRAM_1 IN ('1-13012-1433', '2-13012-1433') 
       ;