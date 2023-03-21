-- first_name�� Curtis�� ����� first_name, last_name, email, phone_number, job_id�� ��ȸ�Ѵ�. ��, job_id����� �ҹ��ڷ� ���

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

-- �μ���ȣ�� 60,70,80,90�� ������� employee_id, first_name, hire_date, job_id��ȸ, ��, job_id�� IT_PROG�� ����ǰ�� ���α׷��ӷ� ������ ���
SELECT
    employee_id,
    first_name,
    hire_date,
    replace(job_id,'IT_PROG','���α׷���')
FROM
    employees
WHERE
    department_id IN ( 60, 70, 80, 90 ) ;


-- job_id�� AD_PRES, PU_CLERK�� ������� employee_id, first_name, last_name, department_id, job_id�� ��ȸ, ��, ������� first_name, last_name�� �����ؼ� ���
select employee_id, concat(first_name,concat(' ', last_name)), department_id, job_id
from employees
where job_id in ('AD_PRES', 'PU_CLERK');


-- [�ǽ�] 
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


-- ȸ�系�� �ִ뿬�� �� �ּҿ����� ���̸� ���
SELECT MAX(SALARY) - MIN(SALARY) AS SAL_GAP
FROM EMPLOYEES;

-- �Ŵ����� �ٹ��ϴ� ������� �� ���� ��� (�ߺ��� ����)
SELECT COUNT(DISTINCT MANAGER_ID) FROM EMPLOYEES;
