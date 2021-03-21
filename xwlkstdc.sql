/* Formatted on 02/11/2020 11:58:17 (QP5 v5.227.12220.39754) */
INSERT INTO TWGRWMRL (TWGRWMRL_NAME,
                      TWGRWMRL_ROLE,
                      TWGRWMRL_ACTIVITY_DATE,
                      TWGRWMRL_SOURCE_IND)
     VALUES ('xwlkstdc.P_DISP',
             'FACULTY',
             SYSDATE,
             'L');

INSERT INTO WTAILOR.TWGBWMNU (TWGBWMNU_NAME,
                              TWGBWMNU_DESC,
                              TWGBWMNU_PAGE_TITLE,
                              TWGBWMNU_HEADER,
                              TWGBWMNU_L_MARGIN_WIDTH,
                              TWGBWMNU_R_MARGIN_WIDTH,
                              TWGBWMNU_BACK_URL,
                              TWGBWMNU_BACK_LINK,
                              TWGBWMNU_BACK_MENU_IND,
                              TWGBWMNU_MODULE,
                              TWGBWMNU_ENABLED_IND,
                              TWGBWMNU_INSECURE_ALLOWED_IND,
                              TWGBWMNU_ACTIVITY_DATE,
                              TWGBWMNU_CACHE_OVERRIDE,
                              TWGBWMNU_SOURCE_IND,
                              TWGBWMNU_ADM_ACCESS_IND)
     VALUES ('xwlkstdc.P_DISP',
             '—’œ «·≈‰ﬁÿ«⁄',
             '—’œ «·≈‰ﬁÿ«⁄',
             '—’œ «·≈‰ﬁÿ«⁄',
             '30',
             '40',
             'bmenu.P_FacMainMnu',
             '«·—ÃÊ⁄ ≈·Ï «·ﬁ«∆„…',
             'Y',
             'STU',
             'Y',
             'Y',
             SYSDATE,
             'S',
             'L',
             'N');
             INSERT INTO WTAILOR.TWGBWMNU (TWGBWMNU_NAME,
                              TWGBWMNU_DESC,
                              TWGBWMNU_PAGE_TITLE,
                              TWGBWMNU_HEADER,
                              TWGBWMNU_L_MARGIN_WIDTH,
                              TWGBWMNU_R_MARGIN_WIDTH,
                              TWGBWMNU_BACK_URL,
                              TWGBWMNU_BACK_LINK,
                              TWGBWMNU_BACK_MENU_IND,
                              TWGBWMNU_MODULE,
                              TWGBWMNU_ENABLED_IND,
                              TWGBWMNU_INSECURE_ALLOWED_IND,
                              TWGBWMNU_ACTIVITY_DATE,
                              TWGBWMNU_CACHE_OVERRIDE,
                              TWGBWMNU_SOURCE_IND,
                              TWGBWMNU_ADM_ACCESS_IND)
     VALUES ('xwlkstdc.P_PRINT_LIST',
             '—’œ «·≈‰ﬁÿ«⁄',
             '—’œ «·≈‰ﬁÿ«⁄',
             '—’œ «·≈‰ﬁÿ«⁄',
             '30',
             '40',
             'bmenu.P_FacMainMnu',
             '«·—ÃÊ⁄ ≈·Ï «·ﬁ«∆„…',
             'Y',
             'STU',
             'Y',
             'Y',
             SYSDATE,
             'S',
             'L',
             'N');
             INSERT INTO WTAILOR.TWGBWMNU (TWGBWMNU_NAME,
                              TWGBWMNU_DESC,
                              TWGBWMNU_PAGE_TITLE,
                              TWGBWMNU_HEADER,
                              TWGBWMNU_L_MARGIN_WIDTH,
                              TWGBWMNU_R_MARGIN_WIDTH,
                              TWGBWMNU_BACK_URL,
                              TWGBWMNU_BACK_LINK,
                              TWGBWMNU_BACK_MENU_IND,
                              TWGBWMNU_MODULE,
                              TWGBWMNU_ENABLED_IND,
                              TWGBWMNU_INSECURE_ALLOWED_IND,
                              TWGBWMNU_ACTIVITY_DATE,
                              TWGBWMNU_CACHE_OVERRIDE,
                              TWGBWMNU_SOURCE_IND,
                              TWGBWMNU_ADM_ACCESS_IND)
     VALUES ('xwlkstdc.P_PROC',
             '—’œ «·≈‰ﬁÿ«⁄',
             '—’œ «·≈‰ﬁÿ«⁄',
             '—’œ «·≈‰ﬁÿ«⁄',
             '30',
             '40',
             'bmenu.P_FacMainMnu',
             '«·—ÃÊ⁄ ≈·Ï «·ﬁ«∆„…',
             'Y',
             'STU',
             'Y',
             'Y',
             SYSDATE,
             'S',
             'L',
             'N');
 


INSERT INTO WTAILOR.TWGRMENU (TWGRMENU_NAME,
                              TWGRMENU_SEQUENCE,
                              TWGRMENU_URL_TEXT,
                              TWGRMENU_URL,
                              TWGRMENU_ENABLED,
                              TWGRMENU_DB_LINK_IND,
                              TWGRMENU_SUBMENU_IND,
                              TWGRMENU_ACTIVITY_DATE,
                              TWGRMENU_SOURCE_IND)
     VALUES ('bmenu.P_FacMainMnu',
             46,
             '—’œ «·≈‰ﬁÿ«⁄',
             'xwlkstdc.P_DISP',
             'Y',
             'Y',
             'N',
            sysdate,
             'L');

COMMIT;

COMMIT;

GRANT EXECUTE ON xwlkstdc TO PUBLIC;
CREATE PUBLIC SYNONYM xwlkstdc FOR bu_apps.xwlkstdc;

create table sybstdc (sybstdc_term_code varchar2(8),sybstdc_crn varchar2(8),sybstdc_pidm number(9),sybstdc_disconnected varchar2(1));
alter table sybstdc ADD CONSTRAINT SYBSTDC_PK
  PRIMARY KEY
  (SYBSTDC_TERM_CODE, SYBSTDC_CRN, SYBSTDC_PIDM);
  ALTER TABLE BU_APPS.SYBSTDC
ADD (sybstdc_submit_date DATE);
  grant select,update,delete on bu_apps.sybstdc to public ;
  CREATE PUBLIC SYNONYM sybstdc FOR bu_apps.sybstdc;
  
SET DEFINE OFF;
Insert into BU_APPS.DEV_SYS_PARAMETERS
   (MODULE, PARAMETER_CODE, SEQUENCE_NO, PARAMETER_VALUE, ACTIVITY_DATE, 
    USER_ID, ACTIVE, SYSTEM_REQ_IND)
 Values
   ('SSB_SERVICE', 'DISCONNECT_REPORT_ONLY', 1, 'Y', TO_DATE('11/04/2020 14:16:18', 'MM/DD/YYYY HH24:MI:SS'), 
    'BU_APPS', 'Y', 'Y');
Insert into BU_APPS.DEV_SYS_PARAMETERS
   (MODULE, PARAMETER_CODE, SEQUENCE_NO, PARAMETER_VALUE, ACTIVITY_DATE, 
    USER_ID, ACTIVE, SYSTEM_REQ_IND)
 Values
   ('SSB_SERVICE', 'DISCONNECT_SERVICE_ALLOW', 1, 'Y', TO_DATE('11/04/2020 14:16:18', 'MM/DD/YYYY HH24:MI:SS'), 
    'BU_APPS', 'Y', 'Y');
COMMIT;

