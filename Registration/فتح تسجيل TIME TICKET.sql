/* Formatted on 23/12/2021 12:00:44 (QP5 v5.371) */
 --UGR1

INSERT INTO SFBRGRP (SFBRGRP_TERM_CODE,
                     SFBRGRP_PIDM,
                     SFBRGRP_RGRP_CODE,
                     SFBRGRP_USER,
                     SFBRGRP_ACTIVITY_DATE)
    SELECT '144420',
           SG.sgbstdn_pidm,
           'UGR1',
           USER,
           SYSDATE
      FROM SGBSTDN SG
     WHERE     SGBSTDN_TERM_CODE_EFF =
               (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                  FROM SGBSTDN
                 WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
           AND SGBSTDN_STST_CODE IN ('AS')
           AND SGBSTDN_DEGC_CODE_1 IN ('��', '�� �', '000000')
           AND SGBSTDN_STYP_CODE IN ('�', '�')
           AND SGBSTDN_LEVL_CODE = '��'
           AND EXISTS
                   (SELECT '1'
                      FROM spriden
                     WHERE     spriden_pidm = SG.sgbstdn_pidm
                           AND SUBSTR (spriden_id, 1, 3) <= '441')
           AND NOT EXISTS
                   (SELECT '1'
                      FROM SFBRGRP
                     WHERE SFBRGRP_PIDM = SG.sgbstdn_pidm
                     and SFBRGRP_TERM_CODE='144420'
                     );

                           --------
                            --UGR2

INSERT INTO SFBRGRP (SFBRGRP_TERM_CODE,
                     SFBRGRP_PIDM,
                     SFBRGRP_RGRP_CODE,
                     SFBRGRP_USER,
                     SFBRGRP_ACTIVITY_DATE)
    SELECT '144420',
           SG.sgbstdn_pidm,
           'UGR2',
           USER,
           SYSDATE
      FROM SGBSTDN SG
     WHERE     SGBSTDN_TERM_CODE_EFF =
               (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                  FROM SGBSTDN
                 WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
           AND SGBSTDN_STST_CODE IN ('AS')
           AND SGBSTDN_DEGC_CODE_1 IN ('��', '�� �', '000000')
           AND SGBSTDN_STYP_CODE IN ('�', '�')
           AND SGBSTDN_LEVL_CODE = '��'
           AND EXISTS
                   (SELECT '1'
                      FROM spriden
                     WHERE     spriden_pidm = SG.sgbstdn_pidm
                           AND SUBSTR (spriden_id, 1, 3) in( '442','443'))
           AND NOT EXISTS
                   (SELECT '1'
                      FROM SFBRGRP
                     WHERE SFBRGRP_PIDM = SG.sgbstdn_pidm
                     and SFBRGRP_TERM_CODE='144420'
                     );

                                                       --UGR3

INSERT INTO SFBRGRP (SFBRGRP_TERM_CODE,
                     SFBRGRP_PIDM,
                     SFBRGRP_RGRP_CODE,
                     SFBRGRP_USER,
                     SFBRGRP_ACTIVITY_DATE)
    SELECT '144420',
           SG.sgbstdn_pidm,
           'UGR3',
           USER,
           SYSDATE
      FROM SGBSTDN SG
     WHERE     SGBSTDN_TERM_CODE_EFF =
               (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                  FROM SGBSTDN
                 WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
           AND SGBSTDN_STST_CODE IN ('AS')
           AND SGBSTDN_DEGC_CODE_1 IN ('��', '�� �', '000000')
           AND SGBSTDN_STYP_CODE IN ('�', '�')
           AND SGBSTDN_LEVL_CODE = '��'
           AND EXISTS
                   (SELECT '1'
                      FROM spriden
                     WHERE     spriden_pidm = SG.sgbstdn_pidm
                           AND SUBSTR (spriden_id, 1, 3) = '444')
           AND NOT EXISTS
                   (SELECT '1'
                      FROM SFBRGRP
                     WHERE SFBRGRP_PIDM = SG.sgbstdn_pidm
                     and SFBRGRP_TERM_CODE='144420'
                       
                     );
                     
                     INSERT INTO SFBRGRP (SFBRGRP_TERM_CODE,
                     SFBRGRP_PIDM,
                     SFBRGRP_RGRP_CODE,
                     SFBRGRP_USER,
                     SFBRGRP_ACTIVITY_DATE)
    SELECT '144420',
           SG.sgbstdn_pidm,
           'UGR3',
           USER,
           SYSDATE
      FROM SGBSTDN SG
     WHERE     SGBSTDN_TERM_CODE_EFF =
               (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                  FROM SGBSTDN
                 WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
           AND SGBSTDN_STST_CODE IN ('AS')
           AND SGBSTDN_DEGC_CODE_1 IN ('��', '�� �', '000000')
           AND SGBSTDN_STYP_CODE IN ('�', '�')
           AND SGBSTDN_LEVL_CODE = '��'
           AND EXISTS
                   (SELECT '1'
                      FROM spriden
                     WHERE     spriden_pidm = SG.sgbstdn_pidm
                           AND SUBSTR (spriden_id, 1, 3) = '444')
           AND NOT EXISTS
                   (SELECT '1'
                      FROM SFBRGRP
                     WHERE SFBRGRP_PIDM = SG.sgbstdn_pidm
                     and SFBRGRP_TERM_CODE='144420'
                       
                     );

DELETE FROM sprhold
      WHERE     EXISTS
                    (SELECT '1'
                       FROM SFBRGRP
                      WHERE SFBRGRP_PIDM = SPRHOLD_PIDM
                      and SFBRGRP_TERM_CODE='144420'
                      )
            AND SPRHOLD_HLDD_CODE = 'RH';

             --������ �������

INSERT INTO SFBRGRP (SFBRGRP_TERM_CODE,
                     SFBRGRP_PIDM,
                     SFBRGRP_RGRP_CODE,
                     SFBRGRP_USER,
                     SFBRGRP_ACTIVITY_DATE)
    SELECT '144420',
           SG.sgbstdn_pidm,
           'UGR3',
           USER,
           SYSDATE
      FROM SGBSTDN SG
     WHERE     SGBSTDN_TERM_CODE_EFF =
               (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                  FROM SGBSTDN
                 WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
           AND SGBSTDN_STST_CODE IN ('AS')
           AND SGBSTDN_DEGC_CODE_1 IN ('��', '�� �', '000000')
           AND SGBSTDN_STYP_CODE IN ('�', '�')
           AND SGBSTDN_LEVL_CODE = '��'
           AND EXISTS
                   (SELECT '1'
                      FROM spriden
                     WHERE     spriden_pidm = SG.sgbstdn_pidm
                           AND SUBSTR (spriden_id, 1, 3) = '444')
           AND NOT EXISTS
                   (SELECT '1'
                      FROM sfrstcr
                     WHERE     sfrstcr_term_code = '144420'
                           AND sfrstcr_pidm = SG.sgbstdn_pidm)
           AND NOT EXISTS
                   (SELECT '1'
                      FROM SFBRGRP
                     WHERE SFBRGRP_PIDM = SG.sgbstdn_pidm);



                           -----------������� ��������


INSERT INTO SFBRGRP (SFBRGRP_TERM_CODE,
                     SFBRGRP_PIDM,
                     SFBRGRP_RGRP_CODE,
                     SFBRGRP_USER,
                     SFBRGRP_ACTIVITY_DATE)
    SELECT '144420',
           SG.sgbstdn_pidm,
           F_GET_STD_ID (SG.sgbstdn_pidm),
           'UGI1',
           USER,
           SYSDATE
      FROM SGBSTDN SG
     WHERE     SGBSTDN_TERM_CODE_EFF =
               (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                  FROM SGBSTDN
                 WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
           AND SGBSTDN_STST_CODE IN ('AS')
           AND SGBSTDN_DEGC_CODE_1 IN ('��', '�� �', '000000')
           AND SGBSTDN_STYP_CODE IN ('�')
           AND SGBSTDN_LEVL_CODE = '��'
           AND NOT EXISTS
                   (SELECT '1'
                      FROM SFBRGRP
                     WHERE SFBRGRP_PIDM = SG.sgbstdn_pidm)
           AND EXISTS
                   (SELECT '1'
                      FROM BNK_STUDENTS_REG_BALANCE
                     WHERE     STUDENT_PIDM = SG.sgbstdn_pidm
                           AND OPENING_BALANCE < 24000
                           AND EXECLUDE_FLAGE = 'N');



                   --- ������� ��� ���
 
INSERT INTO SFBRGRP (SFBRGRP_TERM_CODE,
                     SFBRGRP_PIDM,
                     SFBRGRP_RGRP_CODE,
                     SFBRGRP_USER,
                     SFBRGRP_ACTIVITY_DATE)
    SELECT '144420',
           SG.sgbstdn_pidm,
           'DPM1',
           USER,
           SYSDATE
      FROM SGBSTDN SG
     WHERE     SGBSTDN_TERM_CODE_EFF =
               (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                  FROM SGBSTDN
                 WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
           AND SGBSTDN_STST_CODE IN ('AS')
           AND SGBSTDN_DEGC_CODE_1 IN ('��')
           -- AND SGBSTDN_STYP_CODE IN ('�')
           AND SGBSTDN_LEVL_CODE = '��'
           --**********NOT-----
           AND NOT EXISTS
                   (SELECT '1'
                      FROM spriden
                     WHERE     spriden_pidm = SG.sgbstdn_pidm
                           AND SUBSTR (spriden_id, 1, 3) = '444')
           AND NOT EXISTS
                   (SELECT '1'
                      FROM SFBRGRP
                     WHERE SFBRGRP_PIDM = SG.sgbstdn_pidm
                      and SFBRGRP_TERM_CODE='144420');

                  --- MASTER  

INSERT INTO SFBRGRP (SFBRGRP_TERM_CODE,
                     SFBRGRP_PIDM,
                     SFBRGRP_RGRP_CODE,
                     SFBRGRP_USER,
                     SFBRGRP_ACTIVITY_DATE)
    SELECT '144420',
           SG.sgbstdn_pidm,
           'MA',
           USER,
           SYSDATE
      FROM SGBSTDN SG
     WHERE     SGBSTDN_TERM_CODE_EFF =
               (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                  FROM SGBSTDN
                 WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
           AND SGBSTDN_STST_CODE IN ('AS')
           AND SGBSTDN_LEVL_CODE = 'MA'
           AND NOT EXISTS
                   (SELECT '1'
                      FROM SFBRGRP
                     WHERE     SFBRGRP_PIDM = SG.sgbstdn_pidm
                           AND SFBRGRP_RGRP_CODE = 'MA'
                           and SFBRGRP_TERM_CODE='144420'
                           );
                           
                           
                        update   SFRRGFE set SFRRGFE_COPY_IND = 'Y' ;