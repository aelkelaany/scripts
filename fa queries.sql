/* Formatted on 9/11/2023 2:07:59 PM (QP5 v5.371) */
  SELECT  TBRACCD_PIDM 
    FROM TBRACCD
   WHERE     TBRACCD_DETAIL_CODE = 'Õ.Ø'
         AND EXISTS
                 (SELECT 1
                    FROM SATURN.RWTPAYR crnt
                   WHERE     RWTPAYR_TRAN_NUMBER = 913
                         AND RWTPAYR_pidm = TBRACCD_pidm
                           and RWTPAYR_PAYMENT  in (2000,1700)
                         AND NOT EXISTS
                                 (SELECT '1'
                                    FROM SATURN.RWTPAYR
                                   WHERE     RWTPAYR_PIDM = crnt.RWTPAYR_PIDM
                                         AND RWTPAYR_TRAN_NUMBER = 907))
         AND TBRACCD_TERM_CODE = '144510'
         AND TO_CHAR (TBRACCD_EFFECTIVE_DATE, 'mm/dd/yyyy') = '09/11/2023'
         AND TO_CHAR (TBRACCD_ENTRY_DATE, 'mm/dd/yyyy') = '09/11/2023'
 having count(TBRACCD_PIDM)=1
 group by TBRACCD_PIDM
 
 ;
 
  SELECT count(1)
                    FROM SATURN.RWTPAYR crnt
                   WHERE     RWTPAYR_TRAN_NUMBER = 913
                       --  AND RWTPAYR_pidm = TBRACCD_pidm
                         AND NOT EXISTS
                                 (SELECT '1'
                                    FROM SATURN.RWTPAYR
                                   WHERE     RWTPAYR_PIDM = crnt.RWTPAYR_PIDM
                                         AND RWTPAYR_TRAN_NUMBER = 907) ;