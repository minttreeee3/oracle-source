-- [�ǽ�1] 
--EMP���̺��� ������� �� ��� �ٹ��ϼ��� 21.5���̴�. �Ϸ� �ٹ��ð��� 8�ð����� ������ �� ������� �Ϸ� �޿�(DAY_PAY)�� �ñ�(TIME_PAY)�� ����Ͽ� ����� ����Ѵ�. 
--��, �Ϸ� �޿��� �Ҽ��� ��°�ڸ����� ������, �ñ��� �ι�° �Ҽ������� �ݿø�

SELECT
    empno,
    ename,
    sal,
    trunc(sal / 21.5, 2)      AS day_pay,
    round(sal /(21.5 * 8), 1) AS time_pay
FROM
    emp;
    

-- [�ǽ�2]
-- EMP���̺��� ������� �Ի����� �������� 3������ ���� �� ù �����Ͽ� �������� �ȴ�.
-- ������� �������� �Ǵ� ��¥(R-JOB)�� YYYY-MM-DD�������� �Ʒ��� ���� ����Ͻÿ�.
-- ��, �߰������� ���� ����� �߰������� N/A�� ���


SELECT
    empno,
    ename,
    hiredate,
    to_char(next_day(add_months(hiredate, 3), '������'), 'YYYY-MM-DD') AS r_job,
    nvl(to_char(comm), 'N/A')       --NVL ���� ���� Ÿ���� ���ƾߵ� 
FROM
    emp;


-- [�ǽ�3]
-- EMP���̺��� ��� ����� ������� ���� ����� ��� ��ȣ(MGR)�� ������ ���� ������ �������� ��ȯ�ؼ� CHG_MGR���� ����Ͻÿ�

SELECT EMPNO, ENAME, MGR,
CASE
WHEN MGR IS NULL THEN '0000'
WHEN SUBSTR(TO_CHAR(MGR),1,2)='75' THEN '5555'
WHEN SUBSTR(TO_CHAR(MGR),1,2)='76' THEN '6666'
WHEN SUBSTR(TO_CHAR(MGR),1,2)='77' THEN '7777'
WHEN SUBSTR(TO_CHAR(MGR),1,2)='78' THEN '8888'
ELSE TO_CHAR(MGR)
END AS CHG_MGR
FROM EMP;



SELECT
    empno,
    ename,
   MGR,
    decode(SUBSTR(TO_CHAR(MGR),1,2), NULL, '0000', '75', '5555','76','6666','77','7777','78','8888',SUBSTR(TO_CHAR(MGR),1 ) AS CHG_MGR
FROM
    emp;
    
    
-- [�ǽ�1]
-- �μ���ȣ, ��ձ޿�, �ְ�޿�, �����޿�, ����� ���
select deptno, floor(avg(sal)) as avg_sal, max(sal) as max_sal, min(sal) as min_sal, count(deptno)
from emp
group by deptno
order by deptno desc;

-- [�ǽ�2]
-- ���� ��å�� �����ϴ� ����� 3���̻��� ��å�� �ο����� ���
select job, count(*) 
from emp
group by job
having count(job)>=3; 

-- [�ǽ�3] 
select to_char(hiredate,'yyyy') as hire_year, deptno, count(*) as cnt
from emp
group by to_char(hiredate,'yyyy'), deptno;



