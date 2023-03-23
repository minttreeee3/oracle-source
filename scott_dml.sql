

-- DML (Data Manipulation Language) : 데이터 추가(INSERT), 수정(UPDATE), 삭제(DELETE)하는 데이터 조작어
-- COMMIT : DML 작업을 데이터베이스에 최종 반영
-- ROLLBACK : DML 작업을 취소

-- select + DML ==> 자주사용하는 sql




--연습용 테이블생성 (DEPT 복사해오기)
CREATE TABLE DEPT_TEMP AS SELECT * FROM DEPT;

--테이블 삭제하려면
DROP TABLE DEPT_TEMP;

-- INSERT INTO 테이블이름(열이름1, 열이름2... )  -열이름은 선택사항임
-- VALUES(데이터1, 데이터2......)

-- DEPT_TEMP 새로운 부서 추가하기
INSERT INTO dept_temp(deptno, dname, loc)
VALUES(50, 'DATABASE', 'SEOUL');

SELECT * FROM DEPT_TEMP;

-- 열 이름 안썼을때 (가능)
INSERT INTO dept_temp
VALUES(60, 'NETWORK', 'BUSAN');


-- INSERT시 오류들
--이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다.
--INSERT INTO dept_temp
--VALUES(600, 'NETWORK', 'BUSAN');

-- 숫자여야하는데 문자형으로 입력 => 자동형변환돼서 들어감 (아예문자를 써버리면 에러남)
INSERT INTO dept_temp
VALUES('60', 'NETWORK', 'BUSAN');

--값의 수가 충분하지 않습니다
--INSERT INTO dept_temp(deptno, dname, loc)
--VALUES(50, 'DATABASE');

-- NULL 삽입가능
INSERT INTO dept_temp(deptno, dname, loc)
VALUES(80, 'WEB', NULL);
-- 공백으로 삽입해도 NULL이 됨
INSERT INTO dept_temp(deptno, dname, loc)
VALUES(90, 'MOBILE', '');
-- 칼럼명을 아예 지정하지 않아도 NULL이 됨
-- 삽입시 전체 칼럼을 삽입하지 않는다면 넣을 필드명은 필수 
INSERT INTO dept_temp(deptno, loc)
VALUES(91, 'INCEON');


-- 테이블 구조만 복사하는 법
-- EMP_TEMP 생성 (EMP테이블 복사 - 데이터 복사는 하지않을때)
CREATE TABLE emp_temp AS SELECT * FROM EMP WHERE 1 <> 1; 

INSERT INTO EMP_TEMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(9999, '홍길동', 'PRESIDENT', NULL, '2001/01/01', 5000, 1000, 10);

INSERT INTO EMP_TEMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(1111, '성춘향', 'MANAGER', 9999, '2002/01/05', 4000, NULL, 20);

-- 날짜입력시 년/월/일 => 일/월/년 순서로 삽입한다면 =>오류남
--INSERT INTO EMP_TEMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
--VALUES(2222, '이순신', 'MANAGER', 9999, '07/01/2001', 4000, NULL, 20);
-- TO_DATE 사용해서 날짜데이터로 변환해야함 
INSERT INTO EMP_TEMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(2222, '이순신', 'MANAGER', 9999, TO_DATE('07/01/2001','DD/MM/YYYY'), 4000, NULL, 20);
-- 오늘날짜 삽입 가능 (SYSDATE)
INSERT INTO EMP_TEMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(3333, '심봉사', 'MANAGER', 9999, SYSDATE, 4000, NULL, 30);


-- 서브쿼리로 INSERT 구현 
-- emp, salgrade 테이블을 조인 후 급여 등급이 1인 사원만 emp_temp에 추가 
INSERT INTO EMP_TEMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
select e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno
from emp e, salgrade s
where e.sal between s.losal and s.hisal and s.grade=1; 




COMMIT;   --INSERT부터 여기까지 최종반영하겠다는 뜻

-- UPDATE : 테이블에 있는 데이터 수정
--UPDATE 테이블명
--SET 변경할 열이름 = 데이터, 변경할 열이름 = 데이터...... 나열 
--WHERE 변경을 위한 대상 행을 선별하기 위한 조건

SELECT * FROM EMP_TEMP;

-- DEPT_TEMP LOC열의 모든값을 SEOUL로 변경
UPDATE DEPT_TEMP
SET LOC='SEOUL';

-- 잘못해서 되돌리려면 롤백 (COMMIT 하기 전에만 가능)
ROLLBACK;

-- DEPT_TEMP 부서번호가 40번인 LOC열의 값을 SEOUL로 변경
UPDATE DEPT_TEMP
SET LOC='SEOUL'
WHERE DEPTNO=40;

-- DEPT_TEMP 부서번호가 80번인 DNAME은 SALES, LOC은 CHICAGO로 변경
UPDATE DEPT_TEMP
SET DNAME='SALES', LOC='CHICAGO'
WHERE DEPTNO=80;

-- EMP_TEMP 사원들 중에서 급여가 2500 이하인 사원만 추가수당을 50으로 수정
UPDATE EMP_TEMP
SET COMM=50
WHERE SAL <= 2500;


