/*› Õ ·œ›⁄ «ﬁ· „‰ 40 */
--«·Œ„Ì”
delete   FROM sprhold
      WHERE     EXISTS
                   (SELECT '1'
                      FROM spriden
                     WHERE      
                            spriden_pidm= sprhold_pidm
                            and substr(spriden_id,1,3)<='437')
                            and  EXISTS
                   (SELECT '2'
                      FROM SGBSTDN SG
                     WHERE     SGBSTDN_TERM_CODE_EFF =
                                  (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                     FROM SGBSTDN
                                    WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                           AND SGBSTDN_STST_CODE IN ('AS')
                           AND SGBSTDN_DEGC_CODE_1 IN
                                  ('»ﬂ', '»ﬂ  ', '000000')
                           AND SGBSTDN_STYP_CODE IN ('„',' ')
                           and SGBSTDN_LEVL_CODE='Ã„'
                           AND sprhold_pidm = SG.sgbstdn_pidm)
            AND SPRHOLD_HLDD_CODE = 'RH' ;
            delete   FROM sprhold
      WHERE     EXISTS
                   (SELECT '1'
                      FROM spriden
                     WHERE      
                            spriden_pidm= sprhold_pidm
                            and substr(spriden_id,1,3)<='439')
                            and  EXISTS
                   (SELECT '2'
                      FROM SGBSTDN SG
                     WHERE     SGBSTDN_TERM_CODE_EFF =
                                  (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                     FROM SGBSTDN
                                    WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                           AND SGBSTDN_STST_CODE IN ('AS')
                           AND SGBSTDN_DEGC_CODE_1 IN
                                  ('»ﬂ', '»ﬂ  ', '000000')
                           AND SGBSTDN_STYP_CODE IN ('„',' ')
                           and SGBSTDN_LEVL_CODE='Ã„'
                            and sgbstdn_coll_code_1<>'55'
                           AND sprhold_pidm = SG.sgbstdn_pidm)
            AND SPRHOLD_HLDD_CODE = 'RH' ;
            --«·Ã„⁄…
            delete   FROM sprhold
      WHERE     EXISTS
                   (SELECT '1'
                      FROM spriden
                     WHERE      
                            spriden_pidm= sprhold_pidm
                            and substr(spriden_id,1,3)>'439')
                            and  EXISTS
                   (SELECT '2'
                      FROM SGBSTDN SG
                     WHERE     SGBSTDN_TERM_CODE_EFF =
                                  (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                     FROM SGBSTDN
                                    WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
                           AND SGBSTDN_STST_CODE IN ('AS')
                           AND SGBSTDN_DEGC_CODE_1 IN
                                  ('»ﬂ', '»ﬂ  ', '000000')
                           AND SGBSTDN_STYP_CODE IN ('„',' ')
                           and sgbstdn_coll_code_1<>'55'
                           and SGBSTDN_LEVL_CODE='Ã„'
                           AND sprhold_pidm = SG.sgbstdn_pidm)
            AND SPRHOLD_HLDD_CODE = 'RH' ;