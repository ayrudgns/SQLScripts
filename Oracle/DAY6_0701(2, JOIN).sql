-- 예제. CUSTOM_ID 'mina012'가 구매한 내용 조회 : PCODE는 조회하지만 PNAME은 알 수 없다.
SELECT PCODE FROM TBL_BUY WHERE CUSTOM_ID = 'mina012';

-- 1. 서브쿼리 (SubQuery, SELECT 안에 SELECT를 사용함.)
SELECT PNAME FROM TBL_PRODUCT tp	-- 외부 쿼리
	WHERE PCODE =		-- 조건식이 = 연산이므로 내부 쿼리는 1개 행의 결과여야 한다.
	(SELECT PCODE FROM TBL_BUY tb	-- 내부 쿼리 (1)
		WHERE CUSTOM_ID = 'mina012' AND BUY_DATE = '2022-02-06');
-- 내부 쿼리가 먼저 실행되고 외부 쿼리가 실행된다.		
SELECT PNAME FROM TBL_PRODUCT tp
	WHERE PCODE IN		-- 조건식이 IN 연산이므로 내부 쿼리는 여러개 행의 결과가 가능하다.
	(SELECT PCODE FROM TBL_BUY tb WHERE CUSTOM_ID = 'mina012');
	-- 내부 쿼리 (2)

-- 내부 쿼리 테스트 (내부 쿼리는 별도로 실행할 수 있다.)
SELECT PCODE FROM TBL_BUY tb	-- 내부 쿼리 (1)
		WHERE CUSTOM_ID = 'mina012' AND BUY_DATE = '2022-02-06'

SELECT PCODE FROM TBL_BUY tb WHERE CUSTOM_ID = 'mina012'	-- 내부 쿼리 (2)

-- 서브 쿼리의 문제점 :
-- 외부 쿼리가 조건식을 모든 행에 대해 검사할 때마다 내부 쿼리가 실행되므로, 처리 속도에 문제가 생긴다.
-- 이러한 문제점을 해결하기 위해서 테이블의 JOIN 연산을 사용한다.

-- 2. SELECT의 테이블 JOIN : 둘 이상의 테이블(주로 참조 관계의 테이블)을 연결하여 데이터를 조회하는 명령
-- 동등 조인 : 둘 이상의 테이블은 공통된 컬럼을 갖고, 이 컬럼값이 '같음(=)'을 이용하여 JOIN한다.
-- 동등 조인 후 양쪽 테이블의 모든 컬럼이 합쳐진다. (현재는 컬럼이 총 9개, 같은 컬럼도 이름 구분)
-- 두개의 값이 같은 행만 합쳐진다. (현재 행은 총 6개)

-- 예제를 위해 상품 추가하기
INSERT INTO TBL_PRODUCT VALUES ('GALAXYS22', 'A1', '갤럭시S22', 555600);
-- TBL_PRODUCT , TBL_BUY 화면 캡처 따놓고 비교하기!

-- 형식 1 : SELECT ~~ FROM 테이블1 A, 테이블2 B (JOIN 키워드 없음)
--					WHERE A.공통컬럼1 = B.공통컬럼1;
SELECT * FROM TBL_PRODUCT tp , TBL_BUY tb 	-- JOIN할 테이블 2개 나열
		WHERE TP.PCODE = TB.PCODE;		-- 동등 조인, JOIN 컬럼으로 = 연산 사용
		
-- JOIN 키워드를 쓰는 명령문 형식 2 (ANSI 표준)
SELECT * FROM TBL_PRODUCT tp
		JOIN TBL_BUY tb
		ON TP.PCODE = TB.PCODE;
	
-- 간단 테스트 : TBL_CUSTOM과 TBL_BUY 조인하기
-- TBL_CUSTOM, TBL_BUY 화면 캡처 따놓고 비교하기!
-- 형식 1
SELECT * FROM TBL_CUSTOM tc, TBL_BUY tb
		WHERE TC.CUSTOM_ID = TB.CUSTOM_ID;
-- 형식 2
SELECT * FROM TBL_CUSTOM tc
		JOIN TBL_BUY tb 
		ON TC.CUSTOM_ID = TB.CUSTOM_ID;

