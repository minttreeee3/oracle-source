
-- ★★★개념중요
-- 조인 : 여러 테이블을 하나의 테이블처럼 사용
-- 1) 내부조인(inner join) : 여러 개의 테이블에서 공통된 부분만 추출
--     ① 등가조인 : 두 개의 열이 일치할 때 값 추출
--     ② 비등가조인 : 범위에 해당할 때 값 추출
-- 2) 외부조인(outer join) 
--     ① left outer join
--     ② right outer join
--     ③ full outer join


-- dept 4행, emp 12행 => 48행이 출력됨 
-- 크로스조인 (나올수있는 모든조합추출) 
select * from emp, dept 
order by empno;


-- ORA-00918: 열의 정의가 애매합니다 : 중복되는 행이 있을때 나오는 오류. 어느 테이블에서 가져올지 명확하게 해줘야됨

-- inner join
select e.empno, e.ename, d.deptno, d.dname, d.loc
from emp e, dept d      --테이블에 별칭 붙임
where e.deptno = d.deptno and sal>=3000;

-- SQL-99 표준
-- join ~ on
select e.empno, e.ename, d.deptno, d.dname, d.loc
from emp e join dept d on e.deptno = d.deptno;

select e.empno, e.ename, d.deptno, d.dname, d.loc
from emp e join dept d on e.deptno = d.deptno
where sal>=3000;


-- emp, dept inner join, 급여가 2500 이하이고, 사원번호가 9999이하인 사원정보조회
select e.empno, e.ename, e.sal, d.deptno, d.dname, d.loc
from emp e, dept d
where d.deptno = e.deptno and e.sal<=2500 and e.empno <=9999;

select e.empno, e.ename, e.sal, d.deptno, d.dname, d.loc
from emp e join dept d on d.deptno = e.deptno 
where e.sal<=2500 and e.empno <=9999;


-- emp와 salgrade조인
-- emp테이블의 sal이 salgrade의 losal과 hisal범위에 들어가는 형태로 조인 
select *
from emp e, salgrade s 
where e.sal between s.losal and s.hisal;

select *
from emp e join salgrade s on e.sal between s.losal and s.hisal;


-- self join : 자기 자신 테이블과 조인
select e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename
from emp e1, emp e2 
where e1.mgr = e2.empno; 


-- outer join 

-- 1) left outer join : 오른쪽에 (+) 붙여줌 => 왼쪽테이블기준으로 일치하는데이터가 없어도 출력하겠다 
select e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename
from emp e1, emp e2 
where e1.mgr = e2.empno(+); 

select e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename
from emp e1 left outer join emp e2 on e1.mgr = e2.empno; 


-- 2) right outer join : 왼쪽에 (+) 붙여줌 
select e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename
from emp e1, emp e2 
where e1.mgr(+) = e2.empno; 

select e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename
from emp e1 right outer join emp e2 on e1.mgr = e2.empno; 


-- 3) full outer join : 양쪽에 (+)붙이면 오류남, 표준방식으로 써야함
select e1.empno, e1.ename, e1.mgr, e2.empno as mgr_empno, e2.ename as mgr_ename
from emp e1 full outer join emp e2 on e1.mgr = e2.empno; 


-- 연결해야 할 테이블이 세개일때
select * 
from table1 t1, table2 t2, table3 t3
where t1.empno = te.empno and te.deptno = t3. deptno;

select * 
from table1 t1 join table2 t2 on t1.empno = t2.empno join table3 t3 on t2.deptno = t3. deptno;



-- [실습1]
-- 급여가 2000초과인 사원들의 부서정보, 사원정보를 출력
select d.deptno, d.dname, e.empno, e.ename, e.sal
from dept d, emp e
where d.deptno = e.deptno and e.sal>2000
order by deptno;

select d.deptno, d.dname, e.empno, e.ename, e.sal
from dept d join emp e on d.deptno = e.deptno 
where e.sal>2000
order by deptno;

