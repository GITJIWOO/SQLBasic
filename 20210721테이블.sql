USE sqldb;

CREATE TABLE JDBCInsert(
	num INT,
    str VARCHAR(10)
);
SELECT * FROM JDBCInsert;
DROP TABLE JDBCInsert;
-- JdbcInsert.java에 DB연동코드를 작성해주세요.