/* Formatted on 02/03/2021 12:14:19 (QP5 v5.227.12220.39754) */
SELECT f_get_std_id (REQUESTER_PIDM),
       f_get_std_name (REQUESTER_PIDM),
       REQUEST_no
  FROM request_master M
 WHERE     OBJECT_CODE = 'WF_REACTIVATE'
       AND REQUEST_STATUS = 'P'
        AND NOT EXISTS
                                       (SELECT '1'
                                          FROM wf_request_flow
                                         WHERE     request_no = M.request_no
                                               AND notes LIKE
                                                      '% „ ≈·€«¡ «·ÿ·» ⁄‰ ÿ—Ìﬁ „ﬁœ„ «·ÿ·»%')
       AND EXISTS
              (SELECT '1'
                 FROM request_master
                WHERE     REQUESTER_PIDM = M.REQUESTER_PIDM
                      AND OBJECT_CODE = 'WF_REACTIVATE'
                      AND REQUEST_STATUS = 'R');

SELECT REQUESTER_PIDM
  FROM request_master M
 WHERE     OBJECT_CODE = 'WF_REACTIVATE'
       AND REQUEST_STATUS = 'R'
       AND NOT EXISTS
                  (SELECT '1'
                     FROM request_master
                    WHERE     REQUESTER_PIDM = M.REQUESTER_PIDM
                          AND OBJECT_CODE = 'WF_REACTIVATE'
                          AND REQUEST_STATUS IN ('C', 'P'));

;

SELECT *
  FROM sgbstdn s
 WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                      FROM SGBSTDN
                                     WHERE sgbstdn_pidm = s.sgbstdn_pidm)
       AND SGBSTDN_STST_CODE IN ('ÿÌ')
       AND s.sgbstdn_pidm IN
              (SELECT REQUESTER_PIDM
                 FROM request_master M
                WHERE     OBJECT_CODE = 'WF_REACTIVATE'
                      AND REQUEST_STATUS = 'R'
                      AND NOT EXISTS
                                 (SELECT '1'
                                    FROM request_master
                                   WHERE     REQUESTER_PIDM =
                                                M.REQUESTER_PIDM
                                         AND OBJECT_CODE = 'WF_REACTIVATE'
                                         AND m.request_no < request_no
                                         AND REQUEST_STATUS IN ('C', 'P')));

wf_request_flow
wf_flow_actions

;


DECLARE
   CURSOR get_std
   IS
      SELECT sgbstdn_pidm pidm
        FROM sgbstdn s
       WHERE     SGBSTDN_TERM_CODE_EFF =
                    (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                       FROM SGBSTDN
                      WHERE sgbstdn_pidm = s.sgbstdn_pidm)
             AND SGBSTDN_STST_CODE IN ('ÿÌ')
             AND s.sgbstdn_pidm IN
                    (SELECT REQUESTER_PIDM
                       FROM request_master M
                      WHERE     OBJECT_CODE = 'WF_REACTIVATE'
                            AND REQUEST_STATUS = 'R'
                            AND NOT EXISTS
                                       (SELECT '1'
                                          FROM wf_request_flow
                                         WHERE     request_no = M.request_no
                                               AND notes LIKE
                                                      '% „ ≈·€«¡ «·ÿ·» ⁄‰ ÿ—Ìﬁ „ﬁœ„ «·ÿ·»%')
                            AND NOT EXISTS
                                       (SELECT '1'
                                          FROM request_master
                                         WHERE     REQUESTER_PIDM =
                                                      M.REQUESTER_PIDM
                                               AND OBJECT_CODE =
                                                      'WF_REACTIVATE'
                                               AND m.request_no < request_no
                                               AND REQUEST_STATUS IN
                                                      ('C', 'P')));

BEGIN
   FOR rec IN get_std
   LOOP
      p_update_std_status (rec.pidm,
                           '144220',
                           'ÿ‰',
                           'Banner');
                           dbms_output.put_line( rec.pidm   );  
   END LOOP;
END;



;

------------------++++++++++++--------------------++++++++++++++++---------------++++++++++++++
SELECT f_get_std_id (REQUESTER_PIDM),
       f_get_std_name (REQUESTER_PIDM),
       REQUEST_no
  FROM request_master M
 WHERE     OBJECT_CODE = 'WF_ADDITIONAL_CHANCE'
       AND REQUEST_STATUS = 'P'
       AND EXISTS
              (SELECT '1'
                 FROM request_master
                WHERE     REQUESTER_PIDM = M.REQUESTER_PIDM
                      AND OBJECT_CODE = 'WF_ADDITIONAL_CHANCE'
                      AND REQUEST_STATUS = 'R'
                       AND NOT EXISTS
                                       (SELECT '1'
                                          FROM wf_request_flow
                                         WHERE     request_no = M.request_no
                                               AND ACTION_CODE='CANCEL_REQUEST'));
                                               
                                               
                                               
                                               DECLARE
   CURSOR get_std
   IS
      SELECT F_GET_STD_ID(sgbstdn_pidm),sgbstdn_pidm pidm
        FROM sgbstdn s
       WHERE     SGBSTDN_TERM_CODE_EFF =
                    (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                       FROM SGBSTDN
                      WHERE sgbstdn_pidm = s.sgbstdn_pidm)
             AND SGBSTDN_STST_CODE IN ('≈ ')
             AND s.sgbstdn_pidm IN
                    (SELECT REQUESTER_PIDM
                       FROM request_master M
                      WHERE     OBJECT_CODE = 'WF_ADDITIONAL_CHANCE'
                            AND REQUEST_STATUS = 'R'
                            AND NOT EXISTS
                                       (SELECT '1'
                                          FROM wf_request_flow
                                         WHERE     request_no = M.request_no
                                               AND notes LIKE
                                                      '% „ ≈·€«¡ «·ÿ·» ⁄‰ ÿ—Ìﬁ „ﬁœ„ «·ÿ·»%')
                            AND NOT EXISTS
                                       (SELECT '1'
                                          FROM request_master
                                         WHERE     REQUESTER_PIDM =
                                                      M.REQUESTER_PIDM
                                               AND OBJECT_CODE =
                                                      'WF_ADDITIONAL_CHANCE'
                                               AND m.request_no < request_no
                                               AND REQUEST_STATUS IN
                                                      ('C', 'P')));

BEGIN
   FOR rec IN get_std
   LOOP
      p_update_std_status (rec.pidm,
                           '144220',
                           '„›',
                           'Banner');
                           dbms_output.put_line( rec.pidm   );  
   END LOOP;
END;