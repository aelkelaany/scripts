        SELECT RWTPAYR_PIDM PIDM,SGBSTDN_DEPT_CODE,SG.sgbstdn_program_1 programe,SWRPRDU_GROUP , crnt.*
          FROM SATURN.RWTPAYR crnt ,  SGBSTDN SG ,   
  SATURN.SWRPRDU
 

                       
         WHERE     RWTPAYR_TRAN_NUMBER = 913
               AND NOT EXISTS
                       (SELECT '1'
                          FROM SATURN.RWTPAYR
                         WHERE     RWTPAYR_PIDM = crnt.RWTPAYR_PIDM
                               AND RWTPAYR_TRAN_NUMBER IN( '924','926'))
               AND SGBSTDN_stst_code = 'AS'
and  SGBSTDN_TERM_CODE_EFF =
                           (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                              FROM SGBSTDN
                             WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                                   AND SGBSTDN_TERM_CODE_EFF <= '144510')
                       AND SGBSTDN_PIDM =RWTPAYR_PIDM
                       and SWRPRDU_PROGRAM=SG.sgbstdn_program_1 ;               

 ;

---------
DECLARE
    CURSOR GET_DATA IS
        SELECT RWTPAYR_PIDM PIDM, crnt.*
          FROM SATURN.RWTPAYR crnt
         WHERE     RWTPAYR_TRAN_NUMBER = 913
               AND NOT EXISTS
                       (SELECT '1'
                          FROM SATURN.RWTPAYR
                         WHERE     RWTPAYR_PIDM = crnt.RWTPAYR_PIDM
                               AND RWTPAYR_TRAN_NUMBER IN( '924','926'))
               AND F_GET_STATUS (RWTPAYR_PIDM) = 'AS'
               --AND RWTPAYR_DEPT_CODE = '1602'
               --AND RWTPAYR_PIDM = 300945
               ;

    L_DEPT             VARCHAR2 (5) := '1230';
    L_TRANSACTION_NO   RWTPAYR.RWTPAYR_TRAN_NUMBER%TYPE := '926';
    L_TERM_CODE        STVTERM.STVTERM_CODE%TYPE := '144510';
    L_YEAR             VARCHAR2 (6) := '2023';
    L_MONTH            VARCHAR2 (2) := '10';
    L_H_YEAR           VARCHAR2 (6) := '1445';
   /* L_AMOUNT           RWTPAYR.RWTPAYR_PAYMENT%TYPE := '850';               -- A
    L_AWARD_CODE       VARCHAR2 (10) := 'ãß.Ç';                          -- A
    L_AWARD_DESC       VARCHAR2 (150)
                           := 'ãßÇÝÃÉ ÔåÑíÉ ÇÏÈí 10/2023'; --  A
                           */
                           --
                               L_AMOUNT           RWTPAYR.RWTPAYR_PAYMENT%TYPE := '1000';               -- s
    L_AWARD_CODE       VARCHAR2 (10) := 'ãß.Ú';                          -- s
    L_AWARD_DESC       VARCHAR2 (150)
                           := 'ãßÇÝÃÉ ÔåÑíÉ Úáæã 10/2023'; --  s
BEGIN
    FOR REC IN GET_DATA
    LOOP
        BEGIN
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
                SELECT L_TRANSACTION_NO,
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
                       L_TERM_CODE,
                       F_GET_DESC_FNC ('STVTERM', L_TERM_CODE, 30),
                       L_YEAR,
                       L_MONTH,
                       L_H_YEAR,
                       0,
                       L_AMOUNT,
                       0,
                       SYSDATE,
                       '0',
                       'ÇáãäÊÙãíä',
                       'R', -->>>> voucher type
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
                                   AND SGBSTDN_TERM_CODE_EFF <= L_TERM_CODE)
                       AND SGBSTDN_PIDM = REC.PIDM
                       AND SGBSTDN_DEPT_CODE = L_DEPT;

            -- INSERTING TBRACCD


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
                       L_TERM_CODE,
                       L_AWARD_CODE,
                       USER,
                       SYSDATE,
                       SYSDATE,
                       L_AMOUNT,
                       (-1 * L_AMOUNT),
                       SYSDATE,
                       NULL,
                       NULL,
                       L_AWARD_DESC,
                       (SELECT MAX (TBRACCD_RECEIPT_NUMBER) + 1
                          FROM TBRACCD
                         WHERE TBRACCD_PIDM = REC.PIDM),
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
                       SYSDATE,
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
                                   AND SGBSTDN_TERM_CODE_EFF <= L_TERM_CODE)
                       AND SGBSTDN_PIDM = REC.PIDM
                       AND SGBSTDN_DEPT_CODE = L_DEPT;



            DBMS_OUTPUT.put_line (
                   '==='
                || REC.RWTPAYR_PIDM
                || '==='
                || REC.RWTPAYR_ID
                || '==='
                || REC.RWTPAYR_NAME
                || '==='
                || REC.RWTPAYR_CAMP_CODE
                || '==='
                || REC.RWTPAYR_CAMP_DESC
                || '==='
                || REC.RWTPAYR_COLL_CODE
                || '==='
                || REC.RWTPAYR_COLL_DESC
                || '==='
                || REC.RWTPAYR_DEPT_CODE
                || '==='
                || REC.RWTPAYR_DEPT_DESC
                || '==='
                || REC.RWTPAYR_LEVEL_CODE
                || '==='
                || REC.RWTPAYR_LEVEL_DESC
                || '==='
                || REC.RWTPAYR_TERM_CODE
                || '==='
                || REC.RWTPAYR_TERM_DESC
                || '==='
                || REC.RWTPAYR_EFF_YEAR
                || '==='
                || REC.RWTPAYR_EFF_MONTH
                || '==='
                || REC.RWTPAYR_FA_YEAR
                || '==='
                || REC.RWTPAYR_CHARGE
                || '==='
                || REC.RWTPAYR_PAYMENT);
        EXCEPTION
            WHEN OTHERS
            THEN
                DBMS_OUTPUT.put_line ('ERROR' || SQLERRM);
        END;
    END LOOP;
END;