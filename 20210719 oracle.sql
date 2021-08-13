/* 여러줄 주석 */
-- 한 줄 주석
-- HR 계정으로 테스트하고 있습니다.
-- MySQL과는 달리 Oracle SQL에서는 계정이 데이터베이스 개념까지 겸할 수 있습니다.
-- hr계정에는 인사팀 관련 데이터가 들어와 있습니다.

-- MySQL과 마찬가지로 Oracle에서도 거의 유사한 SELECT구문을 사용합니다.
SELECT employee_id, first_name, last_name FROM employees;

SELECT * FROM employees;

-- 급여가 5000이상인 직원의 아이디, 성, 이름만 출력해보세요.
SELECT employee_id, first_name, last_name FROM employees WHERE salary >= 5000;

-- Oracle에서도 ORDER BY로 정렬을 걸 수 있습니다.
-- 직원아이디를 오름차순으로 정렬까지 해주세요
SELECT employee_id, first_name, last_name
    FROM employees
    WHERE SALARY >= 5000
    ORDER BY employee_id DESC;

-- 조건을 다중으로 걸겠습니다.
-- 급여 5000이상 + jod_id가 'IT_PROG' 인 케이스만 조회해주세요.
SELECT employee_id, first_name, last_name
    FROM employees
    WHERE salary >= 5000
    AND job_id = 'IT_PROG'
    ORDER BY employee_id DESC;

-- Oracle은 문자열 자료셩의 경우 대소문자구분을 합니다.
SELECT employee_id, first_name, last_name
    FROM employees
    WHERE salary >= 5000
    AND job_id = 'it_prog'
    ORDER BY employee_id DESC;

-- 급여가 5000이상이거나 혹은 job_id가 'IT_PROG'인 직원들을 조회해주세요.
SELECT employee_id, first_name, last_name
    FROM employees
    WHERE salary >= 5000
    OR job_id = 'IT_PROG';

-- 나오는 row개수만 알고싶은 경우
SELECT COUNT(*)
    FROM employees
    WHERE salary >= 5000
    OR job_id = 'IT_PROG';

-- 컬럼명이 원래는 기존에 테이블을 만들 때 설정한 이름으로 조회되지만
-- SELECT 결과문에서 바꿔서 조회하고 싶을떄는 AS구문을 사용합니다.
-- SELECT 컬럼명1 AS 바꿀이름1, 컬럼명2 AS 바꿀이름2...
-- 키워드 AS는 생략할 수 있다.
SELECT employee_id AS 직원아이디 FROM employees;
SELECT employee_id 직원아이디 FROM employees;

-- INSERT INTO구문은 테이블에 ROW를 추가하는 구문입니다.
-- MySQL과 거의 동일한 문법을 사용합니다.
-- 테스트용 테이블 1번
CREATE TABLE test1(
    col1 VARCHAR2(10), -- 문자열
    col2 NUMBER, -- 정수
    col3 DATE -- 날짜,(상세시간 제외, 실제시간 입력시 TIMESTAMP)
);

-- INSERT INTO를 이용해 test1에 저장합니다.
-- 시간은 서버시간으로 저장할 경우 SYSDATE를 입력해줍니다.
-- MySQL에서는 SYSDATE 대신 now()를 사용합니다.
INSERT INTO test1(col1, col2, col3) VALUES ('ABC', 10, SYSDATE);

-- INTO 절에서 컬럼 순서를 바꿔도 VALUES에서 바뀐 순서에 맞춰서 넣어주면
-- 문제는 없습니다.
INSERT INTO test1(col3, col1, col2) VALUES (SYSDATE, 'DEF', 20);

-- 하지만 다음과 같이 데이터 타입을 맞추지 않으면 오류가 발생합니다.
INSERT INTO test1(col1, col2, col3) VALUES ('ABC', 10, 30);

-- 컬럼명은 전체컬럼에 집어넣는 경우 MySQL과 마찬가지로 생략 가능합니다.
INSERT INTO test1 VALUES ('CHI', 10, SYSDATE);

-- 일부 생략시 역시 오류가 발생합니다.
INSERT INTO test1 VALUES ('JKL', 20);

SELECT * FROM test1;

-- 컬럼 데이터 내용물 복사하기, INSET - SELECT 문.
-- SubQUERY형태로 INSERT INTo 구문의 VALUES가 들어갈 자리에
-- 데이터 자료형이 일치하는 SELECT 구문을 작성하면
-- SELECT문의 결과물이 그대로 전부 INSERT됩니다.
CREATE TABLE test2(
    emp_id NUMBER
);

