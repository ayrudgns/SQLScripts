-- 강사님이 하신거

CREATE TABLE students0(
	stuno char(7) PRIMARY KEY,
	name nvarchar2(20) NOT NULL,
	age number(3) CHECK (age BETWEEN 10 AND 30),
	address nvarchar2(50)
);

INSERT INTO students0(stuno,name,age,address)
VALUES ('2021001','김모모',16,'서초구');
INSERT INTO students0(stuno,name,age,address)
VALUES ('2019019','강다현',18,'강남구');

CREATE TABLE scores0(
	stuno char(7),		-- PRIMARY KEY 있음.
	subject nvarchar2(20),	-- PRIMARY KEY 있음.
	jumsu number(3) NOT NULL,	-- 점수
	teacher nvarchar2(20) NOT NULL,
	term char(6) NOT NULL,	-- 학기
	PRIMARY KEY (stuno,subject),		-- 기본키 설정
	FOREIGN KEY (stuno) REFERENCES students0(stuno)
				-- 외래키 설정 : REFERENCES(참조) 키워드 뒤에 참조테이블명(참조컬럼명)
				-- 외래키컬럼명과 참조컬럼명이 같으면 참조테이블명 뒤에 참조컬럼명 생략 가능
				-- 외래키 컬럼은 FOREIGN KEY 키워드 뒤 () 안에 작성, LINE 22에서는 스코어테이블 stuno
	-- 검색 : 참조컬럼의 조건은?
	-- 참조하는 부모테이블의 컬럼(참조키)는 PK이거나, UNIQUE 제약조건 컬럼만 가능하다.
);

INSERT INTO scores0(stuno,subject,jumsu,teacher,term)
VALUES ('2021001','국어',89,'이나연','2022_1');
INSERT INTO scores0(stuno,subject,jumsu,teacher,term)
VALUES ('2021001','영어',78,'김길동','2022_1');
INSERT INTO scores0(stuno,subject,jumsu,teacher,term)
VALUES ('2021001','과학',67,'박세리','2021_2');
INSERT INTO scores0(stuno,subject,jumsu,teacher,term)
VALUES ('2019019','국어',92,'이나연','2019_2');
INSERT INTO scores0(stuno,subject,jumsu,teacher,term)
VALUES ('2019019','영어',85,'박지성','2019_2');
INSERT INTO scores0(stuno,subject,jumsu,teacher,term)
VALUES ('2019019','과학',88,'박세리','2020_1');

SELECT * FROM SCORES0 s;
