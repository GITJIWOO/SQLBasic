-- SQL 구문의 분류
-- DML : Data Manipulation Language
-- 데이터 조작언어로 SELECT, INSERT, UPDATE, DELETE 구문을 의미한다.
-- 테이블의 데이터를 변경하기 위해 사용한다.

-- DDL : Data Definition Language
-- 데이터 정의언어로 데이터베이스, 테이블, 뷰, 인덱스 등을 생성하고
-- 삭제하는 구문으로 CREATE, DROP, ALTER가 있습니다.
-- DML과는 달리 COMMIT; 없이도 바로바로 서버에 반영됩니다.

-- DCL : Data Comtrol Language
-- 데이터 제어 언어로 특정 계정에 권한을 부여하거나 뺏을때 사용합니다.
-- GRANT, REVOKE, DENY 등이 있습니다.

-- INSERT 구문은 특정 테이블에 자료를 삽입하는 구문입니다.
-- INSERT INTO 테이블(컬럼1, 컬럼2...) VALUES (값1, 값2...);
-- 만약 모든 테이블에 자료를 집어넣고 싶을때는
-- INSERT INTO 테이블 VALUES (값1, 값2...)
-- 과 같이 테이블 위에 컬럼명을 생략할 수도 있습니다.

USE sqldb;

-- 테이블 예제 1번
CREATE TABLE testTbl1(
	id INT PRIMARY KEY,
	userName CHAR(3),
    age INT
);
-- 테이블명 뒤에 컬럼정보를 적지 않으면, CREATE TABLE시 설정한
-- 컬럼 정보가 순서대로 입력됩니다.
INSERT INTO testTbl1 VALUES (1, '홍길동', 25);

-- id와 이름쪽에만 데이터를 넣을때는 컬럼명을 생략할 수 없습니다.
INSERT INTO testTbl1(id, userName) VALUES (2, '김길동');

-- 만약 컬럼명 지정을 안 했지만 age에는 null을 넣고싶다면
INSERT INTO testTbl1 VALUES (3, '이호영', null);

-- 만약 입력 열(컬럼)의 순서를 바꿔서 삽입하는 경우는
-- 모든 컬럼에 값을 입력하는 상황이어도 컬럼명을 생략할 수 없다.
INSERT INTO testTbl1(userName, age, id) VALUES ('강길동', 10, 4);

SELECT * FROM testTbl1;


-- 지금 testTbl1같은 경우 id값을 수동으로 입력해주고 있습니다.
-- 이 경우 매번 id값을 사용자가 계산해서 insert해야하기 때문에
-- 굉장히 불편한데, auto_increament 속성을 컬럼에 걸어주면
-- 데이터를 입력하지 않았을때 컴퓨터가 순차적으로 컬럼에 중복되지 않고
-- 증가하는 숫자를 자동 입력해줍니다.

-- 테이블 예제 2번
CREATE TABLE testTbl2(
	id INT AUTO_INCREMENT PRIMARY KEY,
    userName CHAR(3),
    age INT
);

-- id컬럼에는 AUTO_INCREMENT가 붙어있으므로 null로 처리해도
-- 자동으로 1부터 숫자가 1씩 증가하며 들어갑니다.
INSERT INTO testTbl2 VALUE (null, '알파카', 4);
INSERT INTO testTbl2 VALUE (null, '애뮤', 2);
INSERT INTO testTbl2 VALUE (null, '토끼', 1);

-- AUTO_INCREMENT의 기준값은 1부터 1씩 자동으로 증가하지만
-- 만약 사용자가 임의로 값을 바꾸고 싶다면 ALTER TABLE을 이용해
-- AUTO_INCREMENT의 값을 수정할 수도 있습니다.

-- testTbl2에 걸린 AUTO_INCREMENT의 현재값을 1000으로 변경
ALTER TABLE testTbl2 AUTO_INCREMENT = 1000;
INSERT INTO testTbl2 VALUES (null, '반달곰', 10);
INSERT INTO testTbl2 VALUES (null, '산양', 3);

-- 커맨드라인에서 testTbl2컬럼에 데이터를 3개 더 입력해주세요.
-- 커맨드라인에서 조회까지 마쳐주세요.

