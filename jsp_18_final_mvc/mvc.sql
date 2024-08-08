-- mvc.sql

-- 데이터베이스 사용 설정
-- use digital_jsp

-- 회원 정보를 저장할 테이블 생성
CREATE TABLE IF NOT EXISTS mvc_member(
	num INT PRIMARY KEY AUTO_INCREMENT,		-- 회원번호 (기본키, 자동증가)
	id VARCHAR(30) UNIQUE,					-- 회원아이디 (고유값)
	pass VARCHAR(30) NOT NULL,				-- 비밀번호 (필수)
	name VARCHAR(20),						-- 이름
	age INT(3),								-- 나이 (최대 3자리 숫자)
	gender ENUM('male', 'female'),			-- 성별 (male 또는 female)
	regdate TIMESTAMP DEFAULT now(),		-- 회원 가입일 (기본값: 현재 시간)
	updatedate TIMESTAMP DEFAULT now()		-- 회원정보 수정 시간 (기본값: 현재 시간)
);

-- 모든 회원 정보 조회
SELECT * FROM mvc_member;

-- 관리자 계정을 테이블에 삽입
INSERT INTO mvc_member 
VALUES(null, 'admin', 'admin', 'MASTER', 23, 'male', now(), sysdate());

-- 기존 백업 테이블을 삭제
DROP TABLE mvc_member_backup;

-- 기존에 백업 테이블이 있으면 해당 테이블의 모든 데이터를 조회
SELECT * FROM mvc_member_backup;

-- 백업 테이블의 구조를 설명
DESC mvc_member_backup;

-- mvc_member 테이블과 동일한 구조의 빈 테이블을 생성
CREATE TABLE mvc_member_backup (SELECT * FROM mvc_member WHERE 1 = 0);

-- mvc_member 테이블의 구조를 그대로 복사하여 새로운 테이블 생성
CREATE TABLE mvc_member_backup LIKE mvc_member;

-- 특정 ID를 가진 회원 정보를 mvc_member와 mvc_member_backup 테이블에서 조회
SELECT * FROM mvc_member WHERE id = 'id002'
UNION 
SELECT * FROM mvc_member_backup WHERE id = 'id002';

-- 회원 삭제 시 자동으로 백업 테이블에 추가하는 트리거 생성
DELIMITER //
	CREATE TRIGGER after_delete_member 
    AFTER DELETE ON mvc_member 
    FOR EACH ROW 
    BEGIN
		-- 삭제된 회원 정보를 mvc_member_backup 테이블에 삽입
		INSERT INTO mvc_member_backup 
        VALUES(OLD.num, OLD.id, OLD.pass, OLD.name, OLD.age, OLD.gender, OLD.regdate, now());
	END //
DELIMITER ;

-- 모든 회원 정보 조회
SELECT * FROM mvc_member;

-- 회원번호가 5인 회원 정보를 삭제
DELETE FROM mvc_member WHERE num = 5;

/******************************************************************************/
-- 등록된 회원만 참여 가능한 답변형 게시물 정보를 저장할 테이블 생성
CREATE TABLE qna_board(
	qna_num INT PRIMARY KEY AUTO_INCREMENT,					-- 글번호 (기본키, 자동증가)
	qna_title VARCHAR(200) NOT NULL,						-- 게시글 제목 (필수)
	qna_content TEXT NOT NULL,								-- 글 내용 (필수)
	qna_writer_num INT NOT NULL,							-- 작성자 회원번호 (필수)
	qna_readcount INT DEFAULT 0,							-- 조회 수 (기본값: 0)
	qna_date TIMESTAMP DEFAULT NOW()						-- 게시글 작성시간 (기본값: 현재 시간)
);

-- 원본글 번호를 나타내는 컬럼 추가
ALTER TABLE qna_board ADD COLUMN qna_re_ref INT NOT NULL DEFAULT 0;

-- 답변글 정렬 번호를 나타내는 컬럼을 qna_re_ref 컬럼 뒤에 추가
ALTER TABLE qna_board 
ADD COLUMN qna_re_seq INT NOT NULL DEFAULT 0 AFTER qna_re_ref;

-- qna_board 테이블의 구조 설명
DESC qna_board;

-- v_qna_board 뷰에서 모든 데이터 조회
SELECT * FROM v_qna_board;

-- qna_board와 mvc_member 테이블을 조인하여 뷰를 생성하거나 대체
CREATE OR REPLACE VIEW v_qna_board AS 
SELECT
	Q.qna_num AS qnaNum,						-- 게시글 번호
	M.name AS qnaName,							-- 작성자 이름
	Q.qna_title AS qnaTitle,					-- 게시글 제목
	Q.qna_content AS qnaContent,				-- 게시글 내용
	Q.qna_writer_num AS qnaWriterNum,			-- 작성자 회원번호
	Q.qna_readcount AS qnaReadCount,			-- 조회 수
	Q.qna_date AS qnaDate,						-- 작성 시간
	Q.qna_re_ref AS qnaReRef,					-- 원본글 번호
	Q.qna_re_seq AS qnaReSeq					-- 답변글 정렬 번호
FROM qna_board AS Q 
JOIN mvc_member AS M 
ON Q.qna_writer_num = M.num;

-- v_qna_board 뷰의 구조 설명
DESC v_qna_board;

-- 특정 게시글 번호(qnaNum)로 조회
SELECT * FROM v_qna_board WHERE qnaNum = 1;

-- qna_board와 mvc_member 테이블을 조인하여 모든 게시글 조회
SELECT Q.*, M.name AS qna_name 
FROM qna_board AS Q, mvc_member AS M 
WHERE Q.qna_writer_num = M.num;

-- 특정 게시글 번호(qna_num)로 조회
SELECT B.*, 
	(SELECT name FROM mvc_member WHERE num = B.qna_writer_num) AS qna_name 
FROM qna_board AS B 
WHERE qna_num = 1;

-- qnaReRef 컬럼의 값을 게시글 번호(qnaNum)로 수정
UPDATE v_qna_board SET qnaReRef = qnaNum;

-- 변경 사항 저장
commit;

-- 새로운 게시글을 v_qna_board 뷰에 삽입
INSERT INTO v_qna_board(qnaTitle, qnaContent, qnaWriterNum) 
VALUES('내일 비오나요?진짜 진짜 냉무','제곧내',6);

-- 마지막으로 삽입된 ID 조회
SELECT LAST_INSERT_ID();

-- 마지막으로 삽입된 게시글의 qnaReRef 값을 해당 게시글 번호로 수정
UPDATE v_qna_board SET qnaReRef = LAST_INSERT_ID() 
WHERE qnaNum = LAST_INSERT_ID();

-- 변경 사항 저장
commit;
