/* ������ �ּ� */
-- �� �� �ּ�
-- HR �������� �׽�Ʈ�ϰ� �ֽ��ϴ�.
-- MySQL���� �޸� Oracle SQL������ ������ �����ͺ��̽� ������� ���� �� �ֽ��ϴ�.
-- hr�������� �λ��� ���� �����Ͱ� ���� �ֽ��ϴ�.

-- MySQL�� ���������� Oracle������ ���� ������ SELECT������ ����մϴ�.
SELECT employee_id, first_name, last_name FROM employees;

SELECT * FROM employees;

-- �޿��� 5000�̻��� ������ ���̵�, ��, �̸��� ����غ�����.
SELECT employee_id, first_name, last_name FROM employees WHERE salary >= 5000;

-- Oracle������ ORDER BY�� ������ �� �� �ֽ��ϴ�.
-- �������̵� ������������ ���ı��� ���ּ���
SELECT employee_id, first_name, last_name
    FROM employees
    WHERE SALARY >= 5000
    ORDER BY employee_id DESC;

-- ������ �������� �ɰڽ��ϴ�.
-- �޿� 5000�̻� + jod_id�� 'IT_PROG' �� ���̽��� ��ȸ���ּ���.
SELECT employee_id, first_name, last_name
    FROM employees
    WHERE salary >= 5000
    AND job_id = 'IT_PROG'
    ORDER BY employee_id DESC;

-- Oracle�� ���ڿ� �ڷ���� ��� ��ҹ��ڱ����� �մϴ�.
SELECT employee_id, first_name, last_name
    FROM employees
    WHERE salary >= 5000
    AND job_id = 'it_prog'
    ORDER BY employee_id DESC;

-- �޿��� 5000�̻��̰ų� Ȥ�� job_id�� 'IT_PROG'�� �������� ��ȸ���ּ���.
SELECT employee_id, first_name, last_name
    FROM employees
    WHERE salary >= 5000
    OR job_id = 'IT_PROG';

-- ������ row������ �˰���� ���
SELECT COUNT(*)
    FROM employees
    WHERE salary >= 5000
    OR job_id = 'IT_PROG';

-- �÷����� ������ ������ ���̺��� ���� �� ������ �̸����� ��ȸ������
-- SELECT ��������� �ٲ㼭 ��ȸ�ϰ� �������� AS������ ����մϴ�.
-- SELECT �÷���1 AS �ٲ��̸�1, �÷���2 AS �ٲ��̸�2...
-- Ű���� AS�� ������ �� �ִ�.
SELECT employee_id AS �������̵� FROM employees;
SELECT employee_id �������̵� FROM employees;

-- INSERT INTO������ ���̺� ROW�� �߰��ϴ� �����Դϴ�.
-- MySQL�� ���� ������ ������ ����մϴ�.
-- �׽�Ʈ�� ���̺� 1��
CREATE TABLE test1(
    col1 VARCHAR2(10), -- ���ڿ�
    col2 NUMBER, -- ����
    col3 DATE -- ��¥,(�󼼽ð� ����, �����ð� �Է½� TIMESTAMP)
);

-- INSERT INTO�� �̿��� test1�� �����մϴ�.
-- �ð��� �����ð����� ������ ��� SYSDATE�� �Է����ݴϴ�.
-- MySQL������ SYSDATE ��� now()�� ����մϴ�.
INSERT INTO test1(col1, col2, col3) VALUES ('ABC', 10, SYSDATE);

-- INTO ������ �÷� ������ �ٲ㵵 VALUES���� �ٲ� ������ ���缭 �־��ָ�
-- ������ �����ϴ�.
INSERT INTO test1(col3, col1, col2) VALUES (SYSDATE, 'DEF', 20);

-- ������ ������ ���� ������ Ÿ���� ������ ������ ������ �߻��մϴ�.
INSERT INTO test1(col1, col2, col3) VALUES ('ABC', 10, 30);

-- �÷����� ��ü�÷��� ����ִ� ��� MySQL�� ���������� ���� �����մϴ�.
INSERT INTO test1 VALUES ('CHI', 10, SYSDATE);

-- �Ϻ� ������ ���� ������ �߻��մϴ�.
INSERT INTO test1 VALUES ('JKL', 20);

SELECT * FROM test1;

-- �÷� ������ ���빰 �����ϱ�, INSET - SELECT ��.
-- SubQUERY���·� INSERT INTo ������ VALUES�� �� �ڸ���
-- ������ �ڷ����� ��ġ�ϴ� SELECT ������ �ۼ��ϸ�
-- SELECT���� ������� �״�� ���� INSERT�˴ϴ�.
CREATE TABLE test2(
    emp_id NUMBER
);

-- �ٷ� �Ʒ��� SELECT ������ NUMBER�����͸� ����� ���ɴϴ�.
SELECT employee_id FROM employees;

