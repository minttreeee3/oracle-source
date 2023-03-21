-- 2. �����Լ�
-- 1) ROUND, TRUNC, CEIL, FLOOR, MOD 

-- round : �ݿø�
-- round(����, �ݿ︲ ��ġ(����)) 
SELECT
    round(1234.5678)      AS round,       --�Ҽ��� ù° �ڸ����� �ݿø�
    round(1234.5678, 0)   AS round0,               --�Ҽ��� ù° �ڸ����� �ݿø�
    round(1234.5678, 1)   AS round1,               --�Ҽ��� ��° �ڸ����� �ݿø�
    round(1234.5678, 2)   AS round2,               --�Ҽ��� ��° �ڸ����� �ݿø�
    round(1234.5678, - 1) AS round_minus1,    --�ڿ��� ù° �ڸ����� �ݿø�
    round(1234.5678, - 2) AS round_minus2      --�ڿ��� ��° �ڸ����� �ݿø�
FROM
    dual;

-- trunc : Ư����ġ���� ������ �Լ�
-- trunc(����, �ݿ︲ ��ġ(����)) 
SELECT
    trunc(1234.5678)      AS trunc,       --�Ҽ��� ù° �ڸ����� ����
    trunc(1234.5678, 0)   AS trunc0,               --�Ҽ��� ù° �ڸ����� ����
    trunc(1234.5678, 1)   AS trunc1,               --�Ҽ��� ��° �ڸ����� ����
    trunc(1234.5678, 2)   AS trunc2,               --�Ҽ��� ��° �ڸ����� ����
    trunc(1234.5678, - 1) AS trunc_minus1,    --�ڿ��� ù° �ڸ����� ����
    trunc(1234.5678, - 2) AS trunc_minus2      --�ڿ��� ��° �ڸ����� ����
FROM
    dual;

-- ceil(����), floor(����) : �Էµ� ���ڿ� ���� ����� ū ���� / ���� ���� 
SELECT
    ceil(3.14),
    floor(3.14),
    ceil(- 3.14),
    floor(- 3.14)
FROM
    dual;


-- mod(����, ������) : �������� (�ڹٿ����� %) 
SELECT
    mod(15, 6),
    mod(10, 2),
    mod(11, 2)
FROM
    dual;



-- ��¥ �Լ�
-- ��¥ ������ + ���� : ��¥ �����ͺ��� ���ڸ�ŭ �ϼ� ������ ��¥ 
-- ��¥ ������ - ��¥ ������ : �� ��¥ ������ ���� �ϼ� ����
-- ��¥ ������ + ��¥ ������ : ����Ұ���

-- 1) sysdate �Լ� : ����Ŭ �����ͺ��̽� ������ ��ġ�� os�� ���糯¥�� �ð��� ������
SELECT
    sysdate,
    sysdate - 1 AS yesterday,
    sysdate + 1 AS tomorrow
FROM
    dual;
    
-- 2) add_months(��¥, ���� ������) : �� ���� ���� ��¥ ���ϱ�
SELECT
    sysdate,
    add_months(sysdate, 3)
FROM
    dual;

-- �Ի� 50�ֳ��� �Ǵ� ��¥ ���ϱ�
-- empno, ename, hiredate, �Ի�50�ֳ⳯¥ ��ȸ
SELECT
    empno,
    ename,
    hiredate,
    add_months(hiredate, 600)
FROM
    emp;
    
-- 3) MONTHS_BETWEEN (ù��°��¥, �ι�°��¥) : �� ��¥ �����Ͱ��� ��¥ ���̸� �������� ����Ͽ� ���
  
-- �Ի� 45�� �̸��� ��������� ��ȸ
-- empno, ename, hiredate

SELECT
    empno,
    ename,
    hiredate
FROM
    emp
WHERE
    months_between(sysdate, hiredate) < 540;

-- ���� ��¥�� 6���� �� ��¥�� ���
SELECT
    sysdate,
    add_months(sysdate, 6)
FROM
    dual;

SELECT
    empno,
    ename,
    hiredate,
    sysdate,
    months_between(hiredate, sysdate)        AS months1,
    months_between(sysdate, hiredate)        AS months2,
    trunc(months_between(sysdate, hiredate)) AS months3
