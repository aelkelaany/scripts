 
INSERT INTO GENERAL.GUBOBJS (GUBOBJS_NAME,
                             GUBOBJS_DESC,
                             GUBOBJS_OBJT_CODE,
                             GUBOBJS_SYSI_CODE,
                             GUBOBJS_USER_ID,
                             GUBOBJS_ACTIVITY_DATE,
                             GUBOBJS_HELP_IND,
                             GUBOBJS_EXTRACT_ENABLED_IND,
                             GUBOBJS_UI_VERSION)
     VALUES ( :OBJECT_CODE,
             :OBJECT_DESC,
             'JOBS',
             'S',
             'LOCAL',
             SYSDATE,
             'N',
             'N',
             'B');

INSERT INTO BANSECR.GURUOBJ (GURUOBJ_OBJECT,
                             GURUOBJ_ROLE,
                             GURUOBJ_USERID,
                             GURUOBJ_ACTIVITY_DATE,
                             GURUOBJ_USER_ID)
     VALUES ( :OBJECT_CODE,
             'BAN_DEFAULT_M',
             'SAISUSR',
             SYSDATE,
             'BANSECR');

INSERT INTO BANSECR.GURUOBJ (GURUOBJ_OBJECT,
                             GURUOBJ_ROLE,
                             GURUOBJ_USERID,
                             GURUOBJ_ACTIVITY_DATE,
                             GURUOBJ_USER_ID)
     VALUES ( :OBJECT_CODE,
             'BAN_DEFAULT_M',
             'BU_APPS',
             SYSDATE,
             'BANSECR');

INSERT INTO BANSECR.GURAOBJ (GURAOBJ_OBJECT,
                             GURAOBJ_DEFAULT_ROLE,
                             GURAOBJ_CURRENT_VERSION,
                             GURAOBJ_SYSI_CODE,
                             GURAOBJ_ACTIVITY_DATE,
                             GURAOBJ_USER_ID,
                             GURAOBJ_OWNER,
                             GURAOBJ_ACCESS_TRACKING_IND)
     VALUES ( :OBJECT_CODE,
             'BAN_DEFAULT_M',
             '8.6',
             'S',
             SYSDATE,
             'BU_DEV',
             'PUBLIC',
             'Y');

INSERT INTO GJBJOBS (GJBJOBS_NAME,
                     GJBJOBS_TITLE,
                     GJBJOBS_ACTIVITY_DATE,
                     GJBJOBS_SYSI_CODE,
                     GJBJOBS_JOB_TYPE_IND,
                     GJBJOBS_DESC,
                     GJBJOBS_COMMAND_NAME,
                     GJBJOBS_PRNT_FORM,
                     GJBJOBS_PRNT_CODE,
                     GJBJOBS_LINE_COUNT,
                     GJBJOBS_VALIDATION)
     VALUES ( :OBJECT_CODE,
             :OBJECT_DESC,
             SYSDATE,
             'S',
             'R',
             :OBJECT_DESC,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL);

COMMIT;