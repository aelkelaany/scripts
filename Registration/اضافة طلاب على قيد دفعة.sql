 
Insert into STVCHRT
   (STVCHRT_CODE, STVCHRT_DESC, STVCHRT_TERM_CODE_START, STVCHRT_TERM_CODE_END, STVCHRT_DLEV_CODE, 
    STVCHRT_ACTIVITY_DATE, STVCHRT_RIGHT_IND)
 Values
   ('m_arab_33', 'ÿ·«» ·€… ⁄—»Ì…33', '144010' , '999999', '»ﬂ', 
    sysdate, NULL);
 Insert into STVCHRT
   (STVCHRT_CODE, STVCHRT_DESC, STVCHRT_TERM_CODE_START, STVCHRT_TERM_CODE_END, STVCHRT_DLEV_CODE, 
    STVCHRT_ACTIVITY_DATE, STVCHRT_RIGHT_IND)
 Values
   ('m_arab_38', 'ÿ·«» ·€… ⁄—»Ì…38', '144010', '999999', '»ﬂ', 
    sysdate, NULL);
 Insert into STVCHRT
   (STVCHRT_CODE, STVCHRT_DESC, STVCHRT_TERM_CODE_START, STVCHRT_TERM_CODE_END, STVCHRT_DLEV_CODE, 
    STVCHRT_ACTIVITY_DATE, STVCHRT_RIGHT_IND)
 Values
   ('f_arab_38', 'ÿ«·»«  ·€… ⁄—»Ì…38', '144010', '999999', '»ﬂ', 
    sysdate, NULL);
     Insert into STVCHRT
   (STVCHRT_CODE, STVCHRT_DESC, STVCHRT_TERM_CODE_START, STVCHRT_TERM_CODE_END, STVCHRT_DLEV_CODE, 
    STVCHRT_ACTIVITY_DATE, STVCHRT_RIGHT_IND)
 Values
   ('f_arab_33', 'ÿ«·»«  ·€… ⁄—»Ì…33', '144010', '999999', '»ﬂ', 
    sysdate, NULL);

