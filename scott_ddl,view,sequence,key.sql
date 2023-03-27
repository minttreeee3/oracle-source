
-- DDL : 데이터 정의어(데이터 베이스 객체 생성, 수정, 삭제)

-- 1. 테이블 생성
-- CREATE TABLE 테이블명( 
--    열이름1 자료형,
--    열이름2 자료형,
--    열이름3 자료형,
-- );

-- 테이블 생성 / 열이름 지정 규칙
-- 1) 테이블 이름은 문자로 시작
-- 2) 테이블 이름은 30BYTE 이하
-- 3) 같은 사용자 소유의 테이블 이름은 중복될 수 없다 
-- 4) 테이블 명에 사용할수있는 특수문자는 $, #, _ 
-- 5) SQL 키워드는 테이블명에 사용할 수 없음 (ex SELECT, FROM, WHERE...) 



-- 자료형

-- 1) 문자
-- VARCHAR2(길이) : 가변 길이 문자열 데이터 저장 (최대 4000BYTE)   
-- CHAR(길이) : 고정 길이 문자열 데이터 저장
-- NVARCHAR2(길이) : 가변 길이(unicode에 맞춘 데이터 저장) 
-- ex)  name varchar2(10) : 영어는 10자, 한글은 3자까지 입력가능
--      name nvarchar2(10) : 영어 10자, 한글 10자까지 입력가능

-- 2) 숫자
-- NUMBER(전체자릿수, 소수점이하자릿수) 

-- 3) 날짜
-- DATE : 날짜, 시간 저장 
-- TIMESTAMP

-- 4) 기타
-- BLOB : 대용량 이진 데이터 (ex이미지,동영상) 저장
-- CLOB : 대용량 텍스트 데이터 저장

create table emp_ddl (
    empno    NUMBER(4), --사번을 쵱 4자리 지정
    ename    VARCHAR2(10), --사원명을 총 10byte 지정
    job      VARCHAR2(9), --직무 총 9byte 지정
    mgr      NUMBER(4), --매니저번호
    hiredate DATE,  --날짜,시간 저장
    SAL number(7,2),  --급여를 전체자릿수 7자리, 소수점2자리 지정
    comm NUMBER(7, 2), 
    deptno number(2)
);

desc emp_ddl;

    
-- 2. 테이블 수정
-- 1) 열 추가 : ADD
ALTER TABLE EMP_TEMP2 ADD HP VARCHAR2(20);

-- 2) 열 이름 변경 : RENAME
ALTER TABLE EMP_TEMP2 RENAME COLUMN HP TO TEL; 

-- 3) 열 자료형(길이) 변경 : MODIFY
ALTER TABLE EMP_TEMP2 MODIFY EMPNO NUMBER(5);

-- 4) 특정 열을 삭제 : DROP
ALTER TABLE EMP_TEMP2 DROP COLUMN TEL;




-- 3. 테이블 삭제
DROP TABLE EMP_RENAME;


-- 테이블 명 변경
RENAME EMP_TEMP2 TO EMP_RENAME;

-- 테이블 데이터 전체 삭제
DELETE FROM EMP_RENAME;
SELECT * FROM EMP_RENAME;
ROLLBACK;

-- DDL구문은 ROLLBACK안됨 



-- [실습1]
CREATE TABLE MEMBER (
ID CHAR(8),
NAME VARCHAR2(10),
ADDR VARCHAR2(50),
NATION CHAR(4),
EMAIL VARCHAR2(50),
AGE NUMBER(7,2)
);

-- [실습2]
ALTER TABLE MEMBER ADD BIGO VARCHAR2(20);

ALTER TABLE MEMBER MODIFY BIGO VARCHAR2(30);

ALTER TABLE MEMBER RENAME COLUMN BIGO TO REMARK;

DROP TABLE MEMBER;



CREATE TABLE MEMBER (
ID CHAR(8),
NAME VARCHAR2(10),
ADDR VARCHAR2(50),
NATION CHAR(20),
EMAIL VARCHAR2(50),
AGE NUMBER(7,2)
);

INSERT INTO MEMBER VALUES('hong1234', '홍길동', '서울시 구로구 개봉동', '대한민국', 'hong123@naver.com', 25, null);


-- 데이터 베이스 객체
-- 테이블, 인덱스, 뷰, 데이터 사전, 시퀀스, 시노님, 프로시저, 함수, 패키지, 트리거
-- 생성: CREATE, 수정: ALTER, 삭제: DROP

-- 인덱스 : 더 빠른 검색을 도와줌
-- 인덱스 : 사용자가 직접 특정 테이블 열에 지정 가능
--          기본키(혹은 UNIQUE KEY)를 생성하면 인덱스로 지정

