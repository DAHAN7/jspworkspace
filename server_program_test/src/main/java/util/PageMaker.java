package util;

//페이징 처리 정보를 관리하는 클래스
public class PageMaker {
	private int totalCount; // 전체 게시물의 수
	private int startPage; // 시작 페이지 블록 번호 (예: 1, 11, 21 ...)
	private int endPage; // 마지막 페이지 블록 번호 (예: 10, 20, 30 ...)
	private int displayPageNum; // 한 번에 보여줄 페이지 블록 수 (예: 10개씩)
	private int maxPage; // 전체 페이지 블록 수

	private boolean prev; // 이전 페이지 블록 존재 여부
	private boolean next; // 다음 페이지 블록 존재 여부

	Criteria cri; // 정렬 기준과 현재 페이지에 대한 정보를 저장하는 Criteria 객체

	// 기본 생성자: Criteria 객체를 생성하고 초기화
	public PageMaker() {
		this.cri = new Criteria();
	}
	// [1][2][3][4][5]
	// [6][7][8][9][10]
	// 페이징 정보 계산 메서드
		public void calcPaging() {
			// 마지막 페이지 블록 번호 계산 (현재 페이지 / 페이지 블록 수를 올림하여 계산)
			endPage = (int) Math.ceil(cri.getPage() / (double) displayPageNum) * displayPageNum;
			// 시작 페이지 블록 번호 계산 (마지막 페이지 블록 번호 - 페이지 블록 수 + 1)
			startPage = (endPage - displayPageNum) + 1;

			// 전체 페이지 블록 수 계산 (전체 게시물 수 / 페이지당 게시물 수를 올림하여 계산)
			maxPage = (int) Math.ceil(totalCount / (double) cri.getPerPageNum());

			// 마지막 페이지 블록 번호가 전체 페이지 블록 수보다 크면 마지막 페이지 블록 번호를 전체 페이지 블록 수로 설정
			if (endPage > maxPage) {
				endPage = maxPage;
			}

			// 이전 페이지 블록 존재 여부 계산 (시작 페이지 블록 번호가 1보다 크면 true)
			prev = (startPage == 1) ? false : true;
			// 다음 페이지 블록 존재 여부 계산 (마지막 페이지 블록 번호가 전체 페이지 블록 수와 같으면 false)
			next = (endPage == maxPage) ? false : true;
		}

	
	public Criteria getCri() {
		return cri;
	}
	public void setCri(Criteria cri) {
		this.cri = cri;
		calcPaging();
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcPaging();
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getDisplayPageNum() {
		return displayPageNum;
	}
	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
		calcPaging();
	}
	public int getMaxPage() {
		return maxPage;
	}
	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	// 객체 정보를 문자열로 반환 (디버깅 용도)
	@Override
	public String toString() {
		return "PageMaker [totalCount=" + totalCount + ", startPage=" + startPage + ", endPage=" + endPage
				+ ", displayPageNum=" + displayPageNum + ", maxPage=" + maxPage + ", prev=" + prev + ", next=" + next
				+ ", cri=" + cri + "]";
	}
	
}