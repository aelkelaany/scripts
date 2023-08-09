 Insert into STVCHRT
   (STVCHRT_CODE, STVCHRT_DESC, STVCHRT_TERM_CODE_START, STVCHRT_TERM_CODE_END, STVCHRT_DLEV_CODE, 
    STVCHRT_ACTIVITY_DATE, STVCHRT_RIGHT_IND)
 Values
   ('TRNS_19', '„ÕÊ·Ì‰ ﬂ·Ì… «·„‰œﬁ', '144440', '999999', '»ﬂ', 
    sysdate, NULL);

INSERT INTO SGRCHRT (SGRCHRT_PIDM,
                     SGRCHRT_TERM_CODE_EFF,
                     SGRCHRT_CHRT_CODE,
                     SGRCHRT_ACTIVE_IND,
                     SGRCHRT_CREA_CODE,
                     SGRCHRT_ACTIVITY_DATE,
                     SGRCHRT_STSP_KEY_SEQUENCE)
   SELECT SGBSTDN_PIDM,
          '144440',
          'TRNS_19',
          NULL,
          NULL,
          SYSDATE,
          NULL
     FROM SGBSTDN SG
    WHERE     SGBSTDN_TERM_CODE_EFF =
                 (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                    FROM SGBSTDN
                   WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                         AND SGBSTDN_TERM_CODE_EFF <= '144440')
                         AND SGBSTDN_COLL_CODE_1='19'
          AND SGBSTDN_STST_CODE NOT IN ('ŒÃ')
          
          ;