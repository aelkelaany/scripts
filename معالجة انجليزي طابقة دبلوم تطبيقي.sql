/* Formatted on 11/28/2022 11:25:43 AM (QP5 v5.371) */
SELECT A.SMRDORQ_PIDM,
       F_GET_STD_ID (A.SMRDORQ_PIDM)       STD_ID,
       F_GET_STD_NAME (A.SMRDORQ_PIDM)     STD_NAME,
       A.SMRDORQ_PROGRAM,
       A.SMRDORQ_SUBJ_CODE || A.SMRDORQ_CRSE_NUMB_LOW,
       B.SMRDOUS_CRN,
       B.SMRDOUS_TITLE,
       B.SMRDOUS_TERM_CODE,
       B.SMRDOUS_SUBJ_CODE || B.SMRDOUS_CRSE_NUMB,
       B.SMRDOUS_GRDE_CODE,
       '---',
       C.SMRDORQ_SUBJ_CODE || C.SMRDORQ_CRSE_NUMB_LOW ,D.SMRDOUS_CRN,
       D.SMRDOUS_TITLE,
       D.SMRDOUS_TERM_CODE,
       D.SMRDOUS_SUBJ_CODE || D.SMRDOUS_CRSE_NUMB,
       D.SMRDOUS_GRDE_CODE
  FROM smrdorq a, SMRDOUS B, smrdorq C ,SMRDOUS D
 WHERE     A.smrdorq_request_no = (SELECT MAX (smrdorq_request_no)
                                   FROM smrdorq
                                  WHERE smrdorq_pidm = a.smrdorq_pidm)
       AND EXISTS
               (SELECT '1'
                  FROM SGBSTDN sg
                 WHERE     SGBSTDN_TERM_CODE_EFF =
                           (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                              FROM sgbstdn
                             WHERE sgbstdn_pidm = sg.sgbstdn_pidm)
                       AND sg.sgbstdn_pidm = a.smrdorq_pidm
                       AND sgbstdn_stst_code IN ('AS', 'ãæ', 'ãÚ')
                       AND sgbstdn_coll_code_1 IN ('14',
                                                   '25',
                                                   '55',
                                                   '33',
                                                   '32',
                                                   '41'))
       AND A.SMRDORQ_MET_IND = 'Y'
       AND A.SMRDORQ_SUBJ_CODE || A.SMRDORQ_CRSE_NUMB_LOW = 'ENGL1003'
        
       
       AND a.SMRDORQ_PIDM = B.SMRDOUS_PIDM
       AND B.smrdoUS_request_no = A.smrdorq_request_no
       AND a.SMRDORQ_AREA = B.SMRDOUS_AREA
       AND a.SMRDORQ_CAA_SEQNO = B.SMRDOUS_CAA_SEQNO
       AND a.SMRDORQ_PIDM = C.SMRDORQ_PIDM
       AND A.smrdorq_request_no = C.smrdorq_request_no
       AND C.SMRDORQ_MET_IND = 'Y'
       AND C.SMRDORQ_SUBJ_CODE || C.SMRDORQ_CRSE_NUMB_LOW = 'ENGL1002'
       
        AND C.SMRDORQ_PIDM = D.SMRDOUS_PIDM
       AND D.smrdoUS_request_no = C.smrdorq_request_no
       AND C.SMRDORQ_AREA = D.SMRDOUS_AREA
       AND C.SMRDORQ_CAA_SEQNO = D.SMRDOUS_CAA_SEQNO
       AND EXISTS
               (SELECT '1'
                  FROM smrdorq
                 WHERE     smrdorq_request_no = A.smrdorq_request_no
                       AND smrdorq_pidm = a.smrdorq_pidm
                       AND SMRDORQ_SUBJ_CODE || SMRDORQ_CRSE_NUMB_LOW IN
                               ('ENGL1001')
                       AND SMRDORQ_MET_IND = 'N')
                       ORDER BY 4,2
     --  AND B.SMRDOUS_PIDM = 242019