-- first_name이 Curtis인 사람의 first_name, last_name, email, phone_number, job_id를 조회한다. 단, job_id결과는 소문자로 출력

SELECT
    first_name,
    last_name,
    email,
    phone_number,
    lower(job_id)
FROM
    employees
WHERE
    first_name = 'Curtis';

-- 부서번호가 60,70,80,90인 사원들의 employee_id, first_name, hire_date, job_id조회, 단, job_id가 IT_PROG인 사원의경우 프로그래머로 변경후 출력
SELECT
    employee_id,
    first_name,
    hire_date,
    replace(job_id,'IT_PROG','프로그래머')
FROM
    employees
WHERE
    department_id IN ( 60, 70, 80, 90 ) ;


-- job_id가 AD_PRES, PU_CLERK인 사원들의 employee_id, first_name, last_name, department_id, job_id를 조회, 단, 사원명은 first_name, last_name를 연결해서 출력
select employee_id, concat(first_name,concat(' ', last_name)), department_id, job_id
from employees
where job_id in ('AD_PRES', 'PU_CLERK');


-- [실습] 
select last_name, salary, 
case 
when salary < 2000 then 0.00
when salary <4000 then 0.09
when salary <6000 then 0.2
when salary <8000 then 0.3
when salary<10000 then 0.4
when salary <12000 then 0.42
when salary <14000 then 0.44
else 0.45
end as TAX_RATE
FROM EMPLOYEES
WHERE DEPARTMENT_ID=80;


SELECT last_name, salary, DECODE(TRUNC(SALARY / 2000,0), 
0, 0.00,
1, 0.09,
2, 0.20,
3, 0.30,
4, 0.40,
5, 0.42,
6, 0.44, 
0.45) AS TAX_RATE
FROM EMPLOYEES WHERE DEPARTMENT_ID=80;


-- 회사내의 최대연봉 및 최소연봉의 차이를 출력
SELECT MAX(SALARY) - MIN(SALARY) AS SAL_GAP
FROM EMPLOYEES;

-- 매니저로 근무하는 사원들의 총 숫자 출력 (중복은 제거)
SELECT COUNT(DISTINCT MANAGER_ID) FROM EMPLOYEES;
