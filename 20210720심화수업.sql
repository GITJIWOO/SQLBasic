/* MySQL에서도 프로그래밍이 가능하고
변수나 함수 등을 지정할 수 있습니다.
물론 Java, Python, cpp 등의 프로그래밍과는
달리 제한되는 점이 많지만 이를 활용하는 경우도 종종 있기 때문에
먼저 변수 지정 및 출력부터 진행하겠습니다. */

-- <MySQL에서 변수 사용하기>

USE sqldb;

-- MySQL에서 변수를 지정할 때는 SET @변수명 = 값; 의 문법을 씁니다.
SET @myVar1 = 5;
SET @myVar2 = 3;
SET @myVar3 = 4.25;
SET @myVar4 = '가수의 이름 => ';

-- 출력시는 SELECT @변수명; 을 사용합니다.
SELECT @myVar1;

-- 만약 계산식 등이 있다면 SELECT 구문 싱행 이전에
-- 계산을 모두 마치고 그 결과를 화면에 보여줍니다.
SELECT @myVar2 + @myVar3;

-- SELECT구문이 그렇듯, 콤마(,)를 이용해서
-- 출력 데이터를 여러 개 나열할 수도 있습니다.
SELECT @myVar4, name FROM userTbl;

-- 일반 구문에서 LIMIT에는 변수를 입력해서 쓸 수 없습니다.
SELECT * FROM userTbl LIMIT 5; -- @myVar1;

-- PREPARE 구문
-- PREPARE 구문은 가변적으로 들어갈 문장요소 자리를
-- ?로 구멍을 뚫어놓고, 그 자리를 채우는 방식으로 만듭니다.
-- 사용법은
-- PREPARE 구문이름
-- 		실제 쿼리문;
-- 방식으로 선언하고
-- 호출은 EXECUTE 구문이름 USING 전달변수;
-- 로 호출합니다.
SET @myVar5 = 3;
PREPARE myQuery
	FROM 'SELECT name, height FROM userTbl LIMIT ?';

EXECUTE myQuery USING @myVar5;

-- <MySQL의 데이터 형식과 형변환>
-- 데이터 변환시는 CAST(), CONVERT() 등의 함수를 이용해서
-- 처리합니다. 두 함수의 차이점은 거의 없습니다.
-- 문법
-- CAST(실행문 as 바꿀자료형); SIGNED
-- CONVERT(실행문, 바꿀자료형);
SELECT avg(amount) FROM buyTbl; -- 실수로 나오는 평균구매수

SELECT CAST(avg(amount) as SIGNED INTEGER) as '평균구매' FROM buyTbl;

SELECT CONVERT(avg(amount), SIGNED INTEGER) as '평균구매' FROM buyTbl;

-- CAST를 이용하면 날짜 양식을 통일시킬 수 있습니다.
SELECT CAST('2021$07$20' as DATE);
SELECT CAST('2021/07/20' as DATE);
SELECT CAST('2021%07%20' as DATE);
SELECT CAST('2021@07@20' as DATE);

-- Oracle에서는 sysdate, MySQL에서는 now()를 이용해
-- 현재 시각을 확인할 수 있습니다.
SELECT now();

-- <암시적 형 변환(자동 형 변환)>
SELECT '100' + 200; -- 문자와 숫자 = 정수로 변환
SELECT '100' + '300'; -- 문자와 문자 = 정수로 변환

-- 만약 문자를 붙여서 출력하고 싶다면 CONCAT()을 활용한다.
SELECT CONCAT('100', '200'); -- 100200을 붙여서 출력
SELECT CONCAT(100, '300'); -- 100300을 붙여서 출력

-- CONCAT(문자열1, 문자열2...);
SELECT CONCAT('가', '다', '마', '사');

-- CONCAT_WS(구문자, 문자열1, 문자열2...);
-- 문자열 사이를 구문자를 이용해 붙여줍니다.
SELECT CONCAT_WS('-', '1', '3', '4', '5', '10', '20');

-- 문자는 첫 머리에 숫자가 포함 된 경우 : 첫 글자를 숫자로 변환
-- 문자만 있는 경우 : 0으로 변환
-- 논리식의 경우는 0은 false, 1은 true
SELECT 1 > '2mega'; -- 문자가 2가 됐기 때문에 false
SELECT 1 > 'AMEGA'; -- 문자만 있기 때문에 true

-- <MySQL 내장함수>
-- CONCAT, CAST, CONVER 등과 같이
-- 내부에 이미 선언되어 있어서 바로 호출해 쓸 수 있는
-- 함수들을 보겠습니다.