-- JOIN한 결과에서 특정 컬럼만 가져오기
-- CUSTOM_ID 는 .을 찍어서 어떤 테이블의 컬럼명인지 지정해주기	
SELECT TC.CUSTOM_ID, NAME, REG_DATE, PCODE, QUANTITY FROM TBL_CUSTOM tc, TBL_BUY tb
		WHERE TC.CUSTOM_ID = TB.CUSTOM_ID;	
	
-- JOIN 조건 외에 다른 조건을 추가해보기	
SELECT TC.CUSTOM_ID, NAME, REG_DATE, PCODE, QUANTITY
		FROM TBL_CUSTOM tc, TBL_BUY tb
		WHERE TC.CUSTOM_ID = TB.CUSTOM_ID AND TC.CUSTOM_ID = 'mina012';			
	
-- mina012가 구매한 상품명은 무엇인지 조회하기
SELECT TP.PNAME FROM TBL_PRODUCT tp, TBL_BUY tb
		WHERE TP.PCODE = TB.PCODE AND CUSTOM_ID = 'mina012';
	
SELECT TP.PNAME FROM TBL_PRODUCT tp JOIN TBL_BUY tb
			ON TP.PCODE = TB.PCODE AND CUSTOM_ID ='mina012';

SELECT TP.PNAME FROM TBL_PRODUCT tp JOIN TBL_BUY tb
	ON TP.PCODE = TB.PCODE AND CUSTOM_ID ='mina012' AND BUY_DATE = '2022-02-06';
	
-- mina012가 구매한 상품명과 가격 조회하기
SELECT TP.PNAME, TP.PRICE FROM TBL_PRODUCT tp, TBL_BUY tb
		WHERE TP.PCODE = TB.PCODE AND CUSTOM_ID = 'mina012';
	
-- JOIN 명령에서 이름이 같은 컬럼은 테이블명을 반드시 지정해야 한다.	

-- 3개의 테이블을 조인할 수 있을까?
SELECT * FROM TBL_PRODUCT tp,
	(SELECT tc.CUSTOM_ID CUSID, NAME, EMAIL, AGE, REG_DATE, PCODE, QUANTITY, BUY_DATE, BUYNO
		FROM TBL_CUSTOM tc, TBL_BUY tb WHERE TC.CUSTOM_ID = TB.CUSTOM_ID) TEMP	-- 첫번째 조인		
WHERE TP.PCODE = TEMP.PCODE;		-- 두번째 조인

SELECT * FROM TBL_BUY tb, TBL_CUSTOM tc, TBL_PRODUCT tp
	WHERE TB.PCODE = TP.PCODE AND TB.CUSTOM_ID = TC.CUSTOM_ID;

-- 특정 컬럼만 조회하기
SELECT TB.CUSTOM_ID, TB.PCODE, NAME, AGE, PNAME, QUANTITY, BUY_DATE
	FROM TBL_BUY tb, TBL_CUSTOM tc, TBL_PRODUCT tp
	WHERE TB.PCODE = TP.PCODE AND TB.CUSTOM_ID = TC.CUSTOM_ID;

-- 3. 외부 조인 (OUTER JOIN) : (=) 연산을 사용하는 조인이나 한쪽에 없는 값(NULL)도 조인 결과로 포함한다.
-- JOIN 키워드 없는 형식 1
SELECT * FROM TBL_PRODUCT tp, TBL_BUY tb
	WHERE TP.PCODE = TB.PCODE(+);
-- 외부 조인 TBL_BUY 테이블에 일치하는 PCODE 값이 없어도 조인한다.
-- 조인했을 때 NULL이 되는 테이블의 컬럼에 (+)기호를 붙인다.

-- JOIN 키워드를 쓰는 명령문 형식 2 (ANSI 표준), 외부 조인은 LEFT JOIN을 주로 쓴다.
-- 부모 테이블이 왼쪽에 있으면 LEFT JOIN이다.
-- 참조하는 경우에만 가능하기 때문에, 참조 관계에 있을 때 부모 테이블은 다 나오게 하라는 의미이다. 
SELECT * FROM TBL_PRODUCT tp
		LEFT OUTER JOIN TBL_BUY tb
		ON TP.PCODE = TB.PCODE;			-- TBL_PRODUCT가 왼쪽 테이블이며 그 값을 모두 포함하여 조인한다.
		
SELECT * FROM TBL_BUY tb
		RIGHT OUTER JOIN TBL_PRODUCT tp
		ON TB.PCODE = TP.PCODE;
