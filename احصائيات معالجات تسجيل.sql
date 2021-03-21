
SELECT (SELECT COUNT (DISTINCT B.REQUEST_NO)
          FROM request_master a, wf_request_flow b
         WHERE     a.request_no = b.request_no
               AND a.object_code = 'WF_REG_MAINTAIN'
               AND A.REQUEST_STATUS = 'P'
               AND EXISTS (SELECT '1' FROM REQUEST_DETAILS WHERE REQUEST_NO=a.request_no AND ITEM_CODE='TERM' AND ITEM_VALUE='144220')
               AND B.SEQUENCE_NO = (SELECT MAX (SEQUENCE_NO)
                                      FROM wf_request_flow
                                     WHERE request_no = B.REQUEST_NO)
               AND B.SEQUENCE_NO = 2)
               
          AS "PENDING AT HEAD OF DEPARTMENT",
       (SELECT COUNT (DISTINCT B.REQUEST_NO)
          FROM request_master a, wf_request_flow b
         WHERE     a.request_no = b.request_no
               AND a.object_code = 'WF_REG_MAINTAIN'
               AND A.REQUEST_STATUS = 'P'
               AND EXISTS (SELECT '1' FROM REQUEST_DETAILS WHERE REQUEST_NO=a.request_no AND ITEM_CODE='TERM' AND ITEM_VALUE='144220')
               AND B.SEQUENCE_NO = (SELECT MAX (SEQUENCE_NO)
                                      FROM wf_request_flow
                                     WHERE request_no = B.REQUEST_NO)
               AND B.SEQUENCE_NO = 3)
          AS "PENDING AT COLLEGE DEAN",
       (SELECT COUNT (DISTINCT B.REQUEST_NO)
          FROM request_master a, wf_request_flow b
         WHERE     a.request_no = b.request_no
               AND a.object_code = 'WF_REG_MAINTAIN'
               AND A.REQUEST_STATUS = 'P'
               AND EXISTS (SELECT '1' FROM REQUEST_DETAILS WHERE REQUEST_NO=a.request_no AND ITEM_CODE='TERM' AND ITEM_VALUE='144220')
               AND B.SEQUENCE_NO = (SELECT MAX (SEQUENCE_NO)
                                      FROM wf_request_flow
                                     WHERE request_no = B.REQUEST_NO)
               AND B.SEQUENCE_NO = 4)
          AS "PENDING AT DAR",
       (SELECT COUNT (DISTINCT A.REQUEST_NO)
          FROM request_master a
         WHERE     a.object_code = 'WF_REG_MAINTAIN'
         AND EXISTS (SELECT '1' FROM REQUEST_DETAILS WHERE REQUEST_NO=a.request_no AND ITEM_CODE='TERM' AND ITEM_VALUE='144220')
               AND A.REQUEST_STATUS = 'P')
               
          AS "TOTAL PENDING  ",
       (SELECT COUNT (DISTINCT B.REQUEST_NO)
          FROM request_master a, wf_request_flow b
         WHERE     a.request_no = b.request_no
               AND a.object_code = 'WF_REG_MAINTAIN'
               AND A.REQUEST_STATUS = 'R'
               AND EXISTS (SELECT '1' FROM REQUEST_DETAILS WHERE REQUEST_NO=a.request_no AND ITEM_CODE='TERM' AND ITEM_VALUE='144220')
               AND B.SEQUENCE_NO = (SELECT MAX (SEQUENCE_NO)
                                      FROM wf_request_flow
                                     WHERE request_no = B.REQUEST_NO)
               AND B.SEQUENCE_NO = 2)
          AS "REJECTED BY HEAD OF DEPARTMENT",
       (SELECT COUNT (DISTINCT B.REQUEST_NO)
          FROM request_master a, wf_request_flow b
         WHERE     a.request_no = b.request_no
               AND a.object_code = 'WF_REG_MAINTAIN'
               AND A.REQUEST_STATUS = 'R'
               AND EXISTS (SELECT '1' FROM REQUEST_DETAILS WHERE REQUEST_NO=a.request_no AND ITEM_CODE='TERM' AND ITEM_VALUE='144220')
               AND B.SEQUENCE_NO = (SELECT MAX (SEQUENCE_NO)
                                      FROM wf_request_flow
                                     WHERE request_no = B.REQUEST_NO)
               AND B.SEQUENCE_NO = 3)
          AS "REJECTED BY COLLEGE DEAN",
       (SELECT COUNT (DISTINCT B.REQUEST_NO)
          FROM request_master a, wf_request_flow b
         WHERE     a.request_no = b.request_no
               AND a.object_code = 'WF_REG_MAINTAIN'
               AND A.REQUEST_STATUS = 'R'
               AND EXISTS (SELECT '1' FROM REQUEST_DETAILS WHERE REQUEST_NO=a.request_no AND ITEM_CODE='TERM' AND ITEM_VALUE='144220')
               AND B.SEQUENCE_NO = (SELECT MAX (SEQUENCE_NO)
                                      FROM wf_request_flow
                                     WHERE request_no = B.REQUEST_NO)
               AND B.SEQUENCE_NO = 4)
          AS "REJECTED BY DAR",
       (SELECT COUNT (DISTINCT A.REQUEST_NO)
          FROM request_master a
         WHERE     a.object_code = 'WF_REG_MAINTAIN'
         AND EXISTS (SELECT '1' FROM REQUEST_DETAILS WHERE REQUEST_NO=a.request_no AND ITEM_CODE='TERM' AND ITEM_VALUE='144220')
               AND A.REQUEST_STATUS = 'R')
          AS "TOTAL REJECTED  ",
       (SELECT COUNT (DISTINCT A.REQUEST_NO)
          FROM request_master a
         WHERE     a.object_code = 'WF_REG_MAINTAIN'
         AND EXISTS (SELECT '1' FROM REQUEST_DETAILS WHERE REQUEST_NO=a.request_no AND ITEM_CODE='TERM' AND ITEM_VALUE='144220')
               AND A.REQUEST_STATUS = 'C')
          AS "TOTAL COMPLETED  ",
       (SELECT COUNT (DISTINCT B.REQUEST_NO)
          FROM request_master a, wf_request_flow b
         WHERE     a.request_no = b.request_no
               AND a.object_code = 'WF_REG_MAINTAIN'
               AND EXISTS (SELECT '1' FROM REQUEST_DETAILS WHERE REQUEST_NO=a.request_no AND ITEM_CODE='TERM' AND ITEM_VALUE='144220')
               AND A.REQUEST_STATUS = 'P'
               AND B.ACTION_CODE = 'HOLD')
          AS "TOTAL HOLD  " ,
          (SELECT COUNT (DISTINCT B.REQUEST_NO) 
          FROM request_master a, wf_request_flow b
         WHERE     a.request_no = b.request_no
               AND a.object_code = 'WF_REG_MAINTAIN'
               AND EXISTS (SELECT '1' FROM REQUEST_DETAILS WHERE REQUEST_NO=a.request_no AND ITEM_CODE='TERM' AND ITEM_VALUE='144220')
               AND A.REQUEST_STATUS = 'P'
               AND B.ACTION_CODE is null
               AND  B.SEQUENCE_NO = 4 
               and b.user_pidm=f_get_pidm('9'))
          AS " Pending AT Raqoush  " 
          ,
          (SELECT COUNT (DISTINCT B.REQUEST_NO) 
          FROM request_master a, wf_request_flow b
         WHERE     a.request_no = b.request_no
               AND a.object_code = 'WF_REG_MAINTAIN'
               AND EXISTS (SELECT '1' FROM REQUEST_DETAILS WHERE REQUEST_NO=a.request_no AND ITEM_CODE='TERM' AND ITEM_VALUE='144220')
               AND A.REQUEST_STATUS = 'P'
               AND B.ACTION_CODE is null
               AND  B.SEQUENCE_NO = 4 
               and b.user_pidm=f_get_pidm('2521'))
          AS " Pending AT Saeed  "
          ,
           (SELECT COUNT (DISTINCT B.REQUEST_NO) 
          FROM request_master a, wf_request_flow b
         WHERE     a.request_no = b.request_no
               AND a.object_code = 'WF_REG_MAINTAIN'
               AND EXISTS (SELECT '1' FROM REQUEST_DETAILS WHERE REQUEST_NO=a.request_no AND ITEM_CODE='TERM' AND ITEM_VALUE='144220')
               AND A.REQUEST_STATUS = 'P'
               AND B.ACTION_CODE is null
               AND  B.SEQUENCE_NO = 4 
               and b.user_pidm=f_get_pidm('4234'))
          AS " Pending AT Ryadh  ",
          (SELECT COUNT (DISTINCT B.REQUEST_NO) 
          FROM request_master a, wf_request_flow b
         WHERE     a.request_no = b.request_no
               AND a.object_code = 'WF_REG_MAINTAIN'
               AND EXISTS (SELECT '1' FROM REQUEST_DETAILS WHERE REQUEST_NO=a.request_no AND ITEM_CODE='TERM' AND ITEM_VALUE='144220')
              -- AND A.REQUEST_STATUS = 'P'
               AND B.ACTION_CODE is not null
               AND  B.SEQUENCE_NO = 4 
               and b.user_pidm=f_get_pidm('9'))
          AS " Worked by  Raqoush  " 
             ,  (SELECT COUNT (DISTINCT B.REQUEST_NO) 
          FROM request_master a, wf_request_flow b
         WHERE     a.request_no = b.request_no
               AND a.object_code = 'WF_REG_MAINTAIN'
               AND EXISTS (SELECT '1' FROM REQUEST_DETAILS WHERE REQUEST_NO=a.request_no AND ITEM_CODE='TERM' AND ITEM_VALUE='144220')
               --AND A.REQUEST_STATUS = 'C'
               AND B.ACTION_CODE is not null
               AND  B.SEQUENCE_NO = 4 
               and b.user_pidm=f_get_pidm('2521'))
          AS " Worked by  Saeed  "
          ,
          
          (SELECT COUNT (DISTINCT B.REQUEST_NO) 
          FROM request_master a, wf_request_flow b
         WHERE     a.request_no = b.request_no
               AND a.object_code = 'WF_REG_MAINTAIN'
               AND EXISTS (SELECT '1' FROM REQUEST_DETAILS WHERE REQUEST_NO=a.request_no AND ITEM_CODE='TERM' AND ITEM_VALUE='144220')
             --  AND A.REQUEST_STATUS = 'P'
               AND B.ACTION_CODE is not null
               AND  B.SEQUENCE_NO = 4 
               and b.user_pidm=f_get_pidm('4234'))
          AS "Worked by  Riyadh "
  FROM DUAL
  
 