-- 1. 데이터베이스를 선택합니다.
USE digital_jsp;

-- 2. 기존 테이블이 존재할 경우 삭제합니다.
DROP TABLE IF EXISTS Used_Books;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS member;
DROP TABLE IF EXISTS baskin;
DROP TABLE IF EXISTS some_table;

-- 3. 테이블 생성

-- Books 테이블 생성 (category 열 포함)
CREATE TABLE IF NOT EXISTS Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,  -- 도서 ID (고유 식별자, 자동 증가)
    title VARCHAR(255) NOT NULL,             -- 도서 제목
    author VARCHAR(255),                     -- 저자
    category VARCHAR(255),                   -- 카테고리
    price DECIMAL(10, 2)                     -- 가격
);

-- member 테이블 생성 (phone 열 포함)
CREATE TABLE IF NOT EXISTS member (
    memberNum INT PRIMARY KEY AUTO_INCREMENT, -- 회원 번호 (고유 식별자, 자동 증가)
    name VARCHAR(255) NOT NULL,              -- 회원 이름
    email VARCHAR(255) UNIQUE NOT NULL,      -- 이메일 (고유)
    phone VARCHAR(20)                        -- 전화번호
);

-- Used_Books 테이블 생성
CREATE TABLE IF NOT EXISTS Used_Books (
    used_book_id INT PRIMARY KEY AUTO_INCREMENT,  -- 중고 도서 ID (고유 식별자, 자동 증가)
    memberNum INT NOT NULL,                     -- 회원 번호 (외래키)
    book_id INT NOT NULL,                       -- 도서 ID (외래키)
    price DECIMAL(10, 2) NOT NULL,              -- 가격
    status ENUM('최상', '상', '중', '하') NOT NULL, -- 상태
    description TEXT,                            -- 설명
    FOREIGN KEY (memberNum) REFERENCES member(memberNum) ON DELETE CASCADE, -- 외래키 제약 조건 (회원 탈퇴 시 중고 도서 정보 삭제)
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE       -- 외래키 제약 조건 (도서 삭제 시 중고 도서 정보 삭제)
);

-- baskin 테이블 생성
CREATE TABLE IF NOT EXISTS baskin (
    id INT PRIMARY KEY AUTO_INCREMENT,  -- 기본 키
    category VARCHAR(255) NOT NULL    -- 카테고리 이름
);

-- some_table 테이블 생성
CREATE TABLE IF NOT EXISTS some_table (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

-- 4. 샘플 데이터 삽입

-- Books 테이블에 데이터 삽입
INSERT INTO Books (title, author, category, price) VALUES
('Java Programming', 'John Doe', 'Programming', 29.99),
('Database Systems', 'Jane Smith', 'Databases', 39.99),
('Web Development', 'Emily Johnson', 'Web', 25.50);

-- member 테이블에 데이터 삽입
INSERT INTO member (name, email, phone) VALUES
('Alice', 'alice@example.com', '123-456-7890'),
('Bob', 'bob@example.com', '234-567-8901'),
('Charlie', 'charlie@example.com', '345-678-9012');

-- Used_Books 테이블에 데이터 삽입
INSERT INTO Used_Books (memberNum, book_id, price, status, description) VALUES
(1, 1, 20.00, '상', 'Good condition'),
(2, 2, 30.00, '중', 'Some wear and tear'),
(3, 3, 15.00, '하', 'Worn out but readable');

-- baskin 테이블에 데이터 삽입
INSERT INTO baskin (category) VALUES
('Fiction'),
('Non-Fiction');

-- some_table 테이블에 데이터 삽입
INSERT INTO some_table (name) VALUES
('Sample Entry 1'),
('Sample Entry 2');