FROM
    emp;

-- 4) next_day(��¥, ����) : Ư�� ��¥�� �������� ���ƿ��� ������ ��¥ ���
-- last_day(��¥) : Ư�� ��¥�� ���� ���� ������ ��¥�� ���
SELECT
    sysdate,
    next_day(sysdate, '�ݿ���'),
    last_day(sysdate)
FROM
    dual;

-- ��¥�� �ݿø�, ���� : ROUND, TRUNC
-- CC : �� �ڸ� ������ �� ���ڸ��� �������� ��� 
--  2023���� ��� 2050�����̹Ƿ� 2001������ ó��
SELECT
    sysdate,
    round(sysdate, 'CC')   AS format_cc,
    round(sysdate, 'YYYY') AS format_yyyy,
    round(sysdate, 'DDD')  AS format_ddd,
    round(sysdate, 'HH')   AS format_hh
FROM
    dual;



-- ����ȯ �Լ� : �ڷ����� �� ��ȯ
-- NUMBER, VARCHAR2, DATE

SELECT
    empno,
    ename,
    empno + '500'    -- �ڵ�����ȯ �Ͼ�� �����
FROM
    emp
WHERE
    ename = 'FORD';

SELECT
    empno,
    ename,
    'abcd' + empno    -- ����+���ڴ� �ȵ� ������
FROM
    emp
WHERE
    ename = 'FORD';


-- TO_CHAR() : ���� �Ǵ� ��¥ �����͸� ���� �����ͷ� ��ȯ
-- TO_NUMBER() : ���� �����͸� ���� �����ͷ� ��ȯ
-- TO_DATE() : ���� �����͸� ��¥ �����ͷ� ��ȯ

-- ���ϴ� ������·� ��¥����ϱ� : TO_CHAR �ַλ���
SELECT
    sysdate,
    to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS') AS ���糯¥�ð�
FROM
    dual;
    
-- MON, MONTH : ���̸�
-- DDD : 365�� �߿��� ��ĥ
SELECT
    sysdate,
    to_char(sysdate, 'YYYY/MM/DD')    AS ���糯¥,
    to_char(sysdate, 'YYYY')          AS ���翬��,
    to_char(sysdate, 'MM')            AS �����,
    to_char(sysdate, 'MON')           AS �����2,
    to_char(sysdate, 'DD')            AS ��������,
    to_char(sysdate, 'DDD')           AS ��������2,
    to_char(sysdate, 'HH12:MI:SS AM') AS ����ð�
FROM
    dual;

-- SAL �ʵ忡 , �� ��ȭ ǥ�ø� �ϰ� �ʹٸ�?
SELECT
    sal,
    to_char(sal, '$999,999') AS sal_$,
    to_char(sal, 'L999,999') AS sal_l
FROM
    emp;


-- TO_NUMBER(���ڿ�������, '�ν��� ��������')
SELECT
    1300 - '1500',
    '1300' + 1500
FROM
    dual;

SELECT
    TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500', '999,999')       -- ,�� ���� ������
FROM
    dual;
    
-- TO_DATE(���ڿ�������, '�λ��� ��¥ ����')
SELECT
    TO_DATE('2018-07-18', 'YYYY-MM-DD') AS todate1,
    TO_DATE('20210708', 'YYYY-MM-DD')   AS todate2
FROM
    dual;

SELECT
    TO_DATE('2023-03-21') - TO_DATE('2023-02-01')
FROM
    dual;



-- ��ó�� �Լ�
-- NULL + 300 => NULL

-- NVL(������, ���� ��� ��ȯ�� ������)
SELECT
    empno,
    ename,
    sal,
    comm,
    sal + comm,
    nvl(comm, 0),
    sal + nvl(comm, 0)
FROM
    emp;

-- NVL2(������, ���� �ƴҰ�� ��ȯ�� ������, ���� ��� ��ȯ�� ������)
SELECT
    empno,
    ename,
    comm,
    nvl2(comm, 'O', 'X'),
    nvl2(comm, sal * 12 + comm, sal * 12) AS annsal
FROM
    emp;

