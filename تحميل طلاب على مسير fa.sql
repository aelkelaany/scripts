CREATE TABLE BU_DEV.TMP_TBRACCD08 AS SELECT * FROM   TBRACCD WHERE
TBRACCD_DETAIL_CODE = 'ã.ÊÝ'
AND TBRACCD_TERM_CODE = '144430' ;

CREATE TABLE BU_DEV.TMP_RWTPAYR08 AS SELECT * FROM RWTPAYR WHERE RWTPAYR_TRAN_NUMBER = 906 ; 

DELETE FROM  TBRACCD WHERE
TBRACCD_DETAIL_CODE = 'ã.ÊÝ'
AND TBRACCD_TERM_CODE = '144430' ;

DELETE FROM RWTPAYR WHERE RWTPAYR_TRAN_NUMBER = 906 ; 

----------------



DELETE FROM BU_DEV.TMP_TBL_KILANY2 ;
SELECT * FROM  BU_DEV.TMP_TBL_KILANY2 ; 
DELETE FROM BU_DEV.TMP_TBL_KILANY2 WHERE COL01 IS NULL ; 
UPDATE  BU_DEV.TMP_TBL_KILANY2 SET COL10='GRD10' WHERE COL10 IS NULL;

----------------

-- INSERTING INTO RWTPAYR

INSERT INTO SATURN.RWTPAYR (RWTPAYR_TRAN_NUMBER,
                            RWTPAYR_PIDM,
                            RWTPAYR_ID,
                            RWTPAYR_NAME,
                            RWTPAYR_CAMP_CODE,
                            RWTPAYR_CAMP_DESC,
                            RWTPAYR_COLL_CODE,
                            RWTPAYR_COLL_DESC,
                            RWTPAYR_DEPT_CODE,
                            RWTPAYR_DEPT_DESC,
                            RWTPAYR_LEVEL_CODE,
                            RWTPAYR_LEVEL_DESC,
                            RWTPAYR_TERM_CODE,
                            RWTPAYR_TERM_DESC,
                            RWTPAYR_EFF_YEAR,
                            RWTPAYR_EFF_MONTH,
                            RWTPAYR_FA_YEAR,
                            RWTPAYR_CHARGE,
                            RWTPAYR_PAYMENT,
                            RWTPAYR_DEDUCTION,
                            RWTPAYR_ACTIVITY_DATE,
                            RWTPAYR_CELG_CODE,
                            RWTPAYR_CELG_DESC,
                            RWTPAYR_REG_EXP_FLAG,
                            RWTPAYR_PROCESSED_FLAG,
                            RWTPAYR_CHRG_PROCESS_FLAG,
                            RWTPAYR_DEDCT_PROCESS_FLAG,
                            RWTPAYR_NON_FA_DED,
                            RWTPAYR_PREV_PAYMENT,
                            RWTPAYR_NOTE,
                            RWTPAYR_USER)
    SELECT 925,
           SGBSTDN_PIDM,
           F_GET_STD_ID (SGBSTDN_PIDM),
           F_GET_STD_NAME (SGBSTDN_PIDM),
           SGBSTDN_CAMP_CODE,
           F_GET_DESC_FNC ('STVCAMP', SGBSTDN_CAMP_CODE, 30),
           SGBSTDN_COLL_CODE_1,
           F_GET_DESC_FNC ('STVCOLL', SGBSTDN_COLL_CODE_1, 30),
           SGBSTDN_DEPT_CODE,
           F_GET_DESC_FNC ('STVDEPT', SGBSTDN_DEPT_CODE, 30),
           SGBSTDN_LEVL_CODE,
           F_GET_DESC_FNC ('STVLEVL', SGBSTDN_LEVL_CODE, 30),
           '144510',
           F_GET_DESC_FNC ('STVTERM', '144430', 30),
           '2023',
           '07',
           '1444',
           0,
           1000,
           0,
           SYSDATE,
           '0',
           'Regular KSA Students',
           'X',
           'N',
           'N',
           'N',
           0,
           0,
           NULL,
           NULL
      FROM SGBSTDN SG
     WHERE     SGBSTDN_TERM_CODE_EFF =
               (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                  FROM SGBSTDN
                 WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                       AND SGBSTDN_TERM_CODE_EFF <= '144430')
           AND SGBSTDN_PIDM IN (SELECT COL01
                                  FROM BU_DEV.TMP_TBL_KILANY2
                                  );
                                  
                                  -- INSERTING TBRACCD
                                  
                                  /* Formatted on 8/3/2023 3:43:25 PM (QP5 v5.371) */
