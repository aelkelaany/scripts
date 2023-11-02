/* Formatted on 11/1/2023 11:48:19 AM (QP5 v5.371) */
SELECT * FROM BU_DEV.TMP_TBL_KILANY4;

UPDATE BU_DEV.TMP_TBL_KILANY4
   SET col05 = INITCAP (col05);
   UPDATE BU_DEV.TMP_TBL_KILANY4
   SET col05 = trim (col05);

SELECT *
  FROM BU_DEV.TMP_TBL_KILANY4
 WHERE NOT EXISTS
           (SELECT '1'
              FROM scbcrse
             WHERE scbcrse_subj_code = col01 AND scbcrse_crse_numb = col02);

SELECT *
  FROM BU_DEV.TMP_TBL_KILANY4
 WHERE EXISTS
           (SELECT '1'
              FROM dle.scbcrse
             WHERE scbcrse_subj_code = col01 AND scbcrse_crse_numb = col02);

----

SELECT COL01,
       COL02,
       COL03,
       COL04,
       COL05,
       SCBCRSE_EFF_TERM,
        
       SCBCRSE_TITLE 
  FROM BU_DEV.TMP_TBL_KILANY4 a, dle.scbcrse
 WHERE scbcrse_subj_code = col01 AND scbcrse_crse_numb = col02;
 -- duplicates
 
 select col01||col02   
 from BU_DEV.TMP_TBL_KILANY4
 group by col01||col02 
 having count(1)>1 ;
 
 select * from  BU_DEV.TMP_TBL_KILANY4
 where length(col05)>30 ;
 ---1548
 update dle.scbcrse
 set SCBCRSE_TITLE=(select  distinct COL05 from BU_DEV.TMP_TBL_KILANY4 where col01=scbcrse_subj_code and col02=scbcrse_crse_numb )
 where exists (
 select '1' from  
 BU_DEV.TMP_TBL_KILANY4
 where col01=scbcrse_subj_code and col02=scbcrse_crse_numb
 ) ;