-- IF 구문
-- 삼항 연산자와 비슷하게 판단합니다.
-- if (수식, 참일 떄 리턴, 거짓일 때 리턴)
SELECT IF(100 > 200, '참입니다', '거짓입니다');

-- IFNULL
-- 수식 1이 NULL이 아니면 수식 1이 반환, 수식 1이 NULL이면
-- 수식 2로 반환한다.
-- IFNULL(수식1, 수식2)
SELECT IFNULL(NULL, '널입니다'), IFNULL(100, '널입니다');

-- NULLIF 구문
-- 수식1과 수식2가 같으면 NULL을 반환하고 다르면 수식2가 반환
-- NULLIF(수식1, 수식2);
SELECT NULLIF(100, 100), NULLIF(200, 100);

-- CASE ~ WHEN ~ ELSE ~ END 구문
	-- SWITCH ~ CASE 문과 비슷하게
	-- 들어온 자료와 일치하는 구간이 있으면 출력
	-- 없을떄는 ELSE쪽 자료를 출력
	-- 단 SQL은 []로 영역을 표시하지 않기 때문에
	-- 구문이 끝나는 지점에 END를 써 줘야 합니다
SELECT CASE 10
		WHEN 1 THEN '일'
		WHEN 5 THEN '오'
		WHEN 10 THEN '십'
        ELSE '모름'
	END as '결과';

-- <문자열 함수>
-- 문자열을 조작하는데 쓰고 활용도가 높은 편입니다.
-- ASCII(문자), CHAR(숫자)를 넣으면
-- 문자는 숫자로, 숫자는 문자로 바뀝니다. 
-- CHAR()는 Workbench상에 버그로 인해 모든 문자가 BLOB으로
-- 표현되고 있습니다.
-- 원래 값을 보려면 BLOB -> 우클릭 -> Open value in viewer -> text탭 선택
SELECT ASCII('8'), CHAR(65);

-- 문자열의 길이를 그때그떄 확인하기 위해서는
-- CHAR_LENGTH(문자열); 을 사용합니다.
-- 이때 결과가 나오는 숫자는 문자열의 길이입니다.
SELECT CHAR_LENGTH('가나다라마바사');
SELECT CHAR_LENGTH('abcdefghijklmn');

-- FORMAT(숫자, 소수점자리);
-- 소수점 아래 몇 자리까지 표현할지 정해줍니다.
SELECT FORMAT(1234.5678901234, 3);

-- BIN(숫자), HEX(숫자), OCT(숫자)
--  2진수	      16진수	    8진수
-- 정수로 10진수 숫자를 바꿔서 표현해줍니다.
SELECT BIN(31), HEX(31), OCT(31);

-- INSERT(기준문자열, 위치, 길이, 삽입할 문자열);
-- 기준 문자열의 위치 ~ 길이 사이를 지워주고, 그 사이에
-- 삽입할 문자열을 새로 넣어줍니다.
SELECT INSERT('abcdefghi', 3, 4, '@@@@');

-- LEFT(문자열, 길이), RIGHT(문자열, 길이);
-- 해당 문자열의 왼쪽, 오른쪽에서 문자열 길이만큼만 남깁니다.
SELECT LEFT('abcdefghi', 3), RIGHT('abcdefghi', 4);

-- UCASE(영문자열), LCASE(영문자열);
-- 소문자를 대문자로, 대문자를 소문자로
SELECT UCASE('abcdEFGH'), LCASE('abcdEFGH');

-- UPPER(문자열), LOWER(문자열); 도 같은 역할을 합니다.
SELECT UPPER('abcdEFGH'), LOWER('abcdEFGH');

-- LPAD(문자열, 길이, 채울문자열), RPAD(문자열, 길이, 채울문자열);
-- 문자열을 길이 만큼 늘려놓고 빈 칸에 채울 문자열로 채웁니다.
SELECT LPAD('이것이', 10, '#-'), RPAD('저것이', 8, '#');

-- LTRIM(문자열), RTRIM(문자열);
-- 문자열의 왼쪽/오른쪽 부분의 공백을 모두 없애줍니다.
-- 단, 가운데 부분의 공백은 사라지지 않습니다.
SELECT LTRIM('        이   것이       '), RTRIM('      저   것이       ');
SELECT '        이것이', '저것이           ';

