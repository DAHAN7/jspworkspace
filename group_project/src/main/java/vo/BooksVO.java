package vo;

import java.util.Date;

/*

 * books 
 * table의 행정보를 저장할 Value Object

CREATE TABLE books (
book_no INT PRIMARY KEY AUTO_INCREMENT,				-- 제품 등록 번호
book_id VARCHAR(200) NOT NULL UNIQUE,				-- 제품 등록 ID 
title VARCHAR(255) NOT NULL,						-- 책 이름
author VARCHAR(100) NOT NULL,						-- 저자  
publisher VARCHAR(100) NOT NULL, 					-- 출판사 
book_memo TEXT,										-- 한줄 소개
new_old_ebook VARCHAR(50) NOT NULL,					-- 신품,중고,ebook
price INT NOT NULL,									-- 제품 가격 
stock INT NOT NULL,									-- 입고 수량
category_overseas VARCHAR(50) NOT NULL, 			-- 국내/외 구분
category_age VARCHAR(50),							-- 연령대 구분
category_all 	VARCHAR(50) NOT NULL,		        -- 대분류
insert_day TIMESTAMP NOT NULL DEFAULT now(),		-- 최초 등록한 날짜
book_fileName  VARCHAR(300)							-- 책이미지파일이름
);

 */
public class BooksVO {
	
	private int book_no; 			
	private String book_id;  
	private String title; 
	private String author;  
	private String publisher; 
	private String book_memo; 
	private String new_old_ebook; 
	private int price; 
	private int stock;	
	private String category_overseas; 
	private String category_age;
	private String category_all; 
	private Date insert_day; 
	private String book_fileName;
	private int seller_id;
	
	public BooksVO() {
		super();
	}	



	public BooksVO(int book_no, String book_id, String title, String author, String publisher, String book_memo,
			String new_old_ebook, int price, int stock, String category_overseas, String category_age,
			String category_all, Date insert_day, String book_fileName, int seller_id) {
		super();
		this.book_no = book_no;
		this.book_id = book_id;
		this.title = title;
		this.author = author;
		this.publisher = publisher;
		this.book_memo = book_memo;
		this.new_old_ebook = new_old_ebook;
		this.price = price;
		this.stock = stock;
		this.category_overseas = category_overseas;
		this.category_age = category_age;
		this.category_all = category_all;
		this.insert_day = insert_day;
		this.book_fileName = book_fileName;
		this.seller_id = seller_id;
	}


	public int getSeller_id() {
		return seller_id;
	}


	public void setSeller_id(int seller_id) {
		this.seller_id = seller_id;
	}
	public int getBook_no() {
		return book_no;
	}
	public void setBook_no(int book_no) {
		this.book_no = book_no;
	}
	public String getBook_id() {
		return book_id;
	}
	public void setBook_id(String book_id) {
		this.book_id = book_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getBook_memo() {
		return book_memo;
	}
	public void setBook_memo(String book_memo) {
		this.book_memo = book_memo;
	}
	public String getNew_old_ebook() {
		return new_old_ebook;
	}
	public void setNew_old_ebook(String new_old_ebook) {
		this.new_old_ebook = new_old_ebook;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public String getCategory_overseas() {
		return category_overseas;
	}
	public void setCategory_overseas(String category_overseas) {
		this.category_overseas = category_overseas;
	}
	public String getCategory_age() {
		return category_age;
	}
	public void setCategory_age(String category_age) {
		this.category_age = category_age;
	}
	public String getCategory_all() {
		return category_all;
	}
	public void setCategory_all(String category_all) {
		this.category_all = category_all;
	}
	public Date getInsert_day() {
		return insert_day;
	}
	public void setInsert_day(Date insert_day) {
		this.insert_day = insert_day;
	}
	public String getBook_fileName() {
		return book_fileName;
	}
	public void setBook_fileName(String book_fileName) {
		this.book_fileName = book_fileName;
	}



	@Override
	public String toString() {
		return "BooksVO [book_no=" + book_no + ", book_id=" + book_id + ", title=" + title + ", author=" + author
				+ ", publisher=" + publisher + ", book_memo=" + book_memo + ", new_old_ebook=" + new_old_ebook
				+ ", price=" + price + ", stock=" + stock + ", category_overseas=" + category_overseas
				+ ", category_age=" + category_age + ", category_all=" + category_all + ", insert_day=" + insert_day
				+ ", book_fileName=" + book_fileName + ", seller_id=" + seller_id + "]";
	}

	
}













