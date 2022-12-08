/* Formatted on 11/7/2022 9:53:19 AM (QP5 v5.371) */
CREATE TABLE bu_apps.anjez_users_roles
(
    ssn             VARCHAR2 (10),
    user_role       VARCHAR2 (3),
    coll            VARCHAR2 (4),
    dept            VARCHAR2 (4),
    dcn_nbr         NUMBER (9),
    dcn_typ         VARCHAR2 (1),
    dcn_dt          VARCHAR2 (15),
    rqst_dt         DATE,
    processed_dt    DATE,
    inb_user        VARCHAR2 (30),
    rqst_status     VARCHAR2 (15),
    error_log       VARCHAR2 (150),
    notes           VARCHAR2 (300)
) ;
CREATE OR REPLACE PUBLIC SYNONYM anjez_users_roles FOR BU_APPS.anjez_users_roles;


GRANT DELETE, INSERT, SELECT, UPDATE ON BU_APPS.anjez_users_roles TO PUBLIC;
