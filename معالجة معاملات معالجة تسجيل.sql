/* Formatted on 4/5/2023 12:43:10 PM (QP5 v5.371) */
 
 

UPDATE REQUEST_DETAILS SET ITEM_VALUE='1205'
WHERE (REQUEST_NO,ITEM_CODE,ITEM_VALUE) IN 
(select REQUEST ,'DEPARTMENT' ,DEPT FROM 
(
 SELECT B.REQUEST_NO REQUEST ,
         f_get_STD_ID (b.user_pidm)       EMPLOYEE_ID,
         f_get_STD_NAME (b.user_pidm)     EMPLOYEE_NAME,
         b.user_pidm                      PIDM,
         C.ITEM_VALUE DEPT,
         V.ITEM_VALUE ,SGBSTDN_DEPT_CODE
    FROM request_master a,
         wf_request_flow b,
         REQUEST_DETAILS C,
         REQUEST_DETAILS V ,SGBSTDN X
   WHERE     a.request_no = b.request_no
         AND a.object_code = 'WF_REG_MAINTAIN'
         AND A.REQUEST_STATUS = 'P'
         AND B.FLOW_SEQ = (SELECT MAX (FLOW_SEQ)
                             FROM wf_request_flow
                            WHERE request_no = B.REQUEST_NO)
         AND B.FLOW_SEQ = 2
         AND b.FLOW_SEQ=(SELECT MAX(FLOW_SEQ) FROM wf_request_flow WHERE REQUEST_NO=B.REQUEST_NO )
         AND a.request_no = C.request_no
         AND a.request_no = V.request_no
         AND C.SEQUENCE_NO = 1
         AND V.SEQUENCE_NO = 1
         AND C.ITEM_CODE = 'DEPARTMENT'
         AND V.ITEM_CODE = 'STUDENT_PIDM'
          
                    AND      SGBSTDN_PIDM = V.ITEM_VALUE
                         AND sgbstdn_term_code_eff =
                             (SELECT MAX (sgbstdn_term_code_eff)
                                FROM sgbstdn d
                               WHERE d.sgbstdn_pidm = x.sgbstdn_pidm)
         AND SGBSTDN_DEPT_CODE != C.ITEM_VALUE 
ORDER BY 1 DESC));


SELECT B.REQUEST_NO REQUEST ,
         f_get_STD_ID (b.user_pidm)       EMPLOYEE_ID,
         f_get_STD_NAME (b.user_pidm)     EMPLOYEE_NAME,
         b.user_pidm                      PIDM,
         C.ITEM_VALUE DEPT,
         V.ITEM_VALUE ,SGBSTDN_DEPT_CODE
    FROM request_master a,
         wf_request_flow b,
         REQUEST_DETAILS C,
         REQUEST_DETAILS V ,SGBSTDN X
   WHERE     a.request_no = b.request_no
         AND a.object_code = 'WF_REG_MAINTAIN'
         AND A.REQUEST_STATUS = 'P'
         AND B.FLOW_SEQ = (SELECT MAX (FLOW_SEQ)
                             FROM wf_request_flow
                            WHERE request_no = B.REQUEST_NO)
         AND B.FLOW_SEQ = 2
         AND b.FLOW_SEQ=(SELECT MAX(FLOW_SEQ) FROM wf_request_flow WHERE REQUEST_NO=B.REQUEST_NO )
         AND a.request_no = C.request_no
         AND a.request_no = V.request_no
         AND C.SEQUENCE_NO = 1
         AND V.SEQUENCE_NO = 1
         AND C.ITEM_CODE = 'DEPARTMENT'
         AND V.ITEM_CODE = 'STUDENT_PIDM'
          
                    AND      SGBSTDN_PIDM = V.ITEM_VALUE
                         AND sgbstdn_term_code_eff =
                             (SELECT MAX (sgbstdn_term_code_eff)
                                FROM sgbstdn d
                               WHERE d.sgbstdn_pidm = x.sgbstdn_pidm)
         AND SGBSTDN_DEPT_CODE != C.ITEM_VALUE 
ORDER BY 1 DESC ;