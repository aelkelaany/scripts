/* Formatted on 12/20/2022 12:52:51 PM (QP5 v5.371) */
  SELECT COUNT (pidm)                                  "«·⁄œœ",
         coll_code                                     "—„“ «·ﬂ·Ì…",
         f_get_desc_fnc ('stvcoll', coll_code, 30)     "«·ﬂ·Ì…"
    FROM (  SELECT sgbstdn_pidm                    pidm,
                   sgbstdn_coll_code_1             coll_code,
                   SUM (sfrstcr_credit_hr)         tot_reg,
                   SMBPOGN_ACT_CREDITS_OVERALL     tot_act,
                   SMBPOGN_REQ_CREDITS_OVERALL     tot_req
              FROM sgbstdn a, SFRSTCR, SMBPOGN
             WHERE     A.SGBSTDN_TERM_CODE_EFF =
                       (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                          FROM SGBSTDN
                         WHERE SGBSTDN_PIDM = A.SGBSTDN_PIDM)
                   AND SFRSTCR_PIDM = sgbstdn_PIDM
                   AND SFRSTCR_PIDM = SMBPOGN_PIDM
                   AND sfrstcr_term_code = '144420'
                   AND sfrstcr_rsts_code IN ('RE', 'RW')
                   AND sgbstdn_coll_code_1 NOT IN ('14',
                                                   '33',
                                                   '55',
                                                   '25')
                   AND SMBPOGN_REQUEST_NO =
                       (SELECT MAX (SMBPOGN_REQUEST_NO)
                          FROM SMBPOGN
                         WHERE SMBPOGN_PIDM = A.SGBSTDN_PIDM)
          GROUP BY sgbstdn_pidm,
                   sgbstdn_coll_code_1,
                   SMBPOGN_ACT_CREDITS_OVERALL,
                   SMBPOGN_REQ_CREDITS_OVERALL)
   WHERE                 -- tot_req - (tot_reg + tot_act) <= 0 -- current term
         tot_req - (tot_reg + tot_act) BETWEEN 1 AND 20           -- next term
GROUP BY coll_code;


  SELECT COUNT (pidm)                                      "«·⁄œœ",
         coll_code                                         "—„“ «·ﬂ·Ì…",
         f_get_desc_fnc ('stvcoll', coll_code, 30)         "«·ﬂ·Ì…",
         DECODE (sex, 'M', 'ÿ·«»', 'ÿ«·»« ')     "«·‰Ê⁄"
    FROM (  SELECT sgbstdn_pidm                    pidm,
                   sgbstdn_coll_code_1             coll_code,
                   SUM (sfrstcr_credit_hr)         tot_reg,
                   SMBPOGN_ACT_CREDITS_OVERALL     tot_act,
                   SMBPOGN_REQ_CREDITS_OVERALL     tot_req,
                   spbpers_sex                     sex
              FROM sgbstdn a,
                   SFRSTCR,
                   SMBPOGN,
                   spbpers
             WHERE     A.SGBSTDN_TERM_CODE_EFF =
                       (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                          FROM SGBSTDN
                         WHERE SGBSTDN_PIDM = A.SGBSTDN_PIDM)
                   AND SFRSTCR_PIDM = sgbstdn_PIDM
                   AND SFRSTCR_PIDM = SMBPOGN_PIDM 
                   AND SFRSTCR_PIDM = Spbpers_PIDM
                   AND sfrstcr_term_code = '144420'
                   AND sfrstcr_rsts_code IN ('RE', 'RW')
                   AND sgbstdn_coll_code_1 NOT IN ('14',
                                                   '33',
                                                   '55',
                                                   '25')
                                                  -- and sgbstdn_levl_code='Ã„'
                                                   and sgbstdn_levl_code='œ»'
                                                   
                   AND SMBPOGN_REQUEST_NO =
                       (SELECT MAX (SMBPOGN_REQUEST_NO)
                          FROM SMBPOGN
                         WHERE SMBPOGN_PIDM = A.SGBSTDN_PIDM)
          GROUP BY sgbstdn_pidm,
                   sgbstdn_coll_code_1,
                   SMBPOGN_ACT_CREDITS_OVERALL,
                   SMBPOGN_REQ_CREDITS_OVERALL,
                   spbpers_sex)
   WHERE              --    tot_req - (tot_reg + tot_act) <= 0 -- current term
         tot_req - (tot_reg + tot_act) BETWEEN 1 AND 20           -- next term
GROUP BY coll_code, sex
ORDER BY 2, 3;


---  Œ’’« 

  SELECT COUNT (pidm)                                      "«·⁄œœ",
         coll_code                                         "—„“ «·ﬂ·Ì…",
         f_get_desc_fnc ('stvcoll', coll_code, 30)         "«·ﬂ·Ì…",
         DECODE (sex, 'M', 'ÿ·«»', 'ÿ«·»« ')     "«·‰Ê⁄" ,major_desc "«· Œ’’"
    FROM (  SELECT sgbstdn_pidm                    pidm,
                   sgbstdn_coll_code_1             coll_code,
                   SUM (sfrstcr_credit_hr)         tot_reg,
                   SMBPOGN_ACT_CREDITS_OVERALL     tot_act,
                   SMBPOGN_REQ_CREDITS_OVERALL     tot_req,
                    f_get_desc_fnc ('stvmajr', a.SGBSTDN_MAJR_CODE_1, 30)
                     major_desc ,
                   spbpers_sex                     sex
              FROM sgbstdn a,
                   SFRSTCR,
                   SMBPOGN,
                   spbpers
             WHERE     A.SGBSTDN_TERM_CODE_EFF =
                       (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                          FROM SGBSTDN
                         WHERE SGBSTDN_PIDM = A.SGBSTDN_PIDM)
                   AND SFRSTCR_PIDM = sgbstdn_PIDM
                   AND SFRSTCR_PIDM = SMBPOGN_PIDM 
                   AND SFRSTCR_PIDM = Spbpers_PIDM
                   AND sfrstcr_term_code = '144420'
                   AND sfrstcr_rsts_code IN ('RE', 'RW')
                   AND sgbstdn_coll_code_1 NOT IN ('14',
                                                   '33',
                                                   '55',
                                                   '25')
                                                   and sgbstdn_levl_code='Ã„'
                                                  -- and sgbstdn_levl_code='œ»'
                                                   
                   AND SMBPOGN_REQUEST_NO =
                       (SELECT MAX (SMBPOGN_REQUEST_NO)
                          FROM SMBPOGN
                         WHERE SMBPOGN_PIDM = A.SGBSTDN_PIDM)
          GROUP BY sgbstdn_pidm,
                   sgbstdn_coll_code_1,
                   SMBPOGN_ACT_CREDITS_OVERALL,
                   SMBPOGN_REQ_CREDITS_OVERALL,
                   spbpers_sex ,a.SGBSTDN_MAJR_CODE_1)
   WHERE                  tot_req - (tot_reg + tot_act) <= 0 -- current term
        -- tot_req - (tot_reg + tot_act) BETWEEN 1 AND 20           -- next term
GROUP BY coll_code, major_desc ,sex  
ORDER BY 2, 3;