-- 바로 아래의 SELECT 구문은 NUMBER데이터만 결과로 나옵니다.
SELECT employee_id FROM employees;

-- 아래 구문은 test2 테이블 내부에, 92번 라인 결과로 나온 숫자 전체를 집어넣습니다.
INSERT INTO test2
    (SELECT employee_id FROM employees);

-- 96번 라인은 실제로는 아래쪽 구문처럼 처리됩니다.
-- INSERT INTO test2
--     (100), (200), (102)... (206);

SELECT * FROM test2;

-- 문제
-- INSERT~SELECT 구문을 이용해서
-- EMPLOYEE 테이블의 employee_id, first_name, last_name, job_id
-- 4개 컬럼을 전체 복사받은 test3 테이블을 생성한 후
-- 복사를 진행해주세요.
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

-- UPDATE문
-- UPDATE SET을 이용해서 처리하면 mysql과 거의 유사한 문법을 사용합니다.
-- UPDATE SET은 그냥 처리하면 컬럼 전체값이 바뀝니다.
-- 따라서 WGERE와 함께 사용하는 것이 일반적입니다.
SELECT * FROM test1;

-- 테이블 col2의 값을 전부 50으로 바꿔줍니다.
UPDATE test1 SET col2 = 50;

SELECT * FROM test1;

-- col1의 값이 DEF인 경우만 col2를 500으로 고쳐주세요
UPDATE test1 SET col2 = 500 WHERE col1 = 'DEF';

SELECT * FROM test1;

-- Oracle SQL의 MERGE 구문은 MySQL의 ON DUPLICATE KEY와 같습니다.
-- 데이터가 있는 경우 UPDATE를, 없는 경우는 INSERT를 실행합니다.
-- MERGE INTO를 사용하고 오라클에서는 MySQL보다는 다소 복잡하지만
-- 기능상으로는 큰 차이는 없이 깨문에 문법적 차이점에 주목해주세요.
DROP TABLE test4;
CREATE TABLE test4(
    employee_id NUMBER PRIMARY KEY,
    bonus_amt NUMBER DEFAULT 0 -- 아무것도 입력되지 않으면 0 입력
);
INSERT INTO test4(employee_id)
    SELECT e.employee_id
        FROM employees e
    WHERE e.employee_id < 106;

SELECT * FROM test4;

-- 존재하는 EMPLOYEE_ID값으로 넣는 경우와 => 갱신
-- 존재하지 않는 EMPLOYEE_ID값으로 넣는 경우 => 추가
INSERT INTO test4(employee_id) VALUES (107);

-- 이미 있는 값을 넣을려고 하면 오류가 뜬다.
INSERT INTO test4 VALUES(105, 1000);

-- MERGE INTO 구문을 이용해서 처리해보겠습니다.
-- 입력할 테이블 t1, 테이블 하나에 대해서 작업시는 USING DUAL
MERGE INTO test4 t1 USING DUAL
    ON (t1.employee_id = 105) -- 조건식 (t1의 employee_id에 우측값이 있는가?)
    WHEN MATCHED THEN -- 매칭되는 경우(값이 존재하는 경우)
        UPDATE SET t1.bonus_amt = 1000 WHERE t1.employee_id = 105
    WHEN NOT MATCHED THEN -- 매칭이 되지 않는 경우(값이 없는 경우)
        INSERT (t1.employee_id, t1.bonus_amt)
            VALUES (105, 1000);

SELECT * FROM test4;

-- DELETE 구문은 특정 로우를 삭제합니다.
-- WHERE 절이 들어가지 않는다면 전체데이터가 삭제되기 때문에
-- 이 점을 유의해서 UPDATE문과 마찬가지로 사실상 WHERE절과 세트로
-- 생각해서 써주시면 됩니다.
-- MySQL과 문법적으로 큰 차이가 없습니다.

-- test4 테이블에서 BONUS_AMT 가 700을 초과하는 데이터만 삭제해주세요
DELETE FROM test4 WHERE bonus_amt > 700;

SELECT * FROM test4;