-- TRIM(문자열), TRIM(방향 '자를문자' FROM '대상문자');
-- TRIM은 기본적으로는 LTRIM + RTRIM형식으로 양쪽의
-- 모든 공백을 다 삭제합니다.
-- 단, 공백이 아닌 특정 문자를 삭제하도록 구문을 지정할 수 있습니다.
SELECT TRIM('        무야호        ');

-- 방향은 BOTH(양쪽), LEADING(왼쪽), TRAILING(오른쪽)
-- 중 하나를 고르면 됩니다.
SELECT TRIM(BOTH 'ㅋ' FROM 'ㅋㅋㅋㅋㅋㅋㄹㅇㅋㅋㅋㅋㅋㅋ');

-- REPEAT(문자열, 횟수);
-- 문자열을 횟수만큼 반복합니다.
SELECT REPEAT('ㅋ', 10);

-- REPLACE(문자열, 원래문자열, 바꿀문자열);
-- 문자열을 찾아 바꿔줍니다.
SELECT REPLACE('JAVA로 작성되었습니다. JAVA', 'JAVA', 'MySQL');

-- REVERSE(문자열);
-- 문자열을 인덱스 역순으로 재배치를 해줍니다.
SELECT REVERSE('MySQL');

-- SPACE(길이);
-- 길이만큼의 공백을 사이에 넣어줍니다.
SELECT CONCAT('이것이', SPACE(50), '저것이');

-- SUBSTRING(문자열, 시작위치, 길이);
-- SUBSTRING(문자열 FROM 시작위치 FOR 길이);
-- 시작위치부터 길이만큼의 문자를 반환합니다.
-- 길이를 생략하고 파라미터를 2개만 주면
-- 시작지점부터 끝까지 모든 문자를 반환합니다.
SELECT SUBSTRING('자바스프링마이에스큐엘', 6, 6);
SELECT SUBSTRING('자바스프링마이에스큐엘' FROM 6 FOR 6);

-- <SQL 프로그래밍>
-- SQL에서도 변수선언이 되는 것은 봤었지만
-- 심지어 프로그래밍을 진행할 수도 있습니다.
-- 문법)
-- DLIMITER $$ -- 시작지점
-- CREATE PROCEDURE 프로시저이름()
-- BEGIN -- 본 실행코드는 BEGIN 아래에 작성합니다.
--     실행코드..
-- END $$
-- DELIMITER ;

-- 선언해둔 프로시저는
-- CALL 프로시저명(); 으로 호출이 가능합니다.

-- IF ~ ELSE 문을 프로시저로 작성
DELIMITER $$
CREATE PROCEDURE ifProc()
BEGIN
	DECLARE var1 INT;
    SET var1 = 100;
    IF var1 = 100 THEN
		SELECT '100이 맞습니다.';
	ELSE
		SELECT '100이 아닙니다.';
	END IF;
END $$
DELIMITER ;

CALL ifProc();

/*
DELIMITER $$ -- 여기서 부터 프로시저 선언이 시작됨
CREATE PROCEDURE ifProc() -- ifProc() 프로시저 생성
BEGIN -- ifProc() 호출시 실행문 시작지점
	DECLARE var1 INT; -- INT타입 var1 내부에서는 @안붙임
    SET var1 = 100; -- 프로시저 내부 SET은 값 대입용도

    IF var1 = 100 THEN -- 만약 var1변수가 100이라면
		SELECT '100이 맞습니다.';
	ELSE
		SELECT '100이 아닙니다.';
	END IF; -- IF문의 종료지점은 END IF; 로 마무리
END $$ -- BEGIN의 종료는 END $$ 로 마무리
DELIMITER ; -- 프로시저의 종료는 DELIMITER ; 로 마무리
*/

-- 테이블 호출 구문을 프로시저로 만들어보겠습니다.
USE employees;

DELIMITER $$
CREATE PROCEDURE getEmp()
BEGIN
    SELECT * FROM employees LIMIT 10;
END $$
DELIMITER ;

CALL getEmp(); -- 프로시저 호출

/*
DELIMITER $$ -- 프로시저 관련 시작부분
CREATE PROCEDURE getEmp() -- 프로시저명 선언
BEGIN -- 내부 실행문 시작
    SELECT * FROM employees LIMIT 10; -- 호출 시 실행구문
END $$ -- 내부 실행문 끝
DELIMITER ; -- 프로시저 관련 종료 부분
*/



-- USE sqldb를 해주시고
-- userTbl에서 name, addr, height을 조회하는
-- 구문을 프로시저로 선언한 다음 호출까지 해 보세요.
-- 프로시저명은 getUser()입니다.
USE sqldb;

