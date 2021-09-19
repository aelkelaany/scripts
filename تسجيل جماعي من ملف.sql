/* Formatted on 15/09/2021 13:33:02 (QP5 v5.371) */
---- ”ÃÌ· Ã„«⁄Ì „‰ „·›

DECLARE
    CURSOR get_data IS
        SELECT DISTINCT col03     crn
          FROM bu_dev.tmp_tbl_kilany where col03 is not null   ;
BEGIN
    FOR rec IN get_data
    LOOP
        INSERT INTO GLBSLCT (GLBSLCT_APPLICATION,
                             GLBSLCT_SELECTION,
                             GLBSLCT_CREATOR_ID,
                             GLBSLCT_DESC,
                             GLBSLCT_LOCK_IND,
                             GLBSLCT_ACTIVITY_DATE,
                             GLBSLCT_TYPE_IND)
             VALUES ('STUDENT',
                     'REG_MS_' || rec.crn,
                     'SAISUSR',
                     ' ”ÃÌ·  ',
                     'N',
                     SYSDATE,
                     NULL);

        INSERT INTO GLBEXTR
            SELECT DISTINCT 'STUDENT',
                   'REG_MS_' || rec.crn,
                   'SAISUSR',
                   'SAISUSR',f_get_pidm (col02) PIDM , SYSDATE,
                   'S',
                   NULL
                      FROM bu_dev.tmp_tbl_kilany
                     WHERE col03 = rec.crn
                     and col02 is not null  ;

        DBMS_OUTPUT.put_line ('REG_MS_' || rec.crn||','||rec.crn);
    END LOOP;
END;

update ssbsect set SSBSECT_BILL_HRS=SSBSECT_CREDIT_HRS
where ssbsect_term_code='144310'
and SSBSECT_BILL_HRS is null ;


  SELECT * FROM   bu_dev.tmp_tbl_kilany
  WHERE col03 NOT IN (SELECT SFRSTCR_CRN FROM SFRSTCR WHERE SFRSTCR_PIDM=COL04 AND SFRSTCR_term_code='144310' )