SELECT * FROM testTbl2;

-- 테이블 예제 3번
CREATE TABLE testTbl3(
	id INT AUTO_INCREMENT PRIMARY KEY,
    userName CHAR(3),
    age INT
);
ALTER TABLE testTbl3 AUTO_INCREMENT = 1000;

-- 증가되는 수치를 바꾸고 싶을때는 서버측 변수인
-- @@auto_increment_increment를 바꿔야 합니다.
SET @@auto_increment_increment = 3;

INSERT INTO testTbl3 VALUES (null, '고양이', 5);
INSERT INTO testTbl3 VALUES (null, '개', 4);
INSERT INTO testTbl3 VALUES (null, '치타', 3);

SELECT * FROM testTbl3;

-- @@auto_increment_increment는 SQL전체에 영향을 준다.
-- 하지만 기본적으로 1에서 바꿀일은 거의 없으므로 기능에 대해서만
-- 알고 넘어가시면 됩니다.
INSERT INTO testTbl2 VALUES (null, '여우', 2);
INSERT INTO testTbl2 VALUES (null, '사막여우', 3);
SET @@auto_increment_increment = 1;
INSERT INTO testTbl2 VALUES (null, '고라니', 6);

SELECT * FROM testTbl2;

-- 하나의 INSERT INTO 구문으로 여러 row를 추가할 때는
-- VALUES 뒤 쪽을 연달아 작성합니다.
INSERT INTO testTbl2 VALUES 
	(null, '얼룩말', 2), (null, '오리', 1), (null, '닭', 2);

SELECT * FROM testTbl2;


-- UPDATE 구문은기존에 입력되어 있는 값을 변결할 떄 사용합니다.
-- WHERE 조건절을 걸지 않는다면, 컬럼 하나의 값을 전부 바꿉니다.
-- 따라서 일반적으로는 무조건 조건절과 조합해서 사용합니다.
-- UPDATE 테이블명 SET 컬럼1 = 바꿀값1, 컬럼2 = 바꿀값2...;

-- testTbl2의 userName을 전부 '소'로 바꾸는 구문
UPDATE testTbl2 SET userName = '소';

-- Workbench에서 safe update모드 해제(0 = 안전모드 해제, 1 = 안전모드 사용)
SET SQL_SAFE_UPDATES = 0;

-- testTbl2의 userName을 '말'로 바꾸기
UPDATE testTbl2 SET userName = '말';

SELECT * FROM testTbl2;

-- 특정 나이대의 userName을 여러분을이 좋아하는 동물로 교체해주세요.
-- WHERE절을 사용해서 age를 필터링합니다.
-- 하나의 나이대만 교체해주세요.
UPDATE testTbl2 SET userName = '라쿤' WHERE age = 3;

SELECT * FROM testTbl2;

-- 이걸 응용해서 특정 컬럼의 값을 일괄적으로 계산식에 따라
-- 결과값을 얻어내 적용할 수도 있습니다.
-- 아래 코드는 나이를 2배한 결과입니다.
UPDATE testTbl2 SET age = age * 2;

SELECT * FROM testTbl2;


-- DELETE FROM 구문은 데이터를 삭제하는 구문입니다.
-- SELECT는 특정 컬럼만 조회하거나 전체 컬럼을 조회하는
-- 경우의 수가 있었기 때문에 SELECT와 FROM 사이에
-- 구체적인 컬럼명이나 혹은 *을 붙여서 전체 컬럼을 조회했지만
-- DELETE는 특정 컬럼만 삭제하는 경우가 없고 전체 로우를
-- 삭제하거나 말거나 이기 때문에
-- DELETE와 FROM 사이에 아무것도 적지 않습니다.
-- DELETE 역시 일반적으로 WHERE절과 함께 사용합니다.
-- WHERE 없이 사용시 테이블 전체 데이터를 삭제합니다.
-- id 1번을 삭제해보겠습니다.
DELETE FROM testTbl2 WHERE id = 1;

-- LIMIT를 사용하면 상위 n개만 삭제할수도 있습니다.
-- 검색 결과물 중 상위 2개만 삭제
DELETE FROM testTbl2 LIMIT 2;

