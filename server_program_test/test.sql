CREATE TABLE test_board(
	board_num INT PRIMARY KEY auto_increment,	-- 게시글 번호
	board_name VARCHAR(20) NOT NULL, 			-- 게시글 작성자
	board_pass VARCHAR(50) NOT NULL, 			-- 게시글 비밀번호
	board_title VARCHAR(50) NOT NULL, 			-- 게시글 제목
	board_content TEXT NOT NULL, 				-- 게시글 내용
	board_readcount INT default 0,				-- 게시글 조회수
	board_date TIMESTAMP default now()			-- 게시글 작성 시간
);

-- sample data 삽입
INSERT INTO test_board(board_name,board_pass,board_title,board_content) 
SELECT board_name,board_pass,board_title,board_content FROM test_board;

-- 게시글 삽입 
INSERT INTO test_board(board_name,board_pass,board_title,board_content) 
VALUES('최기근','12345','첫번째 게시글 입니다.','냉무');

INSERT INTO test_board  
VALUES(null, '최기근','12345','첫번째 게시글 입니다.','냉무', 0, now());

-- 게시글 수정 
UPDATE test_board 
SET board_name = '홍길동',
board_title = '수정된 게시글 제목',
board_content = '게시글 내용 수정' 
WHERE board_pass = '12345';

-- 게시글 삭제
DELETE FROM test_Board WHERE board_num = 1;

-- 조회수 증가
UPDATE test_board SET board_readcount = board_readcount + 1 
WHERE board_num = 1;

-- 게시글 검색
SELECT * FROM test_board;

-- 게시글 부분 검색
--                   							 limit offset, count;
-- page == 1 && perPageNum == 10
SELECT * FROM test_board ORDER BY board_num DESC limit 0, 10;
-- page == 2 && perPageNum == 10
SELECT * FROM test_board ORDER BY board_num DESC limit 10, 10;
-- (page - 1) * perPageNum
-- (1page - 1) * perPageNum(10) == 0
-- (2page - 1) * perPageNum(10) == 10

-- (1page - 1) * perPageNum(5) == 0
SELECT * FROM test_board ORDER BY board_num DESC limit 0, 5;
-- (2page - 1) * perPageNum(5) == 5 
SELECT * FROM test_board ORDER BY board_num DESC limit 5, 5;














