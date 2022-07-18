-- 주제 : 그룹화(행을 그룹화 하기)
-- 순서는 아래와 같다.	([]는 선택사항)
-- SELECT 그룹함수 FROM 테이블명
-- [WHERE] 그룹화하기 전에 사용할 조건식
-- GROUP BY 그룹화에 사용할 컬럼명
-- [HAVING] 그룹화 결과에 대한 조건식
-- [ORDER BY] 그룹화 결과를 정렬할 컬럼명과 방식

SELECT PCODE, COUNT(*) FROM TBL_BUY tb GROUP BY PCODE;

SELECT PCODE, COUNT(*) , SUM(QUANTITY)
	FROM TBL_BUY tb GROUP BY PCODE ORDER BY 2;	-- 조회된 컬럼의 위치(인덱스)

SELECT PCODE, COUNT(*) CNT, SUM(QUANTITY) TOTAL
	FROM TBL_BUY tb GROUP BY PCODE ORDER BY CNT;	-- 그룹함수 결과의 별칭 CNT

-- 그룹화 후에 수량 합계가 3 이상만 조회하기
SELECT PCODE, COUNT(*) CNT, SUM(QUANTITY) TOTAL
	FROM TBL_BUY tb
	GROUP BY PCODE
--	HAVING TOTAL >= 3		-- HAVING에는 컬럼 별칭을 사용할 수 없다. 테이블 컬럼명은 사용할 수 있다.
	HAVING SUM(QUANTITY) >= 3 
	ORDER BY CNT;	-- 그룹함수 결과의 별칭 CNT	
	
SELECT * FROM TBL_BUY tb2 ;
-- 구매 날짜가 2022-04-01 이후인 것만 그룹화하여 조회하기
SELECT PCODE, COUNT(*) CNT, SUM(QUANTITY) TOTAL
	FROM TBL_BUY tb
	WHERE BUY_DATE >= '2022-04-01'
	GROUP BY PCODE
	ORDER BY CNT;


