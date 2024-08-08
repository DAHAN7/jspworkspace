package util;

/**
 * 검색 기능이 포함된 페이지네이션을 처리하는 클래스
 * 이 클래스는 기본 `PageMaker` 클래스를 확장하여, 검색 조건을 포함한 페이지 쿼리 문자열을 생성합니다.
 */
public class SearchPageMaker extends PageMaker {

	/**
	 * 현재 페이지메이커의 검색 조건을 반환합니다.
	 * 
	 * @return 현재 페이지메이커의 검색 조건 (`SearchCriteria` 객체)
	 *         만약 현재 조건이 `SearchCriteria` 타입이 아닐 경우, `null`을 반환
	 */
	public SearchCriteria getSearchCriteria() {
		if (this.cri instanceof SearchCriteria) {
			return (SearchCriteria) cri; // 검색 조건이 `SearchCriteria` 타입인 경우, 타입 캐스팅하여 반환
		}
		return null; // 검색 조건이 `SearchCriteria` 타입이 아닐 경우, `null` 반환
	}

	/**
	 * 페이지 번호를 기준으로 쿼리 문자열을 생성합니다.
	 * 
	 * @param page - 이동할 페이지 번호
	 * @return - 페이지 번호와 검색 조건을 포함한 쿼리 문자열
	 */
	@Override
	public String makeQuery(int page) {
		String queryString = super.makeQuery(page); 
		// 부모 클래스의 `makeQuery` 메서드를 호출하여 기본 쿼리 문자열을 생성
		// 예: ?page=1&perPageNum=20

		if (getSearchCriteria() != null) {
			// 검색 조건이 설정된 경우, 검색 필드와 검색 값을 쿼리 문자열에 추가
			queryString += "&searchName=" + getSearchCriteria().getSearchName();
			queryString += "&searchValue=" + getSearchCriteria().getSearchValue();
		}
		return queryString; // 완성된 쿼리 문자열 반환
	}
}
