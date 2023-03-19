/* Formatted on 3/8/2023 2:15:36 PM (QP5 v5.371) */
SELECT sgbstdn_pidm                              std_pidm,
          f_getspridenid (sgbstdn_pidm)
       || ' - '
       || f_format_name (sgbstdn_pidm, 'FML')    std_name,
       request_no,
       sgbstdn_stst_code,
       OBJECT_CODE
  FROM sgbstdn a, request_master m
 WHERE     object_code IN ('WF_ADDITIONAL_CHANCE', 'WF_REACTIVATE')
       AND m.request_status = 'C'
       AND M.REQUESTER_PIDM = a.sgbstdn_pidm
       AND sgbstdn_stst_code NOT IN ('AS',
                                     'ŒÃ',
                                     '„”',
                                     'ÿ”',
                                     '„Œ')
       AND EXISTS
               (SELECT '1'
                  FROM REQUEST_DETAILS
                 WHERE     REQUEST_NO = M.REQUEST_NO
                       AND SEQUENCE_NO = 1
                       AND ITEM_CODE = 'TERM'
                       AND ITEM_VALUE = '144420')
       AND a.sgbstdn_term_code_eff = (SELECT MAX (b.sgbstdn_term_code_eff)
                                        FROM sgbstdn b
                                       WHERE b.sgbstdn_pidm = a.sgbstdn_pidm)