-- CREATE INDEX 인덱스이름 ON 테이블명(인덱스로 사용할 열이름)

-- EMP 테이블의 SAL열을 인덱스로 지정
CREATE INDEX IDX_EMP_SAL ON EMP(SAL);

-- SELECT : 검색방식
-- FULL SCAN 
-- INDEX SCAN 

SELECT * FROM EMP WHERE EMPNO = 7900;

-- 인덱스 삭제
DROP INDEX IDX_EMP_SAL;

-- VIEW : 가상 테이블
-- 편리성 : SELECT 문의 복잡도를 완화하기 위해 
-- 보완성 : 테이블의 특정 열을 노출하고 싶지 않을 때 

-- CREATE[OR REPLACE] [FORCE | NOFORCE] VIEW 뷰이름(열이름1, 열이름2...) 
-- AS (저장할 SELECT 구문) 
-- [WITH CHECK OPTION]
-- [WITH READ ONLY]

-- 뷰 생성엔 권한이 필요함 (SYSTEM에서 GRANT) 
-- SELECT EMPNO, ENAME, JOB, DEPTNO FROM EMP WHERE DEPTNO=20 뷰로 생성
CREATE VIEW VM_EMP20
AS (SELECT EMPNO, ENAME, JOB, DEPTNO FROM EMP WHERE DEPTNO=20);


-- 서브쿼리를 사용
SELECT * 
FROM(SELECT EMPNO, ENAME, JOB, DEPTNO FROM EMP WHERE DEPTNO=20);

-- 뷰 사용
SELECT *
FROM VM_EMP20;

-- 뷰 삭제
DROP VIEW VM_EMP20;


CREATE VIEW VM_EMP_READ
AS SELECT EMPNO, ENAME, JOB FROM EMP WITH READ ONLY;

-- VIEW에 INSERT작업
INSERT INTO VM_EMP20 VALUES(8888, 'KIM', 'SALES', 20);
-- 원본까지 변경됨
SELECT * FROM EMP;

--읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.
INSERT INTO VM_EMP_READ VALUES(9999, 'KIM', 'SALES');

-- 인라인 뷰 : 일회성으로 만들어서 사용하는 뷰
-- ROWNUM : 조회된 순서대로 일련번호 매김
SELECT ROWNUM, E.*
FROM EMP E;

-- 급여높은 순서대로 번호붙여서 조회
SELECT ROWNUM, E.*
FROM ( SELECT * FROM EMP E ORDER BY SAL DESC) E;

-- 급여 높은 상위 3명 조회
SELECT ROWNUM, E.*
FROM ( SELECT * FROM EMP E ORDER BY SAL DESC) E
WHERE ROWNUM <=3;


-- 시퀀스 : 규칙에 따라 순번 생성
-- CREATE SEQUENCE 시퀀스이름; (설정안하는 것들은 다 기본값으로 세팅)
-- CREATE SEQUENCE 시퀀스명
-- [INCREMENT BY 숫자]   --기본값1
-- [START WITH 숫자]     --기본값1
-- [MAXVALUE 숫자 | NOMAXVALUE]
-- [MINVALUE 숫자 | NOMINVALUE]
-- [CYCLE | NOCYCLE]   -- CYCLE의 경우 MAXVALUE에 값이 다다르면 시작값부터 다시 시작
-- [CACHE 숫자 | NOCACHE] --시퀀스가 생성할 번호를 미리 메모리에 할당해 놓음 (기본 CACHE 20)

CREATE TABLE DEPT_SEQUENCE AS SELECT * FROM DEPT WHERE 1<>1;

CREATE SEQUENCE SEQ_DEPT_SEQUENCE
INCREMENT BY 10
START WITH 10
MAXVALUE 90
MINVALUE 0 
NOCYCLE
CACHE 2;

-- 시퀀스 사용 : 시퀀스이름.CURVAL(마지막으로 생성된 시퀀스 조회), 시퀀스이름.NEXTVAL(시퀀스 생성)

-- 부서번호 입력시 시퀀스 사용
INSERT INTO DEPT_SEQUENCE (
DEPTNO, DNAME, LOC
) VALUES (
SEQ_DEPT_SEQUENCE.NEXTVAL,
'DATABASE',
'SEOUL'
);
--최대값 90까지가능 (9번 INSERT가능) -넘으면 오류남

--시퀀스 삭제
DROP SEQUENCE SEQ_DEPT_SEQUENCE;

CREATE SEQUENCE SEQ_DEPT_SEQUENCE
INCREMENT BY 3
START WITH 10
MAXVALUE 99
MINVALUE 0 
NOCYCLE
CACHE 2;

