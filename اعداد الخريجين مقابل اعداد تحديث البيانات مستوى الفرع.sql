 select  count_requests, F_GET_DESC_FNC('STVCAMP',camp_code,30) CAMP_DESC, camp_code ,(select count( DISTINCT SHRDGMR_pidm) from SHRDGMR a where   
                  SHRDGMR_DEGS_CODE='ÎÌ'
                and   SHRDGMR_CAMP_CODE=camp_code
                and  SHRDGMR_TERM_CODE_GRAD='144430')  real_count 
 from
 (SELECT   count(distinct A.REQUEST_NO) count_requests  ,c.sgbstdn_camp_code camp_code 
          FROM request_master a , request_details b ,sgbstdn c
         WHERE     a.object_code = 'WF_UPDATE_STD_INFO'
               AND A.REQUEST_STATUS = 'C'
                and a.request_no=b.request_no
                and b.SEQUENCE_NO=1
                and b.ITEM_CODE='TERM_CODE'
                and b.ITEM_VALUE>='144430'
                and a.REQUESTER_PIDM=c.sgbstdn_pidm
                and c.SGBSTDN_TERM_CODE_EFF=(select max(SGBSTDN_TERM_CODE_EFF)
                from sgbstdn
                where 
                sgbstdn_pidm=c.sgbstdn_pidm
                )
 and c.sgbstdn_stst_code='ÎÌ'
 group by c.sgbstdn_camp_code
 )
  WF_GRADE_CHANGE
 
;
----------
SELECT c.sgbstdn_pidm
  FROM sgbstdn c
 WHERE     c.SGBSTDN_TERM_CODE_EFF = '144430'
       AND c.sgbstdn_stst_code = 'ÎÌ'
       AND not EXISTS
               (SELECT '1'
                  FROM request_master a, request_details b
                 WHERE     a.object_code = 'WF_UPDATE_STD_INFO'
                       AND A.REQUEST_STATUS = 'C'
                       AND a.request_no = b.request_no
                       AND b.SEQUENCE_NO = 1
                       AND b.ITEM_CODE = 'TERM_CODE'
                       AND b.ITEM_VALUE >= '144430'
                       AND REQUESTER_PIDM = c.sgbstdn_pidm);