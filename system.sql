-- 대소문자 구별하지 않음 (단, 비밀번호는 구별함) 
-- CREATE : 생성 / ALTER : 수정 / DROP : 삭제, DELETE : 삭제
-- 
-- 오라클 버전이 변경되면서 사용자 생성 시 C## 문자를 넣어서 만들도록 변경됨 
-- JAVADB => C##JAVADB 로 만들어야 되는데 이 C##을 쓰지않기위해서 사용하는문구
ALTER SESSION SET "_ORACLE_SCRIPT" = true;

-- USER생성은 sys, system만 가능
-- 유저생성 (공간 할당까지) 
-- CREATE USER 사용자이름 IDENTIFIED BY 비밀번호
 CREATE USER JAVADB IDENTIFIED BY 12345
 DEFAULT TABLESPACE USERS
 TEMPORARY TABLESPACE temp;

-- GRANT : 권한 부여 (사용자 생성만 해서는 아무것도 할 수 없음) 
GRANT connect, resource TO javadb;

CREATE USER scott IDENTIFIED BY tiger
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp;

GRANT connect, resource TO scott;

SELECT * FROM all_users;

GRANT UNLIMITED TABLESPACE TO SCOTT;

GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO SCOTT IDENTIFIED BY TIGER;
ALTER USER SCOTT DEFAULT TABLESPACE USERS;
ALTER USER SCOTT TEMPORARY TABLESPACE TEMP;