CREATE TABLE tbl_member (
    num INT(8) NOT NULL AUTO_INCREMENT, -- 회원번호
    id VARCHAR(300) NOT NULL UNIQUE,    -- 회원아이디
    pass VARCHAR(200) NOT NULL,         -- 비밀번호
    name VARCHAR(30) NOT NULL,          -- 이름
    addr VARCHAR(300),                  -- 주소
    phone VARCHAR(300) NOT NULL,        -- 전화번호
    PRIMARY KEY (num)
);

DESC tbl_member;
