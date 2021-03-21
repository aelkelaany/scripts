
SELECT 'PENDING AT INSTRUCTOR' TITLE, COUNT (DISTINCT B.REQUEST_NO)
  FROM request_master a, wf_request_flow b, REQUEST_DETAILS C
 WHERE     a.request_no = b.request_no
       AND A.REQUEST_NO = C.REQUEST_NO
       AND B.SEQUENCE_NO = C.SEQUENCE_NO
       AND a.object_code = 'WF_WITHDRAW_COURSE'
       AND A.REQUEST_STATUS = 'P'
       AND B.SEQUENCE_NO = (SELECT MAX (SEQUENCE_NO)
                              FROM wf_request_flow
                             WHERE request_no = B.REQUEST_NO)
       AND B.SEQUENCE_NO = 2