
SELECT 
   ROWID, TERM_CODE, STUDENT_PIDM, INVOICE_ID, 
   INVOICE_CODE, AMOUNT, CURRENCY, 
   EXPIRE_DATE, INVOICE_DESC, PAYMENT_LINK, 
   INVOICE_STATUS, ACTIVITY_DATE, USER_ID, 
   DATA_ORIGIN, NOTES
FROM BU_APPS.BNK_INVOICES
WHERE
TERM_CODE = '144430'
 and INVOICE_CODE = 'REGA'
 and student_pidm= f_get_pidm('442019731')
--AND INVOICE_STATUS = 'NEW'
;
select f_calc_tution_fees ('144430',f_get_pidm('442019731'),'')
  from dual ; 

INSERT INTO PG_invoices_waived_amt
    values( '144430',
           f_get_pidm('442019731'),
            f_calc_tution_fees ('144430', f_get_pidm('442019731'))/2 ,
           'email from Musaed on Sep20 half tution fees waived' );
           
           
           select f_calc_tution_fees ('144430',f_get_pidm('442019731'),'D')
  from dual ; 
  
  
  commit ; 