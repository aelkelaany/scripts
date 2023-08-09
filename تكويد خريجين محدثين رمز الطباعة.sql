/* Formatted on 7/6/2023 9:26:33 AM (QP5 v5.371) */
INSERT INTO GLBSLCT (GLBSLCT_APPLICATION,
                     GLBSLCT_SELECTION,
                     GLBSLCT_CREATOR_ID,
                     GLBSLCT_DESC,
                     GLBSLCT_LOCK_IND,
                     GLBSLCT_ACTIVITY_DATE,
                     GLBSLCT_TYPE_IND)
     VALUES ('STUDENT',
             'NOT_UPD_4430',
             'SAISUSR',
             'ØáÇÈ ÛíÑ ãÍÏËíä 4430',
             'N',
             SYSDATE,
             NULL);



INSERT INTO GLBEXTR
    SELECT 'STUDENT',
           'NOT_UPD_4430',
           'SAISUSR',
           'SAISUSR',
           PIDM,
           SYSDATE,
           'S',
           NULL
      FROM (SELECT a.sgbstdn_pidm                    pidm,
                   F_GET_STD_ID (a.sgbstdn_pidm)     STD_ID,
                   a.sgbstdn_term_code_eff
              FROM sgbstdn a
             WHERE     a.sgbstdn_term_code_eff = '144430'
                   AND sgbstdn_stst_code = 'ÎÌ'
                   AND EXISTS
                           (SELECT '1'
                              FROM SHRDGMR
                             WHERE     SHRDGMR_pidm = a.sgbstdn_pidm
                                   AND SHRDGMR_DEGS_CODE = 'ÎÌ'
                                   AND SHRDGMR_TERM_CODE_GRAD = '144430')
                   AND NOT EXISTS
                           (SELECT '1'
                              FROM request_master a, request_details b
                             WHERE     a.object_code = 'WF_UPDATE_STD_INFO'
                                   AND A.REQUEST_STATUS = 'C'
                                   AND a.request_no = b.request_no
                                   AND b.SEQUENCE_NO = 1
                                   AND b.ITEM_CODE = 'TERM_CODE'
                                   AND b.ITEM_VALUE >= '144430'
                                   AND REQUESTER_PIDM = a.sgbstdn_pidm));
                                   
                                   
                                   ------------ UPDATED 
                                   INSERT INTO GLBSLCT (GLBSLCT_APPLICATION,
                     GLBSLCT_SELECTION,
                     GLBSLCT_CREATOR_ID,
                     GLBSLCT_DESC,
                     GLBSLCT_LOCK_IND,
                     GLBSLCT_ACTIVITY_DATE,
                     GLBSLCT_TYPE_IND)
     VALUES ('STUDENT',
             'UPD_4430',
             'SAISUSR',
             'ØáÇÈ ãÍÏËíä 4430',
             'N',
             SYSDATE,
             NULL);



INSERT INTO GLBEXTR
    SELECT 'STUDENT',
           'UPD_4430',
           'SAISUSR',
           'SAISUSR',
           PIDM,
           SYSDATE,
           'S',
           NULL
      FROM (SELECT a.sgbstdn_pidm                    pidm,
                   F_GET_STD_ID (a.sgbstdn_pidm)     STD_ID,
                   a.sgbstdn_term_code_eff
              FROM sgbstdn a
             WHERE     a.sgbstdn_term_code_eff = '144430'
                   AND sgbstdn_stst_code = 'ÎÌ'
                   AND EXISTS
                           (SELECT '1'
                              FROM SHRDGMR
                             WHERE     SHRDGMR_pidm = a.sgbstdn_pidm
                                   AND SHRDGMR_DEGS_CODE = 'ÎÌ'
                                   AND SHRDGMR_TERM_CODE_GRAD = '144430')
                     AND EXISTS
                           (SELECT '1'
                              FROM request_master a, request_details b
                             WHERE     a.object_code = 'WF_UPDATE_STD_INFO'
                                   AND A.REQUEST_STATUS = 'C'
                                   AND a.request_no = b.request_no
                                   AND b.SEQUENCE_NO = 1
                                   AND b.ITEM_CODE = 'TERM_CODE'
                                   AND b.ITEM_VALUE >= '144430'
                                   AND REQUESTER_PIDM = a.sgbstdn_pidm));