-- DECODE �Լ� / CASE ��
-- DECODE (�˻����� �� ������, ����1, ����1�� ��ġ�Ҷ� ������ ����... ����) 
-- EMP���̺� ��å�� MANAGER�� ����� �޿��� 10%�λ�, SALESMAN�� ����� 5%, ANALYST�� ����� �״��, �������� 3%�λ�� �޿� ���

SELECT
    empno,
    ename,
    job,
    sal,
    decode(job, 'MANAGER', sal * 1.1, 'SALESMAN', sal * 1.05,
           'ANALYST', sal, sal * 1.03) AS upsal
FROM
    emp;

SELECT
    empno,
    ename,
    job,
    sal,
    CASE job
        WHEN 'MANAGER'  THEN
            sal * 1.1
        WHEN 'SALESMAN' THEN
            sal * 1.05
        WHEN 'ANALYST'  THEN
            sal
        ELSE
            sal * 1.03
    END AS upsal
FROM
    emp;

SELECT
    empno,
    ename,
    job,
    sal,
    CASE
        WHEN comm IS NULL THEN
            '�ش���� ����'
        WHEN comm = 0 THEN
            '�������'
        WHEN comm > 0 THEN
            '���� : ' || comm
    END AS comm_text
FROM
    emp;
    





-- ������(����) �Լ� : SUM, COUNT, MAX, MIN, AVG

--ORA-00937: ���� �׷��� �׷� �Լ��� �ƴմϴ�
SELECT
    SUM(sal)
FROM
    emp;

SELECT
    SUM(DISTINCT sal),
    SUM(ALL sal),
    SUM(sal)
FROM
    emp;

--SUM() : NULL�� �˾Ƽ� �����ϰ� �հ踦 ������
SELECT
    SUM(comm)
FROM
    emp;

SELECT
    COUNT(sal)
FROM
    emp;


--COUNT() : NULL�� �����ϰ� ������ ������
SELECT
    COUNT(comm)
FROM
    emp;

SELECT
    COUNT(*)
FROM
    emp;

SELECT
    COUNT(*)
FROM
    emp
WHERE
    deptno = 30;


-- MAX
SELECT
    MAX(sal)
FROM
    emp;
-- MAX�� ��¥������ �ֽų�¥�� ����
SELECT
    MAX(hiredate)
FROM
    emp;

--�μ���ȣ�� 20�� ����߿� ���� ������ �Ի���
SELECT
    MIN(hiredate)
FROM
    emp
WHERE
    deptno = 20;

SELECT
    AVG(sal)
FROM
    emp;




-- GROUP BY : ��� ���� ���ϴ� ���� ���� ���
-- GROUB BY�� ���͸� SELECT �� ��������

-- �μ��� SAL ��� ���ϱ�
SELECT
    AVG(sal)
FROM
    emp
WHERE
    deptno = 10;

SELECT
    AVG(sal)
FROM
    emp
WHERE
    deptno = 20;

SELECT
    AVG(sal)
FROM
    emp
WHERE
    deptno = 30;

SELECT
    AVG(sal),
    deptno
FROM
    emp
GROUP BY
    deptno;

-- �μ��� �߰����� ��� ���ϱ�
SELECT
    deptno,
    AVG(comm)
FROM
    emp
GROUP BY
    deptno;


-- GROUP BY + HAVING : GROUP BY���� ������ �ٶ�
-- HAVING : �׷�ȭ�� ��� ������� �ɶ�

-- �� �μ��� ��å�� ��ձ޿����ϱ� (��, ��ձ޿��� 2000�̻��� �׷츸 ���)
SELECT
    deptno,
    job,
    AVG(sal)
FROM
    emp
GROUP BY
    deptno,
    job
HAVING
    AVG(sal) >= 2000        --�׷��Լ� ������ WHERE�� ���� 
ORDER BY
    deptno,
    job;

-- 1)from��������  2)where����  3)group by  4)having  5)select  6)order by 
SELECT
    deptno,
    job,
    AVG(sal)
FROM
    emp
WHERE
    sal <= 3000
GROUP BY
    deptno,
    job
HAVING
    AVG(sal) >= 2000
ORDER BY
    deptno,
    job;

