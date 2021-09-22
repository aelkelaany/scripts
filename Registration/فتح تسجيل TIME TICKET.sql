/* Formatted on 13/09/2021 11:33:45 (QP5 v5.227.12220.39754) */
 --UGR1

INSERT INTO SFBRGRP (SFBRGRP_TERM_CODE,
                     SFBRGRP_PIDM,
                     SFBRGRP_RGRP_CODE,
                     SFBRGRP_USER,
                     SFBRGRP_ACTIVITY_DATE)
   SELECT '144310',
          SG.sgbstdn_pidm,
          'UGR1',
          USER,
          SYSDATE
     FROM SGBSTDN SG
    WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                         FROM SGBSTDN
                                        WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
          AND SGBSTDN_STST_CODE IN ('AS')
          AND SGBSTDN_DEGC_CODE_1 IN ('»ﬂ', '»ﬂ  ', '000000')
          AND SGBSTDN_STYP_CODE IN ('„', ' ')
          AND SGBSTDN_LEVL_CODE = 'Ã„'
          AND EXISTS
                 (SELECT '1'
                    FROM spriden
                   WHERE     spriden_pidm = SG.sgbstdn_pidm
                         AND SUBSTR (spriden_id, 1, 3) <= '439')
          AND NOT EXISTS
                 (SELECT '1'
                    FROM SFBRGRP
                   WHERE SFBRGRP_PIDM = SG.sgbstdn_pidm);

                           --------
                            --UGR2

INSERT INTO SFBRGRP (SFBRGRP_TERM_CODE,
                     SFBRGRP_PIDM,
                     SFBRGRP_RGRP_CODE,
                     SFBRGRP_USER,
                     SFBRGRP_ACTIVITY_DATE)
   SELECT '144310',
          SG.sgbstdn_pidm,
          'UGR2',
          USER,
          SYSDATE
     FROM SGBSTDN SG
    WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                         FROM SGBSTDN
                                        WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
          AND SGBSTDN_STST_CODE IN ('AS')
          AND SGBSTDN_DEGC_CODE_1 IN ('»ﬂ', '»ﬂ  ', '000000')
          AND SGBSTDN_STYP_CODE IN ('„', ' ')
          AND SGBSTDN_LEVL_CODE = 'Ã„'
          AND EXISTS
                 (SELECT '1'
                    FROM spriden
                   WHERE     spriden_pidm = SG.sgbstdn_pidm
                         AND SUBSTR (spriden_id, 1, 3) = '441')
          AND NOT EXISTS
                 (SELECT '1'
                    FROM SFBRGRP
                   WHERE SFBRGRP_PIDM = SG.sgbstdn_pidm);

                                                       --UGR2

INSERT INTO SFBRGRP (SFBRGRP_TERM_CODE,
                     SFBRGRP_PIDM,
                     SFBRGRP_RGRP_CODE,
                     SFBRGRP_USER,
                     SFBRGRP_ACTIVITY_DATE)
   SELECT '144310',
          SG.sgbstdn_pidm,
          'UGR3',
          USER,
          SYSDATE
     FROM SGBSTDN SG
    WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                         FROM SGBSTDN
                                        WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
          AND SGBSTDN_STST_CODE IN ('AS')
          AND SGBSTDN_DEGC_CODE_1 IN ('»ﬂ', '»ﬂ  ', '000000')
          AND SGBSTDN_STYP_CODE IN ('„', ' ')
          AND SGBSTDN_LEVL_CODE = 'Ã„'
          AND EXISTS
                 (SELECT '1'
                    FROM spriden
                   WHERE     spriden_pidm = SG.sgbstdn_pidm
                         AND SUBSTR (spriden_id, 1, 3) = '442')
          AND NOT EXISTS
                 (SELECT '1'
                    FROM SFBRGRP
                   WHERE SFBRGRP_PIDM = SG.sgbstdn_pidm);

DELETE FROM sprhold
      WHERE     EXISTS
                   (SELECT '1'
                      FROM SFBRGRP
                     WHERE SFBRGRP_PIDM = SPRHOLD_PIDM)
            AND SPRHOLD_HLDD_CODE = 'RH';

             --„ÕÊ·Ì‰ Œ«—ÃÌÌ‰

