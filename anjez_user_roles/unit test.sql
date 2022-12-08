/* Formatted on 11/8/2022 10:53:09 AM (QP5 v5.371) */
DECLARE
    v_status          VARCHAR2 (20);
    v_error_message   VARCHAR2 (120);
    v_ref             NUMBER;
BEGIN
    WSO2ESB.p_fetch_angz_users_roles (
        i_ssn                 => '1031433889',
        i_role                => 'DPT',
        i_college             => '15',
        i_department          => '1501',
        i_decision_numb       => '1',
        i_decision_type       => 'A',
        i_decision_eff_date   => '',
        p_ref_numb            => v_ref,
        p_status              => v_status,
        p_error_message       => v_error_message);
    DBMS_OUTPUT.put_line ('ref br    ' || v_ref);

    DBMS_OUTPUT.put_line ('p_status    ' || v_status);
    DBMS_OUTPUT.put_line ('p_error_message    ' || v_error_message);
END;