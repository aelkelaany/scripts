/* Formatted on 6/26/2019 2:48:39 PM (QP5 v5.227.12220.39754) */
--create table adm_qiyas_rqst_result ( ssnid varchar2(10) , result char ) ;

DECLARE
   CURSOR get_data
   IS
        SELECT sybssnl_ssn,
               sybssnl_aidm,
                  STUDENT_FIRST_NAME_AR
               || ' '
               || STUDENT_MI_NAME_AR
               || ' '
               || STUDENT_LAST_NAME_AR
                  "Student Name",
               OLD_QUDRAT_SCORE,
               OLD_TAHSELE_SCORE,
               NEW_QUDRAT_SCORE,
               NEW_TAHSELE_SCORE
          FROM ADM_CHANGE_TEST_SCORE_REQUESTS a, sybssnl, moe_cd
         WHERE     sybssnl_aidm = APPLICANT_AIDM
               AND student_ssn = sybssnl_ssn
               AND sybssnl_term_code = '144010'
               AND sybssnl_admission_type = 'U2'
               AND REQUEST_STATUS = 'P'
               AND sybssnl_ssn IN (SELECT SSNID
                                     FROM adm_qiyas_rqst_result
                                    WHERE RESULT = 'Y')
      ORDER BY 1;

   CURSOR get_moe (p_ssn VARCHAR2)
   IS
      SELECT *
        FROM moe_cd
       WHERE student_ssn = p_ssn;

   moe_rec   get_moe%ROWTYPE;
BEGIN
   FOR i IN get_data
   LOOP
      moe_rec := NULL;

      UPDATE moe_cd
         SET STUDENT_QUDORAT_SCORE =
                NVL (i.NEW_QUDRAT_SCORE, STUDENT_QUDORAT_SCORE),
             STUDENT_TAHSEELY_SCORE =
                NVL (i.NEW_TAHSELE_SCORE, STUDENT_TAHSEELY_SCORE)
       WHERE student_ssn = i.sybssnl_ssn;

      UPDATE moe_cd
         SET TEST_SCORE_2 =
                ROUND (
                     (STUDENT_GPA * 0.3)
                   + (STUDENT_QUDORAT_SCORE * 0.3)
                   + (STUDENT_TAHSEELY_SCORE * 0.4),
                   2),
             TEST_SCORE_3 =
                ROUND ( (STUDENT_GPA * 0.5) + (STUDENT_QUDORAT_SCORE * 0.5),
                       2)
       WHERE student_ssn = i.sybssnl_ssn;

      OPEN get_moe (i.sybssnl_ssn);

      FETCH get_moe INTO moe_rec;

      CLOSE get_moe;

      UPDATE sartest
         SET sartest_test_dte = '01/01/' || TO_CHAR (SYSDATE, 'YYYY'),
             sartest_dfmt_cde = 'MDC',
             sartest_test_score1 =
                DECODE (
                   moe_rec.student_qudorat_score,
                   100, '100.0',
                   TRIM (TO_CHAR (moe_rec.student_qudorat_score, '00.00'))),
             --TRIM (TO_CHAR (moe_rec.student_qudorat_score, '000.0')),
             sartest_test_desc =
                (SELECT stvtesc_desc
                   FROM stvtesc
                  WHERE stvtesc_code = moe_rec.qudrat_test_code),
             sartest_activity_date = SYSDATE
       WHERE     sartest_aidm = i.sybssnl_aidm
             AND sartest_appl_seqno = 1
             AND sartest_subt_cde = moe_rec.qudrat_test_code;

      UPDATE sartest
         SET sartest_test_dte = '01/01/' || TO_CHAR (SYSDATE, 'YYYY'),
             sartest_dfmt_cde = 'MDC',
             sartest_test_score1 =
                DECODE (
                   moe_rec.student_tahseely_score,
                   100, '100.0',
                   TRIM (TO_CHAR (moe_rec.student_tahseely_score, '00.00'))),
             --TRIM (TO_CHAR (moe_rec.student_tahseely_score, '000.0')),
             sartest_test_desc =
                (SELECT stvtesc_desc
                   FROM stvtesc
                  WHERE stvtesc_code = moe_rec.tahseely_test_code),
             sartest_activity_date = SYSDATE
       WHERE     sartest_aidm = i.sybssnl_aidm
             AND sartest_appl_seqno = 1
             AND sartest_subt_cde = moe_rec.tahseely_test_code;

      UPDATE sartest
         SET sartest_test_dte = '01/01/' || TO_CHAR (SYSDATE, 'YYYY'),
             sartest_dfmt_cde = 'MDC',
             sartest_test_score1 =
                DECODE (moe_rec.test_score_2,
                        100, '100.0',
                        TRIM (TO_CHAR (moe_rec.test_score_2, '00.00'))),
             -- TRIM (TO_CHAR (moe_rec.test_score_2, '000.0')),
             sartest_test_desc =
                (SELECT stvtesc_desc
                   FROM stvtesc
                  WHERE stvtesc_code = moe_rec.test_code_2),
             sartest_activity_date = SYSDATE
       WHERE     sartest_aidm = i.sybssnl_aidm
             AND sartest_appl_seqno = 1
             AND sartest_subt_cde = moe_rec.test_code_2;

      UPDATE sartest
         SET sartest_test_dte = '01/01/' || TO_CHAR (SYSDATE, 'YYYY'),
             sartest_dfmt_cde = 'MDC',
             sartest_test_score1 =
                DECODE (moe_rec.test_score_3,
                        100, '100.0',
                        TRIM (TO_CHAR (moe_rec.test_score_3, '00.00'))),
             --TRIM (TO_CHAR (moe_rec.test_score_3, '000.0')),
             sartest_test_desc =
                (SELECT stvtesc_desc
                   FROM stvtesc
                  WHERE stvtesc_code = moe_rec.test_code_3),
             sartest_activity_date = SYSDATE
       WHERE     sartest_aidm = i.sybssnl_aidm
             AND sartest_appl_seqno = 1
             AND sartest_subt_cde = moe_rec.test_code_3;
   END LOOP;