SELECT * FROM DEPT_SEQUENCE;
--시퀀스 SEQ_DEPT_SEQUENCE.NEXTVAL DXCEEDS MAXVALUE : NOCYCLE 옵션으로 생성했기땜에 번호가 순환되지않음

-- SELECT SEQ_DEPT_SEQUENCE.CURVAL;

-- SYNONYMS(동의어) : 테이블, 뷰, 시퀀스 등 객체 이름 대신 사용할수있는 다른이름을 부여하는 객체
-- 권한부여필요함
-- EMP 테이블의 별칭을 E로 지정
CREATE SYNONYM E FOR EMP;

-- PUBLIC : 동의어를 데이터베이스 내 모든 사용자가 사용할 수 있도록 설정 / 안붙이면 나만(여기선 SCOTT만) 사용
-- CREATE [PUBLIC] SYNONYM E FOR EMP;

SELECT * FROM EMP;
SELECT * FROM E;

DROP SYNONYM E;



-- [실습1]
CREATE TABLE EMPIDX AS SELECT * FROM EMP;
-- EMPIDX테이블의 EMPNO열에 인덱스생성
CREATE INDEX IDX_EMPIDX_EMPNO ON EMPIDX(EMPNO);
-- 데이터 사전 뷰를 통해 인덱스 확인
SELECT * FROM USER_INDEXES;

-- [실습2] 
-- 급여가 1500초과인 사원들만 출력하는 뷰를 생성
CREATE VIEW EMPIDX_OVER15K
AS (SELECT EMPNO, ENAME, JOB, DEPTNO, SAL, COMM FROM EMPIDX WHERE SAL>1500);

SELECT * FROM EMPIDX_OVER15K;

-- [실습3]
-- DEPTSEQ 테이블 작성
CREATE TABLE DEPTSEQ AS SELECT * FROM DEPT;

-- 시퀀스생성
CREATE SEQUENCE SEQ_DEPT
START WITH 1
INCREMENT BY 1
MAXVALUE 99
MINVALUE 1
NOCYCLE
NOCACHE;


-- 제약조건 : 테이블의 특정 열에 지정
--          NULL 허용/불허용, 유일한 값, 조건식을 만족하는 데이터만 입력 가능...
--          데이터의 무결성(데이터 정확성, 일관성 보장) 유지 => DML 작업시 지켜야함
--          영역 무결성, 개체 무결성, 참조 무결성
--          테이블 생성 시 제약조건 지정, OR 생성 후에 ALTER 를 통해 추가, 변경 가능

-- 1) NOT NULL : 빈값 허용 불가
CREATE TABLE TABLE_NOTNULL (
LOGIN_ID VARCHAR2(20) NOT NULL,
LOGIN_PWD VARCHAR2(20) NOT NULL,
TEL VARCHAR2(20)
);

INSERT INTO TABLE_NOTNULL(LOGIN_ID, LOGIN_PWD) VALUES('hong123', 'hong123');


--INSERT INTO TABLE_NOTNULL(LOGIN_ID, LOGIN_PWD, TEL) VALUES('hong123', null, '01011111111');

-- 제약조건 전체 조회
select * FROM USER_CONSTRAINTS;

-- 제약조건 + 제약조건 명 지정
CREATE TABLE TABLE_NOTNULL2 (
LOGIN_ID VARCHAR2(20) CONSTRAINT TBLNN2_LOGIN_NN NOT NULL,
LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLNN2_LOGPWD_NN NOT NULL,
TEL VARCHAR2(20)
);


-- 생성한 테이블에 제약조건 추가
-- 이미 들어가있는 데이터도 체크대상임
UPDATE TABLE_NOTNULL
SET TEL = '01012345661'
WHERE LOGIN_ID = 'hong123';

ALTER TABLE TABLE_NOTNULL MODIFY(TEL NOT NULL);
-- 제약조건명 지정하면서 변경 
ALTER TABLE TABLE_NOTNULL2 MODIFY(TEL CONSTRAINT TBLNN2_TEL_NN NOT NULL);

-- 제약조건명 변경
ALTER TABLE TABLE_NOTNULL2 RENAME CONSTRAINT TBLNN2_TEL_NN TO TBLNN3_TEL_NN;

-- 제약조건명 삭제
ALTER TABLE TABLE_NOTNULL2 DROP CONSTRAINT TBLNN3_TEL_NN; 



-- 2) UNIQUE : 중복되지 않는 값
--              아이디, 전화번호
CREATE TABLE TABLE_UNIQUE (
LOGIN_ID VARCHAR2(20) UNIQUE,
LOGIN_PWD VARCHAR2(20) NOT NULL,
TEL VARCHAR2(20)
);