-- Oracle SQL에서는 인덱스를 조회하기가 MySQL보다 쉽습니다.
-- 인덱스란 조회를 위해 ROW별로 매겨진 임의의 값입니다.
-- Oracle SQL에서는 SELECT 문에 ROWNUM을 적어서 로우 인덱스 번호를
-- SELECT 문제 ROWID를 적어 로우 인덱스 주소값을 같이 조회할 수 있습니다.
-- MySQL에는 없는 기능입니다.
-- rownum, rowid처럼 사용자가 직접 입력하지 않고 조회되는 컬럼을 가리켜서
-- 의사컬럼이라고 부릅니다.
-- 인덱스의 장점
-- ROWNUM과 ROWID는 하나씩 값이 증가하고 시작지점을 저장한다.
-- 인덱스는 시작지점과 끝지점을 알고 시작하기 때문에 속도가 매우 빠르다.
SELECT ROWNUM, ROWID, employee_id, bonus_amt FROM test4;

-- GROUP BY역시 MySQL과 비슷한 뭄법을 사용합니다.
-- SELECT 집계함수(컬럼명)... GROUP BY (기준컬럼) HAVING 조건절;
-- 조건절은 HAVING으로 처리합니다.
-- EMPLOYEES에는 JOB_ID(직무 구분), DEPARTMENT_ID(부서 구문) 등 여러
-- GROUP BY를 이용해 부서별, 직무별, 데이터를 집계해보겠습니다.
-- 각 직무별 평균 연봉을 구해주세요.
SELECT job_id, avg(salary)
    FROM employees
    GROUP BY job_id
    ORDER BY avg(salary) DESC;

-- 각 직무별 평균 연봉을 구하되, 10000 이상을 구해주세요.
SELECT job_id, avg(salary)
    FROM employees
    GROUP BY job_id
    HAVING avg(salary) >= 10000
    ORDER BY avg(salary) DESC;

-- 각 부서별 평균 연봉을 구하되, 6000 ~ 9000사이로 구해주세요.
SELECT department_id, avg(salary)
    FROM employees
    GROUP BY department_id
    HAVING avg(salary) >= 6000 AND avg(salary) <= 9000
    ORDER BY avg(salary) DESC;

-- JOIN 은 두 개 이상의 테이블을 하나로 합쳐주는 것을 의미합니다.
-- 기본적으로 JOIN시는 특별한 경우를 제외하고는 합쳐주기 위한 기준컬럼이
-- 필요하며, 일반적으로 FOREIGN KEY로 연결된 컬럼간에 JOIN을 수행합니다.
-- 그러나 반드시 FOREIGN KEY 관계여야만 조인을 수행할 수 있는 것은 아닙니다.
-- SELECT 테이블1.컬럼1, 테이블2.컬럼2, 테이블2.컬럽1 ...
--     FROM 테이블1 (별명) JOIN 테이블2 (별명)
--     ON 테이블1.조건컬럼 = 테이블2.조건컬럼;
-- 조인구문은 INNER, LEFT, RIGHT, FULL이 있으며
-- MySQL에서는 FULL 조인이 FULL키워드로는 불가능합니다.
-- Oracle에서는 FULL키워드를 허용합니다.
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
-- INNER JOIN = 둘 다 가지고 있는 10, 20만 출력
SELECT a.EMP_ID, b.EMP_ID
    FROM JOIN_A a INNER JOIN JOIN_B b
    ON (a.EMP_ID = b.EMP_ID);
-- LEFT OUTER JOIN = 왼쪽 테이블 자료는 모두 살리기 때문에
-- 공통자료 10, 20 그리고 A만 가진 자료 40이 출력
SELECT a.EMP_ID, b.EMP_ID
    FROM JOIN_A a LEFT OUTER JOIN JOIN_B b
    ON (a.EMP_ID = b.EMP_ID);
-- RIGHT OUTER JOIN = 오른쪽 테이블 자료를 모두 살리기 때문에
-- 공통자료 10, 20 그리고 B만 가진 자료 30이 출력
SELECT a.EMP_ID, b.EMP_ID
    FROM JOIN_A a RIGHT OUTER JOIN JOIN_B b
    ON (a.EMP_ID = b.EMP_ID);
-- FULL OUTER JOIN = 왼쪽 오른쪽 자료를 모두 살림
-- 공통자료 10, 20과 왼쪽 40, 오른쪽 30 모두 출력
SELECT a.EMP_ID, b.EMP_ID
    FROM JOIN_A a FULL OUTER JOIN JOIN_B b
    ON (a.EMP_ID = b.EMP_ID);

COMMIT;