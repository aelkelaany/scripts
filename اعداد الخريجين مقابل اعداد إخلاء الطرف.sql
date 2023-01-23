/* Formatted on 12/13/2022 11:55:00 AM (QP5 v5.371) */
SELECT DISTINCT
       f_get_std_id (SG.sgbstdn_pidm),
       f_get_std_name (SG.sgbstdn_pidm),
       (SELECT SPRTELE_INTL_ACCESS
          FROM saturn.sprtele
         WHERE     SPRTELE_TELE_CODE = 'MO'
               AND sprtele_pidm = SG.sgbstdn_pidm
               AND ROWNUM < 2)                                phone,
       F_GET_DESC_FNC ('STVCOLL', sgbstdn_coll_code_1, 30)    coll_DESC,
       (SELECT DECODE (REQUEST_STATUS,
                       'P', 'ÊÍÊ ÇáÇÌÑÇÁ',
                       'C', 'ãßÊãá',
                       'R', 'ãÑÝæÖ')
          FROM request_master a
         WHERE     a.object_code = 'WF_CLEARANCE'
               AND SG.sgbstdn_pidm = REQUESTER_PIDM)          STATUS
  FROM sgbstdn sg, shrdgmr
 WHERE     
         SG.sgbstdn_pidm = SHRDGMR_PIDM
       AND SHRDGMR_DEGS_CODE = 'ÎÌ'
       AND SHRDGMR_TERM_CODE_GRAD = '144410'
       AND SG.SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                         FROM SGBSTDN
                                        WHERE sgbstdn_pidm = SHRDGMR_PIDM) ;
                                        
                                        ---------
                                        
                                        SELECT  COUNT( SG.sgbstdn_pidm) ,
        
       F_GET_DESC_FNC ('STVCOLL', sgbstdn_coll_code_1, 30)    coll_DESC,
      SUM( NVL((SELECT 1
          FROM request_master a
         WHERE     a.object_code = 'WF_CLEARANCE'
               AND SG.sgbstdn_pidm = REQUESTER_PIDM) ,0)   )    REQ_CNT   
  FROM sgbstdn sg, shrdgmr
 WHERE     
         SG.sgbstdn_pidm = SHRDGMR_PIDM
       AND SHRDGMR_DEGS_CODE = 'ÎÌ'
       AND SHRDGMR_TERM_CODE_GRAD = '144410'
       AND SG.SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                         FROM SGBSTDN
                                        WHERE sgbstdn_pidm = SHRDGMR_PIDM) 
                                        GROUP BY sgbstdn_coll_code_1 ;
                                        
                                        ---------
                                        
                                           
                                        SELECT  COUNT( SG.sgbstdn_pidm) ,
        
       F_GET_DESC_FNC ('STVCOLL', sgbstdn_coll_code_1, 30)    coll_DESC,
      SUM( NVL((SELECT MAX(1)
          FROM request_master a
         WHERE     a.object_code = 'WF_UPDATE_STD_INFO'
               AND SG.sgbstdn_pidm = REQUESTER_PIDM
               AND REQUEST_STATUS='C') ,0)   )    REQ_CNT   
  FROM sgbstdn sg, shrdgmr
 WHERE     
         SG.sgbstdn_pidm = SHRDGMR_PIDM
       AND SHRDGMR_DEGS_CODE = 'ÎÌ'
       AND SHRDGMR_TERM_CODE_GRAD = '144410'
       AND SG.SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                         FROM SGBSTDN
                                        WHERE sgbstdn_pidm = SHRDGMR_PIDM) 
                                        GROUP BY sgbstdn_coll_code_1 ;