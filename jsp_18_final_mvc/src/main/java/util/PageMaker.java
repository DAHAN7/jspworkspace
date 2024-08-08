package util;

/**
 * 페이지 정보를 관리하고, 페이지네이션을 계산하는 클래스
 * 이 클래스는 게시물의 총 개수와 현재 페이지 정보에 기반하여 페이지네이션을 계산합니다.
 */
public class PageMaker {

	private int totalCount; // 전체 게시물의 총 개수
	private int startPage; // 현재 페이지 블록의 시작 페이지 번호
	private int endPage; // 현재 페이지 블록의 끝 페이지 번호
	private boolean prev; // 이전 페이지 버튼의 활성화 여부
	private boolean next; // 다음 페이지 버튼의 활성화 여부
	private int displayPageNum = 5; // 한번에 보여줄 페이지 번호의 개수
	private int maxPage; // 전체 페이지의 최대 페이지 번호

	Criteria cri; // 페이지네이션 기준 정보 (현재 페이지, 페이지당 게시물 수 등)
	
	/**
	 * 기본 생성자. Criteria 객체를 기본 값으로 초기화합니다.
	 */
	public PageMaker() {
		cri = new Criteria();
	}

	/**
	 * 페이지네이션 정보를 계산하는 메서드
	 * 현재 페이지와 페이지당 게시물 수를 기반으로 시작 페이지, 끝 페이지, 이전/다음 페이지 버튼의 활성화 여부를 계산합니다.
	 */
	public void calcPaging() {
		// 현재 페이지 블록의 마지막 페이지 번호를 계산
		endPage = (int) Math.ceil(cri.getPage() / (double) displayPageNum) * displayPageNum;

		// 현재 페이지 블록의 시작 페이지 번호를 계산
		startPage = (endPage - displayPageNum) + 1;

		// 전체 페이지의 최대 페이지 번호를 계산
		maxPage = (int) (Math.ceil(totalCount / (double) cri.getPerPageNum()));

		// 끝 페이지가 전체 페이지 수를 초과하지 않도록 조정
		if (endPage > maxPage)
			endPage = maxPage;

		// 이전 페이지 버튼 활성화 여부를 계산
		// 페이지 블록의 시작 페이지가 1이면 이전 페이지 버튼은 비활성화
		prev = (startPage == 1) ? false : true;

		// 다음 페이지 버튼 활성화 여부를 계산
		// 현재 페이지 블록의 끝 페이지가 전체 페이지와 같으면 다음 페이지 버튼은 비활성화
		next = (endPage == maxPage) ? false : true;
	}

	public int getMaxPage() {
		return maxPage;
	}

	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcPaging(); // 전체 게시물 수가 변경되면 페이지네이션을 다시 계산
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

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
		calcPaging(); // 페이지당 보여줄 페이지 수가 변경되면 페이지네이션을 다시 계산
	}

	public Criteria getCri() {
		return cri;
	}

	public void setCri(Criteria cri) {
		this.cri = cri;
		calcPaging(); // Criteria가 변경되면 페이지네이션을 다시 계산
	}
	
	/**
	 * 특정 페이지 번호에 대한 쿼리 문자열을 생성하는 메서드
	 * 
	 * @param page - 쿼리 문자열에서 페이지 번호를 설정할 값
	 * @return String - 쿼리 문자열 (예: ?page=2&perPageNum=15)
	 */
	public String makeQuery(int page) {
		String queryString = "?";
		queryString += "page=" + page;
		queryString += "&perPageNum=" + cri.getPerPageNum();
		return queryString;
	}

	@Override
	public String toString() {
		return "PageMaker [totalCount=" + totalCount + ", startPage=" + startPage + ", endPage=" + endPage + ", prev="
				+ prev + ", next=" + next + ", displayPageNum=" + displayPageNum + ", maxPage=" + maxPage + ", cri="
				+ cri + "]";
	}
}