INSERT INTO SFBRGRP (SFBRGRP_TERM_CODE,
                     SFBRGRP_PIDM,
                     SFBRGRP_RGRP_CODE,
                     SFBRGRP_USER,
                     SFBRGRP_ACTIVITY_DATE)
   SELECT '144310',
          SG.sgbstdn_pidm,
          'UGR3',
          USER,
          SYSDATE
     FROM SGBSTDN SG
    WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                         FROM SGBSTDN
                                        WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
          AND SGBSTDN_STST_CODE IN ('AS')
          AND SGBSTDN_DEGC_CODE_1 IN ('»ﬂ', '»ﬂ  ', '000000')
          AND SGBSTDN_STYP_CODE IN ('„', ' ')
          AND SGBSTDN_LEVL_CODE = 'Ã„'
          AND EXISTS
                 (SELECT '1'
                    FROM spriden
                   WHERE     spriden_pidm = SG.sgbstdn_pidm
                         AND SUBSTR (spriden_id, 1, 3) = '443')
          AND NOT EXISTS
                     (SELECT '1'
                        FROM sfrstcr
                       WHERE     sfrstcr_term_code = '144310'
                             AND sfrstcr_pidm = SG.sgbstdn_pidm)
          AND NOT EXISTS
                 (SELECT '1'
                    FROM SFBRGRP
                   WHERE SFBRGRP_PIDM = SG.sgbstdn_pidm);



                           -----------«‰  ”«» »ﬂ«·—ÌÊ”


INSERT INTO SFBRGRP (SFBRGRP_TERM_CODE,
                     SFBRGRP_PIDM,
                     SFBRGRP_RGRP_CODE,
                     SFBRGRP_USER,
                     SFBRGRP_ACTIVITY_DATE)
   SELECT '144310',
          SG.sgbstdn_pidm,
         F_GET_STD_ID(SG.sgbstdn_pidm),
          'UGI1',
          USER,
          SYSDATE
     FROM SGBSTDN SG
    WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                         FROM SGBSTDN
                                        WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
          AND SGBSTDN_STST_CODE IN ('AS')
          AND SGBSTDN_DEGC_CODE_1 IN ('»ﬂ', '»ﬂ  ', '000000')
          AND SGBSTDN_STYP_CODE IN ('‰')
          AND SGBSTDN_LEVL_CODE = 'Ã„'
          AND NOT EXISTS
                 (SELECT '1'
                    FROM SFBRGRP
                   WHERE SFBRGRP_PIDM = SG.sgbstdn_pidm)
                    AND EXISTS (SELECT '1' FROM BNK_STUDENTS_REG_BALANCE WHERE STUDENT_PIDM=SG.sgbstdn_pidm AND OPENING_BALANCE<24000
                   AND EXECLUDE_FLAGE='N') ;
                   
                   
                   
                   
                   --- œ»·Ê„«  €Ì— Ãœœ
                   
                   INSERT INTO SFBRGRP (SFBRGRP_TERM_CODE,
                     SFBRGRP_PIDM,
                     SFBRGRP_RGRP_CODE,
                     SFBRGRP_USER,
                     SFBRGRP_ACTIVITY_DATE)
   SELECT '144310',
          SG.sgbstdn_pidm,
          'DPM1',
          USER,
          SYSDATE
     FROM SGBSTDN SG
    WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                         FROM SGBSTDN
                                        WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
          AND SGBSTDN_STST_CODE IN ('AS')
          AND SGBSTDN_DEGC_CODE_1 IN ('œ»')
         -- AND SGBSTDN_STYP_CODE IN ('„')
          AND SGBSTDN_LEVL_CODE = 'œ»'
          AND NOT EXISTS
                 (SELECT '1'
                    FROM spriden
                   WHERE     spriden_pidm = SG.sgbstdn_pidm
                         AND SUBSTR (spriden_id, 1, 3) = '443')
          
          AND NOT EXISTS
                 (SELECT '1'
                    FROM SFBRGRP
                   WHERE SFBRGRP_PIDM = SG.sgbstdn_pidm);