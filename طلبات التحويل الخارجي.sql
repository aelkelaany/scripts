/* Formatted on 7/18/2023 9:45:22 AM (QP5 v5.371) */
  SELECT COLL_CODE,
         F_GET_DESC_FNC ('STVCOLL', COLL_CODE, 30),
         MAJR_CODE,
         F_GET_DESC_FNC ('STVMAJR', MAJR_CODE, 30),
         SSNID,
         STUDENT_NAME,
         MOBILE1,
         MOBILE2,
         SEX,
         BDATE,
         EMAIL,
         MYUNI,
         MYCOLL,
         MYPROG,
         CGPA,
         EARNED_HRS,
         DECODE (REQUEST_STATUS,
                 'A', '„Ê«›ﬁ…',
                 'P', '„⁄·ﬁ',
                 '„—›Ê÷')                                status,
         (SELECT f_get_desc_fnc ('stvstst', sg.sgbstdn_stst_code, 30)
            FROM sgbstdn sg, spbpers
           WHERE     sgbstdn_pidm = spbpers_pidm
                 AND spbpers_ssn = ssnid
                 AND SGBSTDN_TERM_CODE_EFF =
                     (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                        FROM SGBSTDN
                       WHERE sgbstdn_pidm = spbpers_pidm))    AS "Ã «·»«Õ…"
    FROM BU_APPS.XTRNL_TRANSFER_DETAILS
   WHERE TERM_CODE = '144440'
ORDER BY 1, 3