 --UGR1
INSERT INTO SFBRGRP (SFBRGRP_TERM_CODE,
                     SFBRGRP_PIDM,
                     SFBRGRP_RGRP_CODE,
                     SFBRGRP_USER,
                     SFBRGRP_ACTIVITY_DATE)
    SELECT '144310' ,SG.sgbstdn_pidm,'UGR1',USER,SYSDATE
      FROM SGBSTDN SG
     WHERE     SGBSTDN_TERM_CODE_EFF =
               (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
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
                           and not exists (select '1' from SFBRGRP where SFBRGRP_PIDM=SG.sgbstdn_pidm );
                           
                           --------
                            --UGR2
INSERT INTO SFBRGRP (SFBRGRP_TERM_CODE,
                     SFBRGRP_PIDM,
                     SFBRGRP_RGRP_CODE,
                     SFBRGRP_USER,
                     SFBRGRP_ACTIVITY_DATE)
    SELECT '144310' ,SG.sgbstdn_pidm,'UGR2',USER,SYSDATE
      FROM SGBSTDN SG
     WHERE     SGBSTDN_TERM_CODE_EFF =
               (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
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
                           and not exists (select '1' from SFBRGRP where SFBRGRP_PIDM=SG.sgbstdn_pidm ); 
                           
                                                       --UGR2
INSERT INTO SFBRGRP (SFBRGRP_TERM_CODE,
                     SFBRGRP_PIDM,
                     SFBRGRP_RGRP_CODE,
                     SFBRGRP_USER,
                     SFBRGRP_ACTIVITY_DATE)
    SELECT '144310' ,SG.sgbstdn_pidm,'UGR3',USER,SYSDATE
      FROM SGBSTDN SG
     WHERE     SGBSTDN_TERM_CODE_EFF =
               (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
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
                           and not exists (select '1' from SFBRGRP where SFBRGRP_PIDM=SG.sgbstdn_pidm ); 
                           
                    DELETE   FROM sprhold
      WHERE     EXISTS
                   (SELECT '1' FROM  SFBRGRP WHERE SFBRGRP_PIDM=SPRHOLD_PIDM)
                    AND SPRHOLD_HLDD_CODE = 'RH'; 
                    
             --„ÕÊ·Ì‰ Œ«—ÃÌÌ‰       
                    
                    INSERT INTO SFBRGRP (SFBRGRP_TERM_CODE,
                     SFBRGRP_PIDM,
                     SFBRGRP_RGRP_CODE,
                     SFBRGRP_USER,
                     SFBRGRP_ACTIVITY_DATE)
    SELECT '144310' ,SG.sgbstdn_pidm,'UGR3',USER,SYSDATE
      FROM SGBSTDN SG
     WHERE     SGBSTDN_TERM_CODE_EFF =
               (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
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
                           and not exists (select '1' from sfrstcr where sfrstcr_term_code='144310' and sfrstcr_pidm=SG.sgbstdn_pidm)
                           and not exists (select '1' from SFBRGRP where SFBRGRP_PIDM=SG.sgbstdn_pidm ); 
                           
                           
                           
                            