END;

--------------------- check results beefore commit

  SELECT sybssnl_ssn,
         sybssnl_aidm,
            STUDENT_FIRST_NAME_AR
         || ' '
         || STUDENT_MI_NAME_AR
         || ' '
         || STUDENT_LAST_NAME_AR
            "Student Name",
         OLD_QUDRAT_SCORE,
         OLD_TAHSELE_SCORE,
         NEW_QUDRAT_SCORE,
         NEW_TAHSELE_SCORE,
         STUDENT_QUDORAT_SCORE "moe_qudrat",
         STUDENT_TAHSEELY_SCORE "moe_tahselee",
         TEST_SCORE_2,
         TEST_SCORE_3,
         (SELECT sartest_test_score1
            FROM sartest
           WHERE     sartest_aidm = sybssnl_aidm
                 AND sartest_appl_seqno = 1
                 AND sartest_subt_cde = 'ﬁÌ«”')
            sartest_qudrat,
         (SELECT sartest_test_score1
            FROM sartest
           WHERE     sartest_aidm = sybssnl_aidm
                 AND sartest_appl_seqno = 1
                 AND sartest_subt_cde = ' Õ’·')
            sartest_tahselee,
         (SELECT sartest_test_score1
            FROM sartest
           WHERE     sartest_aidm = sybssnl_aidm
                 AND sartest_appl_seqno = 1
                 AND sartest_subt_cde = '‰”»2')
            sartest_2,
         (SELECT sartest_test_score1
            FROM sartest
           WHERE     sartest_aidm = sybssnl_aidm
                 AND sartest_appl_seqno = 1
                 AND sartest_subt_cde = '„.ﬂ')
            sartest_3
    FROM ADM_CHANGE_TEST_SCORE_REQUESTS a, sybssnl, moe_cd
   WHERE     sybssnl_aidm = APPLICANT_AIDM
         AND student_ssn = sybssnl_ssn
         AND sybssnl_term_code = '144010'
         AND sybssnl_admission_type = 'U2'
         AND REQUEST_STATUS = 'A'
         AND sybssnl_ssn IN (SELECT SSNID
                               FROM adm_qiyas_rqst_result
                              WHERE RESULT = 'Y')
ORDER BY 1;


---------------------------------+++++++++++++ update requests

UPDATE ADM_CHANGE_TEST_SCORE_REQUESTS
   SET REQUEST_STATUS = 'A',
       ACTION_DATE = SYSDATE,
       NOTES =
          ' „ ﬁ»Ê· «·ÿ·» Ê  „  ⁄œÌ· «·œ—Ã«  «·„ÿ·Ê»…'
 WHERE     REQUEST_STATUS = 'P'
       AND APPLICANT_AIDM IN
              (SELECT sybssnl_aidm
                 FROM sybssnl
                WHERE     sybssnl_term_code = '144010'
                      AND sybssnl_admission_type = 'U2'
                      AND sybssnl_ssn IN (SELECT SSNID
                                            FROM adm_qiyas_rqst_result
                                           WHERE RESULT = 'Y'));

                              ----rejcts

UPDATE ADM_CHANGE_TEST_SCORE_REQUESTS
   SET REQUEST_STATUS = 'R',
       ACTION_DATE = SYSDATE,
       NOTES =
          ' „ —›÷ «·ÿ·» Ê –·ﬂ ·⁄œ„  ÿ«»ﬁ «·œ—Ã«  «·„ÿ·Ê»… »⁄œ „—«Ã⁄… „—ﬂ“ ﬁÌ«”'
 WHERE     REQUEST_STATUS = 'P'
       AND APPLICANT_AIDM IN
              (SELECT sybssnl_aidm
                 FROM sybssnl
                WHERE     sybssnl_term_code = '144010'
                      AND sybssnl_admission_type = 'U2'
                      AND sybssnl_ssn IN (SELECT SSNID
                                            FROM adm_qiyas_rqst_result
                                           WHERE RESULT = 'N'));



                             --- delete results from result table

DELETE FROM adm_qiyas_rqst_result;