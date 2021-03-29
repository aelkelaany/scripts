/* Formatted on 28/03/2021 12:19:06 (QP5 v5.227.12220.39754) */
SELECT A.*, "OVER_ALL" - ("ACT" + "REG_HRS")
  FROM (  SELECT f_get_std_id (SMBPOGN_PIDM) AS "ÇáÑÞã ÇáÌÇãÚí",
                 f_get_std_name (SMBPOGN_PIDM) AS "ÇáÇÓã",
                 NEW_COMP.SMBPOGN_REQUEST_NO "REQUEST NEW",
                 NEW_COMP.SMBPOGN_PROGRAM AS "ÇáÈÑäÇãÌ",
                 NEW_COMP.SMBPOGN_REQ_CREDITS_OVERALL AS "OVER_ALL",
                 F_GET_DESC_FNC('STVCOLL',NEW_COMP.SMBPOGN_COLL_CODE,30) AS "ÇáßáíÉ",
                 SUM (
                    CAPP_MANIPULATION_FUNCTIONAL.F_GET_CRSE_CREDIT_HR (
                       SMRDORQ_SUBJ_CODE,
                       SMRDORQ_CRSE_NUMB_LOW))
                    AS "ACT",
                 (SELECT SUM (SFRSTCR_CREDIT_HR)
                    FROM SFRSTCR
                   WHERE     SFRSTCR_PIDM = SMBPOGN_PIDM
                         AND sfrstcr_term_code = '144220'
                         AND sfrstcr_rsts_code IN ('RE', 'RW'))
                    AS "REG_HRS"
            FROM SMBPOGN NEW_COMP, SMRDORQ
           WHERE     SMRDORQ_PIDM = SMBPOGN_PIDM
                 AND SMBPOGN_REQUEST_NO = SMRDORQ_REQUEST_NO
                 AND SMRDORQ_MET_IND = 'Y'
                 AND F_GET_STATUS (SMBPOGN_PIDM) = 'AS'
                 AND F_GET_STYP(SMBPOGN_PIDM) IN ('ã','Ê')
                 
                 -- AND SMBPOGN_PIDM = 155236
                 AND SMBPOGN_LEVL_CODE = 'Ìã'
                 --AND NEW_COMP.SMBPOGN_COLL_CODE IN ('18', '15', '17', '19', '42', '41', '16', '31') -->>>>>>>>>>>>>>>>>>>>>>>COLLEGE
                 AND NEW_COMP.SMBPOGN_REQUEST_NO =
                        (SELECT MAX (SMBPOGN_REQUEST_NO)
                           FROM SMBPOGN
                          WHERE SMBPOGN_PIDM = NEW_COMP.SMBPOGN_PIDM)
                 --                 AND EXISTS
                 --                        (SELECT '1'
                 --                           FROM SPRIDEN
                 --                          WHERE     SUBSTR (SPRIDEN_ID, 1, 3) < '438'
                 --                                AND SUBSTR (SPRIDEN_ID, 1, 3) >= '433'
                 --                                AND SPRIDEN_PIDM = SMBPOGN_PIDM) -->> SPECIFIC STUDENT CHOHORT
                 AND EXISTS
                        (SELECT '1'
                           FROM SFRSTCR
                          WHERE     SFRSTCR_PIDM = SMBPOGN_PIDM
                                AND sfrstcr_term_code = '144220'
                                AND sfrstcr_rsts_code IN ('RE', 'RW'))
        GROUP BY SMBPOGN_PIDM,
                 NEW_COMP.SMBPOGN_REQUEST_NO,
                 NEW_COMP.SMBPOGN_PROGRAM,
                 NEW_COMP.SMBPOGN_REQ_CREDITS_OVERALL,
                 NEW_COMP.SMBPOGN_COLL_CODE) A
 WHERE "OVER_ALL" - ("ACT"+"REG_HRS") BETWEEN 1 AND 10;