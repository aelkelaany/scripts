/* Formatted on 9/14/2023 10:03:29 AM (QP5 v5.371) */
 bu_dev.tmp_tbl_kilany_pg_fees
  -- col11 pidm 

SELECT * FROM bu_dev.tmp_tbl_kilany_pg_fees where col25='Full';

UPDATE bu_dev.tmp_tbl_kilany_pg_fees
   SET coL11 = f_get_pidm (col02) where col25='Full';
update bu_dev.tmp_tbl_kilany_pg_fees set col25='Full' where col25 is null ;
SELECT *
  FROM bu_dev.tmp_tbl_kilany_pg_fees
 WHERE col11 = 0;

DELETE FROM bu_dev.tmp_tbl_kilany_pg_fees
      WHERE col11 IS NULL;

UPDATE bu_dev.tmp_tbl_kilany_pg_fees
   SET col12 = f_calc_tution_fees ('144510', col11) where col25='Full';

INSERT INTO PG_invoices_waived_amt
    SELECT '144510',
           col11,
           col12 ,
           'email from Musaed on Sep14 with file Full tution fees waived'
      FROM bu_dev.tmp_tbl_kilany_pg_fees where col25='Full';

UPDATE bu_dev.tmp_tbl_kilany_pg_fees
   SET col13 = f_calc_tution_fees ('144510', col11) where col25='Full';

UPDATE bu_dev.tmp_tbl_kilany_pg_fees
   SET col14 = f_calc_tution_fees ('144510', col11, 'D');

UPDATE bu_dev.tmp_tbl_kilany_pg_fees
   SET col15 = col13 + col14;

SELECT *
  FROM bu_dev.tmp_tbl_kilany_pg_fees
 WHERE col15 != 0;



SELECT *
  FROM bnk_invoices
 WHERE     term_code = '144510'
       AND EXISTS
               (SELECT '1'
                  FROM bu_dev.tmp_tbl_kilany_pg_fees
                 WHERE col11 = student_pidm AND col13 = AMOUNT)
       AND INVOICE_CODE = 'REGA';
       
       bu_dev.tmp_tbl_kilany_pg_fees