-- 서브쿼리를 사용하여 데이터 수정
-- DEPT 테이블의 40번 부서의 DNAME, LOC를 DEPT_TEMP 40번 부서의 DNAME,LOC에다가 업데이트
UPDATE DEPT_TEMP
SET (DNAME, LOC) = ( SELECT DNAME, LOC FROM DEPT WHERE DEPTNO=40 )
WHERE DEPTNO = 40;

COMMIT;



-- DELETE : 테이블에 있는 데이터 삭제
--DELETE 테이블명
--FROM (선택)
--WHERE 삭제 데이터를 선별하기 위한 조건식

CREATE TABLE EMP_TEMP2 AS SELECT * FROM EMP;

--JOB이 MANAGER인 사원 삭제
DELETE FROM EMP_TEMP2
WHERE JOB='MANAGER';

-- 전체 데이터 삭제
DELETE EMP_TEMP2;

ROLLBACK;

-- 서브쿼리를 사용하여 삭제
-- 급여등급이 3등급이고, 30번부서의 사원 삭제

DELETE FROM EMP_TEMP2
WHERE EMPNO IN
( SELECT E.EMPNO
FROM EMP_TEMP2 E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL AND S.GRADE=3 AND DEPTNO=30 );


-- [실습1]
CREATE TABLE EXAM_EMP AS SELECT * FROM EMP;
CREATE TABLE EXAM_DEPT AS SELECT * FROM DEPT;
CREATE TABLE EXAM_SALGRADE AS SELECT * FROM SALGRADE;

-- [실습2]
INSERT INTO EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7201, 'TEST_USER1', 'MANAGER', 7788, '2016/01/02',4500, NULL,50);
INSERT INTO EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7202, 'TEST_USER2', 'CLERK', 7201, '2016/02/21',1800,NULL,50);
INSERT INTO EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7203, 'TEST_USER3', 'ANALYST', 7201, '2016/04/11',3400,NULL,60);
INSERT INTO EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7204, 'TEST_USER4', 'SALESMAN', 7201, '2016/05/31',2700,300,60);
INSERT INTO EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7205, 'TEST_USER5', 'CLERK', 7201, '2016/07/20',2600,NULL,70);
INSERT INTO EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7206, 'TEST_USER6', 'CLERK', 7201, '2016/09/08',2600,NULL,70);
INSERT INTO EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7207, 'TEST_USER7', 'LECTURER', 7201, '2016/10/28',2300,NULL,80);
INSERT INTO EXAM_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7208, 'TEST_USER8', 'STUDENT', 7201, '2018/03/09',1200,NULL,80);


-- [실습3]
-- EXAM_EMP에 속한 사원 중 50번 부서에서 근무하는 사원들의 평균 급여보다 많은 급여를 받고 있는 사원들을 70번 부서로 옮기는 SQL 문 작성하기
UPDATE EXAM_EMP
SET DEPTNO=70
WHERE SAL > ( SELECT AVG(SAL) FROM EXAM_EMP WHERE DEPTNO=50 );

-- [실습4]
-- EXAM_EMP에 속한 사원 중 60번 부서의 사원 중에서 입사일이 가장 빠른 사원보다 늦게 입사한 사원의 / 급여를 10% 인상하고 80번 부서로 옮기는 SQL 문 작성하기
UPDATE EXAM_EMP 
SET SAL=1.1*SAL, DEPTNO=80
WHERE HIREDATE > ANY ( SELECT HIREDATE FROM EXAM_EMP WHERE DEPTNO=60 );


-- [실습5]
-- EXAM_EMP에 속한 사원 중, 급여 등급이 5인 사원을 삭제하는 SQL문을 작성하기
DELETE FROM EXAM_EMP
WHERE ENAME IN ( SELECT E.ENAME 
FROM EXAM_EMP E JOIN EXAM_SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE S.GRADE = 5 );




-- 트랜잭션(TRANSACTION) : 최소 수행단위
-- 트랜잭션을 제어하는 구문 : TCL (Transaction Control Language) : commit, rollback 

CREATE TABLE DEPT_TCL AS SELECT * FROM DEPT;

INSERT INTO DEPT_TCL 
VALUES (50, 'DATABASE', 'SEOUL');

UPDATE DEPT_TCL SET LOC='BUSAN' WHERE DEPTNO=40;

DELETE FROM DEPT_TCL WHERE DNAME='RESEARCH';

SELECT * FROM DEPT_TCL;

-- 트랜잭션 취소
ROLLBACK;

-- 트랜잭션 최종 반영
COMMIT;

-- 세션 : 어떤 활동을 위한 시간이나 기간
-- 데이터베이스 세션 : 데이터베이스 접속을 시작으로 관련작업 수행한 후 접속 종료
-- LOCK : 잠금 (수정 중인 데이터 접근 막기)

DELETE FROM DEPT_TCL WHERE DEPTNO=50;

UPDATE DEPT_TCL SET LOC='SEOUL' WHERE DEPTNO=30;

