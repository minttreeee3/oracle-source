-- PL/SQL : SQL만으로는 구현이 어렵거나 구현 불가능한 작업을 수행하기 위해 오라클에서 제공하는 프로그래밍 언어

-- 실행결과를 화면에 출력시켜줌
SET SERVEROUTPUT ON;

-- 블록 : DECLARE ~ BEGIN ~ END 
BEGIN
    dbms_output.put_line('Hello PL/SQL');
END;
/

-- 변수 선언
DECLARE
    v_empno NUMBER(4) := 7788;
    v_ename VARCHAR2(10);
BEGIN
    v_ename := 'SCOTT';
    dbms_output.put_line('V_ENAME : ' || v_ename);
    dbms_output.put_line('V_EMPNO : ' || v_empno);
END;
/


-- 상수 선언
DECLARE
    v_tax CONSTANT NUMBER(4) := 7788;
BEGIN
    dbms_output.put_line('V_TAX : ' || v_tax);
END;
/

-- 변수 + DEFAULT(기본값)
DECLARE
    v_tax NUMBER(4) DEFAULT 10;
BEGIN
    dbms_output.put_line('V_TAX : ' || v_tax);
END;
/

-- 변수 + NOT NULL
DECLARE
    v_tax NUMBER(4) NOT NULL := 10;
BEGIN
    dbms_output.put_line('V_TAX : ' || v_tax);
END;
/

-- 변수 + NOT NULL + DEFAULT
DECLARE
    v_tax NUMBER(4) NOT NULL DEFAULT 10;
BEGIN
    dbms_output.put_line('V_TAX : ' || v_tax);
END;
/

-- 변수와 상수의 자료형
-- 스칼라 : 오라클이 사용하는 타입(NUMBER, CHAR, DATE...) 
-- 참조형 : 오라클 데이터 베이스에 존재하는 특정 테이블의 열의 자료형이나 하나의 행 구조를 참조하는 자료형 
-- 1) 변수이름 테이블명.열이름%TYPE : 특정 테이블에 속한 열과 같은 크기의 자료형을 사용
-- 2) 변수이름 테이블명%ROWTYPE : 특정 테이블에 속한 행구조 전체 참조

DECLARE
    v_deptno dept.deptno%TYPE := 50;
BEGIN
    dbms_output.put_line('V_DEPTNO : ' || v_deptno);
END;
/

DECLARE
    -- V_DEPT_ROW 변수가 DEPT테이블의 한 행의 구조를 참조
    v_dept_row dept%rowtype;
BEGIN
    SELECT
        deptno,
        dname,
        loc
    INTO v_dept_row
    FROM
        dept
    WHERE
        deptno = 40;

    dbms_output.put_line('DEPTNO : ' || v_dept_row.deptno);
    dbms_output.put_line('DNAME : ' || v_dept_row.dname);
    dbms_output.put_line('LOC : ' || v_dept_row.loc);
END;
/


-- 조건문 : IF, IF~THEN~END IF
DECLARE
    v_number NUMBER := 16;
BEGIN
-- V_NUMBER 홀수,짝수 구별 
-- MOD() : 나머지 구하는 오라클함수
    IF MOD(v_number, 2) = 1 THEN
        dbms_output.put_line('V_NUMBER는 홀수');
    ELSE
        dbms_output.put_line('V_NUMBER는 짝수');
    END IF;
END;
/

-- 학점 출력
DECLARE
    v_number NUMBER := 87;
BEGIN
    IF v_number >= 90 THEN
        dbms_output.put_line('A 학점');
    ELSIF v_number >= 80 THEN
        dbms_output.put_line('B 학점');
    ELSIF v_number >= 70 THEN
        dbms_output.put_line('C 학점');
    ELSIF v_number >= 60 THEN
        dbms_output.put_line('D 학점');
    ELSE
        dbms_output.put_line('F 학점');
    END IF;
END;
/

DECLARE
    v_number NUMBER := 87;
BEGIN
    CASE trunc(v_number / 10)
        WHEN 10 THEN
            dbms_output.put_line('A 학점');
        WHEN 9 THEN
            dbms_output.put_line('A 학점');
        WHEN 8 THEN
            dbms_output.put_line('B 학점');
        WHEN 7 THEN
            dbms_output.put_line('C 학점');
        WHEN 6 THEN
            dbms_output.put_line('D 학점');
        ELSE
            dbms_output.put_line('F 학점');
    END CASE;
END;
/

DECLARE
    v_number NUMBER := 87;
BEGIN
    CASE trunc
        WHEN v_number >= 90 THEN
            dbms_output.put_line('A 학점');
        WHEN v_number >= 80 THEN
            dbms_output.put_line('B 학점');
        WHEN v_number >= 70 THEN
            dbms_output.put_line('C 학점');
        WHEN v_number >= 60 THEN
            dbms_output.put_line('D 학점');
        ELSE
            dbms_output.put_line('F 학점');
    END CASE;
END;
/


-- 반복문
-- LOOP ~ END LOOP, WHILE LOOP, FOR LOOP, CUSOR FOR LOOP 

DECLARE
    v_num NUMBER := 0;
BEGIN
    LOOP
        dbms_output.put_line('V_NUM : ' || v_num);
        v_num := v_num + 1;
        EXIT WHEN v_num > 4;
    END LOOP;
END;
/

DECLARE
    v_num NUMBER := 0;
BEGIN
    WHILE V_NUM <4 LOOP
        dbms_output.put_line('V_NUM : ' || v_num);
        v_num := v_num + 1;
    END LOOP;
END;
/

-- FOR i IN 시작값..종료값 
-- 반복수행작업;
-- END LOOP;
BEGIN
    FOR i IN 0..4 LOOP
        dbms_output.put_line('i : ' || i);
    END LOOP;
END;
/

BEGIN
    FOR i IN REVERSE 0..4 LOOP
        dbms_output.put_line('i : ' || i);
    END LOOP;
END;
/

-- 짝수만 출력
BEGIN
    FOR i IN 0..4 LOOP
    CONTINUE WHEN MOD(i, 2) = 1;    -- CONTINUE : 다음문장 건너뛰고 위로 올라감 
        dbms_output.put_line('i : ' || i);
    END LOOP;
END;
/

-- 홀수만 출력
BEGIN
    FOR i IN 0..10 LOOP
    CONTINUE WHEN MOD(i, 2) = 0;     
        dbms_output.put_line('i : ' || i);
    END LOOP;
END;
/

BEGIN
    FOR i IN 0..10 LOOP
        IF MOD(i, 2) = 1 THEN
        dbms_output.put_line('i : ' || i);
    END IF;
    END LOOP;
END;
/
