SELECT distinct a.REQUEST_NO,
       f_get_std_id (REQUESTER_PIDM),
       f_get_std_name (REQUESTER_PIDM) ,(select SPRTELE_INTL_ACCESS from saturn.sprtele where SPRTELE_TELE_CODE = 'MO' and sprtele_pidm=REQUESTER_PIDM ) phone,crn.item_value ,REQUEST_STATUS 
        ,(select f_get_desc_fnc('stvcoll',sgbstdn_coll_code_1,30) from sgbstdn where sgbstdn_pidm= REQUESTER_PIDM) coll
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
                            and REQUEST_STATUS='D'--,'P','R'
                              order by crn.item_value;
                              
                     

 
update request_master set REQUEST_STATUS='D'
where 
request_no in (SELECT distinct a.REQUEST_NO 
        
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
                            and REQUEST_STATUS='D'--,'P','R'
                              )
          
                              