-- WHERE절이 없으면 테이블 내 데이터 전체 삭제
DELETE FROM testTbl2;

INSERT INTO testTbl2 VALUES (null, '말', 1);

-- DELETE FROM은 삭제시 시간이 오래걸리는데 트랜잭션 로그라는 것을
-- 한 로우마다 일일히 작성하기 때문입니다.
-- 따라서 속도를 끌어올라고 싶을때는 TRUNCATE를 대신 씁니다.
TRUNCATE TABLE testTbl2;

SELECT * FROM testTbl2;

-- TRUNCATE와 DELETE FROM 속도차이 비교를 위해서
-- employees 테이블 자료 복사하기
-- 테이블 예제 4번
CREATE TABLE testTbl4(
	id INT PRIMARY KEY,
    Fname VARCHAR(50),
    Lname VARCHAR(50)
);
INSERT INTO testTbl4(
	SELECT emp_no, first_name, last_name
		FROM employees.employees);
SELECT * FROM testTbl4;
-- DELETE FROM 시간 측정
DELETE FROM testTbl4;
-- TRUNCATE TABLE 시간 측정
TRUNCATE TABLE testTbl4;


-- 조건부로 데이터 입력하기
-- 예를 들어 100개의 데이터를 입력하라고 하는데 첫 번쨰 자료만
-- 기존 데이터의 id와 중복되는 값이 있고 이후 99건은 PK가
-- 중복되지 않는다고 해도 SQL 시스템 상 전체 데이터가
-- 입력되지 않는 문제가 발생합니다.
-- 따라서 이 때 중복되는 1건은 중복된다면 무시하고
-- 이후 나머지 99개 데이터는 중단없이 정상적으로
-- 입력하도록 만들 수 있습니다.

-- 테이블 예제 5번
CREATE TABLE memberTbl(
	userID CHAR(3) PRIMARY KEY,
    name CHAR(3) not null,
    addr CHAR(2) not null
);

-- MySQL은 구문 실행시 모두 실행하거나 모두 실행하지 않는다.
INSERT INTO memberTbl VALUES ('bbk', '바비킴', '서울');
INSERT INTO memberTbl VALUES ('ejw', '은지원', '경북');
INSERT INTO memberTbl VALUES ('jkw', '조관우', '경기');

-- 추가 데이터를 입력하되 한 건은 중복, 두 건은 중복 없도록 실행
INSERT INTO memberTbl VALUES ('bbk', '바비킴', '서울');
INSERT INTO memberTbl VALUES ('ljy', '이지은', '경기');
INSERT INTO memberTbl VALUES ('jbj', '장범준', '천안');

-- 위 문제를 해결하기 위해 INSERT와 INTO 사이에 IGNORE 추가
INSERT IGNORE INTO memberTbl VALUES ('bbk', '바비킴', '서울');
INSERT IGNORE INTO memberTbl VALUES ('ljy', '이지은', '경기');
INSERT IGNORE INTO memberTbl VALUES ('jbj', '장범준', '천안');

-- 데이터를 집어넣되, 이미 존재하는 데이터만 데이터 갱신을 원하는 경우
INSERT INTO memberTbl VALUES ('ljy', '이지금', '제주');

-- ON DUPLICATE KEY UPDATE 구문을 사용하면 됩니다.
INSERT INTO memberTbl VALUES ('ljy', '이지금', '제주')
	ON DUPLICATE KEY UPDATE name = '이지금', addr = '제주';
   
-- ON DUPLICATE KEY UPDATE를 이용해서 없는 요소로도 테스트해보세요.
INSERT INTO memberTbl VALUES ('asd', '가나다', '미국')
	ON DUPLICATE KEY UPDATE name = '아야어', addr = '충북';

SELECT * FROM memberTbl;


-- [사용자 관리하기]
-- 현재 root 계정은 모든 권한(수정, 삭제, 조회, 변경, 계정생성 등)
-- 을 가지고 있는 계정입니다.
-- 그렇지만 모든 사람이 이 계정을 쓸 필요는 없기도 하고
-- 올 초에도 DB를 날려먹는 사건이 유명 개발사에서도 나온 만큼
-- 일정 규모 이상의 개발사에서는 직급이나 권한별로 DB계정을 나눠서 관리합니다.
-- 이제 root가 아닌 사용자를 만들고, 그 사용자에 대해서
-- 권한부여를 하는 방법과 권한 개념에 대해 알아보겠습니다.

