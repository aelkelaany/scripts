/* Formatted on 28/02/2021 13:45:14 (QP5 v5.227.12220.39754) */
SELECT A.*, "OVER_ALL" - ("ACT"+"REG_HRS")
  FROM (  SELECT f_get_std_id (SMBPOGN_PIDM) AS "«·—ﬁ„ «·Ã«„⁄Ì",
                 f_get_std_name (SMBPOGN_PIDM) AS "«·«”„",
                 NEW_COMP.SMBPOGN_REQUEST_NO "REQUEST NEW",
                 NEW_COMP.SMBPOGN_PROGRAM AS "«·»—‰«„Ã",
                 NEW_COMP.SMBPOGN_REQ_CREDITS_OVERALL AS "OVER_ALL",
                 NEW_COMP.SMBPOGN_COLL_CODE AS "«·ﬂ·Ì…",
                 SUM (
                    CAPP_MANIPULATION_FUNCTIONAL.F_GET_CRSE_CREDIT_HR (
                       SMRDORQ_SUBJ_CODE,
                       SMRDORQ_CRSE_NUMB_LOW))
                    AS "ACT" ,(SELECT SUM(SFRSTCR_CREDIT_HR) FROM SFRSTCR WHERE SFRSTCR_PIDM = SMBPOGN_PIDM
                                AND sfrstcr_term_code = '144220'
                                AND sfrstcr_rsts_code IN ('RE', 'RW') )AS "REG_HRS"
            FROM SMBPOGN NEW_COMP, SMRDORQ
           WHERE     SMRDORQ_PIDM = SMBPOGN_PIDM
                 AND SMBPOGN_REQUEST_NO = SMRDORQ_REQUEST_NO
                 AND SMRDORQ_MET_IND = 'Y'
                 -- AND  F_GET_STATUS (SMBPOGN_PIDM) = 'AS'
                -- AND SMBPOGN_PIDM = 155236
                 AND SMBPOGN_LEVL_CODE = 'Ã„'
                 AND NEW_COMP.SMBPOGN_COLL_CODE IN
                        ('18', '15', '17', '19', '42', '41', '16', '31')
                 AND NEW_COMP.SMBPOGN_REQUEST_NO =
                        (SELECT MAX (SMBPOGN_REQUEST_NO)
                           FROM SMBPOGN
                          WHERE SMBPOGN_PIDM = NEW_COMP.SMBPOGN_PIDM)
                 AND EXISTS
                        (SELECT '1'
                           FROM SPRIDEN
                          WHERE     SUBSTR (SPRIDEN_ID, 1, 3) < '438'
                                AND SUBSTR (SPRIDEN_ID, 1, 3) >= '433'
                                AND SPRIDEN_PIDM = SMBPOGN_PIDM)
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
 WHERE "OVER_ALL" - "ACT" between 1 and 24  ;
 
 
 
 /* Formatted on 28/02/2021 13:45:14 (QP5 v5.227.12220.39754) */
 
 select 
 
 
 f_get_std_id(SMRDOrq_PIDM),f_get_std_name(SMRDOrq_PIDM),
 SMRDORQ_SUBJ_CODE || SMRDORQ_CRSE_NUMB_LOW ,scbcrse_title ,q.*
 from 
 SMRDORQ q  ,scbcrse
 
 where
 
 
 SMRDORQ_MET_IND = 'N'
 and SMRDORQ_SUBJ_CODE || SMRDORQ_CRSE_NUMB_LOW=scbcrse_subj_code||scbcrse_crse_numb
    AND SCBCRSE_EFF_TERM =
              (SELECT MAX (SCBCRSE_EFF_TERM)
                 FROM SCBCRSE
                WHERE scbcrse_subj_code || scbcrse_crse_numb =
                         SMRDORQ_SUBJ_CODE || SMRDORQ_CRSE_NUMB_LOW)
   and  SMRDOrq_REQUEST_NO =
                                 (SELECT MAX (SMRDOrq_REQUEST_NO)
                                    FROM SMRDOrq
                                   WHERE SMRDOrq_PIDM = q.SMRDOrq_PIDM)
                                   and not exists(select '1' from sfrstcr ,ssbsect 
                                   where sfrstcr_term_code='144220'
                                   and ssbsect_term_code=sfrstcr_term_code
                                   and ssbsect_crn=sfrstcr_crn
                                   and sfrstcr_pidm=SMRDORQ_pidm
                                   and ssbsect_subj_code || ssbsect_crse_numb =
                         SMRDORQ_SUBJ_CODE || SMRDORQ_CRSE_NUMB_LOW)
 and SMRDORQ_pidm in 
 (
SELECT A.SMBPOGN_PIDM 
  FROM (  SELECT  SMBPOGN_PIDM ,
                 f_get_std_name (SMBPOGN_PIDM) AS "«·«”„",
                 NEW_COMP.SMBPOGN_REQUEST_NO "REQUEST NEW",
                 NEW_COMP.SMBPOGN_PROGRAM AS "«·»—‰«„Ã",
                 NEW_COMP.SMBPOGN_REQ_CREDITS_OVERALL AS "OVER_ALL",
                 NEW_COMP.SMBPOGN_COLL_CODE AS "«·ﬂ·Ì…",
                 SUM (
                    CAPP_MANIPULATION_FUNCTIONAL.F_GET_CRSE_CREDIT_HR (
                       SMRDORQ_SUBJ_CODE,
                       SMRDORQ_CRSE_NUMB_LOW))
                    AS "ACT" ,(SELECT SUM(SFRSTCR_CREDIT_HR) FROM SFRSTCR WHERE SFRSTCR_PIDM = SMBPOGN_PIDM
                                AND sfrstcr_term_code = '144220'
                                AND sfrstcr_rsts_code IN ('RE', 'RW') )AS "REG_HRS"
            FROM SMBPOGN NEW_COMP, SMRDORQ
           WHERE     SMRDORQ_PIDM = SMBPOGN_PIDM
                 AND SMBPOGN_REQUEST_NO = SMRDORQ_REQUEST_NO
                 AND SMRDORQ_MET_IND = 'Y'
                 -- AND  F_GET_STATUS (SMBPOGN_PIDM) = 'AS'
                -- AND SMBPOGN_PIDM = 155236
                 AND SMBPOGN_LEVL_CODE = 'Ã„'
                 AND NEW_COMP.SMBPOGN_COLL_CODE IN
                        ('18', '15', '17', '19', '42', '41', '16', '31')
                        AND F_GET_LEVEL(SMRDORQ_PIDM)='Ã„'
                        AND F_GET_STYP(SMRDORQ_PIDM)<>'‰'
                 AND NEW_COMP.SMBPOGN_REQUEST_NO =
                        (SELECT MAX (SMBPOGN_REQUEST_NO)
                           FROM SMBPOGN
                          WHERE SMBPOGN_PIDM = NEW_COMP.SMBPOGN_PIDM)
                 AND EXISTS
                        (SELECT '1'
                           FROM SPRIDEN
                          WHERE     SUBSTR (SPRIDEN_ID, 1, 3) < '438'
                                AND SUBSTR (SPRIDEN_ID, 1, 3) >= '433'
                                AND SPRIDEN_PIDM = SMBPOGN_PIDM)
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
 WHERE "OVER_ALL" - "ACT" between 1 and 24 ) 
 
 ORDER BY 1;