DELIMITER $$
CREATE PROCEDURE getUser()
BEGIN
	SELECT name, addr, height FROM userTbl;
END $$
DELIMITER ;

CALL getUser();

-- 프로시저를 활용해 employees 테이블의 10001번 직원의
-- 입사일이 5년이 넘었는지 여부를 확인해보겠습니다.
-- hire_date 컬럼의 DATE 자료를 이용해 판단합니다.
USE employees;

DELIMITER $$
CREATE PROCEDURE getFive()
BEGIN
	DECLARE hireDATE DATE; # 입사일을 받아옴
    DECLARE todayDATE DATE; # 오늘 날짜를 받아옴
    DECLARE days INT; # 오늘 날짜 - 입사일 해서 경과일수
    SELECT hire_date INTO hireDATE
		FROM employees WHERE emp_no = 10001;
	# hire_date INTO hireDATE는
    # 쿼리문의 결과로 나온 값을 hireDATE 변수에 대입함
	SET todayDATE  = CURRENT_DATE(); # 오늘날짜 함수
    SET days = DATEDIFF(todayDATE, hireDATE);
    # 경과 일수 구하는 함수
    IF (days/365) >= 5 THEN #입사 후 5년 경과시
		SELECT CONCAT('입사한지', days, '일이 경과했습니다.');
	ELSE
		SELECT CONCAT('5년 미만이고, ', days, '일째 근무중입니다.');
	END IF;
END $$
DELIMITER ;

CALL getFive();

-- IF THEN 구문 이후에 ELSE가 아닌 ELSEIF THEN을 붙이면
-- 두 번쨰, 세 번쨰 조건... 을 줄줄이 붙일 수 있습니다.
-- getScore 프로시저를 생성해주세요
-- 변수로 point(int)는 점수를 입력받는데 77점을 주시고
-- 변수로 ranking(char)는 90점 이상이면 'A'를 저장받고
-- 80점 이상이면 'B', 70점 이상이면 'C', 60점 이상이면 'D'
-- 그 이하 점수는 'F'를 저장받습니다.
-- IF문 종료 후 SELECT 문과 CONCAT()을 활용해
-- 취득점수 : 77, 학점 : C 라는 구문이 콘솔에 띄워지도록
-- 프로시저를 생성해주시고 호출까지 해 주세요.
USE sqldb;

DELIMITER $$
CREATE PROCEDURE getScore()
BEGIN
	DECLARE point INT;
    DECLARE ranking CHAR(1);
    SET point = 77;
    IF point >= 90 THEN
		SET ranking = 'A';
	ELSEIF point >= 80 THEN
		SET ranking = 'B';
	ELSEIF point >= 70 THEN
		SET ranking = 'C';
	ELSEIF point >= 60 THEN
		SET ranking = 'D';
	ELSE
		SET ranking = 'F';
	END IF;
	SELECT CONCAT('취득점수 : ', point, ' 학점 : ', ranking) as '성적';
END $$
DELIMITER ;

CALL getScore();

-- getScore2() 프로시저는
-- CASE문을 이용해 작성하도록 해보겠습니다.
-- 기본적인 변수나 점수대는 모두 getScore() 프로시저에
-- 요구한 사항을 그대로 따라가 주시면 됩니다.
-- CASE
--     WHEN 조건식 THEN
--         실행문;
-- 형태로 작성시 범위조건이 IF문 처럼 적용됩니다.
-- 제일 마지막에 ELSE문을 사용할 수 있습니다.
-- END CASE; 로 닫습니다.
-- getScore()를 CASE문을 활용해 구현해주세요.
DELIMITER $$
CREATE PROCEDURE getScore2()
BEGIN
	DECLARE point INT;
    DECLARE ranking CHAR(1);
    SET point = 77;
    CASE
		WHEN point >= 90 THEN
			SET ranking = 'A';
        WHEN point >= 80 THEN
			SET ranking = 'B';
        WHEN point >= 70 THEN
			SET ranking = 'C';
        WHEN point >= 60 THEN
			SET ranking = 'D';
        ELSE
			SET ranking = 'F';
	END CASE;
	SELECT CONCAT('취득점수 : ', point, ' 학점 : ', ranking) as '성적';
END $$
DELIMITER ;

DROP PROCEDURE getScore2;

CALL getScore2();


