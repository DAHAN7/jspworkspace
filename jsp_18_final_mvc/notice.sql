-- 기존에 notice_board 테이블이 존재하는 경우 삭제
DROP TABLE IF EXISTS notice_board;

-- 공지용 게시판 notice_board 테이블 생성
CREATE TABLE IF NOT EXISTS notice_board(
	notice_num int primary key auto_increment,	-- 게시글 번호 (기본키, 자동 증가)
	notice_category VARCHAR(20),				-- 게시글 분류 (최대 20자)
	notice_author VARCHAR(50),					-- 작성자 이름 (최대 50자)
	notice_title VARCHAR(50),					-- 제목 (최대 50자)
	notice_content TEXT,						-- 내용 (TEXT 타입, 대용량 텍스트 저장 가능)
	notice_date TIMESTAMP default now()			-- 작성 시간 (기본값: 현재 시간)
);

-- 테이블 내 전체 게시글 수 조회
SELECT count(*) FROM notice_board;

-- 테이블 내 모든 게시글 조회
SELECT * FROM notice_board;

-- 작성자 이름에 "안녕"이 포함된 게시글 수를 조회
SELECT count(*) FROM notice_board
WHERE notice_author LIKE CONCAT('%','안녕','%');

-- notice_board 테이블의 모든 데이터를 복사하여 같은 테이블에 삽입
INSERT INTO notice_board (
	SELECT null, notice_category, notice_author, notice_title, notice_content, notice_date FROM notice_board
);

-- 테이블 내 전체 게시글 수 조회 (데이터 복사 후)
SELECT count(*) FROM notice_board;

-- 새로운 공지 게시글 작성
INSERT INTO notice_board 
VALUES(null,'공지','최기근','장난입니다.','내용이 없습니다.내용이 없습니다.',now());

-- 테이블 내 모든 게시글을 최신순으로 조회
SELECT * FROM notice_board ORDER BY notice_num DESC;

-- 특정 범위 내에서 게시글 조회 (최신순으로 10개)
SELECT * FROM notice_board ORDER BY notice_num DESC limit 10 OFFSET 0;

-- 위와 동일한 쿼리 (다른 형태로 작성)
SELECT * FROM notice_board ORDER BY notice_num DESC limit 0, 10;

-- 두 문자열 'A'와 'B'를 더한 결과를 조회 (결과는 문자열 결합)
SELECT 'A' + 'B' FROM DUAL;

-- 두 숫자 1과 2를 더한 결과를 조회 (결과는 3)
SELECT 1 + 2 FROM DUAL;

-- 제목에 '동'이 포함된 게시글 조회
SELECT * FROM notice_board WHERE notice_title LIKE '%동%';

-- 제목에 '서울'이 포함된 게시글을 최신순으로 최대 15개 조회
SELECT * FROM notice_board
WHERE notice_title LIKE CONCAT('%','서울','%') 
ORDER BY notice_num DESC limit 0, 15;

-- 작성자 이름에 '로또'가 포함된 게시글 수를 조회
SELECT count(*) FROM notice_board 
-- WHERE notice_title LIKE CONCAT('%','로또','%'); 
WHERE notice_author LIKE CONCAT('%','로또','%');

-- notice_board 테이블의 모든 데이터를 복사하여 같은 테이블에 삽입
INSERT INTO notice_board (
	SELECT 
		null, notice_category, 
		notice_author, notice_title, 
		notice_content, notice_date 
	FROM notice_board
);
