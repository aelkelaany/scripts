---******** -                            ---- 1
  SELECT COUNT (DISTINCT B.REQUEST_NO),
         f_get_STD_ID (b.user_pidm) EMPLOYEE_ID,
         f_get_STD_NAME (b.user_pidm) EMPLOYEE_NAME,
         b.user_pidm PIDM
    FROM request_master a, wf_request_flow b
   WHERE     a.request_no = b.request_no
         AND a.object_code = 'WF_REG_MAINTAIN'
         AND A.REQUEST_STATUS = 'P'  
         AND B.FLOW_SEQ = (SELECT MAX (FLOW_SEQ)
                             FROM wf_request_flow
                            WHERE request_no = B.REQUEST_NO)
         AND B.FLOW_SEQ  =  4
GROUP BY b.user_pidm
order by 1 desc; 
-- 2 
--4234 riyadh
--5797 raqoush
--2521 saeed
--6603 Omair
--3377 khadraa
--3466 Reem
--3344 Nora Ghamdi
--3179 Ahlam
--947 MUJAHED
-- Alia 3497
---********

-----------------------------  ‰›Ì– «· Ê“Ì⁄  3 
DECLARE
   CURSOR GET_REQUESTS
   IS
        SELECT DISTINCT m.request_no REQ_NO
          FROM request_master m, wf_request_flow f
         WHERE     m.request_no = f.request_no
               AND object_code = 'WF_REG_MAINTAIN'
               AND m.request_status = 'P'
               AND F.FLOW_SEQ = 4
               AND USER_PIDM = f_get_pidm ('947') -->>> From „‰ 
               AND ACTION_CODE IS NULL
               AND ROWNUM <= 5       -- «·⁄œœ
      ORDER BY 1 ASC;

BEGIN
   FOR REC IN GET_REQUESTS
   LOOP
      UPDATE wf_request_flow
         SET USER_PIDM = f_get_pidm ('3344')--<<< To «·Ï 
       WHERE REQUEST_NO = REC.REQ_NO AND FLOW_SEQ = 4 --AND  USER_PIDM IS NULL
             AND ACTION_CODE IS NULL;
   END LOOP;
END;

 


 


--  ﬁ—Ì— «‰Ã«“
  SELECT COUNT (DISTINCT B.REQUEST_NO) done,
         f_get_STD_ID (b.user_pidm) EMPLOYEE_ID,
         f_get_STD_NAME (b.user_pidm) EMPLOYEE_NAME,
         b.user_pidm PIDM
    FROM request_master a, wf_request_flow b
   WHERE     a.request_no = b.request_no
         AND a.object_code = 'WF_REG_MAINTAIN'
         AND A.REQUEST_STATUS <> 'P'
         AND B.FLOW_SEQ = (SELECT MAX (FLOW_SEQ)
                             FROM wf_request_flow
                            WHERE request_no = B.REQUEST_NO)
         AND B.FLOW_SEQ = 4
         and exists (select '1' from request_details where request_no=a.request_no and item_value='144430')
          
GROUP BY b.user_pidm
ORDER BY 1 DESC;

 
      