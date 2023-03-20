-- scott

-- emp(employee) 테이블 구성 보기 (describe)
DESC emp;
-- 필드명(열이름)   제약조건   데이터타입
--EMPNO(사원번호)  NOT NULL   NUMBER(4)
--ENMANE(사원명),JOB(직책),MGR(직속상관번호),HIREDATE(입사일),SAL(급여),COMM(수당),DEPTNO(부서번호)
--NUMBER : 소수점 자릿수를 포함해서 지정가능  
--NUMBER(4): 4자리숫자까지 허용, NUMBER(8,2):전체자릿수는 8자리이고 소수점2자리를 포함한다
--VARCHAR2 : 가변형 문자열 저장
--VARCHAR2(10) : 10byte 문자까지 저장 가능 
--DATE : 날짜 데이터 

DESC dept;
--DEPTNO(부서번호), DNAME(부서명), LOC(부서위치) 

DESC salgrade;
--GRADE(급여등급), LOSAL(최소급여액), HISAL(최대급여액)


-- select : 데이터 조회 
-- 조회 방식 : 셀렉션(행단위로 조회), 프로젝션(열단위로 조회), 조인(두 개 이상의 테이블을 사용하여 조회)
--SELECT 열이름1, 열이름2... (조회할 열이 전체라면 * 로 처리) 
--FROM 테이블명;

--1.EMP 테이블의 전체 열을 조회
SELECT
    *
FROM
    emp;

--2. EMP 테이블에서 사원번호,이름,급여 열을 조회
SELECT
    empno,
    ename,
    sal
FROM
    emp;

--3. DEPT 테이블 전체 조회
SELECT
    *
FROM
    dept;

--4. DEPT 테이블 안에 부서번호, 지역만 조회
SELECT
    deptno,
    loc
FROM
    dept;
    
--5. EMP 테이블 안에 부서번호 조회
SELECT
    deptno
FROM
    emp;
    
--6. EMP 테이블 안에 부서번호 조회 (단, 중복된 부서 번호는 제거) 
-- DISTINCT : 중복제거 
SELECT DISTINCT
    deptno
FROM
    emp;

-- 열이 여러 개인 경우 (묶어서 중복이냐 아니냐를 판단) 
SELECT DISTINCT
    job,
    deptno
FROM
    emp;


--7. 연산
--별칭 : 필드에 별칭을 임의로 부여 (as 별칭, 혹은 한칸 띄고 별칭, 별칭에 공백이 있다면 ""로 묶어주기)
--사원들의 1년 연봉 구하기 ( SAL * 12 + COMM ) 
SELECT
    empno,
    ename,
    SAL,
    COMM,
    sal * 12 + comm AS annsal
FROM
    emp;

SELECT
    empno,
    ename           사원명,
    job             "직 책",
    sal * 12 + comm annsal
FROM
    emp; --이름을 새로 정할 수 있음, 대신 공백을주려면 ""로 묶어야함


--8. 정렬 : ORDER BY
--          내림차순=> DESC, 오름차순=> ASC
-- ENAME, SAL 열 추출하고, SAL 내림차순으로 정렬
SELECT
    ename,
    sal
FROM
    emp
ORDER BY
    sal DESC;
    
    
-- ENAME, SAL 열 추출하고, SAL 오름차순으로 정렬
SELECT
    ename,
    sal
FROM
    emp
ORDER BY
    sal ASC;    --오름차순일때는 ASC 생략가능
    

-- 전체 내용 출력하고, 결과가 사원번호의 오름차순으로 정렬
SELECT
    *
FROM
    emp
ORDER BY
    empno ASC;
    
-- 전체 내용 출력하고, 결과가 부서번호의 오름차순과 급여 내림차순으로 정렬
SELECT
    *
FROM
    emp
ORDER BY
    deptno ASC,
    sal DESC;


-- [실습] emp 테이블의 모든 열 출력
-- empno => employee_no
-- ename => employee_name
-- mgr => manager
-- sal => salary
-- comm => commission
-- deptno => department_no
-- 부서 번호를 기준으로 내림차순정렬하되 부서번호가 같다면 사원이름을 기준으로 오름차순 정렬
SELECT
    empno  employee_no,      --as 써도되고 안써도됨
    ename  employee_name,
    job,
    mgr    manager,
    hiredate,
    sal    salary,
    comm   commission,
    deptno department_no
FROM
    emp
ORDER BY
    deptno DESC,
    ename ASC;
    
    
-- WHERE : 특정 조건을 기준으로 원하는 행을 조회. 조건식을 써야함

