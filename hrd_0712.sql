-- ANSI 인코딩 형식으로 hrd_0712.sql 파일을 한꺼번에 실행시킨다.
-- 반드시 순서 잘 고려해서 작성하기

-- step 1 : 테이블, 시퀀스 만들기

create table member_tbl_02 (
custno number(6) primary key,
custname varchar2(20),
phone varchar2(13),
address varchar2(60),
joindate date,
grade char(1),
city char(2));

create table money_tbl_02 (
custno number(6) not null,
salenol number(8) not null,
pcost number(8),
amount number(4),
price number(8),
pcode varchar2(4),
sdate date,
primary key(custno, salenol),
foreign key(custno) references member_tbl_02 (custno));

create sequence custno_seq01 start with 100001;

-- step 2 : 참조 테이블 먼저 insert 하기

insert into member_tbl_02 values
	(custno_seq01.nextval, '김행복', '010-1111-2222', '서울 동대문구 휘경1동', '2015-12-02', 'A', '01');
insert into member_tbl_02 values
	(custno_seq01.nextval, '이축복', '010-1111-3333', '서울 동대문구 휘경2동', '2015-12-06', 'B', '01');
insert into member_tbl_02 values
	(custno_seq01.nextval, '장믿음', '010-1111-4444', '울릉군 울릉읍 독도1리', '2015-10-01', 'B', '30');
insert into member_tbl_02 values
	(custno_seq01.nextval, '최사랑', '010-1111-5555', '울릉군 울릉읍 독도2리', '2015-11-13', 'A', '30');
insert into member_tbl_02 values
	(custno_seq01.nextval, '진평화', '010-1111-6666', '제주도 제주시 외나무골', '2015-12-25', 'B', '60');
insert into member_tbl_02 values
	(custno_seq01.nextval, '차공단', '010-1111-7777', '제주도 제주시 감나무골', '2015-12-11', 'C', '60');

-- step 3 : 참조하는 테이블(외래키가 있는 테이블) insert 하기

insert into money_tbl_02 values
	(100001, 20160001, 500, 5, 2500, 'A001', '2016-01-01');
insert into money_tbl_02 values
	(100001, 20160002, 1000, 4, 4000, 'A002', '2016-01-01');
insert into money_tbl_02 values
	(100001, 20160003, 500, 3, 1500, 'A008', '2016-01-01');
insert into money_tbl_02 values
	(100002, 20160004, 2000, 1, 2000, 'A004', '2016-01-02');
insert into money_tbl_02 values
	(100002, 20160005, 500, 1, 500, 'A001', '2016-01-03');
insert into money_tbl_02 values
	(100003, 20160006, 1500, 2, 3000, 'A003', '2016-01-03');
insert into money_tbl_02 values
	(100004, 20160007, 500, 2, 1000, 'A001', '2016-01-04');
insert into money_tbl_02 values
	(100004, 20160008, 300, 1, 300, 'A005', '2016-01-04');
insert into money_tbl_02 values
	(100004, 20160009, 600, 1, 600, 'A006', '2016-01-04');
insert into money_tbl_02 values
	(100004, 20160010, 3000, 1, 3000, 'A007', '2016-01-06');

-- insert 결과 확인하기

select * from member_tbl_02;
select * from money_tbl_02;

-- 회원매출조회 join과 group by 하기

-- step 1 회원별 매출합계
select custno, sum(price) from money_tbl_02 group by custno;

-- step 2 정렬 기준 확인하기
select custno, sum(price) from money_tbl_02 group by custno order by sum(price) desc;

-- step 3 custno 컬럼으로 조인하여 고객 정보 전체 가져오기
select * from member_tbl_02 met,
	(select custno, sum(price) asum from money_tbl_02 mot 
	group by custno
	order by asum desc) sale
where met.custno = sale.custno;
-- 또는
select * from member_tbl_02 met join
	(select custno, sum(price) asum from money_tbl_02 mot 
	group by custno
	order by asum desc) sale
on met.custno = sale.custno;

-- step 4 필요한 컬럼만 가져오기
select met.custno, custname,
	decode(met.grade, 'A', 'VIP', 'B', '일반', 'C', '직원') as grade,
	sale.asum
	from member_tbl_02 met join
	(select custno, sum(price) asum from money_tbl_02 mot 
	group by custno
	order by asum desc) sale
	on met.custno = sale.custno;
-- 또는
select met.custno, custname,
	decode(met.grade, 'A', 'VIP', 'B', '일반', 'C', '직원') as grade,
	sale.asum
	from member_tbl_02 met,
	(select custno, sum(price) asum from money_tbl_02 mot 
	group by custno
	order by asum desc) sale
	where met.custno = sale.custno;

++ decode(grade, 'A', 'VIP', 'B', '일반', 'C', '직원');