/* Formatted on 8/13/2023 11:23:19 AM (QP5 v5.371) */
SELECT f_get_std_id (shrttrm_pidm) stdid, m.*
  FROM shrttrm m
 WHERE     SHRTTRM_TERM_CODE = (SELECT MAX (SHRTTRM_TERM_CODE)
                                  FROM shrttrm
                                 WHERE shrttrm_pidm = m.shrttrm_pidm)
       AND EXISTS
               (SELECT '1'
                  FROM SGBSTDN SG
                 WHERE     sgbstdn_pidm = shrttrm_pidm
                       AND SGBSTDN_TERM_CODE_EFF =
                           (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                              FROM SGBSTDN
                             WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                       AND SGBSTDN_STST_CODE IN ('AS'))
       AND SHRTTRM_ASTD_CODE_END_OF_TERM = '›ﬂ'
       AND NOT EXISTS
               (SELECT '1'
                  FROM request_master
                 WHERE     REQUESTER_PIDM = shrttrm_pidm
                       AND object_code = 'WF_ADDITIONAL_CHANCE'
                       AND REQUEST_STATUS = 'C');



DECLARE
    CURSOR get_data IS
        SELECT shrttrm_pidm     pidm
          FROM shrttrm m
         WHERE     SHRTTRM_TERM_CODE = (SELECT MAX (SHRTTRM_TERM_CODE)
                                          FROM shrttrm
                                         WHERE shrttrm_pidm = m.shrttrm_pidm)
               AND EXISTS
                       (SELECT '1'
                          FROM SGBSTDN SG
                         WHERE     sgbstdn_pidm = shrttrm_pidm
                               AND SGBSTDN_TERM_CODE_EFF =
                                   (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                      FROM SGBSTDN
                                     WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                               AND SGBSTDN_STST_CODE IN ('AS'))
               AND SHRTTRM_ASTD_CODE_END_OF_TERM = '›ﬂ'
               AND NOT EXISTS
                       (SELECT '1'
                          FROM request_master
                         WHERE     REQUESTER_PIDM = shrttrm_pidm
                               AND object_code = 'WF_ADDITIONAL_CHANCE'
                               AND REQUEST_STATUS = 'C');
                               counter number :=0;
BEGIN

for rec in get_data loop 


 p_update_std_status (rec.pidm,
                           '144510',
                           '≈ ',
                           'Banner');
                           counter:=counter+1;

end loop ; 
   DBMS_OUTPUT.put_line ('Update Count :' || counter);
    end;