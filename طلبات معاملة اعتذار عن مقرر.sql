SELECT distinct a.REQUEST_NO,
       f_get_std_id (REQUESTER_PIDM),
       f_get_std_name (REQUESTER_PIDM) ,crn.item_value ,REQUEST_STATUS 
        
  FROM request_master a, request_details term, request_details crn
 WHERE     a.object_code = 'WF_WITHDRAW_COURSE'
       AND a.request_no = term.request_no
       AND a.request_no = crn.request_no
       AND crn.SEQUENCE_NO = 1
       AND crn.ITEM_CODE = 'CRN'
       AND term.SEQUENCE_NO = 1
       AND term.ITEM_CODE = 'TERM'
       AND term.item_value = '144310'
       AND crn.item_value IN ('17115',
                              '11852',
                              '11857',
                              '11858',
                              '12158',
                              '11843')
                            --  and REQUEST_STATUS='C','P','R'
                              order by crn.item_value;