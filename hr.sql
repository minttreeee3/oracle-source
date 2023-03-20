--employee 테이블 전체 내용 조회
SELECT
    *
FROM
    employees;

--employee 테이블 first_name, last_name, job_id만 조회

SELECT
    first_name,
    last_name,
    job_id
FROM
    employees;
    
-- 사원번호가 176인 사람의 LAST_NAME 조회
SELECT
    last_name
FROM
    employees
WHERE
    employee_id = 176;

-- 연봉이 12000 이상 되는 직원들의 LAST_NAME, SALARY 조회
SELECT
    last_name,
    salary
FROM
    employees
WHERE
    salary >= 12000;

-- 연봉이 5000 에서 12000범위가 아닌 사람들의 LAST_NAME, SALARY 조회
SELECT
    last_name,
    salary
FROM
    employees
WHERE
    salary < 5000
    OR salary > 12000;
    
-- 20, 50번부서에서 근무하는 모든 사원들의 LAST_NAME, 부서번호를 오름차순으로 조회
SELECT
    last_name,
    department_id
FROM
    employees
WHERE
    department_id IN ( 20, 50 )
ORDER BY
    last_name,
    department_id ASC;

-- 커미션을 받는 모든 사원들의 LAST_NAME, 연봉, 커미션 조회(연봉의 내림차순, 커미션 내림차순)
SELECT
    last_name,
    salary,
    commission_pct
FROM
    employees
WHERE
    commission_pct IS NOT NULL
ORDER BY
    salary DESC,
    commission_pct DESC;

-- 연봉이 2500, 3500, 7000이 아니며 직업이 SA_REP나 ST_CLERK인 사원조회
SELECT
    *
FROM
    employees
WHERE
    salary NOT IN ( 2500, 3500, 7000 )
    AND job_id IN ( 'SA_REP', 'ST_CLERK' );

-- 2008/02/20 ~ 2008/05/01 사이에 고용된 사원들의 LAST_NAME, 사번, 고용일자 조회, 고용일자 내림차순 정렬
-- 날짜데이터는 '' 안에 표시, -나 / 사용가능 
SELECT
    last_name,
    employee_id,
    hire_date
FROM
    employees
WHERE
        hire_date >= '08/02/20'
    AND hire_date <= '08/05/01'
ORDER BY
    hire_date DESC;

SELECT
    last_name,
    employee_id,
    hire_date
FROM
    employees
WHERE
    hire_date BETWEEN '08/02/20' AND '08/05/01'
ORDER BY
    hire_date DESC;


-- 2004년도에 고용된 사원들의 LAST_NAME, HIRE_DATE 조회
SELECT
    last_name,
    hire_date
FROM
    employees
WHERE
        hire_date >= '2004-01-01'
    AND hire_date <= '2004-12-31'
ORDER BY
    hire_date;

SELECT
    last_name,
    hire_date
FROM
    employees
WHERE
    hire_date BETWEEN '2004-01-01' AND '2004-12-31'
ORDER BY
    hire_date;

-- 부서가 20,50이고 연봉이 5000~12000범위인 사람들의 LAST_NAME, SALARY조회, 연봉 오름차순 정렬
SELECT
    last_name,
    salary
FROM
    employees
WHERE
    department_id IN ( 20, 50 )
    AND salary BETWEEN 5000 AND 12000
ORDER BY
    salary;


-- 2004년도 고용된 사원들의 LAST_NAME, HIRE_DATE 조회, 고용일자 오름차순정렬 =>LIKE사용
SELECT
    last_name,
    hire_date
FROM
    employees
WHERE
    hire_date LIKE '04%'
ORDER BY
    hire_date;

-- LAST_NAME에 u가 포함된 사원들의 사번, LAST_NAME조회
SELECT
    employee_id,
    last_name
FROM
    employees
WHERE
    last_name LIKE '%u%';

-- LAST_NAME의 네번째 글자가 a인 사원들의 LAST_NAME조회
SELECT
    last_name
FROM
    employees
WHERE
    last_name LIKE '___a%';

-- LAST_NAME에 a혹은 e글자가 포함된 사원들의 LAST_NAME조회, 오름차순
SELECT
    last_name
FROM
    employees
WHERE
    last_name LIKE '%a%'
    OR last_name LIKE '%e%'
ORDER BY
    last_name;

-- LAST_NAME에 a와 e글자가 포함된 사원들의 LAST_NAME조회, 오름차순
SELECT
    last_name
FROM
    employees
WHERE
    last_name LIKE '%a%e%'
    OR last_name LIKE '%e%a%' --LAST_NAME LIKE '%a%' and LAST_NAME LIKE '%e%'
ORDER BY
    last_name;

-- 매니저가 없는 사람들의 last_name, job_id 조회
SELECT
    last_name,
    job_id
FROM
    employees
WHERE
    manager_id IS NULL or manager_id='';

-- job_id가 ST_CLERK인 사원 조회 (단, 부서번호가 NULL인 사원은 제외) -중복을 제거한 후 부서번호만 조회
SELECT DISTINCT
    department_id
FROM
    employees
WHERE
        job_id = 'ST_CLERK'
    AND department_id IS NOT NULL;

-- commission_pct가 null이 아닌 사원들 중에서 commission = salary * commission_pct 를 구하여 employee_id, first_name, job_id 출력
SELECT
    employee_id,
    first_name,
    job_id,
    salary * commission_pct AS commission
FROM
    employees
WHERE
    commission_pct IS NOT NULL;



