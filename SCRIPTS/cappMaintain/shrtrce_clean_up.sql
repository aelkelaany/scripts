/* Formatted on 10/02/2021 14:05:02 (QP5 v5.227.12220.39754) */
DELETE FROM shrtrce
      WHERE     EXISTS
                   (SELECT '1'
                      FROM SHRTRIT, SHRTRAM
                     WHERE     shrtrce_pidm = SHRTRIT_pidm
                           AND SHRTRCE_TRIT_SEQ_NO = SHRTRIT_SEQ_NO
                           AND SHRTRAM_PIDM = shrtrce_pidm
                           AND SHRTRAM_TRIT_SEQ_NO = SHRTRIT_SEQ_NO
                           AND SHRTRAM_SEQ_NO = SHRTRCE_TRAM_SEQ_NO
                           AND SHRTRIT_SBGI_CODE = '99')
            AND EXISTS
                   (SELECT '2'
                      FROM CAPP_MNPL_LOG_DETAIL
                     WHERE shrtrce_pidm = std_pidm AND process_id = 2900);

DELETE FROM SHRTRCR
      WHERE     EXISTS
                   (SELECT '1'
                      FROM SHRTRIT, SHRTRAM
                     WHERE     SHRTRCR_pidm = SHRTRIT_pidm
                           AND SHRTRCR_TRIT_SEQ_NO = SHRTRIT_SEQ_NO
                           AND SHRTRAM_PIDM = SHRTRCR_pidm
                           AND SHRTRAM_TRIT_SEQ_NO = SHRTRIT_SEQ_NO
                           AND SHRTRAM_SEQ_NO = SHRTRCR_TRAM_SEQ_NO
                           AND SHRTRIT_SBGI_CODE = '99')
            AND EXISTS
                   (SELECT '2'
                      FROM CAPP_MNPL_LOG_DETAIL
                     WHERE SHRTRCR_pidm = std_pidm AND process_id = 2900);


DELETE FROM SHRTRAM
      WHERE     EXISTS
                   (SELECT '1'
                      FROM SHRTRIT
                     WHERE     SHRTRAM_PIDM = SHRTRIT_PIDM
                           AND SHRTRAM_TRIT_SEQ_NO = SHRTRIT_SEQ_NO
                           AND SHRTRIT_SBGI_CODE = '99')
            AND EXISTS
                   (SELECT '2'
                      FROM CAPP_MNPL_LOG_DETAIL
                     WHERE SHRTRAM_pidm = std_pidm AND process_id = 2900);


DELETE FROM SHRTRIT
      WHERE     SHRTRIT_SBGI_CODE = '99'
            AND EXISTS
                   (SELECT '2'
                      FROM CAPP_MNPL_LOG_DETAIL
                     WHERE SHRTRIT_pidm = std_pidm AND process_id = 2900)