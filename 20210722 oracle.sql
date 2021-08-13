-- Oracle SQL������ MySQLó�� ���α׷����� �� �� �ֽ��ϴ�.
-- ��, ���� �����̳� ȣ�� ���� ����, �׸��� �ܼ�â�� ����ϴ� ������
-- �Ȱ��� �ʱ� ������ Oracle���� ������ ���� �����ּž� �մϴ�.
-- Oracle���� �����ϴ� ���α׷����� PL/SQL�̶�� �θ��⵵ �մϴ�.

-- <PL/SQL ����>
-- ����
-- �����(DECLARE)
--     ������ �ڷ���;
--     ......
-- BEGIN
--     ���๮;
-- END;

-- �͸� ��� => DECLARE ~ END ������ ����̶�� �θ��ϴ�.
-- �͸� ����� ��ĥ�� ������ �ʰ� ����ϴ� PL/SQL ���α׷��� ������ �ǹ��մϴ�.
/*
DECLARE
    vi_num NUMBER;
BEGIN
    vi_num := 100;
    DBMS_OUTPUT.PUT_LINE(vi_num); -- print ����
END;
*/
-- SQL Developer���� �ܼ�â�� ���� ���
-- ��� �޴��� ���� -> DBMS ��� Ŭ��
-- DBMS ��� â���� �»�� ��� ���ڰ� Ŭ�� �� ���Ӱ��� ����

-- ���������� �Ϲ� ���α׷���ó�� �����ڸ� ����� �� �ֽ��ϴ�.
/*
DECLARE
    a INTEGER := (2 ** 2) * (3 ** 2);
BEGIN
    DBMS_OUTPUT.PUT_LINE('a = ' || TO_CHAR(a)); -- ��������� ���ڿ��� �ٲٱ� ���� TO_CHAR�� ���ϴ�.
END;
*/
-- DECLARE ������ 2�� �������� �ִٸ� �Ⱦ��� ������ �ּ�ó�� �ؾߵ˴ϴ�.

-- MySQL�� ���������� PL/SQL���� Ư�� ������
-- SELECT �������� ������� ������ �� �ֽ��ϴ�.
/*
DECLARE
    vs_emp_name VARCHAR2(80);
BEGIN
    SELECT first_name INTO vs_emp_name
        FROM employees
        WHERE employee_id = 100;
    DBMS_OUTPUT.PUT_LINE('�޾ƿ� ����� ' || vs_emp_name);
END;
*/
-- employees ���̺��� 185�� ����� �μ���ȣ, �̸�(last_name), �޿���
-- PL/SQL �������� ȣ���ؼ� �ֿܼ� ����ּ���.
/*
DECLARE
    emp_da_id NUMBER;
    emp_last_name VARCHAR2(100);
    emp_salary NUMBER;
BEGIN
    SELECT department_id, last_name, salary
        INTO emp_da_id, emp_last_name, emp_salary
        FROM employees
        WHERE employee_id = 185;
    DBMS_OUTPUT.PUT_LINE('����μ� ' || emp_da_id);
    DBMS_OUTPUT.PUT_LINE('����̸� ' || emp_last_name);
    DBMS_OUTPUT.PUT_LINE('����޿� ' || emp_salary);
END;
*/

-- ����ο��� ���� �ڷ����� ������ �� Ư�� ���̺��� Ư�� �÷�����
-- �������� ���翩 �ϴ� ��찡 ����մϴ�.
-- �� ��, ����ڰ� ���������� �ڷ����� ������ Ȯ���ϰ� �����ϸ� �����ϴ�
-- �ڵ����� �ش� �÷� �ڷ����� �޾ƿ����� ó���� ���� �ֽ��ϴ�.
-- ������ ���̺��.�÷���%TYPE; �̶�� ��� ó���մϴ�.
-- DEPARTMENTS���� DEPARTMENT_NAME�� LOCATION_ID�� �������ڽ��ϴ�.
/*
DECLARE
    d_name DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    l_id DEPARTMENTS.LOCATION_ID%TYPE;
BEGIN
    SELECT DEPARTMENT_NAME, LOCATION_ID
        INTO d_name, l_id
        FROM DEPARTMENTS
        WHERE DEPARTMENT_ID = 20;
    DBMS_OUTPUT.PUT_LINE('�μ��̸� : ' || d_name);
    DBMS_OUTPUT.PUT_LINE('�μ���ġ : ' || l_id);
END;
*/
-- PL/SQL�� ���ǹ�
-- IF ���ǽ� THEN�� ����ϸ�, ������ ������ END IF; �� �����ָ� �˴ϴ�.
-- �̿� ������ ���� MySQL�� �����ϳ� ELSE IF�� ELSIF �� ǥ���մϴ�.
-- ����) vn_num1, vn_num2�� NUMBER Ÿ������ ���� ���ڸ� ����־��ֽð�
-- ������� ���ڵ� �� num1�� ũ�� "num1�� Ů�ϴ�", num2�� ũ�� "num2�� Ů�ϴ�"
-- ��� ����ϴ� ���ǹ��� �ۼ����ּ���.
/*
DECLARE
    vn_num1 NUMBER := 10;
    vn_num2 NUMBER := 20;
BEGIN
    IF vn_num1 > vn_num2 THEN
        DBMS_OUTPUT.PUT_LINE(vn_num1 || ' num1�� Ů�ϴ�');
    ELSIF vn_num1 < vn_num2 THEN
        DBMS_OUTPUT.PUT_LINE(vn_num2 || ' num2�� Ů�ϴ�');
    ELSE
        DBMS_OUTPUT.PUT_LINE('num1�� num2�� �����ϴ�.');
    END IF;
END;
*/

-- ���ν��� ����
-- ���ν����� MySQL�� ����ϰ� ����ϸ�
-- ������ �ణ �ٸ��� ������ �����ϼž� �մϴ�.
-- ����)
-- CREATE OR REPLACE PROCETURE ���ν�����(
--     �Ķ����1 ������Ÿ��,
--     ......
-- )
-- IS
--     �ʿ�� ���� �� ��� ����
-- BEGIN
--     ���౸��
-- END ���ν�����;
CREATE OR REPLACE PROCEDURE my_new_job(
    n_job_id IN JOBS.JOB_ID%TYPE,
    n_job_title IN JOBS.JOB_TITLE%TYPE,
    n_min_salary IN JOBS.MIN_SALARY%TYPE,
    n_max_salary IN JOBS.MAX_SALARY%TYPE
)
IS
BEGIN
    INSERT INTO JOBS(JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
        VALUES (n_job_id, n_job_title, n_min_salary, n_max_salary);
    COMMIT;
END my_new_job;

-- ���ν��� ȣ��ô� MySQL�� CALL ���
-- Oracle SQL������ EXEC ���ν�����, EXECUTE ���ν����� �� ����մϴ�.
EXEC my_new_job('INTERN', 'INTERN STAFF', 500, 1000);


