-- JAVADB

-- userTBL 테이블 생성
-- no(번호-숫자(4)), username(이름-한글(4)), birthYear(년도-숫자(4)), addr(주소-문자(한글,숫자)), mobile(010-1234-1234)
-- no pk 제약조건 지정 (제약조건명 pk_userTBL)

CREATE TABLE userTBL (
no number(4) constraint pk_userTBL primary key,
username VARCHAR2(20),
birthYear number(4),
addr VARCHAR2(50),
mobile VARCHAR2(13)
);

drop table userTBL; 


-- select(서브쿼리, 조인) + DML (insert, delete, update) 
-- 전체조회
select * from usertbl;
-- 개별조회(특정번호, 특정이름...)
-- 여러행이 나오는 상태냐? 하나의 행이 결과로 나올것이냐? - pk의 경우엔 하나밖에 안나옴 
select * from usertbl where no=1;
select * from usertbl where username='홍길동';

-- like : _ or % 
select * from usertbl where username like '_길동%';

-- insert into 테이블명(필드명1, 필드명2...)
-- values();

--update 테이블명
--set 업데이트할 필드명=값, 업데이트할 필드명=값,...
--where 조건;

--delete from 테이블명 where 조건




-- 시퀀스 생성 (시퀀스는 테이블이랑 별개로 돌아가고있음)
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



-- 도서 테이블
-- code, title, writer, price
-- code : 1001 (pk)
-- title : '자바의 신'
-- writer : '홍길동'
-- price : 25000

-- bookTBL 테이블생성
create table booktbl(
code number(4) primary key, --not null+unique
title nvarchar2(50) not null,
writer nvarchar2(20) not null,
price number(8) not null
);

insert into booktbl(code, title, writer, price) values(1001, '이것이 자바다', '신용균', 25000);
insert into booktbl(code, title, writer, price) values(1002, '자바의 신', '강신용', 25800);
insert into booktbl(code, title, writer, price) values(1003, '오라클로 배우는 데이터베이스', '이지훈', 19000);
insert into booktbl(code, title, writer, price) values(1004, '자바 1000제', '김용만', 30000);
insert into booktbl(code, title, writer, price) values(1005, '자바 프로그래밍 입문', '박은종', 24000);


alter table booktbl add description nvarchar2(100);

commit;


---------------------------------


-- member 테이블
-- userid (영어, 숫자, 특수문자) 최대12허용, pk 
-- password (영어,숫자,특수문자) 최대15허용
-- name (한글)
-- gender (한글 - 남/여)
-- email 

create table membertbl (
userid varchar2(15) primary key,
password varchar2(20) not null,
name nvarchar2(20) not null,
gender nvarchar2(2) not null,
email varchar2(50) not null
);

insert into membertbl values('hong123', 'hong123@', '홍길동', '남', 'hong123@gmail.com');



--------------------------


