CREATE TABLE BU_DEV.TMP_TBL_KILANY_ADM1 AS SELECT * FROM  BU_DEV.TMP_TBL_KILANY1 ;
SELECT * FROM BU_DEV.TMP_TBL_KILANY1
;
UPDATE BU_DEV.TMP_TBL_KILANY1 SET (COL02,COL04)=
(select sgbstdn_pidm ,f_get_std_id(sgbstdn_pidm) stid  from sgbstdn sg,spbpers
where
SGBSTDN_TERM_CODE_EFF='144510'
AND sgbstdn_pidm=spbpers_pidm
and spbpers_ssn=COL01)
WHERE  COL02 IS NULL
;

SELECT * FROM BU_DEV.TMP_TBL_KILANY1
WHERE (SELECT COUNT(sgbstdn_pidm) FROM sgbstdn sg,spbpers WHERE sgbstdn_pidm=spbpers_pidm
and spbpers_ssn=COL01 )>1 ;


SELECT * FROM BU_DEV.TMP_TBL_KILANY1
WHERE  
   COL17  ='„ﬂ „·' 
 AND COL18!='„ƒﬂœ'
 AND COL24!='—›÷'
 AND COL02 IS NOT NULL 
AND COL19 IS NULL 
;

UPDATE 
BU_DEV.TMP_TBL_KILANY1 SET COL16='SAAQUIK'
WHERE COL02 IS NOT NULL 
AND COL17!='„ﬂ „·'
AND 
 ;
 
 
 UPDATE 
BU_DEV.TMP_TBL_KILANY1 SET COL16='SAADCRV'
 WHERE  
   COL17  ='„ﬂ „·' 
 AND COL18!='„ƒﬂœ'
 AND COL24!='—›÷'
 AND COL02 IS NOT NULL 
AND COL19 IS NULL 
AND
;
  SELECT * FROM BU_DEV.TMP_TBL_KILANY1
  WHERE COL19=' „ «·«‰”Õ«»'
    AND COL24!='—›÷' ;

 UPDATE 
BU_DEV.TMP_TBL_KILANY1 SET COL16='SAADCRV'
 WHERE COL19=' „ «·«‰”Õ«»'
    AND COL24!='—›÷' ;
    
      SELECT * FROM BU_DEV.TMP_TBL_KILANY1
  WHERE COL02 IS NULL 
   AND COL24!='—›÷' ;
   
   
   SELECT * FROM BU_DEV.TMP_TBL_KILANY1
  WHERE COL02 IS NULL 
   AND COL24!='—›÷'
   AND EXISTS (SELECT '1' FROM SARAPPD,SPBPERS WHERE spbpers_PIDM=SARAPPD_PIDM AND SPBPERS_SSN=COL01) ;
   
   
    UPDATE 
BU_DEV.TMP_TBL_KILANY1 SET COL16='SAADCRV'
  WHERE COL02 IS NULL 
   AND COL24!='—›÷'
   AND EXISTS (SELECT '1' FROM SARAPPD,SPBPERS WHERE spbpers_PIDM=SARAPPD_PIDM AND SPBPERS_SSN=COL01)  ;
   
      SELECT * FROM BU_DEV.TMP_TBL_KILANY1
  WHERE COL02 IS NULL 
   AND COL24!='—›÷'
   AND NOT EXISTS (SELECT '1' FROM SARAPPD,SPBPERS WHERE spbpers_PIDM=SARAPPD_PIDM AND SPBPERS_SSN=COL01) ;
   
   UPDATE 
