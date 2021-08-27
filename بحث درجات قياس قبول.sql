DECLARE
   l_qudrat    NUMBER;
   l_tahseel   NUMBER;
BEGIN
   bu_apps.p_get_qiyas (p_ssn       => '1114430638',
                        p_diplom    => 'Ï',
                        o_qudrat    => l_qudrat,
                        o_tahseel   => l_tahseel);
   DBMS_OUTPUT.put_line ('Qudrat : ' || l_qudrat);
   DBMS_OUTPUT.put_line ('Tahssel : ' || l_tahseel);
END;


Qudrat : 74
Tahssel : 71
GPA 91.85