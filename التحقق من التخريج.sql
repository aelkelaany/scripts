delete bu_dev.tmp_tbl03 where COL01 is null ;
UPDATE bu_dev.tmp_tbl03 SET COL02=F_GET_PIDM(COL01) ;
  
Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'GRD_MED21', 'SAISUSR', 'Œ—ÌÃÌ‰ 2021 ÿ» ', 'N', 
    SYSDATE, NULL);
 

Insert into GLBEXTR
   SELECT 'STUDENT', 'GRD_MED21', 'SAISUSR', 'SAISUSR', PIDM, 
    SYSDATE, 'S', NULL  FROM 
    (  SELECT DISTINCT COL02 PIDM
FROM bu_dev.tmp_tbl03
where COL02 is not null );

---------------------******************************----------------------------

SELECT F_GET_STD_ID(SGBSTDN_PIDM)
FROM SGBSTDN SG
WHERE SGBSTDN_PIDM IN 

    (  SELECT   GLBEXTR_KEY PIDM
FROM GLBEXTR
where GLBEXTR_SELECTION='GRD_MAY25DPLM' 
and GLBEXTR_APPLICATION='STUDENT' )
 
AND SGBSTDN_TERM_CODE_EFF =(SELECT MAX(SGBSTDN_TERM_CODE_EFF)
FROM SGBSTDN
WHERE 
SGBSTDN_PIDM=SG.SGBSTDN_PIDM)
AND SGBSTDN_STST_CODE <>'ŒÃ'

UNION

  SELECT DISTINCT F_GET_STD_ID(shrdgmr_pidm) --, SHRDGMR_LEVL_CODE ,shrdgmr_pidm
FROM 
shrdgmr A

WHERE  shrdgmr_pidm IN (    SELECT   GLBEXTR_KEY PIDM
FROM GLBEXTR
where GLBEXTR_SELECTION='GRD_MAY23' 
and GLBEXTR_APPLICATION='STUDENT' ) 

    -- and A.SHRDGMR_SEQ_NO=(select max(SHRDGMR_SEQ_NO) from SHRDGMR where shrdgmr_pidm=A.shrdgmr_pidm  )
     and NOT EXISTS (SELECT '1' FROM SHRDGMR
     WHERE SHRDGMR_PIDM=A.SHRDGMR_PIDM
     AND  SHRDGMR_DEGS_CODE ='ŒÃ') ;

--------------------+++++++++++++++++++++++++--------------------

SELECT F_GET_STD_ID(SGBSTDN_PIDM)
FROM SGBSTDN SG
WHERE SGBSTDN_PIDM IN 

    (  SELECT DISTINCT COL01 PIDM
FROM bu_dev.tmp_tbl03 )
 
AND SGBSTDN_TERM_CODE_EFF =(SELECT MAX(SGBSTDN_TERM_CODE_EFF)
FROM SGBSTDN
WHERE 
SGBSTDN_PIDM=SG.SGBSTDN_PIDM)
AND SGBSTDN_STST_CODE <>'ŒÃ'

UNION

  SELECT DISTINCT F_GET_STD_ID(shrdgmr_pidm) --, SHRDGMR_LEVL_CODE ,shrdgmr_pidm
FROM 
shrdgmr A

WHERE  shrdgmr_pidm IN (  SELECT DISTINCT COL01 PIDM
FROM bu_dev.tmp_tbl03 )

    -- and A.SHRDGMR_SEQ_NO=(select max(SHRDGMR_SEQ_NO) from SHRDGMR where shrdgmr_pidm=A.shrdgmr_pidm  )
     and NOT EXISTS (SELECT '1' FROM SHRDGMR
     WHERE SHRDGMR_PIDM=A.SHRDGMR_PIDM
     AND  SHRDGMR_DEGS_CODE ='ŒÃ') ;
     
     
     SATURN.SHRDGMR_GRAD_STU_TRG
     
     
     Select SGBSTDN_STST_CODE  , SGBSTDN_TERM_CODE_EFF, sgbstdn_program_1
    From   SGBSTDN S1
    Where  SGBSTDN_PIDM = f_get_pidm('441017416')
      and  SGBSTDN_TERM_CODE_EFF= (Select Max(SGBSTDN_TERM_CODE_EFF)
                                        From      SGBSTDN S2
                                   Where  S2.SGBSTDN_PIDM = S1.SGBSTDN_PIDM
                                     and  S2.SGBSTDN_levl_code = 'œ»'
                                    );
                                    
                                    
                                    
 --÷»ÿ œ»·Ê„«     
--update 
shrdgmr A set SHRDGMR_LEVL_CODE='œ»'

WHERE  shrdgmr_pidm IN (    SELECT   GLBEXTR_KEY PIDM
FROM GLBEXTR
where GLBEXTR_SELECTION='GRD_MAY25DPLM' 
and GLBEXTR_APPLICATION='STUDENT' ) 
and SHRDGMR_LEVL_CODE='Ã„'
 ;


-------«· Õﬁﬁ „‰ «· ”ÃÌ· 
  SELECT distinct f_get_std_id(SFRSTCR_PIDM),f_get_std_name(SFRSTCR_PIDM)
            FROM SFRSTCR
           WHERE     SFRSTCR_TERM_CODE = '144230'
                 AND SFRSTCR_RSTS_CODE IN ('RW', 'RE')
                 and SFRSTCR_PIDM in (SELECT A.SGBSTDN_PIDM  
    FROM SGBSTDN A 
   WHERE     SGBSTDN_TERM_CODE_EFF =
                (SELECT MAX (B.SGBSTDN_TERM_CODE_EFF)
                   FROM SGBSTDN B
                  WHERE     
  B.SGBSTDN_PIDM = A.SGBSTDN_PIDM)
  and sgbstdn_stst_code='ŒÃ');