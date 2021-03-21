/* Formatted on 12/16/2019 11:12:26 AM (QP5 v5.227.12220.39754) */
SELECT (SELECT COUNT (DISTINCT B.REQUEST_NO)
          FROM request_master a, wf_request_flow b, REQUEST_DETAILS C
         WHERE     a.request_no = b.request_no
               AND C.REQUEST_NO = A.REQUEST_NO
               AND C.SEQUENCE_NO = 1
               AND C.ITEM_CODE = 'TERM'
               AND C.ITEM_VALUE = '144210'
               AND a.object_code = 'WF_GRADE_APPROVAL'
               AND A.REQUEST_STATUS = 'P'
               AND B.FLOW_SEQ = (SELECT MAX (FLOW_SEQ)
                                   FROM wf_request_flow
                                  WHERE request_no = B.REQUEST_NO)
               AND B.FLOW_SEQ = 2)
          AS "PENDING AT HEAD OF DEPARTMENT",
       (SELECT COUNT (DISTINCT B.REQUEST_NO)
          FROM request_master a, wf_request_flow b, REQUEST_DETAILS C
         WHERE     a.request_no = b.request_no
               AND C.REQUEST_NO = A.REQUEST_NO
               AND C.SEQUENCE_NO = 1
               AND C.ITEM_CODE = 'TERM'
               AND C.ITEM_VALUE = '144210'
               AND a.object_code = 'WF_GRADE_APPROVAL'
               AND A.REQUEST_STATUS = 'P'
               AND B.FLOW_SEQ = (SELECT MAX (FLOW_SEQ)
                                   FROM wf_request_flow
                                  WHERE request_no = B.REQUEST_NO)
               AND B.FLOW_SEQ = 3)
          AS "PENDING AT VICE DEAN",
       (SELECT COUNT (DISTINCT B.REQUEST_NO)
          FROM request_master a, wf_request_flow b, REQUEST_DETAILS C
         WHERE     a.request_no = b.request_no
               AND C.REQUEST_NO = A.REQUEST_NO
               AND C.SEQUENCE_NO = 1
               AND C.ITEM_CODE = 'TERM'
               AND C.ITEM_VALUE = '144210'
               AND a.object_code = 'WF_GRADE_APPROVAL'
               AND A.REQUEST_STATUS = 'P'
               AND B.FLOW_SEQ = (SELECT MAX (FLOW_SEQ)
                                   FROM wf_request_flow
                                  WHERE request_no = B.REQUEST_NO)
               AND B.FLOW_SEQ = 4)
          AS "PENDING AT COLLEGE DEAN",
       (SELECT COUNT ( distinct a.request_no)
          FROM request_master a, request_details b
         WHERE     a.object_code LIKE '%WF_GRADE_APPROVAL%'
               AND a.request_no = b.request_no
               AND A.REQUEST_STATUS = 'P'
               AND b.SEQUENCE_NO = 1
               AND ITEM_CODE = 'TERM'
               AND item_value = '144210')
          AS "TOTAL PENDING  ",
       (SELECT COUNT (DISTINCT B.REQUEST_NO)
          FROM request_master a, wf_request_flow b, REQUEST_DETAILS C
         WHERE     a.request_no = b.request_no
               AND C.REQUEST_NO = A.REQUEST_NO
               AND C.SEQUENCE_NO = 1
               AND C.ITEM_CODE = 'TERM'
               AND C.ITEM_VALUE = '144210'
               AND a.object_code = 'WF_GRADE_APPROVAL'
               AND A.REQUEST_STATUS = 'R'
               AND B.FLOW_SEQ = (SELECT MAX (FLOW_SEQ)
                                   FROM wf_request_flow
                                  WHERE request_no = B.REQUEST_NO)
               AND B.FLOW_SEQ = 2)
          AS "REJECTED BY HEAD OF DEPARTMENT",
       (SELECT COUNT (DISTINCT B.REQUEST_NO)
          FROM request_master a, wf_request_flow b, REQUEST_DETAILS C
         WHERE     a.request_no = b.request_no
               AND C.REQUEST_NO = A.REQUEST_NO
               AND C.SEQUENCE_NO = 1
               AND C.ITEM_CODE = 'TERM'
               AND C.ITEM_VALUE = '144210'
               AND a.object_code = 'WF_GRADE_APPROVAL'
               AND A.REQUEST_STATUS = 'R'
               AND B.FLOW_SEQ = (SELECT MAX (FLOW_SEQ)
                                   FROM wf_request_flow
                                  WHERE request_no = B.REQUEST_NO)
               AND B.FLOW_SEQ = 3)
          AS "REJECTED BY VICE DEAN",
       (SELECT COUNT (DISTINCT B.REQUEST_NO)
          FROM request_master a, wf_request_flow b, REQUEST_DETAILS C
         WHERE     a.request_no = b.request_no
               AND C.REQUEST_NO = A.REQUEST_NO
               AND C.SEQUENCE_NO = 1
               AND C.ITEM_CODE = 'TERM'
               AND C.ITEM_VALUE = '144210'
               AND a.object_code = 'WF_GRADE_APPROVAL'
               AND A.REQUEST_STATUS = 'R'
               AND B.FLOW_SEQ = (SELECT MAX (FLOW_SEQ)
                                   FROM wf_request_flow
                                  WHERE request_no = B.REQUEST_NO)
               AND B.FLOW_SEQ = 4)
          AS "REJECTED BY COLLEGE DEAN",
       (SELECT COUNT (DISTINCT A.REQUEST_NO)
          FROM request_master a, REQUEST_DETAILS C
         WHERE     C.REQUEST_NO = A.REQUEST_NO
               AND C.SEQUENCE_NO = 1
               AND C.ITEM_CODE = 'TERM'
               AND C.ITEM_VALUE = '144210'
               AND a.object_code = 'WF_GRADE_APPROVAL'
               AND A.REQUEST_STATUS = 'R')
          AS "TOTAL REJECTED  ",
       (SELECT COUNT (DISTINCT A.REQUEST_NO)
          FROM request_master a, REQUEST_DETAILS C
         WHERE     a.object_code = 'WF_GRADE_APPROVAL'
               AND C.REQUEST_NO = A.REQUEST_NO
               AND C.SEQUENCE_NO = 1
               AND C.ITEM_CODE = 'TERM'
               AND C.ITEM_VALUE = '144210'
               AND A.REQUEST_STATUS = 'C')
          AS "TOTAL COMPLETED  ",
       (SELECT COUNT (DISTINCT B.REQUEST_NO)
          FROM request_master a, wf_request_flow b, REQUEST_DETAILS C
         WHERE     a.request_no = b.request_no
               AND C.REQUEST_NO = A.REQUEST_NO
               AND C.SEQUENCE_NO = 1
               AND C.ITEM_CODE = 'TERM'
               AND C.ITEM_VALUE = '144210'
               AND a.object_code = 'WF_GRADE_APPROVAL'
               AND A.REQUEST_STATUS = 'P'
               AND B.ACTION_CODE = 'HOLD')
          AS "TOTAL HOLD  ",
       (SELECT COUNT ( distinct a.request_no)
          FROM request_master a, request_details b
         WHERE     a.object_code LIKE '%WF_GRADE_APPROVAL%'
               AND a.request_no = b.request_no
               
               AND b.SEQUENCE_NO = 1
               AND ITEM_CODE = 'TERM'
               AND item_value = '144210')
          AS "TOTAL for All  "
  FROM DUAL