BU_DEV.TMP_TBL_KILANY1 SET COL16='SAAQUIK'
 WHERE COL02 IS NULL 
   AND COL24!='—›÷'
   AND NOT EXISTS (SELECT '1' FROM SARAPPD,SPBPERS WHERE spbpers_PIDM=SARAPPD_PIDM AND SPBPERS_SSN=COL01) ;
   
    SELECT * FROM BU_DEV.TMP_TBL_KILANY1
  WHERE COL02 IS NULL 
   AND COL24!='—›÷'
   AND NOT EXISTS (SELECT '1' FROM SARAPPD,SPBPERS WHERE spbpers_PIDM=SARAPPD_PIDM AND SPBPERS_SSN=COL01) ;
   
   SELECT * FROM BU_DEV.TMP_TBL_KILANY1
  WHERE  
     COL24='—›÷'
     
     ;
     DELETE  FROM BU_DEV.TMP_TBL_KILANY1
  WHERE  
     COL24='—›÷' ;
     DELETE  FROM BU_DEV.TMP_TBL_KILANY1
  WHERE  
     COL02 IS NULL ;
     
     SELECT * FROM BU_DEV.TMP_TBL_KILANY1
     WHERE 
     COL16 NOT IN ( 'SAAQUIK','SAADCRV') ;
     
     SELECT * FROM BU_DEV.TMP_TBL_KILANY1
     WHERE 
        exists (select '5' from sgbstdn where sgbstdn_pidm=col02 and sgbstdn_program_1=col24) 
        
        
 ;
     
     
    SELECT * FROM BU_DEV.TMP_TBL_KILANY1
     WHERE 
     COL16 NOT IN ( 'SAAQUIK','SAADCRV') ; 
     DELETE TRANSFER_STUDENT_PROGRAM;

INSERT INTO TRANSFER_STUDENT_PROGRAM (PIDM_CD,
                                      PROGRAM_CD,
                                      DEPT_CODE,
                                      MAJOR_CODE,
                                      NOTES)
                                      
  select COL02 ,COL24 ,SORCMJR_DEPT_CODE,SORCMJR_MAJR_CODE ,''  FROM
  
  
    BU_DEV.TMP_TBL_KILANY1 ,SOBCURR, SORCMJR
     WHERE 
     COL16 NOT IN ( 'SAAQUIK','SAADCRV') 
AND SOBCURR_CURR_RULE = SORCMJR_CURR_RULE
AND SOBCURR_PROGRAM=COL24
and col02!='335372'
 ;

 exec ITRANSFER_PROC ('144510')   ; 
 
 select * from shrdgmr 
 where  
 SHRDGMR_PIDM  in (select col02   FROM BU_DEV.TMP_TBL_KILANY1
     WHERE 
     COL16 NOT IN ( 'SAAQUIK','SAADCRV'))
AND SHRDGMR_SEQ_NO = 1 ;

SELECT * FROM BU_DEV.TMP_TBL_KILANY1
     WHERE 
     
  NOT  exists (select '1' from sfrstcr
where sfrstcr_term_code='144510'

and sfrstcr_pidm=col02 and sfrstcr_rsts_code in ('RE','RW'))     
 ; 
 
 DELETE FROM sfrstcr WHERE 
 sfrstcr_term_code='144510'
AND  EXISTS (SELECT '1' FROM BU_DEV.TMP_TBL_KILANY1 WHERE sfrstcr_pidm=col02 ) ;
 
UPDATE SGBSTDN
SET SGBSTDN_BLCK_CODE = NULL 
WHERE EXISTS (SELECT '1' FROM 
BU_DEV.TMP_TBL_KILANY1
WHERE COL02=SGBSTDN_PIDM

) 
AND SGBSTDN_TERM_CODE_EFF='144510' ;

DELETE FROM SGRADVR
WHERE EXISTS (SELECT '1' FROM 
BU_DEV.TMP_TBL_KILANY1
WHERE COL02=SGRADVR_PIDM

)
;




select  distinct SGBSTDN_BLCK_CODE , sgbstdn_program_1 ,count(sgbstdn_pidm)

