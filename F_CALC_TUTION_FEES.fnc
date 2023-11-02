
 

CREATE OR REPLACE FUNCTION f_calc_tution_fees (
    p_term        VARCHAR2,
    p_pidm        NUMBER,
    p_fees_type   CHAR DEFAULT NULL)
    RETURN NUMBER
IS
    CURSOR get_fees IS
        SELECT fees
          FROM (SELECT   (SELECT NVL (SUM (tbraccd_amount), 0)
                            FROM sobterm, tbbdetc, tbraccd
                           WHERE     tbraccd_pidm = p_pidm
                                 AND tbraccd_term_code = p_term
                                 AND tbbdetc_detail_code =
                                     tbraccd_detail_code
                                 AND tbbdetc_detail_code = 'REGF'
                                 AND tbbdetc_dcat_code = 'TUI'
                                 AND sobterm_term_code = tbraccd_term_code
                                 AND   NVL (p_fees_type, 'T') != 'D')
                       - NVL (
                             (SELECT WAIVED_AMT
                                FROM PG_invoices_waived_amt
                               WHERE     term_code = p_term
                                     AND st_pidm = p_pidm
                                     AND NVL (p_fees_type, 'T') != 'O'),
                             0) fees
                  FROM DUAL);

    r_fees_value   tbraccd.tbraccd_amount%TYPE;
BEGIN
    OPEN get_fees;

    FETCH get_fees INTO r_fees_value;

    CLOSE get_fees;

    RETURN NVL (r_fees_value, -1);
END;

select f_calc_tution_fees ('144430',f_get_pidm('442021564'),'')
  from dual ; 