-- 부서번호가 30인 데이터만 조회
SELECT
    *
FROM
    emp
WHERE
    deptno = 30;        --자바랑 다르게 같다는 뜻으로 = 를 사용
    
-- 사원번호가 7782인 데이터만 조회
SELECT
    *
FROM
    emp
WHERE
    empno = 7782;
    
-- 부서번호가 30이고 사원직책이 SALESMAN인 정보 조회
SELECT
    *
FROM
    emp
WHERE
        deptno = 30
    AND job = 'SALESMAN';       --조건식AND로 사용, =에서 문자는 '' (""아님), 내용에 대한 대소문자는 구분해야함 
    

-- 사원번호가 7499이고 부서번호가 30인 행 조회
SELECT
    *
FROM
    emp
WHERE
        empno = 7499
    AND deptno = 30;
    
-- 부서번호가 30이거나 사원직책이 CLERK인 행 조회
SELECT
    *
FROM
    emp
WHERE
    deptno = 30
    OR job = 'CLERK';


-- 산술연산자 : +, -, *, /, mod(나머지-표준은아님(오라클에서만 제공))
-- 비교연산자 : >, >=, <, <=
-- 등가비교연산자 : =, !=, <>, ^=
-- 논리부정연산자 : NOT 
-- IN 연산자 
-- BETWEEN A AND B 연산자
-- LIKE 연산자와 와일드 카드 (_, %) 
-- IS NULL 연산자
-- 집합연산자 : UNION(합집합-중복제거), UNION ALL(합집합-중복포함), MINUS(차집합), INTERSECT(교집합)


-- EMP 테이블에서 급여 열에 12를 곱한 값이 36000인 행 조회
SELECT
    *
FROM
    emp
WHERE
    sal * 12 = 36000;
    
-- ENAME이 F이후의 문자로 시작하는 사원 조회
SELECT
    *
FROM
    emp
WHERE
    ename >= 'F';

SELECT
    *
FROM
    emp
WHERE
    ename <= 'FORZ';
    
-- JOB이 MANAGER,SALESMAN,CLERK인 사원 조회
SELECT
    *
FROM
    emp
WHERE
    job = 'MANAGER'
    OR job = 'SALESMAN'
    OR job = 'CLERK';
    
-- SAL이 3000이 아닌 사원 조회
SELECT
    *
FROM
    emp
WHERE
    sal != 3000;
    
-- JOB이 MANAGER,SALESMAN,CLERK인 사원 조회 => IN 연산자 사용
SELECT
    *
FROM
    emp
WHERE
    job IN('MANAGER','SALESMAN','CLERK');

-- JOB이 MANAGER,SALESMAN,CLERK이 아닌 사원 조회 => IN 연산자 사용
SELECT
    *
FROM
    emp
WHERE
    job NOT IN('MANAGER','SALESMAN','CLERK');

-- 부서번호가 10, 20인 사원조회 => IN 사용
SELECT * FROM EMP WHERE DEPTNO IN(10, 20);

-- 급여가 2000이상 3000이하인 사원 조회 
SELECT *
FROM EMP
WHERE SAL >= 2000 AND SAL <=3000; 
--BETWEEN A AND B 사용 
SELECT *
FROM EMP
WHERE SAL BETWEEN 2000 AND 3000;

-- 급여가 2000 이상 3000이하가 아닌 사원
SELECT *
FROM EMP
WHERE SAL NOT BETWEEN 2000 AND 3000;




--LIKE연산자와 와일드카드(_, %)  
-- _ : 어떤값이든 상관없이 한 개의 문자 데이터를 의미
-- % : 길이와 상관없이(문자없는 경우도 포함) 모든 문자 데이터를 의미 

--사원이름이 S로 시작하는 사원정보 조회
SELECT *
FROM EMP
WHERE ENAME LIKE 'S%';

--사원이름의 두번째 글자가 L인 사원만 조회
SELECT *
FROM EMP
WHERE ENAME LIKE '_L%';

--사원이름에 AM이 포함된 사원만 조회
SELECT *
FROM EMP
WHERE ENAME LIKE '%AM%';

--사원이름에 AM이 포함되지 않은 사원만 조회
SELECT *
FROM EMP
WHERE ENAME NOT LIKE '%AM%';


-- NULL : 데이터값이 완전히 비어 있는 상태
-- =을 사용할 수 없음, IS를 사용
SELECT * FROM EMP
WHERE COMM IS NULL;

-- MGR이 NULL이 아닌 데이터
SELECT * FROM EMP
WHERE MGR IS NOT NULL;