INSERT INTO TAISMGR.TBRACCD (TBRACCD_PIDM,
                             TBRACCD_TRAN_NUMBER,
                             TBRACCD_TERM_CODE,
                             TBRACCD_DETAIL_CODE,
                             TBRACCD_USER,
                             TBRACCD_ENTRY_DATE,
                             TBRACCD_ACTIVITY_DATE,
                             TBRACCD_AMOUNT,
                             TBRACCD_BALANCE,
                             TBRACCD_EFFECTIVE_DATE,
                             TBRACCD_BILL_DATE,
                             TBRACCD_DUE_DATE,
                             TBRACCD_DESC,
                             TBRACCD_RECEIPT_NUMBER,
                             TBRACCD_TRAN_NUMBER_PAID,
                             TBRACCD_CROSSREF_PIDM,
                             TBRACCD_CROSSREF_NUMBER,
                             TBRACCD_CROSSREF_DETAIL_CODE,
                             TBRACCD_SRCE_CODE,
                             TBRACCD_ACCT_FEED_IND,
                             TBRACCD_SESSION_NUMBER,
                             TBRACCD_CSHR_END_DATE,
                             TBRACCD_CRN,
                             TBRACCD_CROSSREF_SRCE_CODE,
                             TBRACCD_LOC_MDT,
                             TBRACCD_LOC_MDT_SEQ,
                             TBRACCD_RATE,
                             TBRACCD_UNITS,
                             TBRACCD_DOCUMENT_NUMBER,
                             TBRACCD_TRANS_DATE,
                             TBRACCD_PAYMENT_ID,
                             TBRACCD_INVOICE_NUMBER,
                             TBRACCD_STATEMENT_DATE,
                             TBRACCD_INV_NUMBER_PAID,
                             TBRACCD_CURR_CODE,
                             TBRACCD_EXCHANGE_DIFF,
                             TBRACCD_FOREIGN_AMOUNT,
                             TBRACCD_LATE_DCAT_CODE,
                             TBRACCD_FEED_DATE,
                             TBRACCD_FEED_DOC_CODE,
                             TBRACCD_ATYP_CODE,
                             TBRACCD_ATYP_SEQNO,
                             TBRACCD_CARD_TYPE_VR,
                             TBRACCD_CARD_EXP_DATE_VR,
                             TBRACCD_CARD_AUTH_NUMBER_VR,
                             TBRACCD_CROSSREF_DCAT_CODE,
                             TBRACCD_ORIG_CHG_IND,
                             TBRACCD_CCRD_CODE,
                             TBRACCD_MERCHANT_ID,
                             TBRACCD_TAX_REPT_YEAR,
                             TBRACCD_TAX_REPT_BOX,
                             TBRACCD_TAX_AMOUNT,
                             TBRACCD_TAX_FUTURE_IND,
                             TBRACCD_DATA_ORIGIN,
                             TBRACCD_CREATE_SOURCE,
                             TBRACCD_CPDT_IND,
                             TBRACCD_AIDY_CODE,
                             TBRACCD_STSP_KEY_SEQUENCE,
                             TBRACCD_PERIOD)
    SELECT SGBSTDN_PIDM,
           NVL ((SELECT MAX (TBRACCD_TRAN_NUMBER) + 1
                   FROM TBRACCD
                  WHERE TBRACCD_PIDM = SGBSTDN_PIDM),
                1),
           '144430',
           'ã.ÊÝ',
           USER,
           TO_DATE ('7/23/2023 8:51:35 AM', 'MM/DD/YYYY HH:MI:SS AM'),
           TO_DATE ('7/23/2023 8:51:35 AM', 'MM/DD/YYYY HH:MI:SS AM'),
           1000,
           -1000,
           TO_DATE ('7/23/2023 8:51:35 AM', 'MM/DD/YYYY HH:MI:SS AM'),
           NULL,
           NULL,
           'ãßÇÝÃÉ ÊÝæÞ',
           4603132,
           NULL,
           NULL,
           NULL,
           NULL,
           'F',
           'Y',
           0,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           TO_DATE ('7/23/2023 8:51:35 AM', 'MM/DD/YYYY HH:MI:SS AM'),
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           NULL
      FROM SGBSTDN SG
     WHERE     SGBSTDN_TERM_CODE_EFF =
               (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                  FROM SGBSTDN
                 WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                       AND SGBSTDN_TERM_CODE_EFF <= '144430')
           AND SGBSTDN_PIDM IN (SELECT COL01
                                  FROM BU_DEV.TMP_TBL_KILANY2
                                  );