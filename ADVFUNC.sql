/* Formatted on 4/10/2019 2:40:38 PM (QP5 v5.227.12220.39754) */
FUNCTION wfmf_step_1 (
   i_request_no        request_master.request_no%TYPE,
   p_current_step      wf_request_flow.flow_seq%TYPE,
   p_object_code       object_definition.object_code%TYPE,
   items            IN wf_navigation.varchar_tab DEFAULT wf_navigation.empty_tab,
   items_value      IN wf_navigation.varchar_tab DEFAULT wf_navigation.empty_tab,
   attributes       IN wf_navigation.varchar_tab DEFAULT wf_navigation.empty_tab)
   RETURN NUMBER
IS
   CURSOR C_GET_EXC_CRN_DATA
   IS
      SELECT DEPT_MANAGER_PIDM, VICE_DEAN_PIDM, DEAN_PIDM
        FROM execluded_crn
       WHERE CRN = wf_navigation.f_get_item_value ('CRN', items, items_value);

   L_DEPT_MANAGER_PIDM   NUMBER (8);
   L_VICE_DEAN_PIDM      NUMBER (8);
   L_DEAN_PIDM           NUMBER (8);

   CURSOR C_GET_ROLE_PIDM (
      P_ROLE_CODE VARCHAR2)
   IS
      SELECT E.USER_PIDM DMGR_PIDM
        FROM ROLE_USERS
       WHERE     ROLE_CODE = P_ROLE_CODE                   --'RO_DEPT_MANAGER'
             AND EXISTS
                    (SELECT 'Y'
                       FROM USERS_ATTRIBUTES
                      WHERE     USER_PIDM = E.USER_PIDM
                            AND ATTRIBUTE_CODE = 'COLLEGE'
                            AND ATTRIBUTE_VALUE =
                                   wf_navigation.f_get_item_value (
                                      'COLLEGE',
                                      items,
                                      items_value))
             AND EXISTS
                    (SELECT 'Y'
                       FROM USERS_ATTRIBUTES
                      WHERE     USER_PIDM = E.USER_PIDM
                            AND ATTRIBUTE_CODE = 'DEPARTMENT'
                            AND ATTRIBUTE_VALUE =
                                   wf_navigation.f_get_item_value (
                                      'DEPARTMENT',
                                      items,
                                      items_value))
             AND ACTIVE = 'Y';

BEGIN
   OPEN C_GET_EXC_CRN_DATA;

   FETCH C_GET_EXC_CRN_DATA
      INTO L_DEPT_MANAGER_PIDM, L_VICE_DEAN_PIDM, L_DEAN_PIDM;

   IF C_GET_EXC_CRN_DATA%FOUND
   THEN
      IF p_current_step = 2
      THEN
         RETURN L_DEPT_MANAGER_PIDM;
      ELSIF p_current_step = 3
      THEN
         RETURN L_VICE_DEAN_PIDM;
      ELSIF p_current_step = 4
      THEN
         RETURN L_DEAN_PIDM;
      END IF;

      CLOSE C_GET_EXC_CRN_DATA;
   ELSE
      CLOSE C_GET_EXC_CRN_DATA;                               -- REGULAR CYCLE
   END IF;

   IF p_current_step = 2
   THEN
      OPEN C_GET_ROLE_PIDM ('RO_DEPT_MANAGER');

      FETCH C_GET_ROLE_PIDM INTO L_DEPT_MANAGER_PIDM;

      RETURN NVL (L_DEPT_MANAGER_PIDM, 0);

      CLOSE C_GET_ROLE_PIDM;
   ELSIF p_current_step = 3
   THEN
      OPEN C_GET_ROLE_PIDM ('RO_VICE_DEAN');

      FETCH C_GET_ROLE_PIDM INTO L_VICE_DEAN_PIDM;

      RETURN NVL (L_VICE_DEAN_PIDM, 0);

      CLOSE C_GET_ROLE_PIDM;
   ELSIF p_current_step = 4
   THEN
      OPEN C_GET_ROLE_PIDM ('RO_COLLEGE_DEAN');

      FETCH C_GET_ROLE_PIDM INTO L_DEAN_PIDM;

      RETURN NVL (L_DEAN_PIDM, 0);

      CLOSE C_GET_ROLE_PIDM;
   END IF;

   RETURN r_instr_pidm;
END;

