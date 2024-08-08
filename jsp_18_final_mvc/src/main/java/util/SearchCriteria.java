package util;

/**
 * 검색 조건을 포함하는 페이지네이션 기준을 나타내는 클래스
 * 이 클래스는 기본적인 페이지네이션 기능을 상속받아, 검색에 관련된 추가 정보를 포함합니다.
 */
public class SearchCriteria extends Criteria {
	
	// 검색할 필드의 이름 (예: "title", "author")
	private String searchName;
	
	// 검색할 값 (예: "Java", "John")
	private String searchValue;

	/**
	 * 생성자
	 * 
	 * @param page - 현재 페이지 번호
	 * @param perPageNum - 페이지당 게시물 수
	 * @param searchName - 검색할 필드의 이름
	 * @param searchValue - 검색할 값
	 */
	public SearchCriteria(int page, int perPageNum, String searchName, String searchValue) {
		super(page, perPageNum); // 부모 클래스의 생성자를 호출하여 페이지와 페이지당 게시물 수를 설정
		this.searchName = searchName;
		this.searchValue = searchValue;
	}

	/**
	 * 검색할 필드의 이름을 반환합니다.
	 * 
	 * @return 검색할 필드의 이름
	 */
	public String getSearchName() {
		return searchName;
	}

	/**
	 * 검색할 필드의 이름을 설정합니다.
	 * 
	 * @param searchName - 검색할 필드의 이름
	 */
	public void setSearchName(String searchName) {
		this.searchName = searchName;
	}

	/**
	 * 검색할 값을 반환합니다.
	 * 
	 * @return 검색할 값
	 */
	public String getSearchValue() {
		return searchValue;
	}

	/**
	 * 검색할 값을 설정합니다.
	 * 
	 * @param searchValue - 검색할 값
	 */
	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}

	/**
	 * 객체의 문자열 표현을 반환합니다.
	 * 
	 * @return 문자열 표현 (상위 클래스의 toString() 호출과 검색 조건 포함)
	 */
	@Override
	public String toString() {
		return "SearchCriteria [searchName=" + searchName + ", searchValue=" + searchValue + ", toString()="
				+ super.toString() + "]";
	}
}
