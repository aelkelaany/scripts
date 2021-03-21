/* Formatted on 4/18/2019 1:31:08 PM (QP5 v5.227.12220.39754) */
SELECT 'intake 35',(SELECT SUM (SHRTGPA_HOURS_EARNED)
          FROM shrtgpa, sgbstdn
         WHERE     SGBSTDN_STST_CODE = 'AS'
               AND sgbstdn_term_code_eff =
                      (SELECT MAX (a.sgbstdn_term_code_eff)
                         FROM sgbstdn a
                        WHERE     a.sgbstdn_pidm = shrtgpa_pidm
                              AND a.sgbstdn_term_code_eff <= '143610')
               AND sgbstdn_pidm = shrtgpa_pidm
               AND f_get_std_id (shrtgpa_pidm) LIKE '435%'
               AND shrtgpa_term_code < '143610')
          "year35", (SELECT SUM (SHRTGPA_HOURS_EARNED)
          FROM shrtgpa, sgbstdn
         WHERE     SGBSTDN_STST_CODE = 'AS'
               AND sgbstdn_term_code_eff =
                      (SELECT MAX (a.sgbstdn_term_code_eff)
                         FROM sgbstdn a
                        WHERE     a.sgbstdn_pidm = shrtgpa_pidm
                              AND a.sgbstdn_term_code_eff <= '143710')
               AND sgbstdn_pidm = shrtgpa_pidm
               AND f_get_std_id (shrtgpa_pidm) LIKE '435%'
               AND shrtgpa_term_code < '143710')
          "year36",
       (SELECT SUM (SHRTGPA_HOURS_EARNED)
          FROM shrtgpa, sgbstdn
         WHERE     SGBSTDN_STST_CODE = 'AS'
               AND sgbstdn_term_code_eff =
                      (SELECT MAX (a.sgbstdn_term_code_eff)
                         FROM sgbstdn a
                        WHERE     a.sgbstdn_pidm = shrtgpa_pidm
                              AND a.sgbstdn_term_code_eff <= '143810')
               AND sgbstdn_pidm = shrtgpa_pidm
               AND f_get_std_id (shrtgpa_pidm) LIKE '435%'
               AND shrtgpa_term_code < '143810')
          "year37",
       (SELECT SUM (SHRTGPA_HOURS_EARNED)
          FROM shrtgpa, sgbstdn
         WHERE     SGBSTDN_STST_CODE = 'AS'
               AND sgbstdn_term_code_eff =
                      (SELECT MAX (a.sgbstdn_term_code_eff)
                         FROM sgbstdn a
                        WHERE     a.sgbstdn_pidm = shrtgpa_pidm
                              AND a.sgbstdn_term_code_eff <= '143910')
               AND sgbstdn_pidm = shrtgpa_pidm
               AND f_get_std_id (shrtgpa_pidm) LIKE '435%'
               AND shrtgpa_term_code < '143910')
          "year38",
       (SELECT SUM (SHRTGPA_HOURS_EARNED)
          FROM shrtgpa, sgbstdn
         WHERE     SGBSTDN_STST_CODE = 'AS'
               AND sgbstdn_term_code_eff =
                      (SELECT MAX (a.sgbstdn_term_code_eff)
                         FROM sgbstdn a
                        WHERE     a.sgbstdn_pidm = shrtgpa_pidm
                              AND a.sgbstdn_term_code_eff <= '144010')
               AND sgbstdn_pidm = shrtgpa_pidm
               AND f_get_std_id (shrtgpa_pidm) LIKE '435%'
               AND shrtgpa_term_code < '144010')
          "year39" 
       
  FROM DUAL
  union 
