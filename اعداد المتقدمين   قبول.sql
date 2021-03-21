SELECT DECODE (sybssnl_gender,
                       'M', '–ﬂ—',
                       'F', '√‰ÀÌ',
                       '€Ì— „Õœœ')
                  AS "Gender",
               DECODE (sarhead_appl_comp_ind,
                       'Y', '„ﬂ „·',
                       'N', '€Ì— „ﬂ „·',
                       '€Ì— „ﬂ „·')
                  AS "Application Status",
               COUNT (sybssnl_ssn) AS "Count"
          FROM sybssnl s, sarhead h
         WHERE     s.sybssnl_aidm = h.sarhead_aidm
               AND h.sarhead_appl_seqno = 1
               AND sybssnl_gender IS NOT NULL
               AND s.sybssnl_term_code = '144210'
               AND s.sybssnl_admission_type = 'UG'
      GROUP BY sybssnl_gender, sarhead_appl_comp_ind
      ORDER BY 1 ASC, 2 DESC