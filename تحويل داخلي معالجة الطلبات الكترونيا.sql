/* Formatted on 8/3/2023 12:02:32 PM (QP5 v5.371) */
--- delete bu_dev.tmp_tbl_kilany  where col01 is null ; 
-- rejected requests
--update bu_dev.tmp_tbl_kilany set col03='R' 
-- update bu_dev.tmp_tbl_kilany set col03='A'   where col03 is null ; 

  SELECT col02
    FROM bu_dev.tmp_tbl_kilany
GROUP BY col02
  HAVING COUNT (col02) > 1;

DECLARE
    CURSOR get_requests IS
        SELECT col01     request
          FROM bu_dev.tmp_tbl_kilany
         WHERE col01 IS NOT NULL AND col03 = 'R'      /*AND col01 = '503805'*/
                                                ;

    l_flow_updated_count     NUMBER := 0;
    l_master_updated_count   NUMBER := 0;
    l_check                  NUMBER;
BEGIN
    FOR rec IN get_requests
    LOOP
        l_check := 0;

        UPDATE wf_request_flow w
           SET USER_PIDM =
                   (SELECT a.USER_PIDM
                      FROM users_attributes a, ROLE_USERS r
                     WHERE     a.USER_PIDM = r.USER_PIDM
                           AND ATTRIBUTE_CODE = 'DEPARTMENT'
                           AND ACTIVE = 'Y'
                           AND a.ROLE_CODE = r.ROLE_CODE
                           AND r.ROLE_CODE = 'RO_DEPT_MANAGER'
                           AND ATTRIBUTE_VALUE =
                               (SELECT item_value
                                  FROM request_details
                                 WHERE     item_code = 'TRANSFER_DEPT'
                                       AND request_no = rec.request)),
               ACTION_CODE = 'REJECT',
               ACTIVITY_DATE = SYSDATE,
               USER_ID = USER,
               notes =
                   '”»» —›÷ «·ÿ·»: ≈ﬂ ›«¡ «·„ﬁ«⁄œ ⁄‰ „⁄œ·«   —«ﬂ„Ì… √⁄·Ï'
         WHERE     request_no = rec.request
               AND ROLE_CODE = 'RO_DEPT_MANAGER'
               AND EXISTS
                       (SELECT '1'
                          FROM request_master
                         WHERE     request_no = w.request_no
                               AND request_status = 'P'
                               AND OBJECT_CODE = 'WF_TRANSFER');

        l_check := SQL%ROWCOUNT;

        IF l_check = 0
        THEN
            DBMS_OUTPUT.put_line ('Error : ' || rec.request);
        END IF;

        l_flow_updated_count := l_flow_updated_count + SQL%ROWCOUNT;

        -----
        UPDATE request_master m
           SET REQUEST_STATUS = 'R', ACTIVITY_DATE = SYSDATE, USER_ID = USER
         WHERE     request_no = rec.request
               AND OBJECT_CODE = 'WF_TRANSFER'
               AND REQUEST_STATUS = 'P'
               AND EXISTS
                       (SELECT '1'
                          FROM bu_dev.tmp_tbl_kilany
                         WHERE col01 = m.request_no);

        l_check := SQL%ROWCOUNT;

        IF l_check = 0
        THEN
            DBMS_OUTPUT.put_line ('Error : ' || rec.request);
        END IF;

        l_master_updated_count := l_master_updated_count + SQL%ROWCOUNT;
    END LOOP;

    DBMS_OUTPUT.put_line ('flow Updated Rows : ' || l_flow_updated_count);
    DBMS_OUTPUT.put_line ('Master Updated Rows : ' || l_master_updated_count);
END;

--check user pidm getten proper  

SELECT *
  FROM wf_request_flow
 WHERE     request_no IN (SELECT col01 FROM bu_dev.tmp_tbl_kilany)
       AND ROLE_CODE = 'RO_DEPT_MANAGER'
       AND ACTION_CODE = 'REJECT'
       AND USER_PIDM IS NULL;

-------------------------------------------------------------------------------------------------------------------
---------******------------------
-- manipulate approved requestst 
--------------------------------

DECLARE
    CURSOR get_requests IS
        SELECT col01 request, col04 coll
          FROM bu_dev.tmp_tbl_kilany
         WHERE col01 IS NOT NULL AND col03 = 'A' AND col01 != '503774'
         AND exists (SELECT '1'
                                  FROM request_MASTER
                                 WHERE      
                                         request_no = col01
                                       and REQUEST_STATUS='P');

    l_flow_updated_count     NUMBER := 0;
    l_master_updated_count   NUMBER := 0;
    l_check                  NUMBER;