from  sgbstdn a
                 where SGBSTDN_TERM_CODE_EFF = '144510'
                         AND SGBSTDN_TERM_CODE_ADMIT = '144510'
                         and sgbstdn_stst_code='AS'
                            AND EXISTS
                         (SELECT '1'
                            FROM BU_DEV.TMP_TBL_KILANY1
                           WHERE     COL02 = A.SGBSTDN_PIDM
                                  )
                                 and SGBSTDN_BLCK_CODE     IS     null
                                  
                                 and    not exists (select '1' from sfrstcr where sfrstcr_term_code='144510'
                                 and  sfrstcr_rsts_code in ('RE')
                                 and sfrstcr_pidm=A.SGBSTDN_PIDM)
                                 
                                 
                                 group by SGBSTDN_BLCK_CODE , sgbstdn_program_1
                                  ORDER BY 3 DESC
                                 ;
                                 
                                 
                              DELETE TRANSFER_STUDENT_PROGRAM;

INSERT INTO TRANSFER_STUDENT_PROGRAM (PIDM_CD,
                                      PROGRAM_CD,
                                      DEPT_CODE,
                                      MAJOR_CODE,
                                      NOTES)
                                      
  select COL02 ,COL24 ,SORCMJR_DEPT_CODE,SORCMJR_MAJR_CODE ,''  FROM
  
  
    BU_DEV.TMP_TBL_KILANY1 ,SOBCURR, SORCMJR
     WHERE 
     exists (select '5' from sgbstdn where sgbstdn_pidm=col02 and sgbstdn_program_1!=col24) 
AND SOBCURR_CURR_RULE = SORCMJR_CURR_RULE
AND SOBCURR_PROGRAM=COL24
 
 ;

 exec ITRANSFER_PROC ('144510')   ;     
                         UPDATE 
BU_DEV.TMP_TBL_KILANY1 SET COL16='ITRANSFER'
 WHERE COL02 IS NOT NULL 
   
   AND   EXISTS (SELECT '1' FROM TRANSFER_STUDENT_PROGRAM WHERE  PIDM_CD=COL02) ;
   
   
    UPDATE SYRBLKR
   SET SYRBLKR_CAPACITY_NO=SYRBLKR_CAPACITY_USED
   WHERE  EXISTS (SELECT '1 ' FROM BU_DEV.TMP_TBL_KILANY1 WHERE COL24=SYRBLKR_PROGRAM ) 
   AND SYRBLKR_TERM_CODE='144510' ;
   
   
   UPDATE SYRBLKR
   SET SYRBLKR_CAPACITY_NO=SYRBLKR_CAPACITY_NO+(SELECT COUNT(COL24) FROM BU_DEV.TMP_TBL_KILANY1 WHERE COL24=SYRBLKR_PROGRAM )
   WHERE 
   EXISTS (SELECT '1 ' FROM BU_DEV.TMP_TBL_KILANY1 WHERE COL24=SYRBLKR_PROGRAM ) 
   AND SYRBLKR_TERM_CODE='144510'
   ;
   
   
   Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'BLOCK_REG_ADM2', 'SAISUSR', 'ÿ·»… «·—“„', 'N', 
    SYSDATE, NULL);
 
 
Insert into GLBEXTR
   SELECT 'STUDENT', 'BLOCK_REG_ADM2', 'SAISUSR', 'SAISUSR',  PIDM, 
    SYSDATE, 'S', NULL  FROM 
(  SELECT COL02 PIDM
            FROM BU_DEV.TMP_TBL_KILANY1
            WHERE   EXISTS (
            SELECT '1' FROM SGBSTDN WHERE SGBSTDN_PIDM=COL02
            AND SGBSTDN_BLCK_CODE IS NULL
            )
            
            
                 )
  ;
  
  select * FROM BU_DEV.TMP_TBL_KILANY1
  WHERE 
  EXISTS (SELECT '1' FROM SGBSTDN WHERE SGBSTDN_BLCK_CODE IS NULL
  AND SGBSTDN_PIDM=COL02
  AND SGBSTDN_STST_CODE='AS'
  ) ;
  