SELECT 'intake 36',0, (SELECT SUM (SHRTGPA_HOURS_EARNED)
          FROM shrtgpa, sgbstdn
         WHERE     SGBSTDN_STST_CODE = 'AS'
               AND sgbstdn_term_code_eff =
                      (SELECT MAX (a.sgbstdn_term_code_eff)
                         FROM sgbstdn a
                        WHERE     a.sgbstdn_pidm = shrtgpa_pidm
                              AND a.sgbstdn_term_code_eff <= '143710')
               AND sgbstdn_pidm = shrtgpa_pidm
               AND f_get_std_id (shrtgpa_pidm) LIKE '436%'
               AND shrtgpa_term_code < '143710')
          "year36",
       (SELECT SUM (SHRTGPA_HOURS_EARNED)
          FROM shrtgpa, sgbstdn
         WHERE     SGBSTDN_STST_CODE = 'AS'
               AND sgbstdn_term_code_eff =
                      (SELECT MAX (a.sgbstdn_term_code_eff)
                         FROM sgbstdn a
                        WHERE     a.sgbstdn_pidm = shrtgpa_pidm
                              AND a.sgbstdn_term_code_eff <= '143810')
               AND sgbstdn_pidm = shrtgpa_pidm
               AND f_get_std_id (shrtgpa_pidm) LIKE '436%'
               AND shrtgpa_term_code < '143810')
          "year37",
       (SELECT SUM (SHRTGPA_HOURS_EARNED)
          FROM shrtgpa, sgbstdn
         WHERE     SGBSTDN_STST_CODE = 'AS'
               AND sgbstdn_term_code_eff =
                      (SELECT MAX (a.sgbstdn_term_code_eff)
                         FROM sgbstdn a
                        WHERE     a.sgbstdn_pidm = shrtgpa_pidm
                              AND a.sgbstdn_term_code_eff <= '143910')
               AND sgbstdn_pidm = shrtgpa_pidm
               AND f_get_std_id (shrtgpa_pidm) LIKE '436%'
               AND shrtgpa_term_code < '143910')
          "year38",
       (SELECT SUM (SHRTGPA_HOURS_EARNED)
          FROM shrtgpa, sgbstdn
         WHERE     SGBSTDN_STST_CODE = 'AS'
               AND sgbstdn_term_code_eff =
                      (SELECT MAX (a.sgbstdn_term_code_eff)
                         FROM sgbstdn a
                        WHERE     a.sgbstdn_pidm = shrtgpa_pidm
                              AND a.sgbstdn_term_code_eff <= '144010')
               AND sgbstdn_pidm = shrtgpa_pidm
               AND f_get_std_id (shrtgpa_pidm) LIKE '436%'
               AND shrtgpa_term_code < '144010')
          "year39" 
       
  FROM DUAL
  union 
  SELECT 'intake 37', 0,0
          "year36",
       (SELECT SUM (SHRTGPA_HOURS_EARNED)
          FROM shrtgpa, sgbstdn
         WHERE     SGBSTDN_STST_CODE = 'AS'
               AND sgbstdn_term_code_eff =
                      (SELECT MAX (a.sgbstdn_term_code_eff)
                         FROM sgbstdn a
                        WHERE     a.sgbstdn_pidm = shrtgpa_pidm
                              AND a.sgbstdn_term_code_eff <= '143810')
               AND sgbstdn_pidm = shrtgpa_pidm
               AND f_get_std_id (shrtgpa_pidm) LIKE '437%'
               AND shrtgpa_term_code < '143810')
          "year37",
       (SELECT SUM (SHRTGPA_HOURS_EARNED)
          FROM shrtgpa, sgbstdn
         WHERE     SGBSTDN_STST_CODE = 'AS'
               AND sgbstdn_term_code_eff =
                      (SELECT MAX (a.sgbstdn_term_code_eff)
                         FROM sgbstdn a
                        WHERE     a.sgbstdn_pidm = shrtgpa_pidm
                              AND a.sgbstdn_term_code_eff <= '143910')
               AND sgbstdn_pidm = shrtgpa_pidm
               AND f_get_std_id (shrtgpa_pidm) LIKE '437%'
               AND shrtgpa_term_code < '143910')
          "year38",
       (SELECT SUM (SHRTGPA_HOURS_EARNED)
          FROM shrtgpa, sgbstdn
         WHERE     SGBSTDN_STST_CODE = 'AS'
               AND sgbstdn_term_code_eff =
                      (SELECT MAX (a.sgbstdn_term_code_eff)
                         FROM sgbstdn a
                        WHERE     a.sgbstdn_pidm = shrtgpa_pidm
                              AND a.sgbstdn_term_code_eff <= '144010')
               AND sgbstdn_pidm = shrtgpa_pidm
               AND f_get_std_id (shrtgpa_pidm) LIKE '437%'
               AND shrtgpa_term_code < '144010')
          "year39" from dual 
            union 
  SELECT 'intake 39', 0,0
          "year36",
       0
          "year37",
       0
          "year38",
       (SELECT SUM (SHRTGPA_HOURS_EARNED)
          FROM shrtgpa, sgbstdn
         WHERE     SGBSTDN_STST_CODE = 'AS'
               AND sgbstdn_term_code_eff =
                      (SELECT MAX (a.sgbstdn_term_code_eff)
                         FROM sgbstdn a
                        WHERE     a.sgbstdn_pidm = shrtgpa_pidm
                              AND a.sgbstdn_term_code_eff <= '144010')
               AND sgbstdn_pidm = shrtgpa_pidm
               AND f_get_std_id (shrtgpa_pidm) LIKE '439%'
               AND shrtgpa_term_code < '144010')
          "year39" 
       
  FROM DUAL
   union 
  SELECT 'intake 38', 0,0
          "year36",
       0
          "year37",
       (SELECT SUM (SHRTGPA_HOURS_EARNED)
          FROM shrtgpa, sgbstdn
         WHERE     SGBSTDN_STST_CODE = 'AS'
               AND sgbstdn_term_code_eff =
                      (SELECT MAX (a.sgbstdn_term_code_eff)
                         FROM sgbstdn a
                        WHERE     a.sgbstdn_pidm = shrtgpa_pidm
                              AND a.sgbstdn_term_code_eff <= '143910')
               AND sgbstdn_pidm = shrtgpa_pidm
               AND f_get_std_id (shrtgpa_pidm) LIKE '438%'
               AND shrtgpa_term_code < '143910')
          "year38",
       (SELECT SUM (SHRTGPA_HOURS_EARNED)
          FROM shrtgpa, sgbstdn
         WHERE     SGBSTDN_STST_CODE = 'AS'
               AND sgbstdn_term_code_eff =
                      (SELECT MAX (a.sgbstdn_term_code_eff)
                         FROM sgbstdn a
                        WHERE     a.sgbstdn_pidm = shrtgpa_pidm
                              AND a.sgbstdn_term_code_eff <= '144010')
               AND sgbstdn_pidm = shrtgpa_pidm
               AND f_get_std_id (shrtgpa_pidm) LIKE '438%'
               AND shrtgpa_term_code < '144010')
          "year39" 
       
  FROM DUAL