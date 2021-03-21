/* Formatted on 5/22/2020 8:29:18 PM (QP5 v5.360) */
/*CREATE TABLE DEV_BACKUP.SSRRTST302205 AS SELECT * FROM 
SSRRTST
WHERE SSRRTST_TERM_CODE = '144030' ;*/

SELECT DISTINCT *
  FROM BU_DEV.TMP_TBL03
 WHERE (COL02 IS NOT NULL OR COL03 IS NOT NULL) AND LENGTH (TRIM (COL03)) > 4;

DECLARE
    CURSOR GET_CRNs IS
        SELECT DISTINCT *
          FROM BU_DEV.TMP_TBL03
         WHERE     EXISTS
                       (SELECT 'y'
                          FROM SSRRTST
                         WHERE     SSRRTST_TERM_CODE = '144030'
                               AND SSRRTST_CRN = col01)
               AND NOT EXISTS
                       (SELECT 'i'
                          FROM SSRRTST
                         WHERE     SSRRTST_TERM_CODE = '144030'
                               AND SSRRTST_CRN = col01
                               AND SSRRTST_SUBJ_CODE_PREQ = col02
                               AND SSRRTST_CRSE_NUMB_PREQ = col03);

    L_SEQNO   NUMBER (3);
    l_insert_seq number(4):=0;
    l_fail_seq number(4):=0;
BEGIN
    FOR REC IN GET_CRNS
    LOOP
        BEGIN
            SELECT NVL (MAX (SSRRTST_SEQNO), 0) + 2
              INTO L_SEQNO
              FROM SSRRTST
             WHERE SSRRTST_TERM_CODE = '144030' AND SSRRTST_CRN = rec.col01;

            INSERT INTO SATURN.SSRRTST (SSRRTST_TERM_CODE,
                                        SSRRTST_CRN,
                                        SSRRTST_SEQNO,
                                        SSRRTST_TESC_CODE,
                                        SSRRTST_TEST_SCORE,
                                        SSRRTST_SUBJ_CODE_PREQ,
                                        SSRRTST_CRSE_NUMB_PREQ,
                                        SSRRTST_LEVL_CODE,
                                        SSRRTST_MIN_GRDE,
                                        SSRRTST_CONCURRENCY_IND,
                                        SSRRTST_CONNECTOR,
                                        SSRRTST_LPAREN,
                                        SSRRTST_RPAREN,
                                        SSRRTST_ACTIVITY_DATE)
                 VALUES ('144030',
                         TRIM (rec.COL01),
                         L_SEQNO,
                         NULL,
                         NULL,
                         TRIM (rec.COL02),
                         TRIM (rec.COL03),
                         'Ã„',
                         'œ',
                         NULL,
                         'O',
                         NULL,
                         NULL,
                         SYSDATE);
                         l_insert_seq:=l_insert_seq+1;
                         L_SEQNO:=0;
        EXCEPTION
            WHEN OTHERS
            THEN
            l_fail_seq:=l_fail_seq+1;
                DBMS_OUTPUT.put_line (
                       SQLERRM
                    || REC.COL01
                    || '-'
                    || REC.COL02
                    || '-'
                    || REC.COL03
                    || 'seq'
                    || L_SEQNO);
        END;
    END LOOP;
     DBMS_OUTPUT.put_line (l_insert_seq||' rows inserted');
     DBMS_OUTPUT.put_line (l_fail_seq||' rows failed');
END;