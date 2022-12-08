/* Formatted on 11/01/2021 10:18:47 (QP5 v5.227.12220.39754) */
DELETE FROM BU_DEV.TMP_TBL03
      WHERE (COL01, COL02, COL03, COL04) IN (SELECT SCRRTST_SUBJ_CODE,
                                                    SCRRTST_CRSE_NUMB,
                                                    SCRRTST_SUBJ_CODE_PREQ,
                                                    SCRRTST_CRSE_NUMB_PREQ
                                               FROM SCRRTST);



INSERT INTO SCRRTST

SELECT distinct col01 ,col02,
       '000000',
       NVL (
            ROW_NUMBER ()
               OVER (PARTITION BY COL01 || COL02 ORDER BY COL01 || COL02)
          +(SELECT MAX (SCRRTST_SEQNO)
               FROM SCRRTST
              WHERE SCRRTST_SUBJ_CODE || SCRRTST_CRSE_NUMB = COL01 || COL02),
          1)
          row_num,
       NULL,
       NULL,
       COL03,
       COL04,
       'Ã„',
       'œ',
       NULL,
       'O',
       NULL,
       NULL,
       SYSDATE
  FROM BU_DEV.TMP_TBL03
   WHERE (COL01, COL02, COL03, COL04) not IN (SELECT SCRRTST_SUBJ_CODE,
                                                    SCRRTST_CRSE_NUMB,
                                                    SCRRTST_SUBJ_CODE_PREQ,
                                                    SCRRTST_CRSE_NUMB_PREQ
                                               FROM SCRRTST)
                                               and rownum <10
                                               
                                               SCRRTST
                                               SsRRTST
   ;