-- join

-- 자신의 담당 매니저의 고용일보다 빠른 입사자 찾기 hire_date, last_name, manager_id
-- self join - employees
select e1.hire_date, e1.last_name, e1.manager_id
from employees e1, employees e2
where e1.manager_id = e2.employee_id and e1.hire_date < e2.hire_date
order by e1.employee_id;

select e1.hire_date, e1.last_name, e1.manager_id
from employees e1 join employees e2 on e1.manager_id = e2.employee_id 
where e1.hire_date < e2.hire_date
order by e1.employee_id;


-- 도시이름이 T로 시작하는 지역에 사는 사원들의 사번, last_name, 부서번호, 도시 조회
-- employees, departments, locations inner join 
select e.employee_id, e.last_name, d.department_id, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id and d.location_id = l.location_id and l.city like 'T%'; 

select e.employee_id, e.last_name, d.department_id, l.city
from employees e join departments d on e.department_id = d.department_id join locations l on d.location_id = l.location_id 
where l.city like 'T%'; 



-- 위치 id가 1700인 사원들의 사번, last_name, 부서번호, 급여 조회
-- employees, departments inner join 
select e.employee_id, e.last_name, d.department_id, e.salary
from employees e, departments d
where e.department_id = d.department_id and d.location_id =1700;

select e.employee_id, e.last_name, d.department_id, e.salary
from employees e join departments d on e.department_id = d.department_id
where d.location_id =1700;


-- 부서명, 위치id, 각 부서별 사원 총 수, 각 부서별 평균 연봉(소수점2자리까지) 조회
-- employees, departments inner join 
select d.department_name, d.location_id, count(*), round(avg(e.salary),2) as avg_sal
from employees e, departments d 
where e.department_id = d.department_id
group by d.department_name, d.location_id;

select d.department_name, d.location_id, count(*), round(avg(e.salary),2) as avg_sal
from employees e join departments d on e.department_id = d.department_id
group by d.department_name, d.location_id;


-- Executive 부서에 근무하는 사원들의 부서번호, last_name, job_id조회 
-- employees, departments inner join 
select e.department_id, e.last_name, e.job_id 
from employees e, departments d 
where e.department_id = d.department_id and d.department_name = 'Executive';

select e.department_id, e.last_name, e.job_id 
from employees e join departments d on e.department_id = d.department_id 
where d.department_name = 'Executive';


-- 각 사원별 소속부서에서 자신보다 늦게 고용되었으나 보다 많은 연봉을 받는 사원이 존재하는 모든 사원들의 부서번호, 이름(연결), salary, hire_date 조회
-- employees self join
select distinct e1.department_id, e1.first_name || ' ' || e1.last_name as name, e1.salary, e1.hire_date
from employees e1, employees e2
where e1.department_id = e2.department_id and e1.hire_date < e2.hire_date and e1.salary < e2.salary
order by department_id;

select distinct e1.department_id, e1.first_name || ' ' || e1.last_name as name, e1.salary, e1.hire_date
from employees e1 join employees e2 on e1.department_id = e2.department_id 
where e1.hire_date < e2.hire_date and e1.salary < e2.salary
order by department_id;






-- 서브쿼리

-- LAST_NAME에 u가 포함된 사원들과 동일부서에 근무하는 사원들의 사번, LAST_NAME조회
SELECT EMPLOYEE_ID, LAST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN ( SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE LAST_NAME LIKE '%u%' );


-- JOB_ID가 SA_MAN인 사원들의 최대 연봉보다 높게받는 사원들의 LAST_NAME, JOB_ID, SALARY 조회
SELECT LAST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY > ( SELECT MAX(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'SA_MAN' );


-- 커미션을 버는 사원들의 부서와 연봉이 동일한 사원들의 LAST_NAME, DEPARTMENT_ID, SALARY 조회
SELECT LAST_NAME, DEPARTMENT_ID, SALARY
FROM EMPLOYEES
WHERE SALARY IN ( SELECT SALARY FROM EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL );


-- 회사 전체 평균 연봉보다 더 받는 사원들 중 / LAST_NAME에 u가 있는 사원들이 근무하는 부서에서 근무하는 사원들의 EMPLOYEE_ID, LAST_NAME, SALARY 조회
SELECT EMPLOYEE_ID, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > ( SELECT AVG(SALARY) FROM EMPLOYEES ) AND DEPARTMENT_ID IN ( SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE LAST_NAME LIKE '%u%' );


-- LAST_NAME이 Davies인 사람보다 나중에 고용된 사원들의 LAST_NAME, HIRE_DATE 조회
SELECT LAST_NAME, HIRE_DATE
FROM EMPLOYEES 
WHERE HIRE_DATE > ( SELECT HIRE_DATE FROM EMPLOYEES WHERE LAST_NAME='Davies' );


-- LAST_NAME이 King인 사원을 매니저로 두고있는 모든사원들의 LAST_NAME, SALARY 조회 
SELECT LAST_NAME, SALARY
FROM EMPLOYEES 
WHERE MANAGER_ID IN ( SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE LAST_NAME='King' );






