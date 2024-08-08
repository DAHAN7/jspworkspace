package util;

// 게시물 페이징 처리를 위한 전용 클래스
public class Criteria {

	private int page; // 현재 페이지 번호
	private int perPageNum; // 한 페이지에 표시할 게시글의 수

	// SQL 예제:
	// SELECT * FROM tbl_board ORDER BY bno DESC
	// limit 시작 번호, 가져올 게시물 수;

	// 기본 생성자 - 초기 페이지 번호를 1, 한 페이지에 보여줄 게시글 수를 10으로 설정
	public Criteria() {
		this(1, 10);
		System.out.println("Cri 기본 생성자 호출");
	}

	// 사용자 지정 생성자 - 페이지 번호와 한 페이지에 보여줄 게시글 수를 설정
	public Criteria(int page, int perPageNum) {
		this.page = page;
		this.perPageNum = perPageNum;
		System.out.println("Cri 생성자 호출");
	}

	// 현재 페이지 번호를 반환하는 getter 메서드
	public int getPage() {
		return page;
	}

	// 페이지 번호를 설정하는 setter 메서드
	public void setPage(int page) {
		System.out.println("setPage 호출");
		// 페이지 번호가 0 이하이면 기본값으로 1을 설정
		if (page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}

	// 한 페이지에 표시할 게시글 수를 반환하는 getter 메서드
	public int getPerPageNum() {
		return perPageNum;
	}

	// 한 페이지에 표시할 게시글 수를 설정하는 setter 메서드
	public void setPerPageNum(int perPageNum) {
		System.out.println("setPerPageNum 호출");
		// 한 페이지에 표시할 게시글 수가 0 이하이거나 100을 초과하면 기본값으로 10을 설정
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}

	// 페이지의 시작 위치를 계산하여 반환하는 메서드
	// (페이지 번호 - 1) * 한 페이지에 보여줄 게시글 수
	public int getPageStart() {
		return (this.page - 1) * perPageNum;
	}

	// 객체 정보를 문자열로 반환하는 메서드 (디버깅용)
	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + "]";
	}
}