-- �Ʒ� ������ test2 ���̺� ���ο�, 92�� ���� ����� ���� ���� ��ü�� ����ֽ��ϴ�.
INSERT INTO test2
    (SELECT employee_id FROM employees);

-- 96�� ������ �����δ� �Ʒ��� ����ó�� ó���˴ϴ�.
-- INSERT INTO test2
--     (100), (200), (102)... (206);

SELECT * FROM test2;

-- ����
-- INSERT~SELECT ������ �̿��ؼ�
-- EMPLOYEE ���̺��� employee_id, first_name, last_name, job_id
-- 4�� �÷��� ��ü ������� test3 ���̺��� ������ ��
-- ���縦 �������ּ���.
CREATE TABLE test3(
    emp_id NUMBER,
    f_name VARCHAR2(20),
    l_name VARCHAR2(20),
    j_id VARCHAR2(10)
);
INSERT INTO test3
    (SELECT employee_id, first_name, last_name, job_id FROM employees);

SELECT employee_id, first_name, last_name, job_id FROM employees;

SELECT * FROM test3;

-- UPDATE��
-- UPDATE SET�� �̿��ؼ� ó���ϸ� mysql�� ���� ������ ������ ����մϴ�.
-- UPDATE SET�� �׳� ó���ϸ� �÷� ��ü���� �ٲ�ϴ�.
-- ���� WGERE�� �Բ� ����ϴ� ���� �Ϲ����Դϴ�.
SELECT * FROM test1;

-- ���̺� col2�� ���� ���� 50���� �ٲ��ݴϴ�.
UPDATE test1 SET col2 = 50;

SELECT * FROM test1;

-- col1�� ���� DEF�� ��츸 col2�� 500���� �����ּ���
UPDATE test1 SET col2 = 500 WHERE col1 = 'DEF';

SELECT * FROM test1;

-- Oracle SQL�� MERGE ������ MySQL�� ON DUPLICATE KEY�� �����ϴ�.
-- �����Ͱ� �ִ� ��� UPDATE��, ���� ���� INSERT�� �����մϴ�.
-- MERGE INTO�� ����ϰ� ����Ŭ������ MySQL���ٴ� �ټ� ����������
-- ��ɻ����δ� ū ���̴� ���� ������ ������ �������� �ָ����ּ���.
DROP TABLE test4;
CREATE TABLE test4(
    employee_id NUMBER PRIMARY KEY,
    bonus_amt NUMBER DEFAULT 0 -- �ƹ��͵� �Էµ��� ������ 0 �Է�
);
INSERT INTO test4(employee_id)
    SELECT e.employee_id
        FROM employees e
    WHERE e.employee_id < 106;

SELECT * FROM test4;

-- �����ϴ� EMPLOYEE_ID������ �ִ� ���� => ����
-- �������� �ʴ� EMPLOYEE_ID������ �ִ� ��� => �߰�
INSERT INTO test4(employee_id) VALUES (107);

-- �̹� �ִ� ���� �������� �ϸ� ������ ���.
INSERT INTO test4 VALUES(105, 1000);

-- MERGE INTO ������ �̿��ؼ� ó���غ��ڽ��ϴ�.
-- �Է��� ���̺� t1, ���̺� �ϳ��� ���ؼ� �۾��ô� USING DUAL
MERGE INTO test4 t1 USING DUAL
    ON (t1.employee_id = 105) -- ���ǽ� (t1�� employee_id�� �������� �ִ°�?)
    WHEN MATCHED THEN -- ��Ī�Ǵ� ���(���� �����ϴ� ���)
        UPDATE SET t1.bonus_amt = 1000 WHERE t1.employee_id = 105
    WHEN NOT MATCHED THEN -- ��Ī�� ���� �ʴ� ���(���� ���� ���)
        INSERT (t1.employee_id, t1.bonus_amt)
            VALUES (105, 1000);

SELECT * FROM test4;

-- DELETE ������ Ư�� �ο츦 �����մϴ�.
-- WHERE ���� ���� �ʴ´ٸ� ��ü�����Ͱ� �����Ǳ� ������
-- �� ���� �����ؼ� UPDATE���� ���������� ��ǻ� WHERE���� ��Ʈ��
-- �����ؼ� ���ֽø� �˴ϴ�.
-- MySQL�� ���������� ū ���̰� �����ϴ�.

-- test4 ���̺��� BONUS_AMT �� 700�� �ʰ��ϴ� �����͸� �������ּ���
DELETE FROM test4 WHERE bonus_amt > 700;

SELECT * FROM test4;


