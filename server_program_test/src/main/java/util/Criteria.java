package util;

// 기준!!
// DB에서 검색 할 행의 정보를 처리할 class
// 정렬 기준을 잡기 위한 현재 page정보를 저장
public class Criteria {

	private int page; // 요청이 들어온 현재 페이지 번호
	private int perPageNum; // 한 페이지에 보여줄 게시물 수

	// 기본 생성자: 페이지 1, 페이지당 게시물 수 10으로 초기화
	public Criteria() {
		this(1, 10);
	}

	// 생성자: 페이지 번호와 페이지당 게시물 수를 설정
	public Criteria(int page, int perPageNum) {
		setPage(page); // 페이지 번호 설정 (유효성 검사 포함)
		setPerPageNum(perPageNum); // 페이지당 게시물 수 설정 (유효성 검사 포함)
	}

	// 현재 페이지 번호 반환
	public int getPage() {
		return page;
	}

	// 현재 페이지 번호 설정 (유효성 검사: 0보다 작거나 같으면 1로 설정)
	public void setPage(int page) {
		if (page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}

	// 페이지당 게시물 수 반환
	public int getPerPageNum() {
		return perPageNum;
	}

	// 페이지당 게시물 수 설정 (유효성 검사: 0보다 작거나 같거나 100보다 크면 10으로 설정)
	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}

	// 시작 행 인덱스 번호 반환 (SQL 쿼리의 LIMIT 절에서 사용)
	// 시작 row index 번호 // limit getStartRow, perPageNum
	public int getStartRow() {
		return (this.page - 1) * perPageNum;
	}

	// 객체 정보를 문자열로 반환 (디버깅 용도)
	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + "]";
	}

}