-- workbench에서 계정생성 및 권한부여하기
-- 1. 죄측의 navigator에서 Administration탭을 클릭합니다.
-- 2. Users and Privileges를 클릭합니다.
-- 3. 열리는 화면에서 좌하단 Add Account를 클릭한 다음
-- Login name, password 등을 입력합니다.
-- 4. 우하단 Apply를 누르면 계정 생성이 완료됩니다.
-- 5. Account Limit는 시간당 기능 사용 가능 횟수를 설정합니다.
-- 6. Administrative Roles는 어떤 구문 실행까지 허용할지입니다.
-- 만약 커맨드라인에서 생성한다면
-- CREATE USER manager@'%' IDENTIFIED BY 'mysql';
-- GRANT ALL on *.* TO manager@'%' WITH GRANT OPTION;
-- 위 두 줄을 이용해 처리할 수도 있습니다.

-- manager2 계정을 커맨드라인 환경에서 만들어보세요.

-- 커맨드라인 접속시 mysql -u 계정명 -p 로 연결 가능
-- 접속 후 show databases; 를 이용해 DB목록 확인 가능
-- 계정 목록을 볼 때는
-- 1. use mysql; -- mysql 고유의 DataBase
-- 2. SELECT user, host FROM user; 시 계정 목록 확인 가능 (mysql안에 user라는 테이블)
show databases; -- DB목록 조회
use mysql; -- mysql DB사용
SELECT user, host FROM user; -- 계정 조회 구문

-- 사용중인 DB의 테이블 조회하기
SHOW TABLES;

-- 계정 만들기
-- CREATE USER 아이디@'%' IDENIFIED BY '비밀번호';

-- 계정에 권한 주기
-- GRANT 권한1, 권한2... ON DB명.테이블명 TO 아이디@'%';
-- sqlDB 데이터베이스의 testTbl3 테이블을 SELECT, DELETE하도록
-- 권한을 부여한다면
-- GRANT SELECT, DELETE ON sqlDB.testTbl3 TO staff@'%';
-- WITH GRANT OPTION은 계정설정권한입니다.

-- 권한을 뺏을때는 REVOKE 를 GRANT 대신씁니다.
-- 단, REVOKE는 GRANT의 TO처럼 FROM과 연동해서 씁니다.
-- REVOKE 권한들... ON DB명.테이블명 FROM 계정명;

-- 1번 문제
-- 1. staff2 계정을 커맨드라인에서 생성해주세요.
-- 2. staff2 계정에 sqlDB의 testTbl3,4에 대해서만
-- SELECT, INSERT, UPDATE 권한을 부여합니다.
-- 3. 테스트로 SQLDB testTbl3,4에 각각 로우를 하나씩 추가해주시고, employees.employees는 SELECT로
-- 조회가 안된다는 것을 확인해주세요.
-- 4. staff2 계정의 testTbl4에 대한 모든 권한을 회수해 주세요.
-- 5. staff2 계정 권한이 박탈되었는지 확인까지 해주세요.


-- [조인(JOIN)]
-- 테이블 2개 이상을 합쳐주는 기능
-- 연관된 데이터를 여러 테이블에 나눠담았을때
-- 그것을 다시 재조립해줍니다.
-- 조인 문법
-- SELECT 테이블1.컬럼1, 테이블1.컬럼2
-- 		테이블2.컬럼1, 테이블2.컬럽2...
-- 		FROM 테이블1 조인구문 테이블2
-- 		ON 테이블1.공통컬럼 = 테이블2.공톨컬럼;
-- 		WHERE구문은 ON으로 합쳐진 결과컬럼에 대한 필터링을 해줍니다.
SELECT * FROM buyTbl INNER JOIN userTbl
	ON buyTbl.userID = userTbl.userID;

