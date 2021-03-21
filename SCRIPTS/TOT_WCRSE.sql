
SELECT (SELECT COUNT (DISTINCT B.REQUEST_NO)
          FROM request_master a, wf_request_flow b
         WHERE     a.request_no = b.request_no
               AND a.object_code = 'WF_WITHDRAW_COURSE'
               AND A.REQUEST_STATUS = 'P'
               AND B.SEQUENCE_NO = (SELECT MAX (SEQUENCE_NO)
                                      FROM wf_request_flow
                                     WHERE request_no = B.REQUEST_NO)
               AND B.SEQUENCE_NO = 2)
          AS "PENDING AT INSTRUCTOR",
       (SELECT COUNT (DISTINCT B.REQUEST_NO)
          FROM request_master a, wf_request_flow b
         WHERE     a.request_no = b.request_no
               AND a.object_code = 'WF_WITHDRAW_COURSE'
               AND A.REQUEST_STATUS = 'P'
               AND B.SEQUENCE_NO = (SELECT MAX (SEQUENCE_NO)
                                      FROM wf_request_flow
                                     WHERE request_no = B.REQUEST_NO)
               AND B.SEQUENCE_NO = 3)
          AS "PENDING AT HEAD OF DEPARTMENT",
       (SELECT COUNT (DISTINCT B.REQUEST_NO)
          FROM request_master a, wf_request_flow b
         WHERE     a.request_no = b.request_no
               AND a.object_code = 'WF_WITHDRAW_COURSE'
               AND A.REQUEST_STATUS = 'P'
               AND B.SEQUENCE_NO = (SELECT MAX (SEQUENCE_NO)
                                      FROM wf_request_flow
                                     WHERE request_no = B.REQUEST_NO)
               AND B.SEQUENCE_NO = 4)
          AS "PENDING AT COLLEGE DEAN",
       (SELECT COUNT (DISTINCT A.REQUEST_NO)
          FROM request_master a
         WHERE     a.object_code = 'WF_WITHDRAW_COURSE'
               AND A.REQUEST_STATUS = 'P')
          AS "TOTAL PENDING  ",
       (SELECT COUNT (DISTINCT B.REQUEST_NO)
          FROM request_master a, wf_request_flow b
         WHERE     a.request_no = b.request_no
               AND a.object_code = 'WF_WITHDRAW_COURSE'
               AND A.REQUEST_STATUS = 'R'
               AND B.SEQUENCE_NO = (SELECT MAX (SEQUENCE_NO)
                                      FROM wf_request_flow
                                     WHERE request_no = B.REQUEST_NO)
               AND B.SEQUENCE_NO = 2)
          AS "REJECTED BY INSTRUCTOR",
       (SELECT COUNT (DISTINCT B.REQUEST_NO)
          FROM request_master a, wf_request_flow b
         WHERE     a.request_no = b.request_no
               AND a.object_code = 'WF_WITHDRAW_COURSE'
               AND A.REQUEST_STATUS = 'R'
               AND B.SEQUENCE_NO = (SELECT MAX (SEQUENCE_NO)
                                      FROM wf_request_flow
                                     WHERE request_no = B.REQUEST_NO)
               AND B.SEQUENCE_NO = 3)
          AS "REJECTED BY HEAD OF DEPARTMENT",
       (SELECT COUNT (DISTINCT B.REQUEST_NO)
          FROM request_master a, wf_request_flow b
         WHERE     a.request_no = b.request_no
               AND a.object_code = 'WF_WITHDRAW_COURSE'
               AND A.REQUEST_STATUS = 'R'
               AND B.SEQUENCE_NO = (SELECT MAX (SEQUENCE_NO)
                                      FROM wf_request_flow
                                     WHERE request_no = B.REQUEST_NO)
               AND B.SEQUENCE_NO = 4)
          AS "REJECTED BY COLLEGE DEAN",
       (SELECT COUNT (DISTINCT A.REQUEST_NO)
          FROM request_master a
         WHERE     a.object_code = 'WF_WITHDRAW_COURSE'
               AND A.REQUEST_STATUS = 'R')
          AS "TOTAL REJECTED  ",
       (SELECT COUNT (DISTINCT A.REQUEST_NO)
          FROM request_master a
         WHERE     a.object_code = 'WF_WITHDRAW_COURSE'
               AND A.REQUEST_STATUS = 'C')
          AS "TOTAL COMPLETED  ",
       (SELECT COUNT (DISTINCT B.REQUEST_NO)
          FROM request_master a, wf_request_flow b
         WHERE     a.request_no = b.request_no
               AND a.object_code = 'WF_WITHDRAW_COURSE'
               AND A.REQUEST_STATUS = 'P'
               AND B.ACTION_CODE = 'HOLD')
          AS "TOTAL HOLD  "
  FROM DUAL