-- ID중복되면 : 무결성 제약 조건(SCOTT.SYS_C008362)에 위배됩니다 / 근데 NULL은 못막음 
INSERT INTO TABLE_UNIQUE(LOGIN_ID, LOGIN_PWD, TEL) 
VALUES('hong123', 'hong123', '01011111111');


-- 테이블 생성 제약조건 지정, 변경, 삭제 NOT NULL 형태와 동일함


-- 3) PRIVARY KEY (PK) : UNIQUE + NOT NULL 
CREATE TABLE TABLE_PRIMARY (
LOGIN_ID VARCHAR2(20) PRIMARY KEY,
LOGIN_PWD VARCHAR2(20) NOT NULL,
TEL VARCHAR2(20)
);

-- PRIMARY KEY ==> INDEX까지 자동생성됨

-- 중복X, NULL도 X 
INSERT INTO TABLE_PRIMARY (LOGIN_ID, LOGIN_PWD, TEL) 
VALUES('hong123', NULL, '01011115555');




-- 4) 외래키 : FOREIGN KEY(FK) : 다른 테이블 간 관계를 정의하는 데 사용
--          특정 테이블에서 PRIMARY KEY 제약조건을 지정한 열을 다른 테이블의 특정 열에서 참조 

-- 사원 추가 시 부서번호 입력을 해야함 => DEPT테이블의 DEPTNO (기본키로 잡혀있음) 만 삽입 =>외래키로 가져옴 

--부모 테이블
CREATE TABLE DEPT_FK (
DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK PRIMARY KEY,
DNAME VARCHAR2(14),
LOC VARCHAR2(13)
);

--자식 테이블
-- REFERENCES 참조할테이블명(참조할열) : 외래키 지정
CREATE TABLE EMP_FK(
EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
ENAME VARCHAR2(10),
JOB VARCHAR2(9),
DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO)
);

-- 외래키 제약조건
-- 부모 테이블 데이터부터 INSERT해야함

-- 삭제시에는
-- 자식테이블 데이터 먼저 삭제, 그다음에 부모테이블 데이터 삭제해야함

INSERT INTO DEPT_FK VALUES(10, 'DATABASE', 'SEOUL');

INSERT INTO EMP_FK VALUES(1000, 'TEST', 'SALES', 10);

--  DELETE FROM DEPT_FK WHERE DEPTNO=10;

-- 외래키 제약조건 옵션
-- ON DELETE CASCADE : 부모가 삭제되면 부모를 참조하는 자식 레코드도 같이 삭제 
-- ON DELETE SET NULL : 부모가 삭제되면 부모를 참조하는 자식레코드의 값을 NULL로 변경

--부모 테이블
CREATE TABLE DEPT_FK2 (
DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK2 PRIMARY KEY,
DNAME VARCHAR2(14),
LOC VARCHAR2(13)
);
--자식 테이블
CREATE TABLE EMP_FK2 (
EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK2 PRIMARY KEY,
ENAME VARCHAR2(10),
JOB VARCHAR2(9),
DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK2 REFERENCES DEPT_FK(DEPTNO) ON DELETE CASCADE
);

INSERT INTO DEPT_FK2 VALUES(10, 'DATABASE', 'SEOUL');
INSERT INTO EMP_FK2 VALUES(1000, 'TEST', 'SALES', 10);
-- ON DELETE CASCADE 써서 오류안나고 같이삭제됨
DELETE FROM DEPT_FK2 WHERE DEPTNO=10;



-- 5) CHECK : 열에 지정할 수 있는 값의 범위 또는 패턴 지정

-- 비밀번호는 3자리보다 커야한다
CREATE TABLE TABLE_CHECK (
LOGIN_ID VARCHAR2(20) PRIMARY KEY,
LOGIN_PWD VARCHAR2(20) CHECK (LENGTH(LOGIN_PWD) >3),
TEL VARCHAR2(20)
);

INSERT INTO TABLE_CHECK VALUES('TEST', '1234', '01030004000');




-- 6) DEFAULT : 기본값 지정
CREATE TABLE TABLE_DEFAULT (
LOGIN_ID VARCHAR2(20) PRIMARY KEY,
LOGIN_PWD VARCHAR2(20) DEFAULT '1234',
TEL VARCHAR2(20)
);

INSERT INTO TABLE_DEFAULT VALUES('TEST', NULL, '01030004000');
INSERT INTO TABLE_DEFAULT(LOGIN_ID, TEL) VALUES('TEST1', '01030004000');


