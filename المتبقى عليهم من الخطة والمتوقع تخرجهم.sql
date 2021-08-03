/* Formatted on 29/03/2021 10:12:44 (QP5 v5.227.12220.39754) */
SELECT A.*, "OVER_ALL" - ("ACT" + "REG_HRS")
  FROM (  SELECT f_get_std_id (SMBPOGN_PIDM) AS "«·—ﬁ„ «·Ã«„⁄Ì",
                 f_get_std_name (SMBPOGN_PIDM) AS "«·«”„",
                 NEW_COMP.SMBPOGN_REQUEST_NO "REQUEST NEW",
                 NEW_COMP.SMBPOGN_PROGRAM AS "«·»—‰«„Ã",
                 NEW_COMP.SMBPOGN_REQ_CREDITS_OVERALL AS "OVER_ALL",
                 F_GET_DESC_FNC ('STVCOLL', NEW_COMP.SMBPOGN_COLL_CODE, 30)
                    AS "«·ﬂ·Ì…",
                 F_GET_DESC_FNC ('STVDEPT', sgbstdn_dept_code, 30) dept,
                 (SELECT SUM (crd_hrs)
                    FROM (SELECT CAPP_MANIPULATION_FUNCTIONAL.F_GET_CRSE_CREDIT_HR (
                                    smrdorq_SUBJ_CODE,
                                    smrdorq_CRSE_NUMB_low)
                                    crd_hrs
                            FROM smrdorq
                           WHERE     smrdorq_PIDM = SMBPOGN_PIDM
                                 AND smrdorq_REQUEST_NO =
                                        NEW_COMP.SMBPOGN_REQUEST_NO
                                 AND SMRDORQ_MET_IND = 'Y'
                          UNION ALL
                          SELECT SMBDRRQ_ACT_CREDITS
                            FROM SMBDRRQ
                           WHERE     SMBDRRQ_MET_IND = 'Y'
                                 AND SMBDRRQ_PIDM = SMBPOGN_PIDM
                                 AND SMBDRRQ_REQUEST_NO =
                                        NEW_COMP.SMBPOGN_REQUEST_NO))
                    AS "ACT",
                 (SELECT SUM (SFRSTCR_CREDIT_HR)
                    FROM SFRSTCR
                   WHERE     SFRSTCR_PIDM = SMBPOGN_PIDM
                         AND sfrstcr_term_code = '144230'
                         AND sfrstcr_rsts_code IN ('RE', 'RW'))
                    AS "REG_HRS"
            FROM SMBPOGN NEW_COMP, sgbstdn A
           WHERE     SMBPOGN_PIDM = A.SGBSTDN_PIDM
                 AND A.SGBSTDN_TERM_CODE_EFF =
                        (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                           FROM SGBSTDN
                          WHERE SGBSTDN_PIDM = A.SGBSTDN_PIDM)
                 AND SGBSTDN_STST_CODE = 'AS'
                  AND A.SGBSTDN_STYP_CODE IN ('„', '')
                 and sgbstdn_coll_code_1 not in ('14','33','55','25')
                 AND SMBPOGN_LEVL_CODE in ( 'Ã„','')
                 AND NEW_COMP.SMBPOGN_REQUEST_NO =
                        (SELECT MAX (SMBPOGN_REQUEST_NO)
                           FROM SMBPOGN
                          WHERE SMBPOGN_PIDM = NEW_COMP.SMBPOGN_PIDM)
                 AND EXISTS
                        (SELECT '1'
                           FROM SFRSTCR
                          WHERE     SFRSTCR_PIDM = SMBPOGN_PIDM
                                AND sfrstcr_term_code = '144230'
                                AND sfrstcr_rsts_code IN ('RE', 'RW'))
        GROUP BY SMBPOGN_PIDM,
                 NEW_COMP.SMBPOGN_REQUEST_NO,
                 NEW_COMP.SMBPOGN_PROGRAM,
                 NEW_COMP.SMBPOGN_REQ_CREDITS_OVERALL,sgbstdn_dept_code ,
                 NEW_COMP.SMBPOGN_COLL_CODE) A
 WHERE "OVER_ALL" <= ("ACT" + "REG_HRS")  ;