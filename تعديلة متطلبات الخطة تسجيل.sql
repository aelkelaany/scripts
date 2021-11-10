-- BANINST1.sfkpreq
-- Cursor that gets academic history.
-- ===============================================================
--   CURSOR history_c 

SELECT shrtckn_subj_code, shrtckn_crse_numb
  FROM shrtckl, shrtckg, shrtckn t
 WHERE     
 
   t.shrtckn_pidm = F_GET_PIDM ('441013208')
       AND t.shrtckn_term_code <= '144310'
       AND NVL (t.shrtckn_repeat_course_ind, 'I') = 'I'
       AND shrtckl_pidm = t.shrtckn_pidm
       AND shrtckl_term_code = t.shrtckn_term_code
       AND shrtckl_tckn_seq_no = t.shrtckn_seq_no
       AND shrtckg_pidm = t.shrtckn_pidm
       AND shrtckg_term_code = t.shrtckn_term_code
       AND shrtckg_tckn_seq_no = shrtckl_tckn_seq_no
       AND shrtckg_seq_no =
           (SELECT MAX (g.shrtckg_seq_no)
              FROM shrtckg g
             WHERE     g.shrtckg_pidm = t.shrtckn_pidm
                   AND g.shrtckg_term_code = t.shrtckn_term_code
                   AND g.shrtckg_tckn_seq_no = t.shrtckn_seq_no)
       AND (shrtckl_levl_code, shrtckg_grde_code_final) IN
               (SELECT a.shrgrde_levl_code, a.shrgrde_code
                  FROM shrgrde a
                 WHERE     a.shrgrde_term_code_effective =
                           (SELECT MAX (x.shrgrde_term_code_effective)
                              FROM shrgrde x
                             WHERE     x.shrgrde_levl_code =
                                       a.shrgrde_levl_code
                                   AND x.shrgrde_code = a.shrgrde_code
                                   AND x.shrgrde_term_code_effective <=
                                       '144310')
                       AND a.shrgrde_code = shrtckg_grde_code_final
                       AND a.shrgrde_levl_code = shrtckl_levl_code
                       AND NVL (a.shrgrde_numeric_value, 0) >=
                           (SELECT NVL (y.shrgrde_numeric_value, 0)
                              FROM shrgrde y
                             WHERE     y.shrgrde_levl_code = :rtst_levl
                                   AND y.shrgrde_code = :rtst_min_grde
                                   AND y.shrgrde_term_code_effective =
                                       (SELECT MAX (
                                                   z.shrgrde_term_code_effective)
                                          FROM shrgrde z
                                         WHERE     z.shrgrde_levl_code =
                                                   :rtst_levl
                                               AND z.shrgrde_code =
                                                   :rtst_min_grde
                                               AND z.shrgrde_term_code_effective <=
                                                   '144310')))
                                                   and 2 = 1
         
UNION all
SELECT SMRDOUS_SUBJ_CODE, SMRDOUS_CRSE_NUMB
  FROM SMRDOUS
 WHERE     SMRDOUS_pidm = F_GET_PIDM ('441013208')
       AND SMRDOUS_REQUEST_NO =
           (SELECT MAX (SMRDOUS_REQUEST_NO)
              FROM SMRDOUS
             WHERE SMRDOUS_pidm = F_GET_PIDM ('441013208'))
       AND SMRDOUS_TERM_CODE < '144310'
       AND 1 = 1;

                                                                   --    smrdous


shrlgpa