-- Oracle SQL������ �ε����� ��ȸ�ϱⰡ MySQL���� �����ϴ�.
-- �ε����� ��ȸ�� ���� ROW���� �Ű��� ������ ���Դϴ�.
-- Oracle SQL������ SELECT ���� ROWNUM�� ��� �ο� �ε��� ��ȣ��
-- SELECT ���� ROWID�� ���� �ο� �ε��� �ּҰ��� ���� ��ȸ�� �� �ֽ��ϴ�.
-- MySQL���� ���� ����Դϴ�.
-- rownum, rowidó�� ����ڰ� ���� �Է����� �ʰ� ��ȸ�Ǵ� �÷��� �����Ѽ�
-- �ǻ��÷��̶�� �θ��ϴ�.
-- �ε����� ����
-- ROWNUM�� ROWID�� �ϳ��� ���� �����ϰ� ���������� �����Ѵ�.
-- �ε����� ���������� �������� �˰� �����ϱ� ������ �ӵ��� �ſ� ������.
SELECT ROWNUM, ROWID, employee_id, bonus_amt FROM test4;

-- GROUP BY���� MySQL�� ����� ������ ����մϴ�.
-- SELECT �����Լ�(�÷���)... GROUP BY (�����÷�) HAVING ������;
-- �������� HAVING���� ó���մϴ�.
-- EMPLOYEES���� JOB_ID(���� ����), DEPARTMENT_ID(�μ� ����) �� ����
-- GROUP BY�� �̿��� �μ���, ������, �����͸� �����غ��ڽ��ϴ�.
-- �� ������ ��� ������ �����ּ���.
SELECT job_id, avg(salary)
    FROM employees
    GROUP BY job_id
    ORDER BY avg(salary) DESC;

-- �� ������ ��� ������ ���ϵ�, 10000 �̻��� �����ּ���.
SELECT job_id, avg(salary)
    FROM employees
    GROUP BY job_id
    HAVING avg(salary) >= 10000
    ORDER BY avg(salary) DESC;

-- �� �μ��� ��� ������ ���ϵ�, 6000 ~ 9000���̷� �����ּ���.
SELECT department_id, avg(salary)
    FROM employees
    GROUP BY department_id
    HAVING avg(salary) >= 6000 AND avg(salary) <= 9000
    ORDER BY avg(salary) DESC;

-- JOIN �� �� �� �̻��� ���̺��� �ϳ��� �����ִ� ���� �ǹ��մϴ�.
-- �⺻������ JOIN�ô� Ư���� ��츦 �����ϰ�� �����ֱ� ���� �����÷���
-- �ʿ��ϸ�, �Ϲ������� FOREIGN KEY�� ����� �÷����� JOIN�� �����մϴ�.
-- �׷��� �ݵ�� FOREIGN KEY ���迩�߸� ������ ������ �� �ִ� ���� �ƴմϴ�.
-- SELECT ���̺�1.�÷�1, ���̺�2.�÷�2, ���̺�2.�÷�1 ...
--     FROM ���̺�1 (����) JOIN ���̺�2 (����)
--     ON ���̺�1.�����÷� = ���̺�2.�����÷�;
-- ���α����� INNER, LEFT, RIGHT, FULL�� ������
-- MySQL������ FULL ������ FULLŰ����δ� �Ұ����մϴ�.
-- Oracle������ FULLŰ���带 ����մϴ�.
CREATE TABLE JOIN_A(
    EMP_ID NUMBER
);
CREATE TABLE JOIN_B(
    EMP_ID NUMBER
);
INSERT INTO JOIN_A VALUES(10);
INSERT INTO JOIN_A VALUES(20);
INSERT INTO JOIN_A VALUES(40);
INSERT INTO JOIN_B VALUES(10);
INSERT INTO JOIN_B VALUES(20);
INSERT INTO JOIN_B VALUES(30);
-- INNER JOIN = �� �� ������ �ִ� 10, 20�� ���
SELECT a.EMP_ID, b.EMP_ID
    FROM JOIN_A a INNER JOIN JOIN_B b
    ON (a.EMP_ID = b.EMP_ID);
-- LEFT OUTER JOIN = ���� ���̺� �ڷ�� ��� �츮�� ������
-- �����ڷ� 10, 20 �׸��� A�� ���� �ڷ� 40�� ���
SELECT a.EMP_ID, b.EMP_ID
    FROM JOIN_A a LEFT OUTER JOIN JOIN_B b
    ON (a.EMP_ID = b.EMP_ID);
-- RIGHT OUTER JOIN = ������ ���̺� �ڷḦ ��� �츮�� ������
-- �����ڷ� 10, 20 �׸��� B�� ���� �ڷ� 30�� ���
SELECT a.EMP_ID, b.EMP_ID
    FROM JOIN_A a RIGHT OUTER JOIN JOIN_B b
    ON (a.EMP_ID = b.EMP_ID);
-- FULL OUTER JOIN = ���� ������ �ڷḦ ��� �츲
-- �����ڷ� 10, 20�� ���� 40, ������ 30 ��� ���
SELECT a.EMP_ID, b.EMP_ID
    FROM JOIN_A a FULL OUTER JOIN JOIN_B b
    ON (a.EMP_ID = b.EMP_ID);

COMMIT;