-- 게시판 board 
-- 글번호(bno, 숫자, 시퀀스 삽입, pk(pk_board제약조건명), 작성자(name, 한글), 비밀번호(password, 숫자,영문자), 제목(title, 한글), 
-- 내용(content, 한글), 파일첨부(attach, 파일명), 답변글 작성시 참조되는 글번호(re_ref, 숫자), 답변글 레벨(re_lev, 숫자), 
-- 답변글 순서(re_seq, 숫자), 조회수(cnt, 숫자, default로 0지정), 작성날짜(regdate, defalut로 sysdate지정)


create table board (
bno number(8) constraint pk_board primary key,
name nvarchar2(20) not null,
password varchar2(20) not null,
title nvarchar2(50) not null,
content nvarchar2(2000) not null,
attach nvarchar2(100),
re_ref number(8) not null,
re_lev number(8) not null,
re_seq number(8) not null,
cnt number(8) default 0,
regdate date default sysdate
);


-- 시퀀스생성 board_seq 
create sequence board_seq;



-- 서브쿼리 ( 게시글 x2로 늘리기 )
insert into board(bno, name, password, title, content, re_ref, re_lev, re_seq)
(select board_seq.nextval, name, password, title, content, board_seq.currval, re_lev, re_seq from board);


----------------- 댓글
-- re_ref, re_lev, re_seq

-- 원본글 작성 re_ref : bno값과 동일
--            re_lev : 0, re_seq : 0

select bno, title, re_ref, re_lev, re_seq from board where bno=4606;

-- re_ref : 그룹번호
-- re_seq : 그룹 내에서 댓글의 순서
-- re_lev : 그룹 내에서 댓글의 깊이 (원본의 댓글인지? 댓글의 댓글인지?) 

-- 댓글도 새글임 => insert작업
--                bno : board_seq.nextval
--                re_ref : 원본글의 re_ref값과 동일  (같은그룹이니까)
--                re_seq : 원본글의 re_seq + 1
--                re_lev : 원본글의 re_lev + 1

-- 첫번째 댓글 작성
insert into board(bno, name, password, title, content, attach, re_ref, re_lev, re_seq)
values(board_seq.nextval, '김댓글', '12345', 'Re : 게시글', '게시글 댓글', null, 4606, 1, 1);

commit;

-- 가장 최신글과 댓글 가지고 오기 ( +re_seq asc : 댓글의 최신순으로 정렬) 
select bno, title, re_ref, re_lev, re_seq from board where re_ref=4606 order by re_seq;


-- 두번째 댓글 작성
-- re_seq가 값이 작을수록 최신글임 (나중에 단 댓글이 위로 오도록) 

-- 기존 댓글이 있는가? 따져서 기존댓글의 re_seq변경을(update) 한 후 insert작업을 해야함 
-- update구문에서 where절은 re_ref는 원본글의 re_ref값, re_seq비교구문은 원본글의 re_seq값과 비교 
-- 기존에있던 댓글들의 re_seq가 1씩 증가하게됨 
update board set re_seq = re_seq + 1 where re_ref = 4606 and re_seq > 0;

insert into board(bno, name, password, title, content, attach, re_ref, re_lev, re_seq)
values(board_seq.nextval, '김댓글', '12345', 'Re : 게시글2', '게시글 댓글2', null, 4606, 1, 1);


-- 댓글의 댓글 작성
-- update / insert 
-- 지금있는 원본글을 기준으로 
update board set re_seq = re_seq + 1 where re_ref = 4606 and re_seq > 2;

insert into board(bno, name, password, title, content, attach, re_ref, re_lev, re_seq)
values(board_seq.nextval, '김댓글', '12345', 'ReRe : 게시글', '댓글의 댓글', null, 4606, 2, 3);


--------------------------------- 페이지 나누기
-- ROWNUM : 조회된 순서대로 일련번호 매김
--          order by 구문에 index가 들어가지 않는다면 제대로된 결과를 보장하지 않음(rownum순서 뒤죽박죽)
--          pk가 index로 사용됨 
select rownum, bno, title from board order by bno desc;

select rownum, bno, title, re_ref, re_lev, re_seq 
from board order by re_ref desc, re_seq asc;


-- 해결
-- order by 구문을 먼저 실행한 후, rownum을 붙여야 함 -서브쿼리
select rownum, bno, title, re_ref, re_lev, re_seq 
from(select bno, title, re_ref, re_lev, re_seq 
    from board order by re_ref desc, re_seq asc)
where rownum <=30;

-- 한 페이지에 30개의 글을 보여준다 할 때 
-- 1 2 3 4 5 6 ......  
-- 1 page 요청 (1~30)
-- 2 page 요청 (31~60)
-- 3 page 요청 (61~90) .......
-- 서브쿼리 한 번 더 ( where 30<rownum<60 이렇게 한번에 하는게 안됨 ==> rownum<=60을 뽑고 그중에서 rownum>30을 뽑는 방식으로)
select * 
from (select rownum rnum, bno, title, re_ref, re_lev, re_seq 
    from(select bno, title, re_ref, re_lev, re_seq 
        from board order by re_ref desc, re_seq asc)
    where rownum <=60)
where rnum >30;


select * 
from (select rownum rnum, bno, title, re_ref, re_lev, re_seq 
    from(select bno, title, re_ref, re_lev, re_seq 
        from board order by re_ref desc, re_seq asc)
    where rownum <= ?)
where rnum > ?;
-- rownum값 : 페이지번호 * 한 페이지에 보여줄 글 개수
-- rnum값 : (페이지번호-1) * 한 페이지에 보여줄 글 개수




--------------------------------------------스프링--------------------
----- spring_board
-- bno 숫자(10) 제약조건 pk 제약조건명 pk_spring_board
-- title varchar2(200) 제약조건 not null
-- content varchar2(2000) 제약조건 not null
-- writer varchar2(50) 제약조건 not null
-- regdate date default로 현재시스템날짜
-- updatedate date default로 현재시스템날짜

create table spring_board (
bno number(10) constraint pk_spring_board primary key,
title varchar2(200) not null,
content varchar2(2000) not null,
writer varchar2(50) not null,
regdate date default sysdate,
updatedate date default sysdate
);

-- 시퀀스 seq_board 
create sequence seq_board;

commit;


-- mybatis 연습용 테이블
create table person (
id varchar2(20) primary key,
name varchar2(30) not null
);

insert into person values('kim123', '김길동');
insert into person values('ko123', '고길동');
insert into person values('kang123', '강백호');


-- 트랜잭션 테스트 테이블
-- 트랜잭션 : 하나의 업무에 여러개의 작은 업무들이 같이 묶여있음 / 하나의 단위로 처리 
create table tbl_sample1(col1 varchar2(500));
create table tbl_sample2(col1 varchar2(50));

delete tbl_sample1;




commit;




ALTER TABLE membertbl MODIFY password varchar2(100);


-- 페이지 나누기 (무조건 get방식) 
-- ROWNUM : 조회된 순서대로 일련번호 매김
-- spring_board : bno가 pk인 상황 (order by 기준도 bno)
-- 1 page : 가장 최신글 20개
-- 2 page : 그 다음 최신글 20개 

insert into spring_board(bno,title,content,writer)
(select seq_board.nextval,title,content,writer from spring_board);

select count(*) from spring_board;


-- 페이지 나누기를 할 때 필요한 sql 코드
select *
from(select rownum rn, bno, title, writer 
    from (select bno, title, writer from spring_board order by bno desc)
    where rownum <= 20)
where rn>0; 


-- 오라클 힌트 사용 (pk_spring_board는 bno에 줬던 제약조건명임) 
select bno, title, writer, regdate, updatedate 
from (select /*+INDEX_DESC(spring_board pk_spring_board)*/ rownum rn, bno, title, writer, regdate, updatedate 
    from spring_board 
    where rownum <= 40)
where rn >20; 


-- 댓글 테이블
create table spring_reply(
    rno number(10,0) constraint pk_reply primary key,   --댓글 글번호
    bno number(10,0) not null,                          --원본글 글번호
    reply varchar2(1000) not null,                      --댓글 내용
    replyer varchar2(50) not null,                      --댓글 작성자
    replydate date default sysdate,                     --댓글 작성날짜
    constraint fk_reply_board foreign key(bno) references spring_board(bno)     --외래키 제약조건 
);

-- 댓글 테이블 수정(컬럼추가) updatedate
ALTER TABLE spring_reply ADD updatedate date default sysdate;


create sequence seq_reply;

commit;

insert into spring_reply(rno, bno, reply, replyer)
values(seq_reply.nextval, 2301, '댓글을 달아요', 'test1');


-- spring_reply 인덱스 추가설정
create index idx_reply on spring_reply(bno desc, rno asc); 

select rno, bno, reply, replyer, replydate, updatedate 
from (select /*+INDEX(spring_reply idx_reply)*/ rownum rn, rno, bno, reply, replyer, replydate, updatedate
    from spring_reply
    where bno=2301 and rownum <= 10)
where rn > 0; 

-- spring_board 에 컬럼 추가 (댓글 수 저장)
alter table spring_board add replycnt number default 0; 

-- 이미 들어간 댓글 수 삽입
update spring_board
set replycnt = (select count(rno) from spring_reply where spring_board.bno = spring_reply.bno);

select * from spring_board where bno = 2301;




------------------------- 파일첨부
-- spring_attach
-- uuid, uploadpath, filename, filetype
create table spring_attach(
    uuid varchar2(100) constraint pk_attach primary key,
    uploadpath varchar2(200) not null,
    filename varchar2(100) not null,
    filetype char(1) default '1',
    bno number(10,0) not null,
    constraint fk_board_attach foreign key(bno) references spring_board(bno)
);



-- spring_board bno와 spring_attach bno가 일치 시 
-- title,content,writer,bno,  uuid,uploadpath,filetype,filename 가지고 나오기 
-- inner join
select title,content,writer, sa.bno, uuid,uploadpath,filetype,filename 
from spring_board sb, spring_attach sa
where sb.bno = sa.bno; 

select title,content,writer, sa.bno, uuid,uploadpath,filetype,filename 
from spring_board sb join spring_attach sa on sb.bno = sa.bno
where sa.bno=2322;

-- 어제 날짜의 첨부 목록 가져오기
select * from spring_attach where uploadpath = TO_CHAR(sysdate-1, 'yyyy\mm\dd');




-----------------------------
--security 프로젝트에서 사용할 테이블
--user테이블 작성 시 enabled 컬럼 추가 
create table sp_user(
    userid varchar2(50) primary key,
    email varchar2(100) not null,
    password varchar2(100) not null,
    enabled char(1) default '1'
);

--user테이블과 관련된 권한 테이블 작성
create table sp_user_authority(
    userid varchar2(50) not null,
    authority varchar2(50) not null
);

--외래키 설정 
alter table sp_user_authority add constraint sp_suer_authority_fk foreign key(userid) references sp_user(userid);

insert into sp_user(userid,email,password) values('hong123','hong123@gmail.com','1111');
insert into sp_user_authority(userid,authority) values('hong123','ROLE_USER');
insert into sp_user_authority(userid,authority) values('hong123','ROLE_ADMIN');

commit;

-- sp_user 와 sp_user_authority 를 left outer join 
select s1.userid,email,password,enabled,authority
from sp_user s1 left outer join sp_user_authority s2 on s1.userid = s2.userid;

-- 특정 user의 정보 추출
select s1.userid,email,password,enabled,authority
from sp_user s1 left outer join sp_user_authority s2 on s1.userid = s2.userid 
where s1.userid = 'hong123';

-- remember-me 를 위한 테이블 작성 (반드시 이걸 만들어야함 - 테이블명과 필드명 정해져있음) 
create table persistent_logins(
    username varchar(64) not null,
    series varchar(64) primary key,
    token varchar(64) not null,
    last_used timestamp not null
);


-- spring_board 연결할 user 테이블 생성 => spring_member 
-- userid, userpw, username(성명), regdate, updatedate, enabled
create table spring_member (
    userid varchar2(50) primary key,
    userpw varchar2(100) not null,
    username varchar2(100) not null,
    regdate date default sysdate,
    updatedate date default sysdate,
    enabled char(1) default '1'
);

-- spring_member 권한 테이블 생성 => spring_member_auth 
-- userid, auth 
create table spring_member_auth (
    userid varchar2(50) not null, 
    auth varchar2(50) not null,
    constraint fk_member_auth foreign key(userid) references spring_member(userid)
);







