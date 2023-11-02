/* Formatted on 10/2/2023 11:47:39 AM (QP5 v5.371) */
BEGIN
           WF_BATCH_ACTIONS;
END;


UPDATE BU_APPS.WF_REQUEST_FLOW WF
   SET ACTIVITY_DATE = TO_DATE('10/1/2023 09:58:35','MM/DD/YYYY HH:MI:SS')
 WHERE EXISTS
           (  SELECT '1'
                FROM request_master m 
               WHERE     
                       object_code = 'WF_WITHDRAW_COURSE'
                     AND m.request_status = 'P'
                     AND m.request_no = WF.request_no
                      
            )
            AND  FLOW_SEQ=(SELECT MAX(FLOW_SEQ) FROM wf_request_flow WHERE request_no = Wf.request_no  )
           -- AND WF.REQUEST_NO='523813'
            
            
             
            
            