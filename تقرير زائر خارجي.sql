/* Formatted on 28/10/2020 11:03:20 (QP5 v5.227.12220.39754) */
/* “«∆— Œ«—ÃÌ ›Ï Ã«„⁄… «·„·ﬂ Œ«·œ ÿ·«» Â‰œ”… «·›’· «·’Ì›Ì 144030 */

SELECT m.request_no,
       f_get_std_id (M.REQUESTER_PIDM) stdID,
       f_get_std_name (M.REQUESTER_PIDM)
  FROM request_master m,
       request_details term,
       request_details college,
       request_details UNIVERSITY
 WHERE     m.object_code = 'WF_EXTERNAL_VISITOR'
       AND m.REQUEST_STATUS = 'C'
       AND m.request_no = term.request_no
       AND term.SEQUENCE_NO = 1
       AND TERM.ITEM_CODE = 'TERM'
       AND term.item_value = '144030'
       AND college.request_no = m.request_no
       AND COLLEGE.SEQUENCE_NO = 1
       AND college.item_code = 'COLLEGE'
       AND college.item_value = '32'
       AND UNIVERSITY.item_code = 'UNIVERSITY'
       AND UNIVERSITY.SEQUENCE_NO = 1
       AND UNIVERSITY.request_no = m.request_no
       AND UNIVERSITY.item_value = '9';