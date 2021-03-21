
SELECT *
  FROM SHRTCKN
 WHERE     EXISTS
               (SELECT '1'
                  FROM bu_dev.tmp_tbl03
                 WHERE SHRTCKN_PIDM = COL02 AND COL01 <> '435015022')
       AND SHRTCKN_SUBJ_CODE || SHRTCKN_CRSE_NUMB IN ('11010123')
       AND SHRTCKN_TERM_CODE = '144030';

UPDATE SHRTCKN
   SET SHRTCKN_TERM_CODE = '143920', SHRTCKN_SEQ_NO = SHRTCKN_SEQ_NO + 10
 WHERE     EXISTS
               (SELECT '1'
                  FROM bu_dev.tmp_tbl03
                 WHERE SHRTCKN_PIDM = COL02 AND COL01 <> '435015022')
       AND SHRTCKN_SUBJ_CODE || SHRTCKN_CRSE_NUMB IN ('11010123')
       AND SHRTCKN_TERM_CODE = '144030';



SELECT *
  FROM SHRTCKG G1
 WHERE     SHRTCKG_TERM_CODE = '144030'
       AND SHRTCKG_TCKN_SEQ_NO =
           (SELECT SHRTCKN_SEQ_NO - 10
              FROM SHRTCKN
             WHERE     SHRTCKN_PIDM = SHRTCKG_PIDM
                   AND SHRTCKN_TERM_CODE = '143920'
                   AND SHRTCKN_SUBJ_CODE || SHRTCKN_CRSE_NUMB IN
                           ('11010123')
                   AND EXISTS
                           (SELECT '1'
                              FROM bu_dev.tmp_tbl03
                             WHERE     SHRTCKN_PIDM = COL02
                                   AND COL01 <> '435015022'))
       AND EXISTS
               (SELECT '1'
                  FROM bu_dev.tmp_tbl03
                 WHERE SHRTCKG_PIDM = COL02 AND COL01 <> '435015022');

UPDATE SHRTCKG G1
   SET SHRTCKG_TERM_CODE = '143920',
       SHRTCKG_TCKN_SEQ_NO = SHRTCKG_TCKN_SEQ_NO + 10
 WHERE     SHRTCKG_TERM_CODE = '144030'
       AND SHRTCKG_TCKN_SEQ_NO + 10 =
           (SELECT SHRTCKN_SEQ_NO
              FROM SHRTCKN
             WHERE     SHRTCKN_PIDM = SHRTCKG_PIDM
                   AND SHRTCKN_TERM_CODE = '143920'
                   AND SHRTCKN_SUBJ_CODE || SHRTCKN_CRSE_NUMB IN
                           ('11010123')
                   AND EXISTS
                           (SELECT '1'
                              FROM bu_dev.tmp_tbl03
                             WHERE     SHRTCKN_PIDM = COL02
                                   AND COL01 <> '435015022'))
       AND EXISTS
               (SELECT '1'
                  FROM bu_dev.tmp_tbl03
                 WHERE SHRTCKG_PIDM = COL02 AND COL01 <> '435015022');


SELECT *
  FROM SHRTCKL
 WHERE     SHRTCKL_TERM_CODE = '144030'
       AND SHRTCKL_TCKN_SEQ_NO + 10 =
           (SELECT SHRTCKN_SEQ_NO
              FROM SHRTCKN
             WHERE     SHRTCKN_PIDM = SHRTCKL_PIDM
                   AND SHRTCKN_TERM_CODE = '143920'
                   AND SHRTCKN_SUBJ_CODE || SHRTCKN_CRSE_NUMB IN
                           ('11010123')
                   AND EXISTS
                           (SELECT '1'
                              FROM bu_dev.tmp_tbl03
                             WHERE     SHRTCKN_PIDM = COL02
                                   AND COL01 <> '435015022'))
       AND EXISTS
               (SELECT '1'
                  FROM bu_dev.tmp_tbl03
                 WHERE SHRTCKL_PIDM = COL02 AND COL01 <> '435015022');

UPDATE SHRTCKL
   SET SHRTCKL_TERM_CODE = '143920',
       SHRTCKL_TCKN_SEQ_NO = SHRTCKL_TCKN_SEQ_NO + 10
 WHERE     SHRTCKL_TERM_CODE = '144030'
       AND SHRTCKL_TCKN_SEQ_NO + 10 =
           (SELECT SHRTCKN_SEQ_NO
              FROM SHRTCKN
             WHERE     SHRTCKN_PIDM = SHRTCKL_PIDM
                   AND SHRTCKN_TERM_CODE = '143920'
                   AND SHRTCKN_SUBJ_CODE || SHRTCKN_CRSE_NUMB IN
                           ('11010123')
                   AND EXISTS
                           (SELECT '1'
                              FROM bu_dev.tmp_tbl03
                             WHERE     SHRTCKN_PIDM = COL02
                                   AND COL01 <> '435015022'))
       AND EXISTS
               (SELECT '1'
                  FROM bu_dev.tmp_tbl03
                 WHERE SHRTCKL_PIDM = COL02 AND COL01 <>'435015022');