-- [실습2]
-- 각 부서별 평균급여, 최대급여, 최소급여, 사원수
select d.deptno, d.dname, round(avg(e.sal)) as avg_sal, max(e.sal) as max_sal, min(e.sal) as min_sal, count(e.ename) as cnt
from dept d, emp e 
where d.deptno = e.deptno
group by d.deptno, d.dname
order by deptno;

select d.deptno, d.dname, trunc(avg(e.sal)), max(e.sal), min(e.sal), count(e.ename)
from dept d join emp e on d.deptno = e.deptno
group by d.deptno, d.dname
order by deptno;

-- [실습3]
select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from dept d, emp e 
where d.deptno = e.deptno(+) 
order by deptno, dname, empno;

select d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
from dept d left outer join emp e on d.deptno = e.deptno 
order by deptno, dname, empno;






-- 서브쿼리
-- sql 문을 실행하는 데 필요한 데이터를 추가로 조회하기 위해 sql문 내부에서 사용하는 select문
-- 1) 단일행 서브쿼리 2) 다중행 서브쿼리 3) 다중열 서브쿼리



-- 1) 단일행 서브쿼리 : 서브쿼리 결과로 하나의 행이 반환됨 
-- =, >, <, <>, != 등 연산자 사용 가능

-- select 조회할 열
-- from 테이블명
-- where 조건식 (select 조회할 열 from 테이블 where 조건식)   <=괄호안이 서브쿼리


-- 존스의 급여보다 높은 급여를 받는 사원 조회 
-- jones 급여 알아내기 / 알아낸 jones 급여를 가지고 조건식 
select sal
from emp 
where ename = 'JONES';  --2975

SELECT *
FROM EMP 
WHERE SAL > 2975; 

-- 이걸 합쳐서 쓰기 (서브쿼리 사용)
SELECT *
FROM EMP 
WHERE SAL > ( select sal
from emp 
where ename = 'JONES');


-- 사원이름이 ALLEN인 사원의 추가수당 보다 많은 추가수당을 받느 사원 조회
SELECT *
FROM EMP 
WHERE COMM > ( select COMM
from emp 
where ename = 'ALLEN');

-- 사원이름이 WARD인 사원의 입사일보다 빨리 입사한 사원 조회
SELECT *
FROM EMP 
WHERE HIREDATE < ( select HIREDATE
from emp 
where ename = 'WARD');

-- 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 높은 급여를 받는 사원정보 및 부서정보 조회
-- 사원번호, 사원명, 직무, 급여, 부서번호, 부서명, 지역
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, D.DEPTNO, D.DNAME, D.LOC 
FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE E.DEPTNO = 20 AND E.SAL > ( SELECT AVG(SAL) FROM EMP );

-- 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 작거나 같은 급여를 받는 사원정보 및 부서정보 조회
-- 사원번호, 사원명, 직무, 급여, 부서번호, 부서명, 지역
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, D.DEPTNO, D.DNAME, D.LOC 
FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE E.DEPTNO = 20 AND E.SAL <= ( SELECT AVG(SAL) FROM EMP );


-- 2) 다중행 서브쿼리 : 서브쿼리 결과로 여러개의 행을 반환
-- IN, ANY(SOME), ALL, EXISTS 연산자 허용 (단일행 서브쿼리에 쓰는 연산자 사용불가)

-- 각 부서별 최고 급여와 동일한 급여를 받는 사원정보 조회
SELECT *
FROM EMP
WHERE SAL IN ( SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO );
-- IN : 메인쿼리 결과가 서브쿼리 결과 중 하나라도 일치하면 TRUE


-- 30번 부서 사원중 가장높은 급여보다 적은 급여를 받는 사원 정보 조회
SELECT *
FROM EMP
WHERE SAL < ANY ( SELECT SAL FROM EMP WHERE DEPTNO=30 );

SELECT *
FROM EMP
WHERE SAL < SOME ( SELECT SAL FROM EMP WHERE DEPTNO=30 );

-- 결과적으로 이것과 동일해서 단일형쿼리로도 작성이 가능함 
SELECT *
FROM EMP
WHERE SAL < ( SELECT MAX(SAL) FROM EMP WHERE DEPTNO=30 );