-- SQL에서도 WHILE 문을 작성해서 쓸 수 있습니다.
-- WHILE (조건식) DO
--     실행문...
-- END WHILE;
-- 형태로 작성하며, 자바에서 그랬듯, 조건식이 특정 조건을
-- 만족시키지 못하면 탈출하도록 사용합니다.
DELIMITER $$
CREATE PROCEDURE whileProc()
BEGIN
	DECLARE i INT; # i변수 값으로 반복횟수 조절
    SET i = 1;
    WHILE (i <= 30) DO
		SET i = (i + 1);
	END WHILE;
    SELECT i;
END $$
DELIMITER ;

CALL whileProc(); 

-- 3 + 6 + 9 + 12 ... 와 같은 방식으로
-- 3부터 99까지 더했을 때 총합이 몇인지 SELECT문으로
-- 화면에 띄워주는 프로시저를 작성하고 호출해주세요.
DELIMITER $$
CREATE PROCEDURE whileProc2()
BEGIN
	DECLARE number INT;
	DECLARE result INT;
    SET number = 0;
    SET result = 0;
    WHILE (number < 100) DO
        SET result = result + number;
		SET number = number + 3;
	END WHILE;
    SELECT result;
END $$
DELIMITER ;

CALL whileProc2();


-- <테이블 심화>
-- 1. CREATE TABLE 구문을 이용해 생성
-- 2. Workbench의 DATABASE Tables 탭 우클릭 후 CREATE TABLE 클릭

-- 테이블을 수정 할 때는 ALTER TABLE 구문을 이용합니다.
-- 컬럼 추가
-- ALTER TABLE 테이블명 ADD 컬렴명 자료형(크기)
--     DEFAULT 디폴트값;
-- 기존 테이블의 가장 마지막 컬럼 다음 위치에 생성됩니다.
-- job 컬럼을 wbtbl에 추가해보겠습니다.
-- job 컬럼은 VARCHAR(15) 자료를 저장받고
-- 아무것도 입력받지 않았을 때, '0'을 입력받습니다.(디폴트 값 설정)
ALTER TABLE wbtbl ADD job VARCHAR(15)
	DEFAULT '0';

-- 컬럼 삭제
-- ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
-- 테이블 생성시 컬럼삭제불가 제약조건을 걸고 만드는 경우가 있으면
-- 이런 컬럼은 바로 삭제가 불가능합니다.
-- money 컬럼을 삭제해주세요.
ALTER TABLE wbtbl DROP COLUMN money;

-- 컬럼 변경
-- ALTER TABLE 테이블명 CHANGE COLUMN 컬럼명 바꿀이름
--     자료형(크기) 기타 조건들...;
-- job 컬럼의 이름을 ujob으로, 자료형을 VARCHAR(20)으로
-- default 값을 '1'로 바꿔보겠습니다.
-- 이름을 변경하고 싶지 않을때는 컬럼명과 바꿀 이름을 같은 이름으로 주면 됩니다.
ALTER TABLE wbtbl CHANGE COLUMN job ujob VARCHAR(20)
	DEFAULT '1';


-- <제약조건>
-- 컬럼에 붙는 조건으로, 데이터의 무결성을 보장하기 위해
-- 추가적으로 붙이는 제한을 의미합니다.
-- 제약조건이 붙은 컬럼에는 제약조건을 만족시키는 데이터만
-- 집어넣을 수 있기 때문에 개발자가 의도한 데이터만
-- 들어오는 장점이 있습니다.

-- 제약조건 확인
-- DESC, DESCRIBE
-- DESC DB명.테이블명;
DESC employees.employees;


-- 제약조건 추가
-- PRIMARY KEY
-- ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건 명칭 PRIMARY KEY(컬럼이름);
CREATE TABLE testTbl5 (
	num INT,
    name VARCHAR(5)
);
ALTER TABLE testTbl5 ADD CONSTRAINT pk_tbl5num PRIMARY KEY(num);

DESC testTbl5;

-- FOREIGN KEY
-- ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명
-- FOREIGN KEY(컬럼명) REFERENCES 연결테이블(PK컬럼);
CREATE TABLE testTbl6 (
	fnum INT NOT NULL,
    num INT PRIMARY KEY,
    id VARCHAR(5)
);
ALTER TABLE testTbl6 ADD CONSTRAINT fk_fnum
FOREIGN KEY(fnum) REFERENCES testTbl5(num);

DESC testTbl6;

