 
UPDATE request_master
   SET REQUEST_STATUS = 'P'
 WHERE REQUEST_NO IN
          (SELECT m.REQUEST_NO
             FROM BU_APPS.REQUEST_MASTER 
            WHERE     OBJECT_CODE = 'WF_GRADE_CHANGE'
                  AND REQUEST_STATUS = 'R'
                  AND EXISTS
                         (SELECT 'q'
                            FROM request_details
                           WHERE     REQUEST_NO = m.REQUEST_NO
                                 AND SEQUENCE_NO = 1
                                 AND ITEM_CODE = 'COLLEGE'
                                 AND ITEM_VALUE = '33')
                  AND EXISTS
                         (SELECT 'e'
                            FROM request_details
                           WHERE     REQUEST_NO = m.REQUEST_NO
                                 AND SEQUENCE_NO = 1
                                 AND SEQUENCE_NO = 1
                                 AND ITEM_CODE = 'SELECTED_FINAL'
                                 AND ITEM_VALUE = 'До')
                  AND EXISTS
                         (SELECT '1'
                            FROM wf_request_flow
                           WHERE     REQUEST_NO = m.REQUEST_NO
                                 AND ROLE_CODE = 'RO_GRADE_CHANGE'
                                 AND user_pidm = 168764
                                 AND ACTION_CODE = 'FINAL_REJECT'))
                                 
            ;                     
  UPDATE wf_request_flow set     user_pidm = f_get_pidm('2233')
                                 , ACTION_CODE = ''
  
 WHERE
   ROLE_CODE = 'RO_GRADE_CHANGE'
                                 AND user_pidm = 168764
                                 AND ACTION_CODE = 'FINAL_REJECT'
 
 and  REQUEST_NO IN
          (SELECT m.REQUEST_NO
             FROM BU_APPS.REQUEST_MASTER m
            WHERE     OBJECT_CODE = 'WF_GRADE_CHANGE'
                  AND REQUEST_STATUS = 'P'
                  AND EXISTS
                         (SELECT 'q'
                            FROM request_details
                           WHERE     REQUEST_NO = m.REQUEST_NO
                                 AND SEQUENCE_NO = 1
                                 AND ITEM_CODE = 'COLLEGE'
                                 AND ITEM_VALUE = '33')
                  AND EXISTS
                         (SELECT 'e'
                            FROM request_details
                           WHERE     REQUEST_NO = m.REQUEST_NO
                                 AND SEQUENCE_NO = 1
                                 AND SEQUENCE_NO = 1
                                 AND ITEM_CODE = 'SELECTED_FINAL'
                                 AND ITEM_VALUE = 'До')
                  AND EXISTS
                         (SELECT '1'
                            FROM wf_request_flow
                           WHERE     REQUEST_NO = m.REQUEST_NO
                                 AND ROLE_CODE = 'RO_GRADE_CHANGE'
                                 AND user_pidm = 168764
                                 AND ACTION_CODE = 'FINAL_REJECT'))