INSERT INTO SGRCHRT (SGRCHRT_PIDM,
                     SGRCHRT_TERM_CODE_EFF,
                     SGRCHRT_CHRT_CODE,
                     SGRCHRT_ACTIVE_IND,
                     SGRCHRT_CREA_CODE,
                     SGRCHRT_ACTIVITY_DATE,
                     SGRCHRT_STSP_KEY_SEQUENCE)
   SELECT SGBSTDN_PIDM,
          '144010',
          'm_arab_33',
          NULL,
          NULL,
          SYSDATE,
          NULL
     FROM SGBSTDN SG
    WHERE     SGBSTDN_TERM_CODE_EFF =
                 (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                    FROM SGBSTDN
                   WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                         AND SGBSTDN_TERM_CODE_EFF <= '144010')
          AND SGBSTDN_STST_CODE NOT IN ('ŒÃ', 'ÿ”', '„”', '„‰')
          AND SGBSTDN_PROGRAM_1 IN ('1-1501-1433')
          AND SGBSTDN_TERM_CODE_CTLG_1 BETWEEN '143310' AND '143730' ;
          
          ------------ female 33
          INSERT INTO SGRCHRT (SGRCHRT_PIDM,
                     SGRCHRT_TERM_CODE_EFF,
                     SGRCHRT_CHRT_CODE,
                     SGRCHRT_ACTIVE_IND,
                     SGRCHRT_CREA_CODE,
                     SGRCHRT_ACTIVITY_DATE,
                     SGRCHRT_STSP_KEY_SEQUENCE)
   SELECT SGBSTDN_PIDM,
          '144010',
          'f_arab_33',
          NULL,
          NULL,
          SYSDATE,
          NULL
     FROM SGBSTDN SG
    WHERE     SGBSTDN_TERM_CODE_EFF =
                 (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                    FROM SGBSTDN
                   WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                         AND SGBSTDN_TERM_CODE_EFF <= '144010')
          AND SGBSTDN_STST_CODE NOT IN ('ŒÃ', 'ÿ”', '„”', '„‰')
          AND SGBSTDN_PROGRAM_1 IN ('2-1501-1433')
          AND SGBSTDN_TERM_CODE_CTLG_1 BETWEEN '143310' AND '143730' ;
          
          ----------male 38
          INSERT INTO SGRCHRT (SGRCHRT_PIDM,
                     SGRCHRT_TERM_CODE_EFF,
                     SGRCHRT_CHRT_CODE,
                     SGRCHRT_ACTIVE_IND,
                     SGRCHRT_CREA_CODE,
                     SGRCHRT_ACTIVITY_DATE,
                     SGRCHRT_STSP_KEY_SEQUENCE)
   SELECT SGBSTDN_PIDM,
          '144010',
          'm_arab_38',
          NULL,
          NULL,
          SYSDATE,
          NULL
     FROM SGBSTDN SG
    WHERE     SGBSTDN_TERM_CODE_EFF =
                 (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                    FROM SGBSTDN
                   WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                         AND SGBSTDN_TERM_CODE_EFF <= '144010')
          AND SGBSTDN_STST_CODE NOT IN ('ŒÃ', 'ÿ”', '„”', '„‰')
          AND SGBSTDN_PROGRAM_1 IN ('1-1501-1433')
          AND SGBSTDN_TERM_CODE_CTLG_1 >= '143810'  ;
                   ----------female 38
          INSERT INTO SGRCHRT (SGRCHRT_PIDM,
                     SGRCHRT_TERM_CODE_EFF,
                     SGRCHRT_CHRT_CODE,
                     SGRCHRT_ACTIVE_IND,
                     SGRCHRT_CREA_CODE,
                     SGRCHRT_ACTIVITY_DATE,
                     SGRCHRT_STSP_KEY_SEQUENCE)
   SELECT SGBSTDN_PIDM,
          '144010',
          'f_arab_38',
          NULL,
          NULL,
          SYSDATE,
          NULL
     FROM SGBSTDN SG
    WHERE     SGBSTDN_TERM_CODE_EFF =
                 (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                    FROM SGBSTDN
                   WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                         AND SGBSTDN_TERM_CODE_EFF <= '144010')
          AND SGBSTDN_STST_CODE NOT IN ('ŒÃ', 'ÿ”', '„”', '„‰')
          AND SGBSTDN_PROGRAM_1 IN ('2-1501-1433')
          AND SGBSTDN_TERM_CODE_CTLG_1 >= '143810' ;
          --
          
           Insert into STVCHRT
   (STVCHRT_CODE, STVCHRT_DESC, STVCHRT_TERM_CODE_START, STVCHRT_TERM_CODE_END, STVCHRT_DLEV_CODE, 
    STVCHRT_ACTIVITY_DATE, STVCHRT_RIGHT_IND)
 Values
   ('M_BIO_BAHA', 'ÿ·«» «ÕÌ«¡ »«Õ…', '144030' , '999999', '»ﬂ', 
    sysdate, NULL);
    
              INSERT INTO SGRCHRT (SGRCHRT_PIDM,
                     SGRCHRT_TERM_CODE_EFF,
                     SGRCHRT_CHRT_CODE,
                     SGRCHRT_ACTIVE_IND,
                     SGRCHRT_CREA_CODE,
                     SGRCHRT_ACTIVITY_DATE,
                     SGRCHRT_STSP_KEY_SEQUENCE)
   SELECT col02,
          '144030',
          'M_BIO_BAHA',
          NULL,
          NULL,
          SYSDATE,
          NULL
     FROM bu_dev.tmp_tbl04
    WHERE    COL03 ='M' --sex
    and col04 in ('AQ','MN','BL') --coll
    and col06 in ('BIO') -- dept    
    ; 
    
           ---
   Insert into STVCHRT
   (STVCHRT_CODE, STVCHRT_DESC, STVCHRT_TERM_CODE_START, STVCHRT_TERM_CODE_END, STVCHRT_DLEV_CODE, 
    STVCHRT_ACTIVITY_DATE, STVCHRT_RIGHT_IND)
 Values
   ('F_BIO_BAHA', 'ÿ«·»«  «ÕÌ«¡ »«Õ…', '144030' , '999999', '»ﬂ', 
    sysdate, NULL);
    
              INSERT INTO SGRCHRT (SGRCHRT_PIDM,
                     SGRCHRT_TERM_CODE_EFF,
                     SGRCHRT_CHRT_CODE,
                     SGRCHRT_ACTIVE_IND,
                     SGRCHRT_CREA_CODE,
                     SGRCHRT_ACTIVITY_DATE,
                     SGRCHRT_STSP_KEY_SEQUENCE)
   SELECT col02,
          '144030',
          'F_BIO_BAHA',
          NULL,
          NULL,
          SYSDATE,
          NULL
     FROM bu_dev.tmp_tbl04
    WHERE    COL03 ='F' --sex
    and col04 in ('AQ','MN','BL') --coll
    and col06 in ('BIO') -- dept   
    ;
     ----------------------
        Insert into STVCHRT
   (STVCHRT_CODE, STVCHRT_DESC, STVCHRT_TERM_CODE_START, STVCHRT_TERM_CODE_END, STVCHRT_DLEV_CODE, 
    STVCHRT_ACTIVITY_DATE, STVCHRT_RIGHT_IND)
 Values
   ('M_BIO_THMA', 'ÿ·«» «ÕÌ«¡  Â«„…', '144030' , '999999', '»ﬂ', 
    sysdate, NULL);
    
              INSERT INTO SGRCHRT (SGRCHRT_PIDM,
                     SGRCHRT_TERM_CODE_EFF,
                     SGRCHRT_CHRT_CODE,
                     SGRCHRT_ACTIVE_IND,
                     SGRCHRT_CREA_CODE,
                     SGRCHRT_ACTIVITY_DATE,
                     SGRCHRT_STSP_KEY_SEQUENCE)
   SELECT DISTINCT col02,
          '144030',
          'M_BIO_THMA',
          NULL,
          NULL,
          SYSDATE,
          NULL
     FROM bu_dev.tmp_tbl04
    WHERE    COL03 ='M' --sex
    and col04 in ('MK','QL') --coll
    and col06 in ('BIO') -- dept   
    ;
    
           Insert into STVCHRT
   (STVCHRT_CODE, STVCHRT_DESC, STVCHRT_TERM_CODE_START, STVCHRT_TERM_CODE_END, STVCHRT_DLEV_CODE, 
    STVCHRT_ACTIVITY_DATE, STVCHRT_RIGHT_IND)
 Values
   ('F_BIO_THMA', 'ÿ«·»«  «ÕÌ«¡  Â«„…', '144030' , '999999', '»ﬂ', 
    sysdate, NULL);
    
              INSERT INTO SGRCHRT (SGRCHRT_PIDM,
                     SGRCHRT_TERM_CODE_EFF,
                     SGRCHRT_CHRT_CODE,
                     SGRCHRT_ACTIVE_IND,
                     SGRCHRT_CREA_CODE,
                     SGRCHRT_ACTIVITY_DATE,
                     SGRCHRT_STSP_KEY_SEQUENCE)
   SELECT col02,
          '144030',
          'F_BIO_THMA',
          NULL,
          NULL,
          SYSDATE,
          NULL
     FROM bu_dev.tmp_tbl04
    WHERE    COL03 ='F' --sex
    and col04 in ('MK','QL') --coll
    and col06 in ('BIO') -- dept   
    ;
    
     Insert into STVCHRT
   (STVCHRT_CODE, STVCHRT_DESC, STVCHRT_TERM_CODE_START, STVCHRT_TERM_CODE_END, STVCHRT_DLEV_CODE, 
    STVCHRT_ACTIVITY_DATE, STVCHRT_RIGHT_IND)
 Values
   ('M_PHS_BAHA', 'ÿ·«» ›Ì“Ì«¡ »«Õ…', '144030' , '999999', '»ﬂ', 
    sysdate, NULL);
    
              INSERT INTO SGRCHRT (SGRCHRT_PIDM,
                     SGRCHRT_TERM_CODE_EFF,
                     SGRCHRT_CHRT_CODE,
                     SGRCHRT_ACTIVE_IND,
                     SGRCHRT_CREA_CODE,
                     SGRCHRT_ACTIVITY_DATE,
                     SGRCHRT_STSP_KEY_SEQUENCE)
   SELECT col02,
          '144030',
          'M_PHS_BAHA',
          NULL,
          NULL,
          SYSDATE,
          NULL
     FROM bu_dev.tmp_tbl04
    WHERE    COL03 ='M' --sex
    and col04 in ('AQ','MN','BL') --coll
    and col06 in ('PHS') -- dept    
    ; 
    
           ---
   Insert into STVCHRT
   (STVCHRT_CODE, STVCHRT_DESC, STVCHRT_TERM_CODE_START, STVCHRT_TERM_CODE_END, STVCHRT_DLEV_CODE, 
    STVCHRT_ACTIVITY_DATE, STVCHRT_RIGHT_IND)
 Values
   ('F_PHS_BAHA', 'ÿ«·»«  ›Ì“Ì«¡ »«Õ…', '144030' , '999999', '»ﬂ', 
    sysdate, NULL);
    
              INSERT INTO SGRCHRT (SGRCHRT_PIDM,
                     SGRCHRT_TERM_CODE_EFF,
                     SGRCHRT_CHRT_CODE,
                     SGRCHRT_ACTIVE_IND,
                     SGRCHRT_CREA_CODE,
                     SGRCHRT_ACTIVITY_DATE,
                     SGRCHRT_STSP_KEY_SEQUENCE)
   SELECT col02,
          '144030',
          'F_PHS_BAHA',
          NULL,
          NULL,
          SYSDATE,
          NULL
     FROM bu_dev.tmp_tbl04
    WHERE    COL03 ='F' --sex
    and col04 in ('AQ','MN','BL') --coll
    and col06 in ('PHS') -- dept   
    ;
     ----------------------
        Insert into STVCHRT
   (STVCHRT_CODE, STVCHRT_DESC, STVCHRT_TERM_CODE_START, STVCHRT_TERM_CODE_END, STVCHRT_DLEV_CODE, 
    STVCHRT_ACTIVITY_DATE, STVCHRT_RIGHT_IND)
 Values
   ('M_PHS_THMA', 'ÿ·«» ›“Ì«¡  Â«„…', '144030' , '999999', '»ﬂ', 
    sysdate, NULL);
    
              INSERT INTO SGRCHRT (SGRCHRT_PIDM,
                     SGRCHRT_TERM_CODE_EFF,
                     SGRCHRT_CHRT_CODE,
                     SGRCHRT_ACTIVE_IND,
                     SGRCHRT_CREA_CODE,
                     SGRCHRT_ACTIVITY_DATE,
                     SGRCHRT_STSP_KEY_SEQUENCE)
   SELECT col02,
          '144030',
          'M_PHS_THMA',
          NULL,
          NULL,
          SYSDATE,
          NULL
     FROM bu_dev.tmp_tbl04
    WHERE    COL03 ='M' --sex
    and col04 in ('MK','QL') --coll
    and col06 in ('PHS') -- dept   
    ;
    
           Insert into STVCHRT
   (STVCHRT_CODE, STVCHRT_DESC, STVCHRT_TERM_CODE_START, STVCHRT_TERM_CODE_END, STVCHRT_DLEV_CODE, 
    STVCHRT_ACTIVITY_DATE, STVCHRT_RIGHT_IND)
 Values
   ('F_PHS_THMA', 'ÿ«·»«  ›“Ì«¡  Â«„…', '144030' , '999999', '»ﬂ', 
    sysdate, NULL);
    
              INSERT INTO SGRCHRT (SGRCHRT_PIDM,
                     SGRCHRT_TERM_CODE_EFF,
                     SGRCHRT_CHRT_CODE,
                     SGRCHRT_ACTIVE_IND,
                     SGRCHRT_CREA_CODE,
                     SGRCHRT_ACTIVITY_DATE,
                     SGRCHRT_STSP_KEY_SEQUENCE)
   SELECT col02,
          '144030',
          'F_PHS_THMA',
          NULL,
          NULL,
          SYSDATE,
          NULL
     FROM bu_dev.tmp_tbl04
    WHERE    COL03 ='F' --sex
    and col04 in ('MK','QL') --coll
    and col06 in ('PHS') -- dept   
    ;
    
    ----------------------------
    Insert into STVCHRT
   (STVCHRT_CODE, STVCHRT_DESC, STVCHRT_TERM_CODE_START, STVCHRT_TERM_CODE_END, STVCHRT_DLEV_CODE, 
    STVCHRT_ACTIVITY_DATE, STVCHRT_RIGHT_IND)
 Values
   ('M_CHM_BAHA', 'ÿ·«» ﬂÌ„Ì«¡ »«Õ…', '144030' , '999999', '»ﬂ', 
    sysdate, NULL);
    
              INSERT INTO SGRCHRT (SGRCHRT_PIDM,
                     SGRCHRT_TERM_CODE_EFF,
                     SGRCHRT_CHRT_CODE,
                     SGRCHRT_ACTIVE_IND,
                     SGRCHRT_CREA_CODE,
                     SGRCHRT_ACTIVITY_DATE,
                     SGRCHRT_STSP_KEY_SEQUENCE)
   SELECT col02,
          '144030',
          'M_CHM_BAHA',
          NULL,
          NULL,
          SYSDATE,
          NULL
     FROM bu_dev.tmp_tbl04
    WHERE    COL03 ='M' --sex
    and col04 in ('AQ','MN','BL') --coll
    and col06 in ('CHM') -- dept    
    ; 
    
           ---
   Insert into STVCHRT
   (STVCHRT_CODE, STVCHRT_DESC, STVCHRT_TERM_CODE_START, STVCHRT_TERM_CODE_END, STVCHRT_DLEV_CODE, 
    STVCHRT_ACTIVITY_DATE, STVCHRT_RIGHT_IND)
 Values
   ('F_CHM_BAHA', 'ÿ«·»«  ﬂÌ„Ì«¡ »«Õ…', '144030' , '999999', '»ﬂ', 
    sysdate, NULL);
    
              INSERT INTO SGRCHRT (SGRCHRT_PIDM,
                     SGRCHRT_TERM_CODE_EFF,
                     SGRCHRT_CHRT_CODE,
                     SGRCHRT_ACTIVE_IND,
                     SGRCHRT_CREA_CODE,
                     SGRCHRT_ACTIVITY_DATE,
                     SGRCHRT_STSP_KEY_SEQUENCE)
   SELECT col02,
          '144030',
          'F_CHM_BAHA',
          NULL,
          NULL,
          SYSDATE,
          NULL
     FROM bu_dev.tmp_tbl04
    WHERE    COL03 ='F' --sex
    and col04 in ('AQ','MN','BL') --coll
    and col06 in ('CHM') -- dept   
    ;
     ----------------------
        Insert into STVCHRT
   (STVCHRT_CODE, STVCHRT_DESC, STVCHRT_TERM_CODE_START, STVCHRT_TERM_CODE_END, STVCHRT_DLEV_CODE, 
    STVCHRT_ACTIVITY_DATE, STVCHRT_RIGHT_IND)
 Values
   ('M_CHM_THMA', 'ÿ·«» ﬂÌ„Ì«¡  Â«„…', '144030' , '999999', '»ﬂ', 
    sysdate, NULL);
    
              INSERT INTO SGRCHRT (SGRCHRT_PIDM,
                     SGRCHRT_TERM_CODE_EFF,
                     SGRCHRT_CHRT_CODE,
                     SGRCHRT_ACTIVE_IND,
                     SGRCHRT_CREA_CODE,
                     SGRCHRT_ACTIVITY_DATE,
                     SGRCHRT_STSP_KEY_SEQUENCE)
   SELECT col02,
          '144030',
          'M_CHM_THMA',
          NULL,
          NULL,
          SYSDATE,
          NULL
     FROM bu_dev.tmp_tbl04
    WHERE    COL03 ='M' --sex
    and col04 in ('MK','QL') --coll
    and col06 in ('CHM') -- dept   
    ;
    
           Insert into STVCHRT
   (STVCHRT_CODE, STVCHRT_DESC, STVCHRT_TERM_CODE_START, STVCHRT_TERM_CODE_END, STVCHRT_DLEV_CODE, 
    STVCHRT_ACTIVITY_DATE, STVCHRT_RIGHT_IND)
 Values
   ('F_CHM_THMA', 'ÿ«·»«  ﬂÌ„Ì«¡  Â«„…', '144030' , '999999', '»ﬂ', 
    sysdate, NULL);
    
              INSERT INTO SGRCHRT (SGRCHRT_PIDM,
                     SGRCHRT_TERM_CODE_EFF,
                     SGRCHRT_CHRT_CODE,
                     SGRCHRT_ACTIVE_IND,
                     SGRCHRT_CREA_CODE,
                     SGRCHRT_ACTIVITY_DATE,
                     SGRCHRT_STSP_KEY_SEQUENCE)
   SELECT col02,
          '144030',
          'F_CHM_THMA',
          NULL,
          NULL,
          SYSDATE,
          NULL
     FROM bu_dev.tmp_tbl04
    WHERE    COL03 ='F' --sex
    and col04 in ('MK','QL') --coll
    and col06 in ('CHM') -- dept   
    ;
    
        ----------------------------
    Insert into STVCHRT
   (STVCHRT_CODE, STVCHRT_DESC, STVCHRT_TERM_CODE_START, STVCHRT_TERM_CODE_END, STVCHRT_DLEV_CODE, 
    STVCHRT_ACTIVITY_DATE, STVCHRT_RIGHT_IND)
 Values
   ('M_MTH_BAHA', 'ÿ·«» —Ì«÷Ì«  »«Õ…', '144030' , '999999', '»ﬂ', 
    sysdate, NULL);
    
              INSERT INTO SGRCHRT (SGRCHRT_PIDM,
                     SGRCHRT_TERM_CODE_EFF,
                     SGRCHRT_CHRT_CODE,
                     SGRCHRT_ACTIVE_IND,
                     SGRCHRT_CREA_CODE,
                     SGRCHRT_ACTIVITY_DATE,
                     SGRCHRT_STSP_KEY_SEQUENCE)
   SELECT col02,
          '144030',
          'M_MTH_BAHA',
          NULL,
          NULL,
          SYSDATE,
          NULL
     FROM bu_dev.tmp_tbl04
    WHERE    COL03 ='M' --sex
    and col04 in ('AQ','MN','BL') --coll
    and col06 in ('MTH') -- dept    
    ; 
    
           ---
   Insert into STVCHRT
   (STVCHRT_CODE, STVCHRT_DESC, STVCHRT_TERM_CODE_START, STVCHRT_TERM_CODE_END, STVCHRT_DLEV_CODE, 
    STVCHRT_ACTIVITY_DATE, STVCHRT_RIGHT_IND)
 Values
   ('F_MTH_BAHA', 'ÿ«·»«  —Ì«÷Ì«  »«Õ…', '144030' , '999999', '»ﬂ', 
    sysdate, NULL);
    
              INSERT INTO SGRCHRT (SGRCHRT_PIDM,
                     SGRCHRT_TERM_CODE_EFF,
                     SGRCHRT_CHRT_CODE,
                     SGRCHRT_ACTIVE_IND,
                     SGRCHRT_CREA_CODE,
                     SGRCHRT_ACTIVITY_DATE,
                     SGRCHRT_STSP_KEY_SEQUENCE)
   SELECT col02,
          '144030',
          'F_MTH_BAHA',
          NULL,
          NULL,
          SYSDATE,
          NULL
     FROM bu_dev.tmp_tbl04
    WHERE    COL03 ='F' --sex
    and col04 in ('AQ','MN','BL') --coll
    and col06 in ('MTH') -- dept   
    ;
     ----------------------
        Insert into STVCHRT
   (STVCHRT_CODE, STVCHRT_DESC, STVCHRT_TERM_CODE_START, STVCHRT_TERM_CODE_END, STVCHRT_DLEV_CODE, 
    STVCHRT_ACTIVITY_DATE, STVCHRT_RIGHT_IND)
 Values
   ('M_MTH_THMA', 'ÿ·«» —Ì«÷Ì«   Â«„…', '144030' , '999999', '»ﬂ', 
    sysdate, NULL);
    
              INSERT INTO SGRCHRT (SGRCHRT_PIDM,
                     SGRCHRT_TERM_CODE_EFF,
                     SGRCHRT_CHRT_CODE,
                     SGRCHRT_ACTIVE_IND,
                     SGRCHRT_CREA_CODE,
                     SGRCHRT_ACTIVITY_DATE,
                     SGRCHRT_STSP_KEY_SEQUENCE)
   SELECT col02,
          '144030',
          'M_MTH_THMA',
          NULL,
          NULL,
          SYSDATE,
          NULL
     FROM bu_dev.tmp_tbl04
    WHERE    COL03 ='M' --sex
    and col04 in ('MK','QL') --coll
    and col06 in ('MTH') -- dept   
    ;
    
           Insert into STVCHRT
   (STVCHRT_CODE, STVCHRT_DESC, STVCHRT_TERM_CODE_START, STVCHRT_TERM_CODE_END, STVCHRT_DLEV_CODE, 
    STVCHRT_ACTIVITY_DATE, STVCHRT_RIGHT_IND)
 Values
   ('55-33', '’Ìœ·… ', '144030' , '999999', '»ﬂ', 
    sysdate, NULL);
    
              INSERT INTO SGRCHRT (SGRCHRT_PIDM,
                     SGRCHRT_TERM_CODE_EFF,
                     SGRCHRT_CHRT_CODE,
                     SGRCHRT_ACTIVE_IND,
                     SGRCHRT_CREA_CODE,
                     SGRCHRT_ACTIVITY_DATE,
                     SGRCHRT_STSP_KEY_SEQUENCE)
   SELECT sgbstdn_pidm,
          '144030',
          '55-33',
          NULL,
          NULL,
          SYSDATE,
          NULL
     FROM SGBSTDN sg 
     
where   SGBSTDN_LEVL_CODE='Ã„'
     
   AND  SGBSTDN_STST_CODE='AS'
   and   SGBSTDN_TERM_CODE_EFF =(select max(SGBSTDN_TERM_CODE_EFF) from sgbstdn where sgbstdn_pidm=sg.sgbstdn_pidm)
    
          
         and sgbstdn_coll_code_1='55'
         and substr(f_get_std_id(sgbstdn_pidm),1,3)in ('435','433','436','434');