/* Formatted on 5/23/2022 9:05:55 AM (QP5 v5.371) */
--deploy script


INSERT INTO BU_APPS.OBJECT_DEFINITION (OBJECT_CODE,
                                       OBJECT_DESC,
                                       OBJECT_TYPE,
                                       WEB_DISPLAY_IND,
                                       ONE_STEP_FLOW,
                                       RULE_CODE,
                                       ACTIVITY_DATE,
                                       USER_ID,
                                       RULE_APPLY,
                                       SERVICE_ROLE)
     VALUES ('WF_REGRADING',
             'طلب إعادة رصد مقرر',
             'W',
             'N',
             'N',
             'R_IS_DEPT_HEAD',
             SYSDATE,
             'SAISUSR',
             'B',
             'A');



INSERT INTO BU_APPS.WF_OBJECT_ATTRIBUTES (OBJECT_CODE,
                                          ATTRIBUTE_CODE,
                                          ACTIVITY_DATE,
                                          USER_ID)
     VALUES ('WF_REGRADING',
             'COLLEGE',
             SYSDATE,
             'BU_APPS');


 SET DEFINE OFF;

INSERT INTO BU_APPS.WF_FLOW (OBJECT_CODE,
                             FLOW_SEQ,
                             FLOW_DISPLAY,
                             FLOW_PROCEDURE,
                             FLOW_TYPE,
                             HISTORY_IND,
                             ACTIVITY_DATE,
                             USER_ID,
                             MATCH_TYPE,
                             REVIEW_PROCEDURE,
                             ALLOW_BATCH_ACTION)
     VALUES ('WF_REGRADING',
             1,
             'C',
             'WF_REGRADING.WFDP_INITIATOR',
             'I',
             'Y',
             SYSDATE,
             'BU_APPS',
             'F',
             'WF_REGRADING.WFRP_INITIATOR',
             'N');

INSERT INTO BU_APPS.WF_FLOW (OBJECT_CODE,
                             FLOW_SEQ,
                             FLOW_DISPLAY,
                             FLOW_PROCEDURE,
                             FLOW_TYPE,
                             ROLE_CODE,
                             HISTORY_IND,
                             ACTIVITY_DATE,
                             USER_ID,
                             MATCH_TYPE,
                             REVIEW_PROCEDURE,
                             SEND_EMAIL_TYPE,
                             ALLOW_BATCH_ACTION)
     VALUES ('WF_REGRADING',
             2,
             'C',
             'WF_REGRADING.WFDP_APPROVER',
             'R',
             'RO_COLLEGE_DEAN',
             'Y',
             SYSDATE,
             'BU_APPS',
             'R',
             'WF_REGRADING.WFRP_APPROVER',
             'N',
             'N');

INSERT INTO BU_APPS.WF_FLOW (OBJECT_CODE,
                             FLOW_SEQ,
                             FLOW_DISPLAY,
                             FLOW_PROCEDURE,
                             FLOW_TYPE,
                             ROLE_CODE,
                             FLOW_LABLE,
                             HISTORY_IND,
                             ACTIVITY_DATE,
                             USER_ID,
                             MATCH_TYPE,
                             REVIEW_PROCEDURE,
                             SEND_EMAIL_TYPE,
                             ALLOW_BATCH_ACTION)
     VALUES ('WF_REGRADING',
             3,
             'C',
             'WF_REGRADING.WFDP_APPROVER',
             'R',
             'RO_GRADE_CHANGE',
             'عمادة القبول والتسجيل',
             'Y',
             SYSDATE,
             'SAISUSR',
             'R',
             'WF_REGRADING.WFRP_APPROVER',
             'N',
             'N');



INSERT INTO BU_APPS.WF_FLOW_ACTIONS (OBJECT_CODE,
                                     FLOW_SEQ,
                                     ACTION_CODE,
                                     VALIDATION_PROCEDURE,
                                     ACTIVITY_DATE,
                                     USER_ID,
                                     FORWARD_NEXT_STEP,
                                     PUBLIC_IND)
     VALUES ('WF_REGRADING',
             1,
             'INIT',
             'WF_REGRADING.WFVP_INITIATOR',
             SYSDATE,
             'BU_APPS',
             'N',
             'Y');

INSERT INTO BU_APPS.WF_FLOW_ACTIONS (OBJECT_CODE,
                                     FLOW_SEQ,
                                     ACTION_CODE,
                                     EXECUTION_PROCEDURE,
                                     ACTIVITY_DATE,
                                     USER_ID,
                                     FORWARD_NEXT_STEP,
                                     PUBLIC_IND)
     VALUES ('WF_REGRADING',
             3,
             'FINAL_APPROVE',
             'WF_REGRADING.WFEP_APPROVER_FINAL',
             SYSDATE,
             'BU_APPS',
             'N',
             'Y');

INSERT INTO BU_APPS.WF_FLOW_ACTIONS (OBJECT_CODE,
                                     FLOW_SEQ,
                                     ACTION_CODE,
                                     ACTIVITY_DATE,
                                     USER_ID,
                                     FORWARD_NEXT_STEP,
                                     PUBLIC_IND)
     VALUES ('WF_REGRADING',
             3,
             'FINAL_REJECT',
             SYSDATE,
             'BU_APPS',
             'N',
             'Y');

INSERT INTO BU_APPS.WF_FLOW_ACTIONS (OBJECT_CODE,
                                     FLOW_SEQ,
                                     ACTION_CODE,
                                     ACTIVITY_DATE,
                                     USER_ID,
                                     FORWARD_NEXT_STEP,
                                     PUBLIC_IND)
     VALUES ('WF_REGRADING',
             2,
             'APPROVE',
             SYSDATE,
             'BU_APPS',
             'N',
             'Y');

INSERT INTO BU_APPS.WF_FLOW_ACTIONS (OBJECT_CODE,
                                     FLOW_SEQ,
                                     ACTION_CODE,
                                     ACTIVITY_DATE,
                                     USER_ID,
                                     FORWARD_NEXT_STEP,
                                     PUBLIC_IND)
     VALUES ('WF_REGRADING',
             2,
             'FINAL_REJECT',
             SYSDATE,
             'BU_APPS',
             'N',
             'Y');
             
              
Insert into BU_APPS.WF_FLOW_ACTIONS
   (OBJECT_CODE, FLOW_SEQ, ACTION_CODE, ACTIVITY_DATE, USER_ID, 
    FORWARD_NEXT_STEP, PUBLIC_IND)
 Values
   ('WF_REGRADING', 2, 'HOLD', sysdate, 'SAISUSR', 
    'N', 'Y');
    
    Insert into BU_APPS.WF_FLOW_ACTIONS
   (OBJECT_CODE, FLOW_SEQ, ACTION_CODE, ACTIVITY_DATE, USER_ID, 
    FORWARD_NEXT_STEP, PUBLIC_IND)
 Values
   ('WF_REGRADING', 3, 'HOLD', sysdate, 'SAISUSR', 
    'N', 'Y');
 
