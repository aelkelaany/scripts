 
  SELECT f_get_std_id (B.SGBSTDN_PIDM),
         f_get_std_name (B.SGBSTDN_PIDM),
         f_get_desc_fnc ('STVCOLL', b.SGBSTDN_COLL_CODE_1, 30),
         SMRPRLE_PROGRAM_DESC,
         GET_EARNED_HRS (B.SGBSTDN_PIDM, '143510'),
         GET_EARNED_HRS (B.SGBSTDN_PIDM, '143610'),
         GET_EARNED_HRS (B.SGBSTDN_PIDM, '143710'),
         GET_EARNED_HRS (B.SGBSTDN_PIDM, '143810'),
         GET_EARNED_HRS (B.SGBSTDN_PIDM, '143910'),
         GET_EARNED_HRS (B.SGBSTDN_PIDM, '144010')
    FROM sgbstdn b, spriden s, smrprle
   WHERE     SGBSTDN_STST_CODE = 'AS'
         AND sgbstdn_term_code_eff =
                (SELECT MAX (a.sgbstdn_term_code_eff)
                   FROM sgbstdn a
                  WHERE     a.sgbstdn_pidm = b.sgbstdn_pidm
                        AND a.sgbstdn_term_code_eff <= '143920')
         AND S.SPRIDEN_PIDM = b.sgbstdn_pidm
         AND S.SPRIDEN_CHANGE_IND IS NULL
         AND S.SPRIDEN_ID LIKE '438%'
         AND SMRPRLE_PROGRAM = b.SGBSTDN_PROGRAM_1
GROUP BY b.SGBSTDN_COLL_CODE_1, SMRPRLE_PROGRAM_DESC, B.SGBSTDN_PIDM
ORDER BY 3, 4
--DROP FUNCTION GET_EARNED_HRS
 CREATE OR REPLACE FUNCTION GET_EARNED_HRS ( P_PIDM NUMBER , P_TERM_CODE VARCHAR2 ) RETURN NUMBER 
 IS
 R_VALUE   NUMBER ;
 BEGIN
 SELECT SUM (SHRTGPA_HOURS_EARNED)     INTO R_VALUE FROM shrtgpa
 WHERE shrtgpa_PIDM=P_PIDM
 AND   shrtgpa_term_code < P_TERM_CODE ;
 RETURN  R_VALUE ;
 END;