-- test_member 테이블 생성
CREATE TABLE test_member (
    num INT PRIMARY KEY AUTO_INCREMENT,    -- 회원 번호 (자동 증가하는 정수, 기본키)
    id VARCHAR(50) UNIQUE NOT NULL,       -- 아이디 (최대 50자, 중복 불가, 필수 입력)
    pass VARCHAR(200) NOT NULL,          -- 비밀번호 (최대 200자, 필수 입력)
    addr TEXT,                            -- 주소 (텍스트 형식)
    phone VARCHAR(20),                    -- 전화번호 (최대 20자)
    gender VARCHAR(10),                   -- 성별 (최대 10자)
    age INT(3)                            -- 나이 (최대 3자리 정수)
);

-- test_member 테이블에 데이터 삽입
INSERT INTO test_member 
VALUES (null, 'admin', 'admin', '부산', '01011111111', '남성', 26); 
-- 회원 번호는 자동 증가하므로 null로 지정, 나머지 값들을 순서대로 입력

-- test_member 테이블의 모든 데이터 조회
SELECT * FROM test_member; 
