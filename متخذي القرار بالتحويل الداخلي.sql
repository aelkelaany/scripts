/* Formatted on 29/07/2021 14:42:30 (QP5 v5.227.12220.39754) */
SELECT f_get_std_name (a.user_pidm),
       f_get_std_id (a.user_pidm) || '***' || a.user_pidm,
       B.ATTRIBUTE_VALUE
  FROM  role_users a, users_attributes b
 WHERE     a.ROLE_CODE = 'RO_DEPT_MANAGER'
 and  a.ROLE_CODE=b.ROLE_CODE
       AND ATTRIBUTE_CODE = 'DEPARTMENT'
       AND a.user_pidm = B.USER_PIDM
       AND a.user_pidm IN
              (SELECT user_pidm
                 FROM users_attributes
                WHERE     ATTRIBUTE_CODE = 'TRN_ALLOW_APPROVALS'
                      AND ATTRIBUTE_VALUE = 'N')
                      order by 3