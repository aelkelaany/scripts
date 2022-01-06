SELECT COUNT (*) OVER (PARTITION BY day) AS day_cnt,
       SUBSTR (day, 1, 1) day_no,
       DECODE (SUBSTR (day1, 1, 1),
               '1', '«·”» ',
               '2', '«·√Õœ',
               '3', '«·≈À‰Ì‰',
               '4', '«·À·«À«¡',
               '5', '«·√—»⁄«¡',
               '6', '«·Œ„Ì”',
               '7', '«·Ã„⁄…',
               '9', '€Ì— „Õœœ')
          day_name,
       scbcrse_title scbcrse_title,
       ssbsect_schd_code,
       stvschd_desc,
       ssbsect_crn,
       ssbsect_seq_numb,
       ssbsect_subj_code,
       ssbsect_crse_numb,
       sfrstcr_credit_hr,
       sfrstcr_term_code,
       course_no,
       ssrmeet_begin_time,
       ssrmeet_end_time,
       ssrmeet_bldg_code,
       ssrmeet_room_code
  FROM (  SELECT day,
                 sfrstcr_pidm,
                 stvschd_desc,
                 ssbsect_schd_code,
                 ssbsect_crn,
                 ssbsect_seq_numb,
                 ssbsect_subj_code,
                 ssbsect_crse_numb,
                 sfrstcr_credit_hr,
                 sfrstcr_term_code,
                 course_no,
                 scbcrse_title,
                 CASE
                    WHEN LAG (day) OVER (ORDER BY NULL) = day THEN NULL
                    ELSE day
                 END
                    day1,
                 ssrmeet_begin_time,
                 ssrmeet_end_time,
                 ssrmeet_bldg_code,
                 ssrmeet_room_code
            FROM (SELECT sfrstcr_pidm,
                         stvschd_desc,
                         ssbsect_schd_code,
                         ssbsect_crn,
                         ssbsect_seq_numb,
                         ssbsect_subj_code,
                         ssbsect_crse_numb,
                         sfrstcr_credit_hr,
                         sfrstcr_term_code,
                         scbcrse_subj_code || '-' || scbcrse_crse_numb
                            course_no,
                         ' ' || NVL (ssbsect_crse_title, scbcrse_title)
                            scbcrse_title,
                         DECODE (ssrmeet.ssrmeet_sun_day, 'U', '2U')
                            ssrmeet_sun_day,
                         DECODE (ssrmeet.ssrmeet_mon_day, 'M', '3M')
                            ssrmeet_mon_day,
                         DECODE (ssrmeet.ssrmeet_tue_day, 'T', '4T')
                            ssrmeet_tue_day,
                         DECODE (ssrmeet.ssrmeet_wed_day, 'W', '5W')
                            ssrmeet_wed_day,
                         DECODE (ssrmeet.ssrmeet_thu_day, 'R', '6R')
                            ssrmeet_thu_day,
                         DECODE (ssrmeet.ssrmeet_fri_day, 'F', '7F')
                            ssrmeet_fri_day,
                         DECODE (ssrmeet.ssrmeet_sat_day, 'S', '1S')
                            ssrmeet_sat_day,
                         COALESCE (ssrmeet.ssrmeet_sun_day,
                                   ssrmeet.ssrmeet_mon_day,
                                   ssrmeet.ssrmeet_tue_day,
                                   ssrmeet.ssrmeet_wed_day,
                                   ssrmeet.ssrmeet_thu_day,
                                   ssrmeet.ssrmeet_fri_day,
                                   ssrmeet.ssrmeet_sat_day,
                                   '9U')
                            unknow_day,
                         ssrmeet.ssrmeet_begin_time,
                         ssrmeet.ssrmeet_end_time,
                         (SELECT stvbldg_desc
                            FROM stvbldg
                           WHERE stvbldg_code = ssrmeet_bldg_code)
                            ssrmeet_bldg_code,
                         ssrmeet_room_code,
                         slbrdef.slbrdef_desc
                    FROM sfrstcr,
                         scbcrse,
                         ssbsect,
                         ssrmeet,
                         stvschd,
                         slbrdef
                   WHERE     sfrstcr_pidm = f_get_pidm('441014218')
                         AND sfrstcr_term_code = '144310'
                         AND ssrmeet_term_code(+) = ssbsect_term_code
                         AND ssrmeet_crn(+) = ssbsect_crn
                         AND sfrstcr_term_code = ssbsect_term_code
                         AND sfrstcr_crn = ssbsect_crn
                         AND scbcrse_subj_code = ssbsect_subj_code
                         AND scbcrse_crse_numb = ssbsect_crse_numb
                         AND slbrdef_bldg_code(+) = ssrmeet_bldg_code
                         AND slbrdef.slbrdef_room_number(+) = ssrmeet_room_code
                         AND scbcrse_eff_term =
                                (SELECT MAX (scbcrse_eff_term)
                                   FROM scbcrse
                                  WHERE     scbcrse_subj_code =
                                               ssbsect_subj_code
                                        AND scbcrse_crse_numb =
                                               ssbsect_crse_numb)
                         AND ssbsect_schd_code = stvschd_code
                         --AND NVL (sfrstcr_error_flag, 'O') = 'O'
                         AND sfrstcr_rsts_code IN
                                (SELECT DISTINCT stvrsts_code
                                   FROM stvrsts
                                  WHERE     stvrsts_incl_sect_enrl = 'Y'
                                        AND stvrsts_gradable_ind = 'Y')) UNPIVOT (day
                                                                         FOR node
                                                                         IN  (ssrmeet_sun_day,
                                                                             ssrmeet_mon_day,
                                                                             ssrmeet_tue_day,
                                                                             ssrmeet_wed_day,
                                                                             ssrmeet_thu_day,
                                                                             ssrmeet_fri_day,
                                                                             ssrmeet_sat_day,
                                                                             unknow_day))
        ORDER BY day, ssrmeet_begin_time)
 WHERE SUBSTR (day, 1, 1) BETWEEN '1' AND '9';