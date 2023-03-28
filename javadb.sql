-- JAVADB

-- userTBL 테이블 생성
-- no(번호-숫자(4)), username(이름-한글(4)), birthYear(년도-숫자(4)), addr(주소-문자(한글,숫자)), mobile(010-1234-1234)
-- no pk 제약조건 지정 (제약조건명 pk_userTBL)

CREATE TABLE userTBL (
no number(4) constraint pk_userTBL primary key,
username VARCHAR2(12),
birthYear number(4),
addr VARCHAR2(50),
mobile VARCHAR2(13)
);

-- 시퀀스 생성
-- user_seq 생성(기본)

CREATE SEQUENCE user_seq;


-- INSERT (no에는 시퀀스 번호 넣기) 
INSERT INTO userTBL VALUES ( user_seq.NEXTVAL , '홍길동', 2010, '서울시 종로구 100로', '010-1234-1234');

COMMIT; -- DML작업시 한번에 시행되어야 하는 단위, DML작업한후 COMMIT(DB최종반영)해야함