BEGIN
    l_check := 0;

    FOR rec IN get_requests
    LOOP
        BEGIN
            UPDATE wf_request_flow w
               SET USER_PIDM =
                       (SELECT a.USER_PIDM
                          FROM users_attributes a, ROLE_USERS r
                         WHERE     a.USER_PIDM = r.USER_PIDM
                               AND ATTRIBUTE_CODE = 'DEPARTMENT'
                               AND ACTIVE = 'Y'
                               AND a.ROLE_CODE = r.ROLE_CODE
                               AND r.ROLE_CODE = 'RO_DEPT_MANAGER'
                               AND ATTRIBUTE_VALUE =
                                   (SELECT item_value
                                      FROM request_details
                                     WHERE     item_code = 'TRANSFER_DEPT'
                                           AND request_no = rec.request)),
                   ACTION_CODE = 'APPROVE',
                   ACTIVITY_DATE = SYSDATE,
                   USER_ID = USER
             WHERE     request_no = rec.request
                   AND ROLE_CODE = 'RO_DEPT_MANAGER'
                   AND EXISTS
                           (SELECT '1'
                              FROM request_master
                             WHERE     request_no = w.request_no
                                   AND request_status = 'P'
                                   AND OBJECT_CODE = 'WF_TRANSFER');
        EXCEPTION
            WHEN OTHERS
            THEN
                DBMS_OUTPUT.put_line ('Error : ' || SQLERRM || rec.request);
        END;

        l_check := SQL%ROWCOUNT;

        IF l_check = 0
        THEN
            DBMS_OUTPUT.put_line ('Error : ' || rec.request);
        END IF;

        l_flow_updated_count := l_flow_updated_count + SQL%ROWCOUNT;

        -- college dean

        IF rec.coll = '12'
        THEN
            INSERT INTO BU_APPS.WF_REQUEST_FLOW (REQUEST_NO,
                                                 SEQUENCE_NO,
                                                 FLOW_SEQ,
                                                 ROLE_CODE,
                                                 USER_PIDM,
                                                 ACTION_CODE,
                                                 ACTIVITY_DATE,
                                                 USER_ID)
                 VALUES (rec.request,
                         3,
                         3,
                         'RO_COLLEGE_DEAN',
                         157409,
                         'APPROVE',
                         SYSDATE,
                         USER);
        ELSE
            BEGIN
                INSERT INTO BU_APPS.WF_REQUEST_FLOW (REQUEST_NO,
                                                     SEQUENCE_NO,
                                                     FLOW_SEQ,
                                                     ROLE_CODE,
                                                     USER_PIDM,
                                                     ACTION_CODE,
                                                     ACTIVITY_DATE,
                                                     USER_ID)
                         VALUES (
                                    rec.request,
                                    3,
                                    3,
                                    'RO_COLLEGE_DEAN',
                                    (SELECT a.USER_PIDM
                                       FROM users_attributes a, ROLE_USERS r
                                      WHERE     a.USER_PIDM = r.USER_PIDM
                                            AND ATTRIBUTE_CODE = 'COLLEGE'
                                            AND ACTIVE = 'Y'
                                            AND a.ROLE_CODE = r.ROLE_CODE
                                            AND a.ROLE_CODE IN
                                                    ('RO_COLLEGE_DEAN')
                                            AND ATTRIBUTE_VALUE =
                                                (SELECT item_value
                                                   FROM request_details
                                                  WHERE     item_code =
                                                            'TRANSFER_COLLEGE'
                                                        AND request_no =
                                                            rec.request)),
                                    'APPROVE',
                                    SYSDATE,
                                    USER);
            EXCEPTION
                WHEN OTHERS
                THEN
                    DBMS_OUTPUT.put_line (
                        'Error : ' || SQLERRM || rec.request);
            END;
        END IF;

        --- insert DAR Approval record
        INSERT INTO BU_APPS.WF_REQUEST_FLOW (REQUEST_NO,
                                             SEQUENCE_NO,
                                             FLOW_SEQ,
                                             ROLE_CODE,
                                             USER_PIDM,
                                             ACTION_CODE,
                                             NOTES,
                                             ACTIVITY_DATE,
                                             USER_ID)
             VALUES (rec.request,
                     4,
                     4,
                     'RO_DAR_VICE_DEAN',
                     0,
                     'FINAL_APPROVE',
                     ' „  «·„Ê«›ﬁ… ⁄·Ï ÿ·» «· ÕÊÌ· ',
                     SYSDATE,
                     'BU_APPS');


        -----
        UPDATE request_master m
           SET REQUEST_STATUS = 'C', ACTIVITY_DATE = SYSDATE, USER_ID = USER
         WHERE     request_no = rec.request
               AND OBJECT_CODE = 'WF_TRANSFER'
               AND REQUEST_STATUS = 'P'
               AND EXISTS
                       (SELECT '1'
                          FROM bu_dev.tmp_tbl_kilany
                         WHERE col01 = m.request_no AND col03 = 'A');

        l_check := SQL%ROWCOUNT;

        IF l_check = 0
        THEN
            DBMS_OUTPUT.put_line ('Error : ' || rec.request);
        END IF;

        l_master_updated_count := l_master_updated_count + SQL%ROWCOUNT;
    END LOOP;



    DBMS_OUTPUT.put_line ('flow Updated Rows : ' || l_flow_updated_count);
    DBMS_OUTPUT.put_line ('Master Updated Rows : ' || l_master_updated_count);
END;

SELECT *
  FROM wf_request_flow
 WHERE     request_no IN (SELECT col01 FROM bu_dev.tmp_tbl_kilany)
       AND ROLE_CODE = 'RO_DEPT_MANAGER'
       AND ACTION_CODE = 'APPROVE'
       AND USER_PIDM IS NULL;

SELECT *
  FROM wf_request_flow
 WHERE     request_no IN (SELECT col01 FROM bu_dev.tmp_tbl_kilany)
       AND ROLE_CODE = 'RO_COLLEGE_DEAN'
       AND ACTION_CODE = 'APPROVE'
       AND USER_PIDM IS NULL;