-- 지금 현재 구매자 정보를 조회하려고 하는데, 필요한 정보는
-- buyTbl의 구매 물품정보 전체에 구매자 정보는 택배를 받기 위해서
-- 이름, 주소, 휴대폰 번호만 있으면 되는 상황입니다.
-- 조언구문을 이용해 필요한 컬럼만 출력하게 살짝 수정해주세요.
SELECT buyTbl.*, userTbl.name, addr, pnum
	FROM buyTbl INNER JOIN userTbl
	ON buyTbl.userID = userTbl.userID;
   
-- FROM 테이블명 별명 을 적을 경우 테이블명을 풀네임으로 적지않고
-- 별명으로 대체할 수 있습니다.
SELECT b.*, u.name, addr, pnum
	FROM buyTbl b INNER JOIN userTbl u
	ON b.userID = u.userID;

-- WHERE절은 먼저 결과가 나온 상태에서 추가 필터링만 담당합니다.
-- 구매물건이 2개 이상인 경우만 남기는 구문
SELECT b.*, u.name, addr, pnum
	FROM buyTbl b INNER JOIN userTbl u
	ON b.userID = u.userID
    WHERE amount > 1;

-- 위 구문에 ORDER BY를 추가해 비싼 가격의 물건부터 나열해주세요.
SELECT b.*, u.name, addr, pnum
	FROM buyTbl b INNER JOIN userTbl u
    ON b.userID = u.userID
    WHERE amount > 1
    ORDER BY b.price DESC;

-- LEFT JOIN, RIGHT JOIN 은 공통데이터가 아닌 데이터도 방향에 따라
-- 출력이 되기 때문에 공통데이터(INNER)가 아닌 데이터(OUTER)까지
-- 출력되는 점을 반영해 OUTER JOIN이라 부릅니다.
-- LEFT OUTER JOIN은 JOIN구문의 왼쪽 테이블 자료는 모두 출력하고
-- 오른쪽 자료 테이블 데이터는 매칭이 되는 데이터만 출력합니다.
-- RIGHT OUTER JOIN은 JOIN구문의 오른쪽테이블 자료는 모두 출력하고
-- 왼쪽 테이블 데이터는 매칭이 되는 데이터만 출력합니다.
SELECT * FROM buyTbl b LEFT OUTER JOIN userTbl u
	ON b.userID = u.userID;
SELECT * FROM buyTbl b RIGHT OUTER JOIN userTbl u
	ON b.userID = u.userID;

-- FULL JOIN은 누락데이터 없이 양쪽 테이블의 모든 자료를 보여줍니다.
-- Oracle에는 FULL JOIN을 구문으로서 지원하지만 MySQL에서는
-- FULL JOIN을 UNION을 이용해 LEFT, RIGHT JOIN결과물을
-- 합쳐서 구현합니다.
-- 이때 접점이 없는 데이터는 반대쪽 데이터를 null로 가집니다.
-- UNION은 위쪽 결과물과 아래쪽 결과물을 합쳐줍니다.
SELECT * FROM buyTbl b LEFT OUTER JOIN userTbl u
	ON b.userID = u.userID 
    UNION
SELECT * FROM buyTbl b RIGHT OUTER JOIN userTbl u
	ON b.userID = u.userID;
    

-- FULL OUTER JOIN 이해를 돕기위한 추가 데이터 설정
CREATE TABLE student(
	name CHAR(3) PRIMARY KEY,
    addr CHAR(2) not null
);
CREATE TABLE membership(
	name CHAR(3) PRIMARY KEY,
    point int not null
);
INSERT INTO student VALUES ('김자바', '경기');
INSERT INTO student VALUES ('박씨샵', '서울');
INSERT INTO student VALUES ('정고랭', '제주');

INSERT INTO membership VALUES ('김자바', 100);
INSERT INTO membership VALUES ('박루비', 200);
INSERT INTO membership VALUES ('정고랭', 50);
DELETE FROM membership;
SELECT * FROM student;
SELECT * FROM membership;

SELECT * FROM student s LEFT OUTER JOIN membership m
	ON s.name = m.name
    UNION
SELECT * FROM student s RIGHT OUTER JOIN membership m
	ON s.name = m.name;

COMMIT;