-- JAVADB

-- userTBL 테이블 생성
-- no(번호-숫자(4)), username(이름-한글(4)), birthYear(년도-숫자(4)), addr(주소-문자(한글,숫자)), mobile(010-1234-1234)
-- no pk 제약조건 지정 (제약조건명 pk_userTBL)

CREATE TABLE userTBL (
no number(4) constraint pk_userTBL primary key,
username VARCHAR2(12),
birthYear number(4),
addr VARCHAR2(50),
mobile VARCHAR2(13)
);

-- 시퀀스 생성
-- user_seq 생성(기본)

CREATE SEQUENCE user_seq;


-- INSERT (no에는 시퀀스 번호 넣기) 
INSERT INTO userTBL VALUES ( user_seq.NEXTVAL , '홍길동', 2010, '서울시 종로구 100로', '010-1234-1234');

COMMIT; -- DML작업시 한번에 시행되어야 하는 단위, DML작업한후 COMMIT(DB최종반영)해야함




-- [자바 SHOP 연동]
-- 모든 컬럼 not null
-- paytype : pay_no(숫자-1 pk), info(문자-card,cash)  
-- paytype_seq 생성
CREATE TABLE paytype (
pay_no number(1) primary key,
info VARCHAR2(4) not null
);

CREATE SEQUENCE paytype_seq;

insert into paytype values (paytype_seq.NEXTVAL, 'card');
insert into paytype values (paytype_seq.NEXTVAL, 'cash');


-- suser : user_id(숫자-4 pk), name(문자-한글), pay_no(숫자-1 : paytype 테이블에 있는 pay_no 참조해서 사용)
create table suser (
user_id number(4) primary key,
name VARCHAR2(15) not null,
pay_no number(1) not null references paytype(pay_no)
);

-- product
-- product_id(숫자-8 pk), pname(문자), price(숫자), content(문자)
create table product (
product_id number(8) primary key,
pname VARCHAR2(30) not null,
price number(10) not null,
content VARCHAR2(30) not null
);

create sequence product_seq;

-- sorder
-- order_id(숫자-8 pk), user_id(user테이블참조), product_id(product테이블참조)
-- order_seq
create table sorder (
order_id number(8) primary key,
user_id number(4) not null references suser(user_id),
product_id number(8) not null references product(product_id)
);

alter table sorder add order_date DATE;

create sequence order_seq;

-- INSERT INTO sorder VALUES(order_seq.NEXTVAL, 물건을 구매한ID, SYSDATE);

-- user_id, name, pay_no, info 조회 (JOIN사용) 
SELECT U.user_id, U.name, P.pay_no, P.info
FROM PAYTYPE P JOIN SUSER U ON P.PAY_NO = U.PAY_NO; 


-- 주문목록 조회
-- user_id, name, card/cash, product_id, pname, price, content
SELECT u.user_id, u.name, c.info, p.product_id, p.pname, p.price, p.content, o.order_date
from suser u join paytype c on u.pay_no=c.pay_no join sorder o on u.user_id=o.user_id join product p on o.product_id=p.product_id;

-- 홍길동 주문목록 조회
SELECT u.user_id, u.name, c.info, p.product_id, p.pname, p.price, p.content, o.order_date
from suser u, paytype c, sorder o, product p 
where u.pay_no=c.pay_no and u.user_id=o.user_id and o.product_id=p.product_id and u.user_id=1000;


