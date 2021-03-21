/* Formatted on 5/23/2019 12:35:23 PM (QP5 v5.227.12220.39754) */
  SELECT f_get_std_id (sfrstcr_pidm),
         f_get_std_name (sfrstcr_pidm),
           SUM (DISTINCT S.SMBPOGN_REQ_CREDITS_OVERALL)
         - SUM (DISTINCT S.SMBPOGN_ACT_CREDITS_OVERALL),
           SUM (DISTINCT S.SMBPOGN_REQ_CREDITS_OVERALL)
         - SUM (DISTINCT S.SMBPOGN_ACT_CREDITS_OVERALL)
         - SUM (DISTINCT SFRSTCR_CREDIT_HR),
         SUM (DISTINCT SFRSTCR_CREDIT_HR),
         SMBPOGN_REQUEST_NO,
         A.SGBSTDN_COLL_CODE_1
    FROM sfrstcr, sgbstdn a, SMBPOGN s
   WHERE     sfrstcr_term_code = '143930'
         AND sfrstcr_pidm = sgbstdn_pidm
         AND sfrstcr_pidm = SMBPOGN_pidm
         AND A.SGBSTDN_TERM_CODE_EFF =
                (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                   FROM sgbstdn
                  WHERE     sgbstdn_pidm = a.sgbstdn_pidm
                        AND SGBSTDN_TERM_CODE_EFF <= '143930')
         AND S.SMBPOGN_REQUEST_NO = (SELECT MAX (SMBPOGN_REQUEST_NO)
                                       FROM SMBPOGN
                                      WHERE SMBPOGN_pidm = sfrstcr_pidm)
 /* HAVING   SUM (DISTINCT S.SMBPOGN_REQ_CREDITS_OVERALL)
         - SUM (DISTINCT S.SMBPOGN_ACT_CREDITS_OVERALL)
         - SUM (DISTINCT SFRSTCR_CREDIT_HR) > 6*/
GROUP BY sfrstcr_pidm, SMBPOGN_REQUEST_NO, A.SGBSTDN_COLL_CODE_1
ORDER BY A.SGBSTDN_COLL_CODE_1