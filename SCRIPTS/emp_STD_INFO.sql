SELECT COUNT (DISTINCT B.REQUEST_NO) ,f_get_std_name(USER_PIDM) 
          FROM request_master a, wf_request_flow b
         WHERE     a.request_no = b.request_no
               AND a.object_code = 'WF_UPDATE_STD_INFO'
               AND A.REQUEST_STATUS = 'C'
               and F_GET_STD_ID(A.REQUESTER_PIDM) LIKE '439%' 
               AND B.SEQUENCE_NO = (SELECT MAX (SEQUENCE_NO)
                                      FROM wf_request_flow
                                     WHERE request_no = B.REQUEST_NO)
               AND B.SEQUENCE_NO = 2
               group by USER_PIDM
               
               SELECT COUNT (DISTINCT B.REQUEST_NO) ,f_get_std_name(USER_PIDM) 
          FROM request_master a, wf_request_flow b
         WHERE     a.request_no = b.request_no
               AND a.object_code = 'WF_UPDATE_STD_INFO'
              -- AND A.REQUEST_STATUS = 'R'
               and F_GET_STD_ID(A.REQUESTER_PIDM) LIKE '439%' 
               AND B.SEQUENCE_NO = (SELECT MAX (SEQUENCE_NO)
                                      FROM wf_request_flow
                                     WHERE request_no = B.REQUEST_NO)
               AND B.SEQUENCE_NO = 2
               group by USER_PIDM
               