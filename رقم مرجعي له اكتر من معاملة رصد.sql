 
SELECT crn.item_value   
  FROM request_details crn, request_details term, request_master a
 WHERE     a.object_code = 'WF_GRADE_APPROVAL'
       AND A.REQUEST_NO = crn.REQUEST_NO
       AND A.REQUEST_NO = term.REQUEST_NO
       AND TERM.SEQUENCE_NO = 1
       AND CRN.SEQUENCE_NO = 1
       AND CRN.ITEM_CODE = 'CRN'
       AND TERM.ITEM_CODE = 'TERM'
       AND TERM.ITEM_VALUE = '144220'
HAVING COUNT (crn.item_value) > 1
group by crn.item_value ;


SELECT   crn.REQUEST_NO
  FROM request_details crn, request_details term, request_master a
 WHERE     a.object_code = 'WF_GRADE_APPROVAL'
       AND A.REQUEST_NO = crn.REQUEST_NO
       AND A.REQUEST_NO = term.REQUEST_NO
       AND TERM.SEQUENCE_NO = 1
       AND CRN.SEQUENCE_NO = 1
       AND CRN.ITEM_CODE = 'CRN'
       AND TERM.ITEM_CODE = 'TERM'
       AND TERM.ITEM_VALUE = '144220'
       and crn.item_value =26208 ;