-- 30번부서 사원들이 최소급여보다 많은급여를 받는 사원정보 조회
SELECT *
FROM EMP
WHERE SAL > ( SELECT MIN(SAL) FROM EMP WHERE DEPTNO=30 );

SELECT *
FROM EMP
WHERE SAL > ANY ( SELECT SAL FROM EMP WHERE DEPTNO=30 );


-- ALL : 서브쿼리 모든결과가 조건식에 맞아떨어져야만 메인쿼리 조건식이 TRUE
SELECT *
FROM EMP
WHERE SAL > ALL ( SELECT SAL FROM EMP WHERE DEPTNO=30 );


-- EXISTS : 서브쿼리에 결과값이 하나이상 존재하면 조건식이 모두 TRUE, 존재하지 않으면 FALSE
SELECT *
FROM EMP
WHERE EXISTS (SELECT DNAME FROM DEPT WHERE DEPTNO=10);   -- 존재하기때문에 전체출력됨, 존재하지않으면 아무것도 출력안됨



-- [실습1]
-- 전체사원중 ALLEN과 같은직책인 사원들의 사원정보, 부서정보 출력
SELECT E.JOB, E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME
FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE JOB = ( SELECT JOB FROM EMP WHERE ENAME='ALLEN' );

-- [실습2]
-- 전체사원의 평균급여보다 높은급여를 받는 사원들의 사원정보, 부서정보, 급여등급정보
SELECT EMPNO, ENAME, DNAME, HIREDATE, LOC, SAL, GRADE
FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE SAL > ( SELECT AVG(SAL) FROM EMP )
ORDER BY SAL DESC, EMPNO;



-- 3) 다중열 서브쿼리 : 서브쿼리의 SELECT 절에 비교할 데이터를 여러개 지정 
SELECT *
FROM EMP
WHERE (DEPTNO, SAL) IN ( SELECT DEPTNO, MAX(SAL) FROM EMP GROUP BY DEPTNO );


-- FROM 절에 사용하는 서브쿼리 (인라인 뷰)
-- FROM 절에 직접 테이블을 명시해서 사용하기에는 테이블 내 데이터 규모가 클 때, 불필요한 열이 많을 때 
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10, (SELECT * FROM DEPT) D
WHERE E10.DEPTNO = D.DEPTNO;


-- SELECT 절에 사용하는 서브쿼리 (스칼라 서브쿼리)
-- 하나의 결과만 반환하는 서브쿼리만 사용가능 
SELECT EMPNO, ENAME, JOB, SAL, (SELECT GRADE FROM SALGRADE WHERE E.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE, DEPTNO, (SELECT DNAME FROM DEPT WHERE E.DEPTNO = DEPT.DEPTNO) AS DNAME
FROM EMP E;


-- [실습1]
-- 10번 부서에 근무하는 사원 중 / 30번 부서에는 존재하지 않는 직책을 가진 사원들의 사원정보, 부서정보
SELECT E.EMPNO, E.ENAME, E.JOB, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO 
WHERE D.DEPTNO=10 AND E.JOB NOT IN ( SELECT JOB FROM EMP WHERE DEPTNO=30 );

-- [실습2]
-- 단일행 쿼리
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE 
FROM EMP E JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL 
WHERE E.SAL > ( SELECT MAX(SAL) FROM EMP WHERE JOB='SALESMAN' )
ORDER BY E.EMPNO;

-- 다중행 쿼리
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE 
FROM EMP E JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL 
WHERE E.SAL > ALL ( SELECT SAL FROM EMP WHERE JOB='SALESMAN' )
ORDER BY E.EMPNO;

-- 조인 대신 스칼라 서브쿼리 사용 가능
SELECT E.EMPNO, E.ENAME, E.SAL, (SELECT GRADE FROM SALGRADE WHERE E.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE
FROM EMP E 
WHERE E.SAL > ( SELECT MAX(SAL) FROM EMP WHERE JOB='SALESMAN' )
ORDER BY E.EMPNO;


