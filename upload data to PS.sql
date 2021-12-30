 
Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'BLOCK_REG_143910_k3', 'SAISUSR', '���� �����', 'N', 
    SYSDATE, NULL);
 
 
Insert into GLBEXTR
   SELECT 'STUDENT', 'BLOCK_REG_143910_k3', 'SAISUSR', 'SAISUSR', SFRSTCR_PIDM, 
    SYSDATE, 'S', NULL  FROM 
(  SELECT SFRSTCR_PIDM
            FROM SFRSTCR
           WHERE     SFRSTCR_TERM_CODE = '143920'
                 AND SFRSTCR_RSTS_CODE IN ('RW', 'RE')
                 AND SFRSTCR_CRN = '28425'
        ORDER BY SFRSTCR_PIDM DESC)
 WHERE ROWNUM < 51 ;
 
 
 
 ---------------------------------------------------------------------------------
 Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'BLOCK_REG_143920_f16', 'SAISUSR', '���� �����', 'N', 
    SYSDATE, NULL);
 
 
Insert into GLBEXTR
   SELECT 'STUDENT', 'BLOCK_REG_143920_f16', 'SAISUSR', 'SAISUSR', SGBSTDN_PIDM, 
    SYSDATE, 'S', NULL  FROM 
(  SELECT A.SGBSTDN_PIDM  
    FROM SGBSTDN A, bu_dev.temp_tbl01 C
   WHERE     SGBSTDN_TERM_CODE_EFF =
                (SELECT MAX (B.SGBSTDN_TERM_CODE_EFF)
                   FROM SGBSTDN B
                  WHERE     SGBSTDN_TERM_CODE_EFF <= '143920'
                        AND B.SGBSTDN_PIDM = A.SGBSTDN_PIDM)
         AND C.C_COL01 = A.SGBSTDN_PIDM
         AND A.SGBSTDN_BLCK_CODE = 'F16'
ORDER BY A.SGBSTDN_PIDM DESC)
 WHERE ROWNUM < 23 ;
 
 
 --------------------
 
 Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'SUB144030', 'SAISUSR', '���� ���������', 'N', 
    SYSDATE, NULL);
 
 
Insert into GLBEXTR
   SELECT 'STUDENT', 'SUB144030', 'SAISUSR', 'SAISUSR',  PIDM, 
    SYSDATE, 'S', NULL  FROM 
(  SELECT DISTINCT  PIDM.ITEM_VALUE PIDM
            FROM REQUEST_DETAILS PIDM ,REQUEST_DETAILS TERM
           WHERE
           PIDM.ITEM_CODE='STUDENT_PIDM'
           AND TERM.ITEM_VALUE='144030'
           AND TERM.ITEM_CODE='TERM'
           AND PIDM.SEQUENCE_NO=1  
           AND TERM.SEQUENCE_NO = PIDM.SEQUENCE_NO
           AND TERM.REQUEST_NO = PIDM.REQUEST_NO 
           AND  EXISTS (SELECT '1' FROM REQUEST_MASTER 
           WHERE OBJECT_CODE='WF_INTERNAL_EQUATION'
           AND REQUEST_STATUS='C'
           AND REQUEST_NO=PIDM.REQUEST_NO)
           AND F_GET_STATUS(PIDM.ITEM_VALUE)='AS'
           )
                 
                 
          
  ;
  
  -------------------
  Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'CRN30838', 'SAISUSR', '30838', 'N', 
    SYSDATE, NULL);
 
 
Insert into GLBEXTR
   SELECT 'STUDENT', 'CRN30838', 'SAISUSR', 'SAISUSR', SFRSTCR_PIDM, 
    SYSDATE, 'S', NULL  FROM 
(  SELECT SFRSTCR_PIDM
            FROM SFRSTCR
           WHERE     SFRSTCR_TERM_CODE = '144030'
                 AND SFRSTCR_RSTS_CODE IN ('RW', 'RE')
                 AND SFRSTCR_CRN = '30838'
        ORDER BY SFRSTCR_PIDM DESC)
  ;
  
  -----------comp
  
  Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'COMP3302', 'SAISUSR', '3302������� ', 'N', 
    SYSDATE, NULL);
 
 
Insert into GLBEXTR
   SELECT 'STUDENT', 'COMP3302', 'SAISUSR', 'SAISUSR', SGBSTDN_PIDM, 
    SYSDATE, 'S', NULL  FROM 
(  SELECT A.SGBSTDN_PIDM  
    FROM SGBSTDN A 
   WHERE     SGBSTDN_TERM_CODE_EFF =
                (SELECT MAX (B.SGBSTDN_TERM_CODE_EFF)
                   FROM SGBSTDN B
                  WHERE     
  B.SGBSTDN_PIDM = A.SGBSTDN_PIDM)
  AND A.SGBSTDN_STST_CODE NOT IN ('��','��','��')
        
         AND A.SGBSTDN_PROGRAM_1 IN ('1-3302-1433','2-3302-1433')
 )
  ;
  
  
  
  Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'COMP3302', 'SAISUSR', '3302������� ', 'N', 
    SYSDATE, NULL);
 
 
Insert into GLBEXTR
   SELECT 'STUDENT', 'COMP3302', 'SAISUSR', 'SAISUSR', SFRSTCR_PIDM, 
    SYSDATE, 'S', NULL  FROM 
(  SELECT SFRSTCR_PIDM
            FROM SFRSTCR
           WHERE     SFRSTCR_TERM_CODE = '144310'
                 AND SFRSTCR_RSTS_CODE IN ('RW', 'RE')
                 AND SFRSTCR_CRN = '25333'
        ORDER BY SFRSTCR_PIDM DESC)
  ;
  
----����� ����� �� ���
declare 
cursor get_data is select  distinct col03 crn  from bu_dev.tmp_tbl_kilany;
begin 
for rec in get_data loop 
Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'REG_MA_'||rec.crn, 'SAISUSR', '�����  ', 'N', 
    SYSDATE, NULL);
    
    
    Insert into GLBEXTR
   SELECT 'STUDENT', 'REG_MA_'||rec.crn, 'SAISUSR', 'SAISUSR',  PIDM, 
    SYSDATE, 'S', NULL  FROM 
(  SELECT  f_get_pidm(col02) PIDM
            from bu_dev.tmp_tbl_kilany
           WHERE      col03=crn)
        
        ;
        DBMS_OUTPUT.put_line ('REG_MA_'||rec.crn );
        
        
        end ;