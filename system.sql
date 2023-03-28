-- 대소문자 구별하지 않음 (단, 비밀번호는 구별함) 
-- CREATE : 생성 / ALTER : 수정 / DROP : 삭제, DELETE : 삭제
-- 

-- 사용자 : scott, hr => 데이터베이스 접속하여 데이터를 관리하는 계정
--      테이블, 인덱스, 뷰 등 여러 객체가 사용자별로 생성됨
--      업무에 따라 사용자들을 나눠서 관리

-- 스키마 : 데이터간 관계, 데이터 구조, 제약조건 등 데이터를 관리 저장하기 위해 정의한 데이터베이스 구조의 범위
-- 스키마 == 사용자 (오라클 데이터베이스의 경우에) 


-- 오라클 버전이 변경되면서 사용자 생성 시 C## 문자를 넣어서 만들도록 변경됨 
-- JAVADB => C##JAVADB 로 만들어야 되는데 이 C##을 쓰지않기위해서 사용하는문구
ALTER SESSION SET "_ORACLE_SCRIPT" = true;

-- USER생성은 sys, system만 가능
-- 유저생성 (공간 할당까지) 
-- CREATE USER 사용자이름 IDENTIFIED BY 비밀번호 (비밀번호는 대소문자 구분함!)
 CREATE USER JAVADB IDENTIFIED BY 12345
 DEFAULT TABLESPACE USERS
 TEMPORARY TABLESPACE temp;

ALTER USER JAVADB QUOTA 2M ON USERS;


-- GRANT : 권한 부여 (사용자 생성만 해서는 아무것도 할 수 없음) 
GRANT connect, resource TO javadb;

CREATE USER SCOTT IDENTIFIED BY TIGER
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp;


-- SCOTT에게 부여된 권한
GRANT connect, resource TO SCOTT;
-- 뷰 생성 권한 부여
GRANT CREATE VIEW TO SCOTT;
-- SYNONYM 생성 권한 부여
GRANT CREATE SYNONYM TO SCOTT;
GRANT CREATE PUBLIC SYNONYM TO SCOTT;

SELECT * FROM all_users;

GRANT UNLIMITED TABLESPACE TO SCOTT;

GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO SCOTT IDENTIFIED BY TIGER;
ALTER USER SCOTT DEFAULT TABLESPACE USERS;
ALTER USER SCOTT TEMPORARY TABLESPACE TEMP;



-- test 사용자 생성 / 비번 12345
CREATE USER test IDENTIFIED BY 12345;

-- 접속권한 부여하지 않으면 안됨
-- 권한 권리
-- 1) 시스템 권한
--      사용자생성(create user) / 수정(alter user) / 삭제(drop user)
--      데이터베이스 접근 (create session) / 수정 (alter session) 
--      여러 객체 생성(view, synonym) 및 관리 권한


-- 2) 객체 권한
--      테이블 수정, 삭제, 인덱스 생성, 삽입, 참조, 조회, 수정
--      뷰 삭제, 삽입, 생성, 조회, 수정
--      시퀀스 수정, 조회
--      프로시저, 함수, 패키지 권한


-- 권한 부여
-- create session을 test에게 부여
GRANT CREATE SESSION TO test;

GRANT RESOURCE, CREATE TABLE TO test;

-- 테이블 스페이스 USERS에 권한이 없습니다.
ALTER USER test DEFAULT TABLESPACE USERS;
ALTER USER test TEMPORARY TABLESPACE TEMP;
ALTER USER test QUOTA 2M ON USERS; -- USERS에 공간 설정 

-- SCOTT에게 TEST가 생성한 MEMBER테이블 조회 권한 부여하려면
-- GRANT SELECT ON MEMBER TO SCOTT;

-- 권한 취소
-- REVOKE SELECT, INSERT ON MEMBER FROM SCOTT; 

-- 롤 : 여러 권한들의 모임
-- CONNECT 롤 : CREATE SESSION
-- RESOURCE 롤 : 




-- 사용자 삭제
DROP USER test;
DROP USER test CASCADE; --test와 관련된 모든 객체 같이 삭제 

-- 사용자 생성 + 테이블 스페이스 권한 부여
CREATE USER test2 IDENTIFIED BY 12345
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;
--권한부여
GRANT CONNECT, RESOURCE TO test2;
