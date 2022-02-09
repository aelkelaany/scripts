/* Formatted on 25/03/2021 11:55:42 (QP5 v5.227.12220.39754) */
DECLARE
   CURSOR GET_REQUESTS
   IS
        SELECT DISTINCT m.request_no REQ_NO
          FROM request_master m, wf_request_flow f
         WHERE     m.request_no = f.request_no
               AND object_code = 'WF_REG_MAINTAIN'
               AND m.request_status = 'P'
               AND F.FLOW_SEQ = 4
               AND USER_PIDM = f_get_pidm ('3497') -->>> From
               AND ACTION_CODE IS NULL
               AND ROWNUM <= 15
      ORDER BY 1 ASC;

BEGIN
   FOR REC IN GET_REQUESTS
   LOOP
      UPDATE wf_request_flow
         SET USER_PIDM = f_get_pidm ('3179')--<<< To
       WHERE REQUEST_NO = REC.REQ_NO AND FLOW_SEQ = 4 --AND  USER_PIDM IS NULL
             AND ACTION_CODE IS NULL;
   END LOOP;
END;

UPDATE wf_request_flow
   SET USER_PIDM = NULL
 WHERE     ACTION_CODE IS NULL
       AND USER_PIDM IN (235905, 235906, 235907, 235908, 235909)
       AND ROWNUM < 21;

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
select f_get_pidm('2521') from dual ; 
---********
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
         AND B.FLOW_SEQ =  4
GROUP BY b.user_pidm
order by 1 desc;


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
         and exists (select '1' from request_details where request_no=a.request_no and item_value='144320')
          
GROUP BY b.user_pidm
ORDER BY 1 DESC;

--------AUTO

SELECT DISTINCT m.request_no REQ_NO ,ACTION_CODE ,REQUEST_DATE
          FROM request_master m, wf_request_flow f
         WHERE     m.request_no = f.request_no
               AND object_code = 'WF_REG_MAINTAIN'
               AND m.request_status = 'P'
               AND F.FLOW_SEQ = 4
            --  and user_pidm=235909
             --  AND ACTION_CODE =''
              
      ORDER BY 1 ASC;
      
      SELECT stvcitz_desc
  FROM dle.stvcitz
 WHERE stvcitz_code = :SPBPERS_CITZ_CODE ;
 
 --role_users
 
 -- moe_majors
 
 select get_moe_major('1503','AR') from dual ; 
  get_moe_major('1503','EN')