-- 제약조건 삭제
-- 일부 제약조건은 구문이 조금 다릅니다.
-- PRIMARY KEY
-- ALTER TABLE 테이블명 DROP PRIMARY KEY;
ALTER TABLE testTbl5 DROP PRIMARY KEY;

-- FOREIGN KEY
-- ALTER TABLE 테이블명 DROP FOREIGN KEY 제약조건명;
ALTER TABLE testTbl6 DROP FOREIGN KEY fk_fnum;

-- 프로시저는 그냥 호출할 수도 있지만, 파라미터를 입력받게
-- 처리해야 훨씬 사용성이 높아집니다.
-- 따라서 프로시저의 성질에 따라 파라미터를 활용할 수 있도록
-- 파라미터를 추가한 프로시저를 정의해보겠습니다.
-- 파라미터 지정은
-- CREATE PROCEDURE 프로시저명(
--             IN 파라미터명 자료형(크기)
-- )
-- 와 같은 형식으로 지정할 수 있습니다.
-- 예시 프로시저
DELIMITER $$
CREATE PROCEDURE singerAge(
	IN userName VARCHAR(10)
)
BEGIN
	DECLARE bYear INT;
    SELECT birthYear INTO bYear FROM userTbl
		WHERE name = userName;
	IF (bYear >= 1980) THEN
		SELECT '젊은 편입니다.' as '결과';
	ELSE
		SELECT '나이가 좀 있습니다.' as '결과';
	END IF;
END $$
DELIMITER ;

CALL singerAge('이승기');

-- 어제 작성한 employees.getFive() 프로시저를
-- 사원번호를 입력받아서 입력받은 사원의 근속년수가
-- 5년이 넘는지 안넘는지 판단하는 프로시저로 고쳐서
-- getFive2() 로 만들어주시고 호출도 해 주세요.
USE employees;

DESC employees;
DELIMITER $$
CREATE PROCEDURE getFive2(
	IN number INT
)
BEGIN
	DECLARE hireDATE DATE;
    DECLARE todayDATE DATE;
    DECLARE days INT;
    SELECT hire_date INTO hireDATE
		FROM employees WHERE emp_no = number;
	SET todayDATE  = CURRENT_DATE();
    SET days = DATEDIFF(todayDATE, hireDATE);
    IF (days / 365) >= 5 THEN
		SELECT days as '근속 일수';
	ELSE
		SELECT '근속 년수가 5년보다 적습니다.';
	END IF;
END $$
DELIMITER ;

CALL getFive2(10001);

-- <트리거>
-- 트리거는 특정 테이블에 명령이 내려지면 자동으로
-- 연동된 명령을 수행하도록 구문을 걸어주는 것입니다.
-- 예를들어 회원이 탈퇴를 했다고 가정했을 때
-- 탈퇴한 회원을 DB에서 바로 삭제하는게 아니라
-- 탈퇴보류회원 테이블에 INSERT를 해 둔다던지
-- 수정이 일어났을 때 수정 전 내역을 따로 다른 테이블에
-- 저장해 둔다던지 특정 테이블을 대상으로 실행되는 구문 이전이나
-- 혹은 이후에 추가로 실행할 명령어를 지정해두는 것입니다.

-- 문법은 프로시저와 유사하나, 차이점이 조금 있습니다.
-- 문법)
-- DELIMITER //
-- CREATE TRIGGER 트리거명
--         실행시점 실행로직
--         ON 트리거부착테이블
--         FOR EACH ROW
-- BEGIN
--     트리거 실행시 작동코드
-- END //
-- DELIMITER ;

-- 트리거 테스트용 테이블
CREATE TABLE gameList (
    id INT,
    gamename VARCHAR(10)
);
INSERT INTO gameList VALUES(1, '바람의 나라');
INSERT INTO gameList VALUES(2, '스타크래프트');
INSERT INTO gameList VALUES(3, '롤');
SELECT * FROM gameList;

-- 트리거를 gameList 테이블에 부착합니다.
DELIMITER //
CREATE TRIGGER testTrg
    AFTER DELETE
    ON gameList
    FOR EACH ROW
BEGIN
    SET @msg = '게임이 삭제되었습니다.';
END //
DELIMITER ;

SELECT @msg = '';
INSERT INTO gameList VALUES(4, '배틀 그라운드');
SELECT @msg;

SET sql_safe_updates = 0;
UPDATE gameList SET gamename = '리그 오브 레전드'
    WHERE id = 3;
SELECT @masg;
DELETE FROM gameList WHERE id = 4;
SELECT @msg;


COMMIT;