/* Formatted on 8/27/2020 9:13:34 AM (QP5 v5.360) */
DELETE bu_dev.tmp_tbl03
 WHERE col01 IS NULL;

UPDATE bu_dev.tmp_tbl03
   SET col02 = f_get_pidm (col01);

DELETE bu_dev.tmp_tbl03
 WHERE col02 IS NULL;

UPDATE bu_dev.tmp_tbl03
   SET col03 = TRIM (REPLACE (col03, 'ÓÇÚÇÊ'));

UPDATE sfbetrm
   SET SFBETRM_MHRS_OVER =
             SFBETRM_MHRS_OVER
           + NVL ((SELECT max(col03)
                     FROM bu_dev.tmp_tbl03
                    WHERE col02 = SFBETRM_PIDM),
                  0)
 WHERE     SFBETRM_TERM_CODE = '144210'
       AND SFBETRM_PIDM IN (SELECT col02 FROM bu_dev.tmp_tbl03);