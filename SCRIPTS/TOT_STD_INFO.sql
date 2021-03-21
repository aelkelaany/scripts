 
SELECT  
        
       (SELECT COUNT (DISTINCT A.REQUEST_NO)
          FROM request_master a
         WHERE     a.object_code = 'WF_UPDATE_STD_INFO'
               AND A.REQUEST_STATUS = 'P'
             )--  and F_GET_STD_ID(A.REQUESTER_PIDM) LIKE '439%'  )
          AS "TOTAL PENDING  ",
         
        
       (SELECT COUNT (DISTINCT A.REQUEST_NO)
          FROM request_master a
         WHERE     a.object_code = 'WF_UPDATE_STD_INFO'
               AND A.REQUEST_STATUS = 'R'
               and F_GET_STD_ID(A.REQUESTER_PIDM) LIKE '439%' )
          AS "TOTAL REJECTED  ",
       (SELECT COUNT (DISTINCT A.REQUEST_NO)
          FROM request_master a
         WHERE     a.object_code = 'WF_UPDATE_STD_INFO'
               AND A.REQUEST_STATUS = 'C'
               and F_GET_STD_ID(A.REQUESTER_PIDM) LIKE '439%' )
          AS "TOTAL COMPLETED  "
  FROM DUAL